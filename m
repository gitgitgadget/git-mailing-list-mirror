From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add test case for ls-files --with-head
Date: Wed, 03 Oct 2007 17:52:48 +0200
Message-ID: <85odfgry9b.fsf@lola.goethe.zz>
References: <1191390255.16292.2.camel@koto.keithp.com>
	<7vtzp8g2s2.fsf@gitster.siamese.dyndns.org>
	<87y7ekr86e.wl%cworth@cworth.org> <47038669.30302@viscovery.net>
	<Pine.LNX.4.64.0710031634300.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Carl Worth <cworth@cworth.org>,
	Junio C Hamano <gitster@pobox.com>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 21:11:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id9cz-00060A-4Z
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 21:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbXJCTLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 15:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbXJCTLH
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 15:11:07 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:54985 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbXJCTLF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 15:11:05 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Id9bT-0005RT-2V; Wed, 03 Oct 2007 15:09:51 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 43DED1C4CE11; Wed,  3 Oct 2007 17:52:48 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0710031634300.28395@racer.site> (Johannes Schindelin's message of "Wed\, 3 Oct 2007 16\:36\:13 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59867>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 3 Oct 2007, Johannes Sixt wrote:
>> 
>> seq is not universally available. Can we have that as
>> 
>> for i in 0 1 2 3 4; do
>> 	for j in 0 1 2 3 4 5 6 7 8 9; do
>> 		> sub/file-$i$j
>> 		echo file-$i$j >> expected
>> 	done
>> done
>
> Or as
>
> 	i=1
> 	while test $i -le 50
> 	do
> 		num=$(printf %04d $i)
> 		> sub/file-$num
> 		echo file-$num >> expected
> 		i=$(($i+1))
> 	done
>
> This version should be as portable,

Huh?  It uses the conceivably-not-builtin "test" (something which
_you_ picked as something to complain about in a patch of mine where
it was not used in an inner loop) on every iteration, it uses printf
and it uses $((...))  arithmetic expansion.  Whereas the proposal by
Johannes works fine even on prehistoric shell versions.  So the "as
portable" enough moniker is surely weird.

> with the benefit that it is easier to change for different start and
> end values.

Correct.  But why would we want those here?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
