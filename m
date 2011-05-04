From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH RFC] Test for apparent regression of merging renamed files
Date: Tue, 3 May 2011 20:18:40 -0600
Message-ID: <BANLkTi=HR7CG0agR=cVMP3m6T-Y8dHP+4A@mail.gmail.com>
References: <BANLkTimcRbuYzSp+MM-vsvxoWhAS8Jvo8Q@mail.gmail.com>
	<BANLkTin6u8e4-x99JgN-D7FFJbO7pXVp-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ciaran <ciaranj@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 04:18:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHRfv-0003jr-P9
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 04:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638Ab1EDCSq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 22:18:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60984 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593Ab1EDCSl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 22:18:41 -0400
Received: by fxm17 with SMTP id 17so513406fxm.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 19:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xW+euBfvXG+VcQuw5DPGRvqQiXtgJa/KfQlsOg2eihs=;
        b=gLEl9Rl7sWQf9a2SS8/rW4TQF1ejMcvmyCBT4cI/Sceycgm7+z16skPhryz96j86vB
         oEfKJ9TSNOFUffqEa0Do8SiCXeYCrhxAkr0giG/7nafA3HxIGVHQTq19a05FF8EYaXbD
         /KMQpZg5wUb8lAtfWq/p/KSGTODb60y4o9Hds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g/gDq8ROavNUZJyOt0fOM4pr5ny/9/EFUawCRliB+4Xj2j6mU52WUuashEditTs0aZ
         hxkRcMxENxcCmGLg2JoXUzR//ym98OFu8h/cMIvRMlSAhQxtiEKgSQhZDd7zBAde2LAm
         MylSpo2EBE+ik/MYTEirpaDpoLMOoXkpzTN04=
Received: by 10.223.1.84 with SMTP id 20mr610227fae.55.1304475520700; Tue, 03
 May 2011 19:18:40 -0700 (PDT)
Received: by 10.223.26.11 with HTTP; Tue, 3 May 2011 19:18:40 -0700 (PDT)
In-Reply-To: <BANLkTin6u8e4-x99JgN-D7FFJbO7pXVp-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172709>

Hi,

On Tue, May 3, 2011 at 1:15 PM, Ciaran <ciaranj@gmail.com> wrote:
> On Mon, May 2, 2011 at 8:04 PM, Ciaran <ciaranj@gmail.com> wrote:
>> Provides a test to cover a case that appears to have been regressed =
out by:
>>
>> =C2=A0b2c8c0a762745768e8fb249949801c1aed8f7c1d
>>
>> At this point no tags contain the above commit, but 'master' does. =C2=
=A0I'm unsure
>> what is causing the issue, but can see discussion about this fix her=
e:
>>
>> http://git.661346.n2.nabble.com/BUG-merge-recursive-triggered-quot-B=
UG-quot-td6179353.html
>>
>> Providing a patch to demonstrate the issue and spark discussion.
=2E...
> The original behaviour (successful merge) seems 'better' than the
> current behaviour 'failed merge, 'erroneous' both modified flag' ...
> am I mis-reading this, is this a new non-supported edge case ?

Thanks for the testcase.  This is clearly a bug; and a rather easy one
to trigger at that.  I'll have to take a look, though I suspect it's
time to fix the deeper issues Junio pointed out previously...

Elijah
