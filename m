From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Tue, 10 Sep 2013 10:06:37 +0200
Message-ID: <CAHGBnuN=vpJPXgd78aLohW3Awe+Y+0J7Bxwr4Fmn2NijMK1Z5g@mail.gmail.com>
References: <522A36AA.3050701@gmail.com>
	<xmqqeh91wrvq.fsf@gitster.dls.corp.google.com>
	<CAHGBnuP6w8rvoz+h2Xase1ApY_kpZh4X=VF6LY4O0r7RS0UayA@mail.gmail.com>
	<xmqqsixgvci1.fsf@gitster.dls.corp.google.com>
	<CAHGBnuNKrtGSoOYS1T0VH=tGvKUW0XKFnWf_WNvZkOriGurgpg@mail.gmail.com>
	<xmqqr4cx1u7u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 10:06:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJIyE-0001hV-3b
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 10:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078Ab3IJIGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 04:06:41 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:46029 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778Ab3IJIGj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 04:06:39 -0400
Received: by mail-la0-f50.google.com with SMTP id es20so5848831lab.37
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 01:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AYY0cotoK+7/yucxGS8aHHatHySWKhSfOszL9u69l9g=;
        b=jSrI6KlV6O6wkeloJ0gzrtfIpkdPaxWpd1Z12N7uMA6bBNBAL470cQbj66w8ZFeYln
         mVIyJD6Jt5zbZ/G5xCZDmROA3tWrWZJQAOx/vhifzHC0bH/uOuMm68YPelEvYACmLEp7
         P4uwiz1iMzhikD6i5KGgSGNRmQ7+dZKNbNoS0E44S7ddJIfxfc5BwulCj82D9krSyEiI
         SVvJ9suljO+AJYdDHK3fD1yyxrjbq2pwbGT2Ot2+thGfII2cUG8WSroG8H6L0zbcOrI0
         h+W66CWGC/0zyKWm4WG6bbzVpPo84j8W5xCMGJtKDm59+lOIX5qPMoSXTSSSlTxsLOap
         8/Bw==
X-Received: by 10.112.167.66 with SMTP id zm2mr195771lbb.46.1378800397566;
 Tue, 10 Sep 2013 01:06:37 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Tue, 10 Sep 2013 01:06:37 -0700 (PDT)
In-Reply-To: <xmqqr4cx1u7u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234421>

On Sun, Sep 8, 2013 at 7:41 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> Which raises another question on my side: Isn't it tedious for you to
>> both update DEF_VER *and* tag a version? Wouldn't it probably be less
>> error prove (in the sense of keeping DEF_VER and tagged version in
>> sync) to remove DEF_VER completely and just die if all ways to derive
>> a Git version fail?
>
> I do not see how it will fly well.  Some people want to build out of
> tarballs without having any "describe", and DEF_VER and version were
> added for that specific purpose.

Right, but do we really need DEF_VER *and* version? Couldn't we just
package official source tarballs in a way that they already contain an
auto-generated version file?

>>> a case where you have your own tag that points at the exact version
>>> as I tagged?  In such a case, do you have a preference on which tag
>>
>> No. I always carry patches on top.
>
> That answer sidesteps the real issue; which one would you prefer if
> there are two or more tags?  "describe" updated with your patch
> would consider both and I think it favours the annotated one over
> lightweight.  If it matches the preferred order then G-V-N with you
> patch would help your workflow; otherwise you would still need a
> different way, e.g. making sure what you want it to use is always
> used by doing the ">version" thing.

My answer sidesteps the issue because you were explicitly offering the
sidestep in you original question ;-) Anyway, in such a scenario I
would probably prefer my own tag instead of upstream's tag, to be
honest. So you're right that in this case my patch won't help. But
like I said, the case is not valid for me as I will always carry
patches on top, and other people might feel differently about which
tag (annotated vs. lightweight) they prefer if both point to the same
commit.

-- 
Sebastian Schuberth
