From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCHv2 1/3] Documentation/git-svn: Promote the use of
 --prefix in docs + examples
Date: Tue, 8 Oct 2013 21:33:02 -0400
Message-ID: <CAPig+cQfWSY=NdynKOcrVrjoncjz_sNsJ40EpTMmp4FbyLZKmg@mail.gmail.com>
References: <20131003190139.GA8710@dcvr.yhbt.net>
	<1381015833-696-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, tfnico@gmail.com,
	Eric Wong <normalperson@yhbt.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Oct 09 03:33:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTieD-0001Xx-TK
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 03:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab3JIBdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 21:33:06 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:35732 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab3JIBdE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 21:33:04 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so90112lab.33
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 18:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dzvxr3loevKZuGbc8g6BTqqS1QQpSNElgn1cZAKfmek=;
        b=fkBM78lr9031tjkcHmcUD6r9wMlyBODN3+ZzzxVj2JvPeLjwGk5ujF2M/a6cUElmx2
         pMMCVPFU7nK1RNUezLl6xJ5lFMhuEkhGrXc5lnIpqwt09/hENIDYGJEjpQXGHS264cHg
         6GEaRNtnaTwxlBvhBhUWe67liDiblmSfynb5qmt+SCETcKBiniyyl2YUDbabMQ0cDQ4Z
         AtNGYTaOZbHW7uyVD+uWhjxHaJBNTyCzBkzWOqzAsUj6jW6+ErVwJUyb1QrcKDmh619h
         1fHMUf/e2zln6k7MC11HWnJsN+UN/tWyDX4ra1N5bXldHhSVWRrgD8ImwhV7i7/mMnPm
         iK0A==
X-Received: by 10.112.143.3 with SMTP id sa3mr4953640lbb.12.1381282382666;
 Tue, 08 Oct 2013 18:33:02 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Tue, 8 Oct 2013 18:33:02 -0700 (PDT)
In-Reply-To: <1381015833-696-1-git-send-email-johan@herland.net>
X-Google-Sender-Auth: uONpczjRUxBSB4IhqaKlsUCKujI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235798>

On Sat, Oct 5, 2013 at 7:30 PM, Johan Herland <johan@herland.net> wrote:
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 4dd3bcb..da00671 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -973,6 +979,15 @@ without giving any repository layout options.  If the full history with
>  branches and tags is required, the options '--trunk' / '--branches' /
>  '--tags' must be used.
>
> +When using the options for describing the repository layout (--trunk,
> +--tags, --branches, --stdlayout), please also specify the --prefix
> +option (e.g. '--prefix=origin/') to cause your SVN-tracking refs to be
> +placed at refs/remotes/origin/* rather than the default refs/remotes/*.
> +The former is more compatible with the layout of Git's "regular"
> +remote-tracking refs (refs/remotes/$remote/*), and may potentially
> +prevent similarly named SVN branches and Git remotes from clobbering
> +eachother.

s/eachother/each other/

>  When using multiple --branches or --tags, 'git svn' does not automatically
>  handle name collisions (for example, if two branches from different paths have
>  the same name, or if a branch and a tag have the same name).  In these cases,
> @@ -1035,8 +1050,8 @@ comma-separated list of names within braces. For example:
>  [svn-remote "huge-project"]
>         url = http://server.org/svn
>         fetch = trunk/src:refs/remotes/trunk
> -       branches = branches/{red,green}/src:refs/remotes/branches/*
> -       tags = tags/{1.0,2.0}/src:refs/remotes/tags/*
> +       branches = branches/{red,green}/src:refs/remotes/project-a/branches/*
> +       tags = tags/{1.0,2.0}/src:refs/remotes/project-a/tags/*
>  ------------------------------------------------------------------------
>
>  Multiple fetch, branches, and tags keys are supported:
> --
