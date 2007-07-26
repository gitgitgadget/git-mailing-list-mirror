From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/5] Clean up work-tree handling
Date: Thu, 26 Jul 2007 02:56:50 -0400
Message-ID: <20070726065650.GC18114@spearce.org>
References: <Pine.LNX.4.64.0707260729150.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 08:57:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDxHV-0008Qa-Fm
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 08:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757675AbXGZG44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 02:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758540AbXGZG4z
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 02:56:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42573 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395AbXGZG4z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 02:56:55 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IDxHH-00088f-DX; Thu, 26 Jul 2007 02:56:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8451A20FBAE; Thu, 26 Jul 2007 02:56:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707260729150.14781@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53792>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> In related news, there is a long standing bug fixed: when in
> .git/bla/x.git/, which is a bare repository, git formerly assumed
> ../.. to be the appropriate git dir.

Heh.  I spent about 10 minutes last week trying to understand why
git-new-workdir was failing horribly on one user's system.

Turns out they once managed to do:

  cd /
  git init

a long, long, long time ago and just didn't notice it until now.  git
kept finding /.git rather than the .git it was supposed to locate,
which was a bare repository in $HOME/.storage-pool/dayjob.git.
 
-- 
Shawn.
