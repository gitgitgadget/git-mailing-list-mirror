From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/PATCH v5 05/10] for-each-ref: introduce 'ref_array_clear()'
Date: Mon, 08 Jun 2015 10:05:19 -0700
Message-ID: <xmqq3822cer4.fsf@gitster.dls.corp.google.com>
References: <55729B78.1070207@gmail.com>
	<1433574581-23980-1-git-send-email-karthik.188@gmail.com>
	<1433574581-23980-5-git-send-email-karthik.188@gmail.com>
	<vpqvbey6yli.fsf@anie.imag.fr> <5575B25A.6020608@gmail.com>
	<vpqbngq2mkw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:05:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20UK-0004MT-5T
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbbFHRFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:05:24 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35911 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbbFHRFW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:05:22 -0400
Received: by ieclw1 with SMTP id lw1so102617095iec.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hIzxeG35rUUeQiuGUVhtCvwLVtlyd5YhHvWVKjS4tUs=;
        b=mTwTnGbc6SY2PIuM33SRZ02apT8hwRwHydHeOu3hcFuMoYHuSQEadYjSa3RPl7ziH/
         Q1XmG6l1uzVVa7kX2LD7nNa08jK49aoRdnvaBIyLr1E8XogR1amoBcGNIR2v68z00iWa
         uSZTSyMaoMU21OOIMM63p9HwuTobJ2cQFANQCiPQi/nRWwGsnuDwEFaHfHgTXyaLqiGn
         OchP/OHPLKq7Iac4d25JOaqIiIGNMgiZ+e22wtC3Ao+gcRiLfJPR7UhWFt+r66/4D1YM
         H+FD0kK1Vgwk6rRBisiX0lgC6ch+SdnEQo+0qTB99Gix72WOuC8yHLwrnICuplney2zG
         IUBw==
X-Received: by 10.107.135.68 with SMTP id j65mr13459023iod.91.1433783121367;
        Mon, 08 Jun 2015 10:05:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d91a:edb1:b738:fb03])
        by mx.google.com with ESMTPSA id j3sm722344ige.0.2015.06.08.10.05.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 10:05:20 -0700 (PDT)
In-Reply-To: <vpqbngq2mkw.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	08 Jun 2015 18:26:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271081>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On 06/08/2015 08:23 PM, Matthieu Moy wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>> > +/* Free all memory allocated for ref_array */
>>> > +void ref_array_clear(struct ref_array *array)
>>>
>>> Is this a private function? If so, then add static. If not, you probably
>>> want to export it in a .h file.
>>>
>> It is in ref-filter.h.
>
> Ah, OK. It comes later in the series.

Confused I am; if it comes later not in the same patch then it is
not OK, is it?
