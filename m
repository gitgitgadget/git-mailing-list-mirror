From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Introduce file with the common default build-time items.
Date: Thu, 14 Jun 2007 00:36:33 -0400
Message-ID: <20070614043633.GV6073@spearce.org>
References: <20070613054316.GN86872@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Thu Jun 14 06:36:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyh4d-0007UM-MC
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 06:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbXFNEgj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 00:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbXFNEgj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 00:36:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54516 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbXFNEgi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 00:36:38 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1Hyh4W-0002TJ-8V; Thu, 14 Jun 2007 00:36:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4B49920FBAE; Thu, 14 Jun 2007 00:36:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070613054316.GN86872@void.codelabs.ru>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50164>

Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> Words 'wish' and 'tclsh' are scattered across at least three files,
> but they are tied to the same entities.  To ease the maintenance
> and remove errors, these configuration items were gathered into the
> separate file named 'common-make-vars.def'.
...
> diff --git a/git-gui/Makefile b/git-gui/Makefile
> index 3de0de1..654641a 100644
> --- a/git-gui/Makefile
> +++ b/git-gui/Makefile
> @@ -6,6 +6,8 @@ all::
>  GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
>  	@$(SHELL_PATH) ./GIT-VERSION-GEN
>  -include GIT-VERSION-FILE
> +# Default values
> +-include ../common-make-vars.def

A good idea to try and make these all common, but you cannot do this,
or at least this part of the patch.

The git-gui subdirectory of git.git is actually its own project,
maintained in its own Git repository.  It appears inside of
git.git only as a convience for users.  So I cannot reference
../common-make-vars.def as not all git-gui repositories have a
git.git repository wrapped around them.

-- 
Shawn.
