From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: question: connecting to multiple remote svn projects
Date: Fri, 6 Nov 2009 14:51:28 -0500
Message-ID: <32541b130911061151q68ddcc58w209acf28c5eec2f@mail.gmail.com>
References: <hd1nv2$79e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Dave Rodgman <dav1dr@eml.cc>
X-From: git-owner@vger.kernel.org Fri Nov 06 20:51:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Uqg-0000pm-Cx
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 20:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759696AbZKFTvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 14:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759688AbZKFTvn
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 14:51:43 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:50379 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759052AbZKFTvm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 14:51:42 -0500
Received: by ywh40 with SMTP id 40so1191231ywh.33
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 11:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=grNnhQ64izwmrTcFX6q3oH66FWhN2GyvzvPdRHZBhts=;
        b=wp0ICTvWGvcrf1ibCxGvGS5/yhNICum+5cixWpbWYLE1LR1Y7vClXexPXuQrRmReKC
         WA8gM4G6b+BJ3GFzzF4jbtCmh2RvJ3zj8Ccmi3MLZtFBK1SkyxDudpZscV6QoKWJNS8U
         9jfcWs/wzx4yjJDXvAQIh9vWkYyxnJXdt0gUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=RUS1ZwLOWigpLNSUHOhi9Ak8cyPfEapYhPiEzDCXFUndf4TMHXIuRSeaAD9wuI72wu
         vkdcJ6T1ZOrjQJKNUUgSqp5gyIYC42L8ombPf8ecGN4xTP9Ox4HGSPKJoX3he6RSNNcW
         +zPYBwCJbwa224XFCx5qJ5WdKyhHurrIbOVuc=
Received: by 10.150.237.10 with SMTP id k10mr8563062ybh.112.1257537108085; 
	Fri, 06 Nov 2009 11:51:48 -0800 (PST)
In-Reply-To: <hd1nv2$79e$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132323>

On Fri, Nov 6, 2009 at 12:55 PM, Dave Rodgman <dav1dr@eml.cc> wrote:
> Given a layout in a single subversion repository like this:
>
> module1/branches/1.0/work
> module2/branches/1.0/work
>
> I would like achieve the following layout locally, in git:
>
> module1/work
> module2/work
>
> Obviously I can create multiple git repositories in separate directories,
> but I would like them to be in a single repository. I can also get the
> same layout as subversion, but this breaks various bits of build
> infrastructure.

Can you just create the file structure you want using symlinks?  That
would be the easiest way.

> I don't care about tracking the subversion branches in git, or being able
> to switch between subversion branches.

Don't care about tracking *any* subversion history, or just the
history of branches other than the 1.0 branch you've listed above?  I
assume the latter, because otherwise the problem is easy (just copy
the latest revision of the files into a git repo and commit).

Other options that might work for you: create a "superproject" branch
and import the two modules using git-submodule, or else import them
using git-subtree (http://github.com/apenwarr/git-subtree).  Or import
the svn history and then use git-filter-branch to move stuff around.

Good luck.

Avery
