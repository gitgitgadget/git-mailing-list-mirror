From: Stefan Beller <sbeller@google.com>
Subject: Re: bug: git submodule add fails when .git is a symlink
Date: Tue, 1 Mar 2016 13:39:26 -0800
Message-ID: <CAGZ79kY6Lf6u0=s8J_cqRNFsry4nu2SdL0GZ2gkFsu6gBrB65Q@mail.gmail.com>
References: <20160301204218.GA4083@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Tue Mar 01 22:39:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aas0x-0006cM-Vc
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 22:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837AbcCAVj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 16:39:28 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36776 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbcCAVj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 16:39:27 -0500
Received: by mail-ig0-f177.google.com with SMTP id xg9so28166205igb.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 13:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=5P43CTZecdkiaq/f48rTVG1pDl5DCxMKqDUVPNcbyCQ=;
        b=XxyGHLqmf5iSFhk2QXgrDC90qN3XFCNVoSVC0V/E06fC4/rU0toVn9Y//gdHui6KqX
         HKMT75zDU1WXzkzrKKCCHL+gHe42+n6sk9w4oVTK+PvTQRxB3yW519HBfQaGi0l/EDEr
         QEux4LLR28vqrmQSm7vIn/nusbDEcz1f4FP7ErljMfYFvl++gj3OdYMS2XIh8WJDzGkK
         IdbvHFmYcPMbJcKPKfmD608oh+p/LqYYI0U7jm3ZD1IfDKu/Ul9y+cZMVHzKKM/Ta7uU
         HJULr/VGtu/J4s6BvZLc42tqLaL5VausLWs8MfiYc+l3DiF95EAjmIpAS5em+XIHSsbO
         zYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=5P43CTZecdkiaq/f48rTVG1pDl5DCxMKqDUVPNcbyCQ=;
        b=Ihyw8Yj/XzNZtPpwFX5WSMsAmheU5cb59XIZmcfWY3qNavH7Na7HgqYrIyKLIbIHPN
         uazYFXmoBLmuS03IvIgCYsRxvctQ1xRK9iNnRoyIqQo7OrsiHvmU4lCFzmsgdYBnceQv
         syPQfqQ332kYx+v3F81g6byN8aLPaOvY7iz+NSuEgsqjN1jYqn05ArFRrsEhIKfiBXad
         HCiThtbqpEsTq5HbZBGeFX6E6jUV/MVDlbUcyDR/CO38vPPATvp8zOqBuke0jsO3NWfB
         gbjIZpPxaWc0I4op8rBw873/o+kCSS9p1kE62J6xZbVFHvQSlWeumRLNd48Szzpg96ds
         zk0A==
X-Gm-Message-State: AD7BkJKP+wrIcLNIVLfbk+Mavdw4jrnajrbO7mZ9Nvp3UAnryLGx+WsWDYYsUmxG9MOusSQq3TFfWYMQC83+QU/E
X-Received: by 10.50.112.10 with SMTP id im10mr1249081igb.93.1456868366762;
 Tue, 01 Mar 2016 13:39:26 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Tue, 1 Mar 2016 13:39:26 -0800 (PST)
In-Reply-To: <20160301204218.GA4083@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288067>

On Tue, Mar 1, 2016 at 12:42 PM, Joey Hess <id@joeyh.name> wrote:
>         git init gitdir
>         mkdir worktree
>         cd worktree
>         ln -s ../gitdir/.git .git
>         git submodule add /any/git/repo sub
>
>         fatal: Could not chdir to '../../../sub': No such file or directory
>
> Fairly sure this is a bug..

Which version(s) of Git do you use?
