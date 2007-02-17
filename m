From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] name-rev: introduce the --ref-filter=<pattern> option
Date: Sat, 17 Feb 2007 11:00:31 -0800
Message-ID: <7v3b54txrk.fsf@assigned-by-dhcp.cox.net>
References: <20070127040618.GA14205@fieldses.org>
	<Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org>
	<20070127044246.GC14205@fieldses.org>
	<20070127045552.GB9966@spearce.org>
	<7vhcudoxfj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701271334410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0702171502040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vlkiwvfy5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702171921130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 17 20:00:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIUnU-0001iK-5M
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 20:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbXBQTAd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 14:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbXBQTAc
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 14:00:32 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:55392 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932765AbXBQTAc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 14:00:32 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217190031.DKWH21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 14:00:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qj0X1W00A1kojtg0000000; Sat, 17 Feb 2007 14:00:31 -0500
In-Reply-To: <Pine.LNX.4.63.0702171921130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 17 Feb 2007 19:22:35 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40009>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Instead of (or, in addition to) --tags, to use only tags for naming,
> you can now use --ref-filter=<patter> to specify a shell pattern
> which the refs must match to be used for naming.
>
> Example:
>
> 	$ git name-rev --ref-filter=*v1* 33db5f4d
> 	33db5f4d tags/v1.0rc1^0~1593
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Thanks.  It's a bit counterintuitive that the first asterisk in
your example "*v1*" matches something that contains a slash, but
at least the patch makes it usable for me.

By the way, v1.0rc1^0~1593 is the same as v1.0rc1~1593.
Technically, the latter loses the information that the starting
ref is a tag, but I wonder if it is worth keeping that
information at the expense of (slightly) uglier output.
