From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Relative alternates question
Date: Fri, 10 Aug 2007 12:38:50 -0700
Message-ID: <7vfy2rrxh1.fsf@assigned-by-dhcp.cox.net>
References: <20070810164556.GB3442@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Aug 10 21:38:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJaK2-0004Bq-Jm
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 21:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760327AbXHJTix (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 15:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759173AbXHJTiw
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 15:38:52 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:57928 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304AbXHJTiw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 15:38:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070810193850.JEWW7193.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 10 Aug 2007 15:38:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aKer1X0031kojtg0000000; Fri, 10 Aug 2007 15:38:51 -0400
In-Reply-To: <20070810164556.GB3442@efreet.light.src> (Jan Hudec's message of
	"Fri, 10 Aug 2007 18:45:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55570>

Jan Hudec <bulb@ucw.cz> writes:

> And my question is, is there any good reason to reject relative paths in
> alternates of an alternate? From what I see the recursive call to
> link_alt_odb_entries (via link_alt_odb_entry and read_info_alternates) has
> all the information it needs to resolve such paths.

As long as you are careful not to introduce loops that cause the
rest of the code to add the same thing twice, I do not think
there is anything fundamentally wrong with relative alternate
paths.  The original motivation of that check was not much more
than "let's not complicate our lives by supporting it", I think.
