From: Chris Mason <mason@suse.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 07:13:24 -0400
Message-ID: <200504260713.26020.mason@suse.com>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251938210.18901@ppc970.osdl.org> <Pine.LNX.4.58.0504252032500.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mike Taht <mike.taht@timesys.com>, Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261437AbVDZLNm@vger.kernel.org Tue Apr 26 13:11:03 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261437AbVDZLNm@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQNxZ-0008E7-Uk
	for glk-linux-kernel@gmane.org; Tue, 26 Apr 2005 13:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVDZLNm (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Tue, 26 Apr 2005 07:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVDZLNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 07:13:42 -0400
Received: from ns2.suse.de ([195.135.220.15]:56026 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261400AbVDZLNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 07:13:34 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 67D9493AA;
	Tue, 26 Apr 2005 13:13:33 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 3BC7C14AF5E; Tue, 26 Apr 2005 13:13:32 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504252032500.18901@ppc970.osdl.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 April 2005 00:00, Linus Torvalds wrote:
> On Mon, 25 Apr 2005, Linus Torvalds wrote:
> > The easiest test-case is Andrew's 198-patch patch-bomb on linux-kernel a
> > few weeks ago: they all apply cleanly to 2.6.12-rc2 (in order), and you
> > can use my "dotest" script to automate the test..
>
> Oh, well. That was so trivial that I just did it:
[ ... ]

> ie the "initial add" is almost twice as fast (because it spends most of
> the time compressing _all_ the files), but the difference in applying 198
> patches is not noticeable at all (because the costs are all elsewhere).
>
> That's 198 patches in less than a minute even with the highest
> compression. That rocks.

This agrees with my tests here, the time to apply patches is somewhat disk 
bound, even for the small 100 or 200 patch series.  The io should be coming 
from data=ordered, since the commits are still every 5 seconds or so.

-chris
