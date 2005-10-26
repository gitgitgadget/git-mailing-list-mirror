From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Tue, 25 Oct 2005 17:12:58 -0700
Message-ID: <7vd5ltcf05.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510260120260.28994@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 02:14:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUYue-0000hq-Jr
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 02:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVJZANA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 20:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbVJZANA
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 20:13:00 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:39165 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932500AbVJZAM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 20:12:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051026001242.NLBZ4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Oct 2005 20:12:42 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510260120260.28994@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 26 Oct 2005 01:22:11 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10640>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Using dc is not really necessary, since expr understands summing 32 bit 
> signed integers. Which means that git-count-objects will now fail when 2 
> GB of unpacked objects have accumulated.

Sorry, but I am not very happy about this patch.  "local"
bashism aside, doesn't this spawn expr for every unpacked
object?
