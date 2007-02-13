From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svn test suite failures due to Subversion race
Date: Mon, 12 Feb 2007 19:03:13 -0800
Message-ID: <7vhctq4v4e.fsf@assigned-by-dhcp.cox.net>
References: <45CFDFDE.8080907@uwaterloo.ca>
	<20070212103822.GA21413@localdomain> <45D1239C.4040706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Michael Spang <mcspang@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 04:03:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGnxH-0006ko-7H
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 04:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030623AbXBMDDP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 22:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030627AbXBMDDP
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 22:03:15 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:39783 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030623AbXBMDDO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 22:03:14 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213030313.ZEED21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Feb 2007 22:03:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Nr3D1W00k1kojtg0000000; Mon, 12 Feb 2007 22:03:14 -0500
In-Reply-To: <45D1239C.4040706@gmail.com> (Michael Spang's message of "Mon, 12
	Feb 2007 21:34:04 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39483>

Michael Spang <mcspang@gmail.com> writes:

> I've had no failures with the patch (without it, they are quite frequent).
>

I've seen the failures myself without the patch, and working it
around is a good thing, however...

> Cheers,
> Michael Spang
> From f3a86250469df6607b71da235ac69ccb82d59fd9 Mon Sep 17 00:00:00 2001
> From: Michael Spang <mspang@uwaterloo.ca>
> Date: Mon, 12 Feb 2007 19:33:37 -0500
> Subject: [PATCH] Work around Subversion race in git-svn tests.
>
> +poke() {
> +	touch -r "$1" -d +1sec "$1"
> +}

I wonder how portable this might be.
