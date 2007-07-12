From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Function stripspace now gets a buffer instead file descriptors.
Date: Wed, 11 Jul 2007 17:03:23 -0700
Message-ID: <7v8x9m1oac.fsf@assigned-by-dhcp.cox.net>
References: <4695267A.7080202@gmail.com>
	<7vd4yy1svw.fsf@assigned-by-dhcp.cox.net>
	<18069.26029.224024.66576@lisa.zopyra.com>
	<1b46aba20707111641y615ff82dpf2da4afab2b17d58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Bill Lear" <rael@zopyra.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Kristian_H=C3=B8gsberg?= <krh@redhat.com>
To: "Carlos Rica" <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 02:04:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8mAI-0003DO-PO
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 02:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936935AbXGLAD1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 20:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936998AbXGLAD1
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 20:03:27 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:52461 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937082AbXGLADZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 20:03:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070712000324.GXTZ1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 11 Jul 2007 20:03:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NQ3P1X0071kojtg0000000; Wed, 11 Jul 2007 20:03:24 -0400
In-Reply-To: <1b46aba20707111641y615ff82dpf2da4afab2b17d58@mail.gmail.com>
	(Carlos Rica's message of "Thu, 12 Jul 2007 01:41:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52225>

"Carlos Rica" <jasampler@gmail.com> writes:

> Now the function cleanup is not removing spaces at all, but only
> counting where the line of text ends.
>
> Before, in the previous version, the function cleanup was taking a
> string as argument, and then it needed to modify that string.  Now, it
> just returns the new length, "not counting" the spaces and newline at
> the end of the buffer passed. Its name and comments then could be
> different, but I didn't know which ones.

Ah, you are right.  I misread the patch --- cleanup() does not
even touch the buffer.
