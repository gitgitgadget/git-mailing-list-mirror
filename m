From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: 1.5.0.rc1.gb60d: fetch in another branch works strangely
Date: Sat, 13 Jan 2007 16:14:28 -0500
Message-ID: <20070113211428.GA17749@spearce.org>
References: <200701132106.l0DL6BPH008314@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 22:14:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5qD4-0002oU-Nc
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 22:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422797AbXAMVOd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 16:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422798AbXAMVOd
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 16:14:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34105 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422797AbXAMVOc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 16:14:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5qCj-0002ll-4N; Sat, 13 Jan 2007 16:14:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2D29E20FBAE; Sat, 13 Jan 2007 16:14:28 -0500 (EST)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200701132106.l0DL6BPH008314@laptop13.inf.utfsm.cl>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36772>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:
> I created a new branch in the kernel to carry a not yet official patch, to
> keep this up to date I do:
> 
>    $ git fetch git://git2.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

That's only writing into FETCH_HEAD whatever branch is marked as
HEAD in Linus' repository.  No local refs are being updated.

>    $ git pull . origin

So this won't merge in the changes fetched above.


Why not setup that URL as a remote (git remote add linus ....)
Then you can do:

  $ git fetch linus
  $ git merge linus/master

or 

  $ git fetch linus
  $ git pull . linus/master

or 

  $ git pull linus master

-- 
Shawn.
