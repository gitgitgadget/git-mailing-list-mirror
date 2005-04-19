From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: SCSI trees, merges and git status
Date: Mon, 18 Apr 2005 19:16:57 -0500
Message-ID: <1113869817.4998.106.camel@mulgrave>
References: <1113856118.4998.70.camel@mulgrave>
	 <Pine.LNX.4.58.0504181429570.15725@ppc970.osdl.org>
	 <1113866092.4998.92.camel@mulgrave>
	 <Pine.LNX.4.58.0504181651241.15725@ppc970.osdl.org>
	 <1113869456.3579.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 02:13:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNgMb-0002VU-1r
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 02:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVDSARM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 20:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVDSARM
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 20:17:12 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:21377 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261205AbVDSARJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 20:17:09 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j3J0GvA23415;
	Mon, 18 Apr 2005 20:16:58 -0400
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113869456.3579.12.camel@localhost.localdomain>
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-04-19 at 10:10 +1000, David Woodhouse wrote:
> On Mon, 2005-04-18 at 17:03 -0700, Linus Torvalds wrote:
> > Git does work like BK in the way that you cannot remove history when you
> > have distributed it. Once it's there, it's there.
> 
> But older history can be pruned, and there's really no reason why an
> http-based 'git pull' couldn't simply refrain from fetching commits
> older than a certain threshold.

Yes, that's what I did to get back to the commit just before the merge:

fsck-cache --unreachable 54ff646c589dcc35182d01c5b557806759301aa3|awk
'/^unreachable /{print $2}'|sed 's:^\(..\):.git/objects/\1/:'|xargs rm

removes all the objects from the tree prior to the bogus commit---it's
based on your (Linus') git-prune-script.

James


