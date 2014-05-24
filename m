From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: commit: support commit.verbose and --no-verbose
Date: Sat, 24 May 2014 16:25:35 +0700
Message-ID: <CACsJy8C6Ff-wUvwhrT0y6F2rnqwaYByxxFF_8A7rvKTdZn199g@mail.gmail.com>
References: <20140523212222.GA10412@sirius.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	James P Howard II <jh@jameshoward.us>,
	Jeff King <peff@peff.net>
To: Caleb Thompson <cjaysson@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 11:26:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wo8DX-0001sp-LJ
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 11:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbaEXJ0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2014 05:26:08 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:38412 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbaEXJ0H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2014 05:26:07 -0400
Received: by mail-qc0-f178.google.com with SMTP id l6so9655152qcy.9
        for <git@vger.kernel.org>; Sat, 24 May 2014 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hEb2+ZmhGsoOxhzcCzQe86YoZJnHPHuGz3s1LwcNFRY=;
        b=dcJ1/wuWyRU8tsFfafW9fPFh/hxd/qjr2D6VsqePmraMu3rskBbX+S5Vgw49S4bans
         A0dyRL36WBqbGKy0qtj2WEHMq/zG05dXeTXkMKGrwNPmAk6Y4LSDLwxr3g8Xz5ykT2rD
         vuPhOLnS20YdJ6yeR4HuuFjPJAMzgtoIjTBpcWyb3mesv3NveJaZtbPi+HRdgvZNvM4N
         mLcQDrx+cAqJCGXWOI0SblW1WOD9K9//K/Eh3EWkzjqccgD3WMrRLlfFOmuvXH6JoN6Q
         oJCCXalOkKBjxp5vT4lyRvSl0c8GAlWgNL5mo9XB4mkpK8wmvvuXwAyKfJ4OUxp0UapK
         xoHw==
X-Received: by 10.140.80.67 with SMTP id b61mr13535829qgd.98.1400923565967;
 Sat, 24 May 2014 02:26:05 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Sat, 24 May 2014 02:25:35 -0700 (PDT)
In-Reply-To: <20140523212222.GA10412@sirius.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250059>

On Sat, May 24, 2014 at 4:22 AM, Caleb Thompson <cjaysson@gmail.com> wrote:
> This patch allows people to set `commit.verbose` to implicitly send `--verbose`
> to `git commit`. It also introduces `--no-verbose` to override the configuration
> setting.

The code change looks fine to me (no opinion if we should do this though).

> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -282,7 +282,14 @@ configuration variable documented in linkgit:git-config[1].
>         Show unified diff between the HEAD commit and what
>         would be committed at the bottom of the commit message
>         template.  Note that this diff output doesn't have its
> -       lines prefixed with '#'.
> +       lines prefixed with '#'.  The `commit.verbose` configuration
> +       variable can be set to true to implicitly send this option.
> +
> +-V::

No, I don't think -V is the negative form of -v if you use OPT_BOOL().

> +--no-verbose::
> +       Do not show the unified diff  at the bottom of the commit message
> +       template.  This is the default behavior, but can be used to override
> +       the`commit.verbose` configuration variable.
-- 
Duy
