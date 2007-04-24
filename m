From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Only use ETC_GITCONFIG=$(prefix)/etc/gitconfig ifeq ($(prefix),$(HOME))
Date: Mon, 23 Apr 2007 23:17:01 -0700
Message-ID: <7v1wia9u02.fsf@assigned-by-dhcp.cox.net>
References: <462D673A.1010805@freedesktop.org>
	<7v8xci9uea.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 08:17:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgEL9-000695-Ji
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 08:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161652AbXDXGRT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 02:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161654AbXDXGRT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 02:17:19 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62373 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161652AbXDXGRD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 02:17:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424061702.UDFJ1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Apr 2007 02:17:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id quH11W00K1kojtg0000000; Tue, 24 Apr 2007 02:17:02 -0400
In-Reply-To: <7v8xci9uea.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 23 Apr 2007 23:08:29 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45417>

Junio C Hamano <junkio@cox.net> writes:

> Josh Triplett <josh@freedesktop.org> writes:
>
>> ETC_GITCONFIG defaults to $(prefix)/etc/gitconfig, so if you just set
>> prefix=/usr or prefix=/usr/local, you end up with a git that looks in
>> /usr/etc/gitconfig or /usr/local/etc/gitconfig.  That seems rather suboptimal.
>>
>> Use ifeq in the Makefile to set ETC_GITCONFIG=/etc/gitconfig unless the prefix
>> points to $HOME .
>
> I personally have four installations of git under $HOME by
> setting prefix to $HOME/git-{maint,master,next,pu}.  I would
> rather not see this to break, as I suspect there are other
> people who depend on this behaviour.

Also what happens to people who use "prefix=/usr/local"?
