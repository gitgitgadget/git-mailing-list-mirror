From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Sat, 03 Oct 2015 18:37:26 -0700
Message-ID: <xmqq612n2z3d.fsf@gitster.mtv.corp.google.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	<xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	<1443150875.3042.3.camel@kaarsemaker.net>
	<699c08632232180166145f70c7f16645@dscho.org>
	<CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
	<vpq7fnc83ki.fsf@grenoble-inp.fr> <vpq4mie1m3n.fsf@grenoble-inp.fr>
	<xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com>
	<CAFY1edZSNKepx_+2U=C-raOBiVK3Zh2r_Y_NO2-RtbhH_n-tdg@mail.gmail.com>
	<CAPc5daXkn=C-D5RQCw2w+JrHn7XZA6X-P4F-PugRe-S4Z2RO0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Luke Diamand <luke@diamand.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 03:37:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiYF2-0006j5-L9
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 03:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbbJDBh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 21:37:28 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34760 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbbJDBh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 21:37:28 -0400
Received: by padhy16 with SMTP id hy16so880923pad.1
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 18:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=B7vRVZ/qj+RMBiRoI90fVt2foVCZGsANnONeEUUHl8Y=;
        b=HqZWZdGiIbI4ayeoCLKRtMAhfJJt0BWqGmyaUdK2GYqsNRBv0yXdVz1vLa6KbluZML
         d04Yod4+e9FjJRaKp2xCmBB0QlFde6xWPCwtPS5jdjaYTBzP9l7qKPmaUA7aRCTZjLVm
         tv/GSU/zbwGTKbvdTk5OTeyDtw81JBe5wJImw8awSkSU3E1HRS04j1QUmc2wOfRzNrxG
         K2hWNZvZMWfup/jcDX4i2bRZ5BDJOV6oqFuYziAOb3IVg0TzpBDo3d+mFfJNW3G8PPh+
         iiphz3+AQmQ7XeTeG4LaVQMnN8tXLzEMNBU64Z4lZ2EaDhYvkeoQNyRuOVbBU8cIvtE9
         SA7Q==
X-Received: by 10.67.3.167 with SMTP id bx7mr30104336pad.47.1443922647848;
        Sat, 03 Oct 2015 18:37:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:cd5:dd7c:35c8:15e])
        by smtp.gmail.com with ESMTPSA id xm9sm19639710pbc.32.2015.10.03.18.37.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Oct 2015 18:37:26 -0700 (PDT)
In-Reply-To: <CAPc5daXkn=C-D5RQCw2w+JrHn7XZA6X-P4F-PugRe-S4Z2RO0g@mail.gmail.com>
	(Junio C. Hamano's message of "Sat, 3 Oct 2015 18:27:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278989>

Junio C Hamano <gitster@pobox.com> writes:

> On Sat, Oct 3, 2015 at 3:23 PM, Roberto Tyley <roberto.tyley@gmail.com> wrote:
>>
>> Given this, enabling Travis CI for git/git seems pretty low risk,
>> are there any strong objections to it happening?
>
> I still don't see a reason why git/git needs to be the one that is
> used, when somebody
> so interested (and I seem to see very many of them in the thread) can
> sacrifice his or
> her own fork and enable it him or herself.

To state it a bit differently.

If somebody says "I've been maintaining a clone of git/git with
Travis webhooks enabled and as the result caught this many glitches
during the past two months without any ill side effect.  Here are
the patches to fix them, and by the way, the first patch in this
series is not a fix but the configuration to tell Travis how to run
tests so that other people can enable it on _their_ own fork before
they send their own series to the mailing list." in the cover letter
of a patch series, I would appreciate such a series greatly and
would not mind carrying one extra yml file in the tree at all.

But that is not what I am seeing in this thread at all.  I am tired
of hearing people telling others to help them by doing more without
doing the grunt work themselves.
