From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Mon, 05 Oct 2015 09:51:50 -0700
Message-ID: <xmqqpp0tz2ah.fsf@gitster.mtv.corp.google.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	<xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	<1443150875.3042.3.camel@kaarsemaker.net>
	<699c08632232180166145f70c7f16645@dscho.org>
	<CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
	<vpq7fnc83ki.fsf@grenoble-inp.fr> <vpq4mie1m3n.fsf@grenoble-inp.fr>
	<xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com>
	<CAFY1edZSNKepx_+2U=C-raOBiVK3Zh2r_Y_NO2-RtbhH_n-tdg@mail.gmail.com>
	<CAPc5daXkn=C-D5RQCw2w+JrHn7XZA6X-P4F-PugRe-S4Z2RO0g@mail.gmail.com>
	<vpq1tdb83nt.fsf@grenoble-inp.fr>
	<xmqqmvvy1q83.fsf@gitster.mtv.corp.google.com>
	<1443981968.3520.5.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Roberto Tyley <roberto.tyley@gmail.com>,
	Jeff King <peff@peff.net>, Luke Diamand <luke@diamand.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 18:51:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj8zW-00015p-5n
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 18:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbbJEQvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 12:51:54 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35417 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbbJEQvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 12:51:52 -0400
Received: by pacfv12 with SMTP id fv12so185475974pac.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bh1ER5G7mqSuXmc+oYY2y/vRYaZL3+sMOUKLn7sOtNk=;
        b=YmMjY82Gsldr+rGPAR9Uy6ZjpgmosjaIoyUqGniTehKxcSnEGm1oE47V87ejHOkXNs
         W/1b8pnaFBUwHQa0WXxLC0pN79wibHHzAeij/FUxtuWW/63sMhQLpbL45O/ZElxHUqjS
         AOfV+gdC5FvZ9ycGPjUwNnyo/++UP6B4wxiwTSugadOGtmYXLlLG8RzWZqBYcf0Kwno4
         A/kT3j+w1TlCwQusgIggdjIUipjh4jDnIYDvOfmvygTDhoQfZDAPcFwOIYPvr7WzB5/1
         QnFdc1Hi5hIr9b+UwIBXQxcAoKasEDzZ5MukRFUuCAdIFInQLK/XH1J0GXc+AlEIavCT
         ERsg==
X-Received: by 10.66.145.97 with SMTP id st1mr40445125pab.145.1444063912300;
        Mon, 05 Oct 2015 09:51:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:60e8:cc09:ddf4:4eed])
        by smtp.gmail.com with ESMTPSA id k10sm28573729pbq.78.2015.10.05.09.51.50
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 05 Oct 2015 09:51:51 -0700 (PDT)
In-Reply-To: <1443981968.3520.5.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Sun, 04 Oct 2015 20:06:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279059>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On zo, 2015-10-04 at 10:46 -0700, Junio C Hamano wrote:
>> One final question.  Which configuration file does the CI use when
>> running a PR-initiated test?  The one already in the repository
>> i.e. the target of the proposed pull, or the one that is possibly
>> updated by the PR?
>>
>> I am wondering if that can be an avenue for a possible mischief.
>
> The latter. And it can, as it can enable notifications.

So it can add a slight annoyance if somebody wanted to, but not much
over the annoyance a random pull-request can already give to project
participants.  IOW, nothing to worry about.

Thanks.
