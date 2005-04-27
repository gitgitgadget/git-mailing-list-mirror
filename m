From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Wed, 27 Apr 2005 08:34:39 +0200
Message-ID: <20050427063439.GA22014@elte.hu>
References: <20050426004111.GI21897@waste.org> <200504260713.26020.mason@suse.com> <aec7e5c305042608095731d571@mail.gmail.com> <200504261138.46339.mason@suse.com> <aec7e5c305042609231a5d3f0@mail.gmail.com> <20050426135606.7b21a2e2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Magnus Damm <magnus.damm@gmail.com>, mason@suse.com,
	torvalds@osdl.org, mike.taht@timesys.com, mpm@selenic.com,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 08:30:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQg3u-0000z6-2o
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 08:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVD0GfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 02:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVD0GfY
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 02:35:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14811 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261695AbVD0GfQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 02:35:16 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 351CE3154FE;
	Wed, 27 Apr 2005 08:33:26 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 2909C1FC2; Wed, 27 Apr 2005 08:34:42 +0200 (CEST)
To: Andrew Morton <akpm@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050426135606.7b21a2e2.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Magnus Damm <magnus.damm@gmail.com> wrote:
> >
> > My primitive guess is that it was because
> >  the ext3 journal became full.
> 
> The default ext3 journal size is inappropriately small, btw.  Normally 
> you should manually make it 128M or so, rather than 32M.  Unless you 
> have a small amount of memory and/or a large number of filesystems, in 
> which case there might be problems with pinned memory.
> 
> Mounting as ext2 is a useful technique for determining whether the fs 
> is getting in the way.

on ext3, when juggling patches and trees, the biggest performance boost 
for me comes from adding noatime,nodiratime to the mount options in 
/etc/fstab:

 LABEL=/ / ext3 noatime,nodiratime,defaults 1 1

	Ingo
