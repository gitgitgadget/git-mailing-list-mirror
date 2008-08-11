From: Andi Kleen <andi@firstfloor.org>
Subject: Re: pack operation is thrashing my server
Date: Mon, 11 Aug 2008 22:10:49 +0200
Message-ID: <20080811201049.GV9038@one.firstfloor.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <20080811192208.GK26363@spearce.org> <a6b6acf60808111229u72ffad66kb7a253f2fef44654@mail.gmail.com> <20080811193423.GM26363@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ken Pratt <ken@kenpratt.net>, Andi Kleen <andi@firstfloor.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 22:10:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSdj4-0004dR-Di
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 22:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbYHKUJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 16:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbYHKUJn
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 16:09:43 -0400
Received: from one.firstfloor.org ([213.235.205.2]:33681 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbYHKUJn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 16:09:43 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id CA9141AD0021; Mon, 11 Aug 2008 22:10:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080811193423.GM26363@spearce.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91991>

> There really isn't a global "malloc/mmap at most X bytes".

Sure it can never be 100% accurate because other processes
can also steal memory.

Still a 90+% heuristic can work pretty well. If memory < 512MB then don't
use mmap for example. If memory < 256MB do everything as tight
as possible. gcc is using such heuristics quite successfully.

The only problem might be testing coverage for such options.
It might be useful to add options to force it and then run
the test suite with it.

-Andi
