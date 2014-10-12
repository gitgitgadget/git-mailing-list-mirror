From: Dun Peal <dunpealer@gmail.com>
Subject: Re: $GIT_DIR/info/exclude fails to negate a pattern defined by core.excludesfile
Date: Sun, 12 Oct 2014 10:48:06 -0400
Message-ID: <CAD03jn5_LY4gr68bCO1axXiGxCwX9xZeywD9uGoZdsXqzynBWQ@mail.gmail.com>
References: <CAD03jn4md9YJZ3fFWmvjiO2KSztc-02QpznXO3LJeiZDz8YhrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 12 16:48:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdKRW-0001Y1-Un
	for gcvg-git-2@plane.gmane.org; Sun, 12 Oct 2014 16:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbaJLOsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2014 10:48:09 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:49862 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbaJLOsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2014 10:48:07 -0400
Received: by mail-oi0-f47.google.com with SMTP id a141so11087956oig.34
        for <git@vger.kernel.org>; Sun, 12 Oct 2014 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=2jO27cq+mbe+ebzGe+xK1Ugcf0Fc/K2I1IdvrWPCAuk=;
        b=hQ9v2ZP5Y0j8QsdKeJXhqlNDA0+gJ/YrZfcjKAdw3MrWVFsfyyqAz36L81ryCMF6Dd
         ZTyYb2Og7JvXB1diJRF8PoyYHCWQQYWKFF2jO77MH8QMZq2C5N2XgmijTybuXydNullv
         aHja2WXP/ngTc2kRqr1CC10hIno4kvj0TWEjNPv9fJFVhRDegdLaCz2Z2xui6OC6yLgC
         tDLk2h8ra9A5DoxMTyLdakmOIH83lK5yiLutDF5ghhAJKnSjQ/KQ+c8pCiuL0E0MDAel
         Cv8I/1V0NOCUZyeeMpdG0btQCGOaKC8S8l50/rQd1KTSOBRsNsSTNew7pNDto8vqW+IT
         9iZA==
X-Received: by 10.202.44.129 with SMTP id s123mr1234925ois.82.1413125286356;
 Sun, 12 Oct 2014 07:48:06 -0700 (PDT)
Received: by 10.76.33.66 with HTTP; Sun, 12 Oct 2014 07:48:06 -0700 (PDT)
In-Reply-To: <CAD03jn4md9YJZ3fFWmvjiO2KSztc-02QpznXO3LJeiZDz8YhrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I used `check-ignore -v`, and the `.out` file is being ignored by the
`*.out` pattern in the `core.excludesfile` file. Its parent folder is
not being ignored. So as a rule, `core.excludesfile` overrides
`$GIT_DIR/info/exclude`.

That doesn't make much sense to me, because I'm much more likely to
want to override global exclusions for a specific project, than
override specific project settings with a global exclusion file (that
last one really makes no sense imho).

Thoughts?

On Sat, Oct 11, 2014 at 10:58 PM, Dun Peal <dunpealer@gmail.com> wrote:
> I have the pattern `*.out` defined in my `core.excludesfile`.
> According to the documentation[1], patterns defined in
> `$GIT_DIR/info/exclude` take precedence over `core.excludesfile`, so
> for one particular project that needs to track some `.out` files, I
> created `$GIT_DIR/info/exclude` with just one pattern: `!*.out`.
>
> Yet for some reason, `git status` still fails to report newly created
> `.out` files for that project. Am I misunderstanding the
> documentation?
>
> Thanks, D.
>
> [1] http://jk.gs/gitignore.html
