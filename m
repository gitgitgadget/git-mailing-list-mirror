From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Support comparing blobs (files) with different names
Date: Thu, 05 Apr 2007 03:38:49 -0700
Message-ID: <7vircbqf5y.fsf@assigned-by-dhcp.cox.net>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at>
	<7vmz1t6oe2.fsf@assigned-by-dhcp.cox.net>
	<200704031657.25698.jnareb@gmail.com>
	<200704042327.49632.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 12:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZPMk-0004O2-07
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 12:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966076AbXDEKiv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 06:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966077AbXDEKiv
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 06:38:51 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:59896 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966076AbXDEKiu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 06:38:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405103850.HRS792.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 06:38:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jNep1W0091kojtg0000000; Thu, 05 Apr 2007 06:38:49 -0400
In-Reply-To: <200704042327.49632.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 4 Apr 2007 23:27:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43815>

Jakub Narebski <jnareb@gmail.com> writes:

> As to browsers: Mozilla 1.7.12 implements RFC2183 correctly, although for
> example shows %0A / \n as a strange symbol in "save as" dialog, created
> file has embedded newline in filename, as it should. But both Lynx 2.8.5,
> and ELinks 0.10.3 do not implement it fully and without errors.
>
> So that is why we have:
>
> 	# It not worth potential problems to try to carry newlines
> 	# in the header; it is just _suggested_ filename
> 	$filename =~ s/[[:cntrl:]\n\r]/_/g;

I think the logic in the comment is very sane, although I am not
sure if saying \n \r when you say :cntrl: is necessary.
