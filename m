From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] run_diff_{files,index}(): update calling convention.
Date: Sat, 10 Feb 2007 07:13:37 -0800
Message-ID: <7vd54im4f2.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	<Pine.LNX.4.64.0702091253120.8424@woody.linux-foundation.org>
	<7vmz3mq394.fsf@assigned-by-dhcp.cox.net>
	<7vejoyq330.fsf@assigned-by-dhcp.cox.net>
	<7vy7n6ohc3.fsf_-_@assigned-by-dhcp.cox.net>
	<e5bfff550702100002y3929c50mfb99b8da44c9c82b@mail.gmail.com>
	<7vps8imnis.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550702100029h65d1fd3fke5496da0664642ee@mail.gmail.com>
	<e5bfff550702100046m1c0b1931t11ed0cf95853cda9@mail.gmail.com>
	<7vhctumh1m.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550702100325v5ce9ba1fx4b9b7adcc5040948@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"GIT list" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 10 16:13:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFtvE-0004vW-H3
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 16:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbXBJPNj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 10:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbXBJPNj
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 10:13:39 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36634 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932594AbXBJPNi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 10:13:38 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070210151337.OAGS4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 10 Feb 2007 10:13:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id MrDd1W00K1kojtg0000000; Sat, 10 Feb 2007 10:13:38 -0500
In-Reply-To: <e5bfff550702100325v5ce9ba1fx4b9b7adcc5040948@mail.gmail.com>
	(Marco Costalba's message of "Sat, 10 Feb 2007 12:25:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39229>

"Marco Costalba" <mcostalba@gmail.com> writes:

> So in this case your patch that introduce '--refresh' option in 'git
> runstatus' is not just a shortcut for 'git update-index' + 'git
> runstatus' but adds some real value.
>
> One more reason for asking you to add it before 1.5 release ;-)

The thing is, it touches central part of the system by changing
the calling convention of two rather important functions.  You
might have already fully tested that there is no regression for
git-runstatus, but it affects other callers as well.  I tried to
be careful when I did the conversion but I am not 100% sure
there is no "unintended side effects".
