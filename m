From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/7] Small changes
Date: Sat, 03 Mar 2007 14:15:23 -0800
Message-ID: <7vps7q7z44.fsf@assigned-by-dhcp.cox.net>
References: <15313.1172917217@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, julliard@winehq.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 23:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNcVp-0004RW-6B
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 23:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbXCCWP0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 17:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933104AbXCCWP0
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 17:15:26 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:39322 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932931AbXCCWPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 17:15:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070303221525.XBA1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 17:15:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WNFQ1W0091kojtg0000000; Sat, 03 Mar 2007 17:15:24 -0500
In-Reply-To: <15313.1172917217@localhost> (Xavier Maillard's message of "Sat,
	03 Mar 2007 11:20:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41333>

Xavier Maillard <zedek@gnu.org> writes:

> * Makefile: add git-blame as a candidate to the
>   byte-compilation. Change the function to call to byte-compile.

Could we have a bit more detailed description on the latter
change?

Explaining why something needed a change is the point of a
commit log message.  Summarizing what got changed and how is
good but that is secondary, because anybody can see that you
changed the handcrafted --eval to -f by running "git show", even
if you did not have the above proposed log message.

What is left unsaid is _why_ it is better to use single dash
form of "-batch" and -f form instead of handcrafted --eval, and
the proposed log message does not clarify the reason.

>  %.elc: %.el
> -	$(EMACS) --batch --eval '(byte-compile-file "$<")'
> +	$(EMACS) -batch -f batch-byte-compile $<
>  
>  clean:; rm -f $(ELC)
