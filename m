From: Chris Wedgwood <cw@f00f.org>
Subject: Re: enforcing DB immutability
Date: Wed, 20 Apr 2005 01:58:22 -0700
Message-ID: <20050420085822.GC3263@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0504131027210.4501@ppc970.osdl.org> <20050413182909.GA25221@elte.hu> <Pine.LNX.4.58.0504131144160.4501@ppc970.osdl.org> <20050413200237.GA26635@elte.hu> <425D7C0F.2050109@zytor.com> <20050413201523.GC27088@elte.hu> <Pine.LNX.4.58.0504131404380.4501@ppc970.osdl.org> <20050420074053.GA22436@elte.hu> <20050420074948.GA22620@elte.hu> <20050420075320.GA22676@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 10:55:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOAym-0000Kx-Fs
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 10:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVDTI6q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 04:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVDTI6q
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 04:58:46 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:43404 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261498AbVDTI6m
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 04:58:42 -0400
Received: from pimout2-ext.prodigy.net (pimout2-ext.prodigy.net [207.115.63.101])
	by ylpvm29.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j3K8w3D9021966
	for <git@vger.kernel.org>; Wed, 20 Apr 2005 04:58:06 -0400
X-ORBL: [67.124.119.21]
Received: from taniwha.stupidest.org (adsl-67-124-119-21.dsl.snfc21.pacbell.net [67.124.119.21])
	by pimout2-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j3K8wPcU440696;
	Wed, 20 Apr 2005 04:58:31 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id D14C2115C85B; Wed, 20 Apr 2005 01:58:22 -0700 (PDT)
To: Ingo Molnar <mingo@elte.hu>
Content-Disposition: inline
In-Reply-To: <20050420075320.GA22676@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2005 at 09:53:20AM +0200, Ingo Molnar wrote:

> so the only sensible thing the editor/tool can do when it wants to
> change the file is precisely what we want: it will copy the
> hardlinked files's contents to a new file, and will replace the old
> file with the new file - a copy on write. No accidental corruption
> of the DB's contents.

editors that have SCM smarts and know about the files different states
can do this

i really like the way this works under BK btw --- files are RO until i
do the magic thing which will do a 'bk edit' and i can then do
checkins or similar as needed (this assumes you can do per-file
deltas)
