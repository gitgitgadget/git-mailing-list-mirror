From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Mon, 27 Jul 2009 12:06:10 +0200
Message-ID: <200907271206.11431.trast@student.ethz.ch>
References: <20090723074104.GI4750@laphroaig.corp> <20090725145237.GB18545@artemis.corp> <20090726153950.GA16780@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@madism.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 27 12:06:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVN6E-0005Q8-M3
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 12:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975AbZG0KGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 06:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755970AbZG0KGX
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 06:06:23 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:7128 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755968AbZG0KGW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 06:06:22 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Jul 2009 12:06:21 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Jul 2009 12:06:21 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <20090726153950.GA16780@sigill.intra.peff.net>
X-OriginalArrivalTime: 27 Jul 2009 10:06:21.0215 (UTC) FILETIME=[E40E5AF0:01CA0EA1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124159>

Jeff King wrote:
> 
>   5. Commit 'b' on top of new HEAD (and this would probably actually
>      mean the changes from 'b' to the old HEAD, not setting the new HEAD
>      state to what's in 'b').
> 
> So it's sort of a generalized form of the index, where you have N "index
> registers" and you sort your changes into them. And during steps 2 and
> 3, you could also make more changes, pick them out, etc.

I think the parenthetical remark actually contradicts the notion that
it's an index.  It's more like a place to hold a patch.  Which then
makes it rather similar to a temporary branch and cherry-pick, or
interactive rebase, or whatever.

Granted, the register idea does not directly map to interactive rebase
because that cannot (automatically) add changes to an older commit.
So I frequently wind up making a series of commits along the lines of

  WIP implement foo
  WIP implement bar
  WIP fix foo some
  WIP docs for bar
  WIP docs for foo
  WIP tests for foo

and then have to sort and squash them with rebase -i.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
