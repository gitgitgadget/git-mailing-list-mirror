From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] gitweb: Add an option to show size of blobs in the tree view
Date: Tue, 31 Jul 2007 15:12:03 -0700
Message-ID: <7vd4y8fcjw.fsf@assigned-by-dhcp.cox.net>
References: <1185880790812-git-send-email-jnareb@gmail.com>
	<11858807944170-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 00:12:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFzwr-0004L0-KF
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 00:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbXGaWMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 18:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757513AbXGaWMH
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 18:12:07 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:54273 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217AbXGaWMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 18:12:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070731221205.MNGI26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 31 Jul 2007 18:12:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WNC31X00U1kojtg0000000; Tue, 31 Jul 2007 18:12:04 -0400
In-Reply-To: <11858807944170-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Tue, 31 Jul 2007 13:19:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54377>

Jakub Narebski <jnareb@gmail.com> writes:

> It allows to play with 'tree' view with blob size. Currently you
> have to start browsing by adding ";opt=-l" to the gitweb URL by
> hand.  There is not link which will change view from ordinary 'tree'
> view to 'tree' view with blob sizes.
>
> The 'tree' with blob size view is slightly more costly than the
> ordinary, old 'tree' view, but not much more (0.018s vs 0.012s
> in the hot cache case), so I don't think we need to control it
> as a enabled (or disabled) feature, overrideable or not.  It
> probably should not be default.

I do not think there is any reason to forbid its use, as the
"-l" to ls-tree was introduced for exactly this purpose,
However, it might make sense to make the use of -l optional via
the %feature mechanism.  50% increase even on hot cache case is
not a price people who run busy sites would want to pay.
