From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clone: use cpio's --quiet flag
Date: Sun, 05 Aug 2007 01:36:29 -0700
Message-ID: <7v4pjefkdu.fsf@assigned-by-dhcp.cox.net>
References: <20070804070308.GA6493@coredump.intra.peff.net>
	<Pine.LNX.4.64.0708041636290.14781@racer.site>
	<20070804160409.GA16326@sigill.intra.peff.net>
	<7vwswbgphu.fsf@assigned-by-dhcp.cox.net>
	<20070804175240.GB17113@sigill.intra.peff.net>
	<7vps23gnpj.fsf@assigned-by-dhcp.cox.net>
	<20070805080651.GB10863@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 10:36:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHbbT-00033S-V4
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 10:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756375AbXHEIgc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 04:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755801AbXHEIgc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 04:36:32 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34996 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845AbXHEIgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 04:36:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070805083630.KKLR2095.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 5 Aug 2007 04:36:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y8cV1X00A1kojtg0000000; Sun, 05 Aug 2007 04:36:30 -0400
In-Reply-To: <20070805080651.GB10863@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 5 Aug 2007 04:06:51 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54967>

Jeff King <peff@peff.net> writes:

> On Sat, Aug 04, 2007 at 11:27:04AM -0700, Junio C Hamano wrote:
>
>> Try cloning across filesystem boundaries so that you do not get
>> a hardlink -- you will get block count of the copy ;-)
>
> I see, though the hardlink warning is a bit much.
>
> $ git-clone /path/on/fs/one /path/on/fs/two
> Initialized empty Git repository in /path/on/fs/two/.git/
> Warning: -l asked but cannot hardlink to /path/on/fs/one/.git
> 36634 blocks

True; -l is not given explicitly in your example.  Should be
trivial to fix.
