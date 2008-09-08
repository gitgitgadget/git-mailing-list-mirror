From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Mon, 8 Sep 2008 07:38:07 -0700
Message-ID: <20080908143807.GB10252@spearce.org>
References: <20080907103415.GA3139@cuci.nl> <7vhc8rjyxj.fsf@gitster.siamese.dyndns.org> <20080908115129.GA19031@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Mon Sep 08 16:40:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kchub-0006CS-Tp
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 16:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbYIHOiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 10:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754754AbYIHOiJ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 10:38:09 -0400
Received: from george.spearce.org ([209.20.77.23]:37510 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744AbYIHOiI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 10:38:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 790083835C; Mon,  8 Sep 2008 14:38:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080908115129.GA19031@cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95253>

"Stephen R. van den Berg" <srb@cuci.nl> wrote:
> If we were to put the SHA1-ref somewhere in the commit message, 
> finding references to a certain commit through cherry-picks becomes
> rather disk/CPU-intensive.
> 
> Would there be any objections against extending the on-disk format to
> accomodate something like the following:
> 
> commit 7df437e56b5a2c5ec7140dd097b517563db4972c
> tree a006f20b481d811ccb4846534ef6394be5bc78a8
> parent ff1e8bfcd69e5e0ee1a3167e80ef75b611f72123
> parent bbb896d8e10f736bfda8f587c0009c358c9a8599
> cousin 6ffaecc7d8b2c3c188a2efa5977a6e6605d878d9
> cousin a1184d85e8752658f02746982822f43f32316803
> author Junio C Hamano <gitster@pobox.com> 1220153499 -0700
> committer Junio C Hamano <gitster@pobox.com> 1220153499 -0700
> 
> Whereas cherry-pick would (optionally) generate a cousin reference for every
> commit it picks.

Sorry for wandering into a thread in the middle.  But we've already
been down this road before, and decided the additional header wasn't
worth it from cherry-pick.  What's changed?  The fact that gitk
wants to hyperlink this?  Why can't it just regex out a string of
hex digits longer than 6 and see if there is a commit that matches?

-- 
Shawn.
