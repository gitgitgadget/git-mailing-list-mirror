From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Mon, 9 Sep 2013 18:21:29 -0500
Message-ID: <CAMP44s3Nh-YoYTOXdxJDp469P7dz=kiEEXr3_XKzxuepFiD1GA@mail.gmail.com>
References: <522A36AA.3050701@gmail.com>
	<xmqqeh91wrvq.fsf@gitster.dls.corp.google.com>
	<CAHGBnuP6w8rvoz+h2Xase1ApY_kpZh4X=VF6LY4O0r7RS0UayA@mail.gmail.com>
	<xmqqsixgvci1.fsf@gitster.dls.corp.google.com>
	<CAHGBnuNKrtGSoOYS1T0VH=tGvKUW0XKFnWf_WNvZkOriGurgpg@mail.gmail.com>
	<xmqqr4cx1u7u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 01:21:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJAlz-0003mu-Hb
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 01:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199Ab3IIXVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 19:21:31 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36362 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901Ab3IIXVb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 19:21:31 -0400
Received: by mail-lb0-f176.google.com with SMTP id y6so5584796lbh.35
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 16:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AGc4yKf7XcuSPa+J5Qy+jRjH97tgLdE789uEpIDlQ2I=;
        b=GtI5SXFF7miczTPDp+1WJas/kHoQdPH2+RT2mnDhpXjGty5GWo4lJWtL53Q9CRdshq
         xc2nyHAj2/1uFW00NTl2eS+CJr043IIkLqowHYHAybD2How/Od3J+qaBItcS4GlNgef9
         XvV27PRq+i1BQzOWF+U7HlreMzGMU1S8viakkVl2T9iDIic+Fw4mrAX2ppvORv85Uoub
         oRBDfte6jxou63Ly31RFT4PEJKGz1e2NTygNX3QkfFHjaPdEjOm9tS3FNnfgz2TmCv8F
         n1bn0yK91/hNe12cJdind0JhS0u5eQRXE+MYVbzBskkl7827yrKlQAl7HflaQn6wnYuo
         iSSQ==
X-Received: by 10.152.6.97 with SMTP id z1mr4419794laz.26.1378768889745; Mon,
 09 Sep 2013 16:21:29 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Mon, 9 Sep 2013 16:21:29 -0700 (PDT)
In-Reply-To: <xmqqr4cx1u7u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234401>

On Sun, Sep 8, 2013 at 12:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Sebastian Schuberth <sschuberth@gmail.com> writes:
>
>> Which raises another question on my side: Isn't it tedious for you to
>> both update DEF_VER *and* tag a version? Wouldn't it probably be less
>> error prove (in the sense of keeping DEF_VER and tagged version in
>> sync) to remove DEF_VER completely and just die if all ways to derive
>> a Git version fail?
>
> I do not see how it will fly well.  Some people want to build out of
> tarballs without having any "describe", and DEF_VER and version were
> added for that specific purpose.

'version' works, there's no need for DEF_VER.

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

That is a red herring.

If there's a lightweight tag on top of v1.8.4, and Git chooses to use
v1.8.4 as a version name, that's fine because as a matter of fact,
that's the real version, since there's no actual changes on top of
that.

-- 
Felipe Contreras
