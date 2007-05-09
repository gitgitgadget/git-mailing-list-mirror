From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Wed, 09 May 2007 00:13:17 -0700
Message-ID: <7vd51axyeq.fsf@assigned-by-dhcp.cox.net>
References: <4640FBDE.1000609@gmail.com>
	<7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.99.0705082010230.24220@xanadu.home>
	<56b7f5510705081729t34a585c6y9ca9e2f9963d24a2@mail.gmail.com>
	<alpine.LFD.0.99.0705082031370.24220@xanadu.home>
	<56b7f5510705082346m32d3c48dj987fd9b0a6118c10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 09:13:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlgMY-0004hX-Ie
	for gcvg-git@gmane.org; Wed, 09 May 2007 09:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbXEIHNU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 03:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755506AbXEIHNU
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 03:13:20 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62078 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbXEIHNT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 03:13:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509071318.KZNV22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 03:13:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id wvDH1W0071kojtg0000000; Wed, 09 May 2007 03:13:17 -0400
In-Reply-To: <56b7f5510705082346m32d3c48dj987fd9b0a6118c10@mail.gmail.com>
	(Dana How's message of "Tue, 8 May 2007 23:46:57 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46674>

"Dana How" <danahow@gmail.com> writes:

> This doesn't interact well with each variable being processed
> completely independently in git_config() and the callbacks it calls.
> The isset() value is "out-of-band"; either store it in the _seen
> variables, or some special value in used_value .
>
> Which makes the most sense:
> * Leave _seen as-is;
> * Move pack.compression recognition into config.c which means
>  the _seen variables would all be local to config.c;
> * Use some special value, and if still present replace it with the default
>  at the end of git_config() using extra code;
> * Change the config rule to something simpler.
>
> I like the 2nd and the 4th.  You didn't like the 4th.
> Shall I change to the 2nd?

FWIW, I am Ok with (1).
