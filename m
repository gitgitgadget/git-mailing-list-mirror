From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rename_ref(): only print a warning when config-file update fails
Date: Fri, 06 Apr 2007 13:35:52 -0700
Message-ID: <7v1wixkzpz.fsf@assigned-by-dhcp.cox.net>
References: <11758483861506-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Bosch <bosch@gnat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 00:21:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZvA5-0000Dh-Gz
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 22:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932933AbXDFUfy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 16:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932854AbXDFUfy
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 16:35:54 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:48192 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932933AbXDFUfx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 16:35:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070406203553.DQOL373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Apr 2007 16:35:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id jwbs1W00D1kojtg0000000; Fri, 06 Apr 2007 16:35:52 -0400
In-Reply-To: <11758483861506-git-send-email-hjemli@gmail.com> (Lars Hjemli's
	message of "Fri, 6 Apr 2007 10:33:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43920>

Lars Hjemli <hjemli@gmail.com> writes:

> If git_config_rename_section() fails, rename_ref() used to return 1, which
> left HEAD pointing to an absent refs/heads file (since the actual renaming
> had already occurred).

I wonder if rolling back the rename that was asked is an
option.  We would want to keep these low-level things atomic
whenever possible.
