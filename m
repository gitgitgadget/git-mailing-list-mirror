From: Andi Kleen <andi@firstfloor.org>
Subject: Re: pack operation is thrashing my server
Date: Mon, 11 Aug 2008 21:10:31 +0200
Message-ID: <87vdy71i6w.fsf@basil.nowhere.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	<20080811030444.GC27195@spearce.org>
	<a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Ken Pratt" <ken@kenpratt.net>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:11:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KScnv-0005EP-7E
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 21:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673AbYHKTKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 15:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754616AbYHKTKf
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 15:10:35 -0400
Received: from one.firstfloor.org ([213.235.205.2]:56632 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbYHKTKe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 15:10:34 -0400
Received: from basil.firstfloor.org (f053156102.adsl.alicedsl.de [78.53.156.102])
	by one.firstfloor.org (Postfix) with ESMTP id 818111AD0020;
	Mon, 11 Aug 2008 21:11:40 +0200 (CEST)
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id D9C001B4449; Mon, 11 Aug 2008 21:10:31 +0200 (CEST)
In-Reply-To: <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> (Ken Pratt's message of "Mon, 11 Aug 2008 00:43:27 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91979>

"Ken Pratt" <ken@kenpratt.net> writes:
>
> I'm starting to think repacking is just not feasible on a 64-bit
> server with 256MB of RAM (which is a very popular configuration in the
> VPS market).

As a quick workaround you could try it with a 32bit git executable?
(assuming you have a distribution with proper multilib support) 

I think the right fix would be to make git throttle itself (not 
use mmap, use very small defaults etc.) on low memory systems.
It could take a look a /proc/meminfo for this.

-Andi
