From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: refining .gitignores
Date: Thu, 15 Nov 2007 00:02:58 +0100
Message-ID: <20071114230258.GG3973@steel.home>
References: <804pfobgkp.fsf@tiny.isode.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 00:03:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsRGu-0005Fz-CN
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 00:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756181AbXKNXDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 18:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756099AbXKNXDF
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 18:03:05 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:39724 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755745AbXKNXDC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 18:03:02 -0500
Received: from tigra.home (Fad5d.f.strato-dslnet.de [195.4.173.93])
	by post.webmailer.de (mrclete mo37) (RZmta 14.0)
	with ESMTP id 4026f0jAEHLYWn ; Thu, 15 Nov 2007 00:02:59 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 10A78277AE;
	Thu, 15 Nov 2007 00:02:59 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id DC3C856D22; Thu, 15 Nov 2007 00:02:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <804pfobgkp.fsf@tiny.isode.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyCll4dQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65023>

Bruce Stephens, Wed, Nov 14, 2007 23:36:06 +0100:
> How do I get a list of files (in HEAD, say) that would be ignored by
> the .gitignore files (and the other usual settings)?
> 
> It feels like something like this ought to work:
> 
>      git ls-files -z | xargs -0 git ls-files --ignored
> 
> But listing its arguments that are ignored by .gitignore (etc.)
> doesn't seem to be what "git ls-files --ignored" does.  Or at least,
> not quite as straightforwardly as that.

git ls-files --exclude-per-directory=.gitignore -X .git/info/exclude -i -o

> The motivation is (obviously) that I fear some of the .gitignore
> patterns are too broad, and a reasonable check is that none of the
> files that are already committed would be caught by the patterns.

git ls-files --exclude-per-directory=.gitignore -X .git/info/exclude -i

(IOW, remove the -o aka --others)
