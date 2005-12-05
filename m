From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config.c: remove unnecessary header in minimum configuration file.
Date: Mon, 05 Dec 2005 13:47:47 -0800
Message-ID: <7vzmnf9px8.fsf@assigned-by-dhcp.cox.net>
References: <7v7jawmkpo.fsf@assigned-by-dhcp.cox.net>
	<7vu0docrqz.fsf@assigned-by-dhcp.cox.net> <4394255D.1030009@op5.se>
	<Pine.LNX.4.63.0512052124400.4026@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vek4rb6vc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512052202300.12016@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 22:51:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjOBy-0001Rr-6q
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 22:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVLEVr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 16:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVLEVr4
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 16:47:56 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:39138 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964810AbVLEVrz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 16:47:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051205214716.LXLX3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Dec 2005 16:47:16 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13237>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, reading the code I am not satisfied. If there is no template for 
> the config file, it does not test the filemode at all.

I have a feeling that you have not tried the code you are
arguing against.

It always creates the config file because it needs to record the
repository format version (among other things), so the config
file exists even if you do not have templates.  Even if you do
not have a valid template directory that is supposed to work,
but obviously you have not tried it ;-).

Now, it is arguable that the current format version being 0, and
not having the format version is equivalent to having 0 as the
format version, it is not necessary to create an empty
configuration file at this moment, but by making sure we record
the format version the tool that created the repository supports
now in the version 0, we do not have to risk forgetting to add
that logic later when we _do_ need to write something non-zero.
