From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RESEND PATCH] fast-import: Cleanup mode setting.
Date: Tue, 13 Jan 2009 18:17:51 -0800
Message-ID: <20090114021751.GW10179@spearce.org>
References: <1231897027-16197-1-git-send-email-felipe.contreras@gmail.com> <alpine.DEB.1.00.0901140308200.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 03:19:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMvLg-0000fL-4i
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 03:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914AbZANCRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 21:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753322AbZANCRx
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 21:17:53 -0500
Received: from george.spearce.org ([209.20.77.23]:57780 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbZANCRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 21:17:52 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id EDFFF38210; Wed, 14 Jan 2009 02:17:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901140308200.3586@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105574>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 14 Jan 2009, Felipe Contreras wrote:
> 
> > "S_IFREG | mode" probably is only required for 0644 and 0755.
> 
> Why should we want to have that patch?  IOW what does it fix, and what 
> might it break?

It cleans up the code to make it more readable.

It makes no sense to be doing S_IFREG | S_IFLINK, which happens when
the input is for a symlink.  It doesn't break anything to do that |
operation, but it also looks damn odd when reading the function.

-- 
Shawn.
