From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [Advance Warning PATCH] Move gitk to its own subdirectory
Date: Sun, 18 Nov 2007 00:25:19 +0100
Message-ID: <20071117232519.GA7664@steel.home>
References: <7vsl34u1iv.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 00:25:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItX2m-0006OS-LW
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 00:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbXKQXZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 18:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752445AbXKQXZX
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 18:25:23 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:8474 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbXKQXZW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 18:25:22 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAPrzg==
Received: from tigra.home (Fc945.f.strato-dslnet.de [195.4.201.69])
	by post.webmailer.de (fruni mo23) (RZmta 14.3)
	with ESMTP id I00db2jAHLVoI1 ; Sun, 18 Nov 2007 00:25:20 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 37629277AE;
	Sun, 18 Nov 2007 00:25:20 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 82F0A56D22; Sun, 18 Nov 2007 00:25:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vsl34u1iv.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65319>

Junio C Hamano, Sat, Nov 17, 2007 20:15:20 +0100:
> The plan is to stop merging gitk.git as a single file project
> into git.git but instead use the subtree merge strategy into its
> own subdirectory of git.git.  We can use subproject support in
> the future, but once _a_ subproject is used that means the
> project's history is not pullable with subproject unaware
> versions of git anymore, so I'd avoid it for now.

You made it part of "all" target, which we will have to change if gitk
is to become a subproject: Makefile better handle absence of the
Makefile under gitk-git, and continue build.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Makefile              |   14 +++-----------
>  gitk-git/Makefile     |   29 +++++++++++++++++++++++++++++
>  gitk => gitk-git/gitk |    0 
>  3 files changed, 32 insertions(+), 11 deletions(-)
>  create mode 100644 gitk-git/Makefile
>  rename gitk => gitk-git/gitk (100%)
>  mode change 100755 => 100644
...
>  all::
>  ifndef NO_TCLTK
>  	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) all
> +	$(QUIET_SUBDIR0)gitk-git $(QUIET_SUBDIR1) all

maybe "git-gitk" instead of "gitk-git"? As "git-gui" and "gitweb"...
Maybe even shorter: "gui", "web" and "k" :)
