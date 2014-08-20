From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] Signed push
Date: Tue, 19 Aug 2014 19:54:48 -0700
Message-ID: <CAPc5daWJj1oM3ebc59sbpORggoigyq-hSOvfc0ueFHD=WeCYWg@mail.gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com> <20140820011935.GC3104@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 04:55:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJw3R-0005SB-M2
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 04:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbaHTCzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 22:55:11 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39438 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbaHTCzK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 22:55:10 -0400
Received: by mail-lb0-f174.google.com with SMTP id c11so6285687lbj.33
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 19:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IJCPA18CiLGUIZAEsspuDfDr1rk2BwNiW1gd+xf2K7g=;
        b=PGi2KvSXiqAlJtH0P3tV+hkoyTeYNE/hx6kh7COgmIc2HoqTpT/Iz8x74CkeumOfyc
         GITU1pvBfmGowmA4Mx074+x2Lk2cJK3BN4yLUuNwEf767VBvzOdx60ZatInzU6g+oLIs
         Z4CVvHUUpdegfkYTbtjDC/sxYnCASu1pOTeeIqYofwIlUvyU52c98wz9mYgIKJmVOK4R
         4lnxmMmzILt5cQGndMVSwyGofn8/1vK0DooKDbiYzqSZo/dkgXFA0Tq2uCD5y0YDIa/h
         LKwpHvebiBjWg6mxDoMgzkZMmDNe8GV3iF7gsOkn8+gKbWPYcpzLflyxqipMsaHbHrnr
         l2bw==
X-Received: by 10.112.255.36 with SMTP id an4mr38351268lbd.31.1408503308621;
 Tue, 19 Aug 2014 19:55:08 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Tue, 19 Aug 2014 19:54:48 -0700 (PDT)
In-Reply-To: <20140820011935.GC3104@localhost>
X-Google-Sender-Auth: DG-HeLl0lARyVCzKzpTiaYVuwRc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255549>

Sorry, but I cannot answer, as the only thing that I recall when
I hear "branch object" was that I heard the phrase used but
without much substance.

I do not think I saw a clear explanation on what it is, how it is
represented, how it is presented to the end user, how it is
propagated across repositories (if it is to be propagated),
how it is stored (if it is to be stored), how it is to be used,
etc. and such crucial details necessary to judge the merit
of thinking about introducing one. Perhaps it was explained
in the old thread, but I don't recall, so I cannot judge how
useful it would be to solve the problem the push certificate is
trying to solve.


On Tue, Aug 19, 2014 at 6:19 PM, Nico Williams <nico@cryptonector.com> wrote:
> On Tue, Aug 19, 2014 at 03:06:09PM -0700, Junio C Hamano wrote:
>> While signed tags and commits assert that the objects thusly signed
>> came from you, who signed these objects, there is not a good way to
>> assert that you wanted to have a particular object at the tip of a
>> particular branch.  My signing v2.0.1 tag only means I want to call
>> the version v2.0.1, and it does not mean I want to push it out to my
>> 'master' branch---it is likely that I only want it in 'maint', so
>> the signature on the object alone is insufficient.
>>
>> [...]
>>
>> This series introduces a cryptographic assurance for ref updates
>> done by "git push" by introducing a mechanism that allows you to
>> sign a "push certificate" (for the lack of better name) every time
>> you push.  Think of it as working on an axis orthogonal to the
>> traditional "signed tags".
>
> Sounds a lot like the "branch object" concept I suggest earlier, where
> each push would also push a commit to a branch object describing the
> updates to the branch, including signing of the updates to the branch
> (hey, it's just a signed commit), groups of commits pushed together / to
> be backed out together, rebase history, ...  (What about pushing
> orphaned commits?)
>
> Code-wise, would that be more or less generic?
>
> Nico
> --
