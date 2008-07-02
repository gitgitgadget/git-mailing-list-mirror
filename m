From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui fails to start
Date: Wed, 2 Jul 2008 00:53:52 -0400
Message-ID: <20080702045352.GM11793@spearce.org>
References: <20080627002307.GE2620@tigger.digitaltorque.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Michael P. Soulier" <msoulier@digitaltorque.ca>
X-From: git-owner@vger.kernel.org Wed Jul 02 06:54:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDuMn-0001vz-T3
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 06:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbYGBEx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 00:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbYGBEx5
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 00:53:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50689 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933AbYGBEx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 00:53:56 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KDuLq-0002S9-QL; Wed, 02 Jul 2008 00:53:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A357B20FBAE; Wed,  2 Jul 2008 00:53:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080627002307.GE2620@tigger.digitaltorque.ca>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87084>

"Michael P. Soulier" <msoulier@digitaltorque.ca> wrote:
> 
> I'm on a CentOS Linux box, tracking 4.6 with Git 1.5.5.4 built
> from source.
>
> When I run gitk on a repository it works fine, but nothing happens when I run
> git-gui. No error messages, nothing. 
...
> and then it just sits there. 
> 
> I have Tcl/Tk 8.4.9. 

I think this was fixed in gitgui-0.10.2, which did not ship with
Git proper until 1.5.6-rc0.  Now that 1.5.6.1 has been released I
would encourage you to upgrade to the latest stable release of Git.

The issue was aspell earlier than 0.60 caused git-gui to deadlock
because it didn't understand "$$cr master", which git-gui sends
on startup when it launches the background spell checker.

You can also work around the issue by disabling the spell checker:

	git config --global gui.spellingdictionary none

-- 
Shawn.
