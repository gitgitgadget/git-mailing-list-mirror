From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 20:43:41 +0200
Message-ID: <m2fwa0fk0y.fsf@igel.home>
References: <20120611183414.GD20134@sigill.intra.peff.net>
	<20120611211401.GA21775@thunk.org>
	<20120611213948.GB32061@sigill.intra.peff.net>
	<20120611221439.GE21775@thunk.org>
	<20120611222308.GA10476@sigill.intra.peff.net>
	<alpine.LFD.2.02.1206112024110.23555@xanadu.home>
	<20120612171048.GB12706@sigill.intra.peff.net>
	<alpine.LFD.2.02.1206121326490.23555@xanadu.home>
	<20120612173214.GA16014@sigill.intra.peff.net>
	<CAJo=hJvMtfVhadYowvVE0zUhDpbViXqGsvkmHpJpuynySLwb3A@mail.gmail.com>
	<20120612175046.GA16522@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>, Ted Ts'o <tytso@mit.edu>,
	Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 20:43:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeW4G-0002nA-KQ
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 20:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab2FLSnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 14:43:49 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39076 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab2FLSns (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 14:43:48 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WBg3L4Bqkz4KMj6;
	Tue, 12 Jun 2012 20:43:42 +0200 (CEST)
Received: from igel.home (ppp-88-217-99-204.dynamic.mnet-online.de [88.217.99.204])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WBg3L0k2jz4KK6V;
	Tue, 12 Jun 2012 20:43:42 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 7E8E9CA2A3; Tue, 12 Jun 2012 20:43:41 +0200 (CEST)
X-Yow: It's the RINSE CYCLE!!  They've ALL IGNORED the RINSE CYCLE!!
In-Reply-To: <20120612175046.GA16522@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 12 Jun 2012 13:50:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199830>

Jeff King <peff@peff.net> writes:

> We could close it in both cases by tweaking the mtime of the file
> containing the object when we decide not to write because the object
> already exists.

Though there is always the window between the existence check and the
mtime update where pruning can hit you.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
