From: David Kastrup <dak@gnu.org>
Subject: Re: Something is broken in repack
Date: Wed, 12 Dec 2007 09:05:51 +0100
Message-ID: <85d4tc8hi8.fsf@lola.goethe.zz>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	<9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
	<alpine.LFD.0.99999.0712102231570.555@xanadu.home>
	<9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
	<9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>
	<9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
	<alpine.LFD.0.99999.0712110832251.555@xanadu.home>
	<alpine.LFD.0.99999.0712110951070.555@xanadu.home>
	<alpine.LFD.0.99999.0712111117440.555@xanadu.home>
	<9e4733910712110821o7748802ag75d9df4be8b2c123@mail.gmail.com>
	<alpine.LFD.0.99999.0712112057390.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	gcc@gcc.gnu.org, Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 09:06:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2MbH-00026b-CG
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 09:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbXLLIF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 03:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753517AbXLLIF2
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 03:05:28 -0500
Received: from mail-in-17.arcor-online.net ([151.189.21.57]:52012 "EHLO
	mail-in-17.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753472AbXLLIF1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 03:05:27 -0500
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-17.arcor-online.net (Postfix) with ESMTP id 6E0B42BC4DB;
	Wed, 12 Dec 2007 09:05:26 +0100 (CET)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 5BE6523D296;
	Wed, 12 Dec 2007 09:05:26 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-048-119.pools.arcor-ip.net [84.61.48.119])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 283A3292B62;
	Wed, 12 Dec 2007 09:05:21 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 7AFA61C4CE33; Wed, 12 Dec 2007 09:05:51 +0100 (CET)
In-Reply-To: <alpine.LFD.0.99999.0712112057390.555@xanadu.home> (Nicolas
	Pitre's message of "Wed, 12 Dec 2007 00:12:57 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/5098/Wed Dec 12 06:46:37 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68007>

Nicolas Pitre <nico@cam.org> writes:

> Well... This is weird.
>
> It seems that memory fragmentation is really really killing us here.  
> The fact that the Google allocator did manage to waste quite less memory 
> is a good indicator already.

Maybe an malloc/free/mmap wrapper that records the requested sizes and
alloc/free order and dumps them to file so that one can make a compact
git-free standalone test case for the glibc maintainers might be a good
thing.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
