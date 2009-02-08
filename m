From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: tool and worktree
Date: Sun, 8 Feb 2009 10:47:48 +0100
Message-ID: <2c6b72b30902080147u61412b04w24baa0e5fdc29584@mail.gmail.com>
References: <20090208034406.GB7230@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 08 10:50:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW6Hv-0004e2-Nr
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 10:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbZBHJrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 04:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbZBHJrx
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 04:47:53 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:61825 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbZBHJrv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 04:47:51 -0500
Received: by fxm13 with SMTP id 13so2059975fxm.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 01:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Z8LTQfSc3IwVs4AMRQwqvs9ipKDe6bmCJFoNx91x4NY=;
        b=pG3cpJLh57t6XoTMTc2KqSM6SNmvYZZqrijireX9pFfS4bfIi/vdNOi050nYpCcdkB
         iBD9Z0k6/ZPBVfEA+vCr9/MtrNG6NY5Z7cZObCkiCy+B5+BLPw4GIYa5I958k9/7R1vF
         zkrjlxpDqRGhImZCz+QFyAzS9jduu5yx6aOgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=dgI64UoblbKScY/BfBRy+igIcFhseJze1pwCaILZ+VEU7bANqbgSndUl9nlbs8ZIy0
         EE+DNaRYMXzAnxX+A0FLFCdC8CcNWHCjQAqMnT9ChhgsZRJGmVNOxB8FxGlq26kXDrMo
         UbmBOy3IygTGVoXNOVQ52eecV3sPPXVjcUakE=
Received: by 10.181.138.13 with SMTP id q13mr238553bkn.42.1234086468448; Sun, 
	08 Feb 2009 01:47:48 -0800 (PST)
In-Reply-To: <20090208034406.GB7230@b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108938>

On Sun, Feb 8, 2009 at 04:44, bill lam <cbill.lam@gmail.com> wrote:
> I track /etc using a config
>
> [core]
>        repositoryformatversion = 0
>        filemode = true
>        bare = false
>        worktree = /etc
>        logAllRefUpdates = true
>        excludesfile =
>
> But that can not be handled by tools,
>
> tig : status view said, The status view requires a working tree

Yes, on startup, tig checks git-rev-parse --is-inside-work-tree and
disables things like the status view if it is false. I don't know how
much work it would be to start using core.worktree. It might be as
simple as setting the GIT_DIR environment to getcwd() + output of
git-rev-parse --git-dir and then chdir() to core.worktree.

-- 
Jonas Fonseca
