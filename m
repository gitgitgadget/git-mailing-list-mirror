From: "/#!/JoePea" <trusktr@gmail.com>
Subject: Re: Relative paths don't work in .gitignore as would be expected.
Date: Wed, 11 Feb 2015 22:28:28 -0800
Message-ID: <CAKU1PAU8zSa3jjPYC7egRxJkr9hM6FerVXLsaU7ieCOZwEFd0g@mail.gmail.com>
References: <CAKU1PAXgofoOqtFMrLYyRoFqNp3Poj-PO35eh1ukxR=h29FPfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@gmail.com>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 12 07:29:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLnH1-0005vb-Qd
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 07:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750AbbBLG3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 01:29:11 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:54133 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbBLG3J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 01:29:09 -0500
Received: by mail-qg0-f49.google.com with SMTP id q107so6505608qgd.8
        for <git@vger.kernel.org>; Wed, 11 Feb 2015 22:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wv1L3Mnk4o4r92CZKMoE0xZiNJz8I3k1LfQOi5JaBkU=;
        b=bF5/oV3uW938kZ3aF1WwDQyWTWLCekpC0AVGKDIPTYnMv4OVp3S6bp3ti7qGB9V/9i
         ofCHaAblrw/Es10Jb2cDImBKlOE/f0iHU0+rK8R6uCWqF1pujim9dOp7z27FHVJIkKDK
         NIJRfqKewyjoTbn+15HYwCrPfQ/Dp1+QamTBQgOXPwdMMtyNxv3UWDL2y/hNl2DMyOuJ
         RNT1G6sfGpOhqROsItXVMsSpxvl5EK3w8ZVM3wRnnswLVrt98+bBM792bPVpZmJ6EMK4
         BxxJXJWvNirp6B8jfwC0DHNBAq0W/wlbeCsddRjDYNZiHCn/KIisuKEU+LHzl8kI6Q6u
         9gEA==
X-Received: by 10.140.21.48 with SMTP id 45mr6112026qgk.87.1423722549046; Wed,
 11 Feb 2015 22:29:09 -0800 (PST)
Received: by 10.140.102.197 with HTTP; Wed, 11 Feb 2015 22:28:28 -0800 (PST)
In-Reply-To: <CAKU1PAXgofoOqtFMrLYyRoFqNp3Poj-PO35eh1ukxR=h29FPfQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263706>

+git@vger.kernel.org, plain text

I would say just use zsh globbing, it has the double star, but it'd
likely too late for that. You'd add a single rule: ignore any files
that are in a directory higher up than the .gitignore where the rule
is found.

Then if you have a git repo in your fs at /git/repo with a
/git/repo/.gitignore you could put /git/repo/*.js, *.js, or ./*.js to
ignore the same thing (the absolute path may or may not bite the
person in the ass when he moves the repo, but that's not our problem),
so those would be equivalent to the current /*.js (give or take the
absolute example). You could do **/*.js the zsh way to start ignoring
things everywhere, equivalent to the current *.js.
/#!/JoePea


On Tue, Feb 10, 2015 at 1:19 AM, /#!/JoePea <trusktr@gmail.com> wrote:
> I would say just use zsh globbing, it has the double star, but it'd likely
> too late for that. You'd add a single rule: ignore any files that are in a
> directory higher up than the .gitignore where the rule is found.
>
> Then if you have a git repo in your fs at /git/repo with a
> /git/repo/.gitignore you could put /git/repo/*.js, *.js, or ./*.js to ignore
> the same thing (the absolute path may or may not bite the person in the ass
> when he moves the repo, but that's not our problem), so those would be
> equivalent to the current /*.js (give or take the absolute example). You
> could do **/*.js the zsh way to start ignoring things everywhere, equivalent
> to the current *.js.
>
> /#!/JoePea
