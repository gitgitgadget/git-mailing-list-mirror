From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] describe: add option --dirty
Date: Sun, 22 Jul 2007 23:56:58 -0700
Message-ID: <7vsl7fmwud.fsf@assigned-by-dhcp.cox.net>
References: <87odi3mxtl.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 08:57:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICrrC-0006S0-5e
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 08:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757813AbXGWG5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 02:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763579AbXGWG5I
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 02:57:08 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:60579 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763465AbXGWG5E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 02:57:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070723065702.PAIV1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Jul 2007 02:57:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Suwy1X00N1kojtg0000000; Mon, 23 Jul 2007 02:56:59 -0400
In-Reply-To: <87odi3mxtl.wl@mail2.atmark-techno.com> (Yasushi SHOJI's message
	of "Mon, 23 Jul 2007 15:35:50 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53398>

Yasushi SHOJI <yashi@atmark-techno.com> writes:

> when --dirty is given, git describe will check the working tree and
> append "-dirty" to describe string if the tree is dirty.
> ---
> I'm not sure this is good idea or the current way (using diff-index in
> shell script) is more prefered.

Hmph, this makes sense _ONLY_ for HEAD, doesn't it?

IOW, what should this output?

	$ git checkout v1.5.0 ;# detached HEAD
        $ git reset --hard  ;# clean slate
        $ echo >>Makefile ;# not anymore
        $ git describe --dirty v1.4.0^1

Should it say "v1.4.0-rc2-156-g0a8f4f0-dirty"?  The dirtiness
does not have anything to do with commit v1.4.0^1, so...
