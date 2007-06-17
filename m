From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 1/2] git-submodule: move cloning into a separate function
Date: Sun, 17 Jun 2007 16:38:02 +0200
Message-ID: <20070617143802.GV955MdfPADPa@greensroom.kotnet.org>
References: <11810357523435-git-send-email-hjemli@gmail.com>
 <11810357522478-git-send-email-hjemli@gmail.com>
 <46653DB2.997A3ABD@eudaptics.com> <op.ttf34qd99pspc6@localhost>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <J.Sixt@eudaptics.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 16:38:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzvtN-00005e-FO
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 16:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758176AbXFQOiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 10:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757202AbXFQOiJ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 10:38:09 -0400
Received: from smtp15.wxs.nl ([195.121.247.6]:58803 "EHLO smtp15.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753437AbXFQOiI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 10:38:08 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp15.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JJS00H6LBBFLN@smtp15.wxs.nl> for git@vger.kernel.org; Sun,
 17 Jun 2007 16:38:07 +0200 (CEST)
Received: (qmail 2536 invoked by uid 500); Sun, 17 Jun 2007 14:38:02 +0000
In-reply-to: <op.ttf34qd99pspc6@localhost>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50350>

On Tue, Jun 05, 2007 at 01:13:28PM +0200, Lars Hjemli wrote:
> +module_clone()
> +{
> +	path=$1
> +	url=$2
> +
> +	# If there already is a directory at the submodule path,
> +	# expect it to be empty (since that is the default checkout
> +	# action) and try to remove it.
> +	# Note: if $path is a symlink to a directory the test will
> +	# succeed but the rmdir will fail. We might want to fix this.
> +	if test -d "$path"
> +	then
> +		rmdir "$path" 2>/dev/null ||
> +		die "Directory '$path' exist, but is neither empty nor a git repository"

What makes you say that '$path' is not a git repository?

skimo
