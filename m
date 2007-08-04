From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Shell script cleanups/style changes?
Date: Sat, 04 Aug 2007 13:39:09 -0700
Message-ID: <7v3ayzjaqa.fsf@assigned-by-dhcp.cox.net>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
	<86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
	<873ayzojw7.fsf@mid.deneb.enyo.de>
	<20070804203220.GZ29424@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 22:39:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHQP4-000487-Qf
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 22:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763132AbXHDUjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 16:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761974AbXHDUjM
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 16:39:12 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37218 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761927AbXHDUjK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 16:39:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070804203910.KMUM23215.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 4 Aug 2007 16:39:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Xwf91X0021kojtg0000000; Sat, 04 Aug 2007 16:39:09 -0400
In-Reply-To: <20070804203220.GZ29424@schiele.dyndns.org> (Robert Schiele's
	message of "Sat, 4 Aug 2007 22:32:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54905>

Robert Schiele <rschiele@gmail.com> writes:

> Hi Florian,
>
> I recommend you read the other mails in this thread.  This issue is already
> completely resolved.

To be a bit more helpful, a short summary is:

 * SHELL_PATH in Makefile lets you munge installed scripts;

 * /bin/ksh is usable on Solaris and xpg4 is fine too;

 * We need to draw a line somewhere, and the current rule is
   that we cannot afford to support a shell that does not
   understand $(cmd) substitution, as we haven't seen a shell
   that supports ${parameter#word} but not $(cmd).
