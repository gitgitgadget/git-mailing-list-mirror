From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Sun, 20 May 2007 03:03:20 -0700
Message-ID: <7vabvzq0bb.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 12:03:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpiG6-0002gg-PR
	for gcvg-git@gmane.org; Sun, 20 May 2007 12:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756524AbXETKDW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 06:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756756AbXETKDW
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 06:03:22 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:36256 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756524AbXETKDV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 06:03:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520100321.EMSZ6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 20 May 2007 06:03:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1N3L1X0081kojtg0000000; Sun, 20 May 2007 06:03:21 -0400
In-Reply-To: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com>
	(Marco Costalba's message of "Sun, 20 May 2007 11:51:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47811>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Signed-off-by: Marco Costalba <mcostalba@gmail.com>
> ---
>
> This one seems to pass all the tests.

I think this happens to work because you are not feeding -u0
patch; if you have more than one context, then a hunk that ends
with + line is guaranteed to apply only at the end,  With a
diff prepared with -u0, that is not true anymore, is it?

We can argue that -u0 patch is crazy but we do support them.
