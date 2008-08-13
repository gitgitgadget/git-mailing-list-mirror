From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pack operation is thrashing my server
Date: Tue, 12 Aug 2008 20:15:03 -0700
Message-ID: <20080813031503.GC5855@spearce.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 05:16:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT6qW-0003zB-Hm
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 05:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbYHMDPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 23:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754269AbYHMDPF
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 23:15:05 -0400
Received: from george.spearce.org ([209.20.77.23]:49960 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbYHMDPE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 23:15:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4DA1338375; Wed, 13 Aug 2008 03:15:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92169>

Geert Bosch <bosch@adacore.com> wrote:
> I've always felt that keeping largish objects (say anything >1MB)
> loose makes perfect sense. These objects are accessed infrequently,
> often binary or otherwise poor candidates for the delta algorithm.

Sadly this causes huge problems with streaming a pack because the
loose object has to be inflated and then delfated again to fit into
the pack stream.

The new style loose object format was meant to fix this problem,
and it did, but the code was difficult to manage so it was backed
out of the tree.

-- 
Shawn.
