From: Edgar Toernig <froese@gmx.de>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Thu, 21 Apr 2005 16:21:00 +0200
Message-ID: <20050421162100.068146b9.froese@gmx.de>
References: <20050420205633.GC19112@pasky.ji.cz>
	<20050420211919.GA20129@kroah.com>
	<20050420215117.GJ19112@pasky.ji.cz>
	<Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>
	<20050420222815.GM19112@pasky.ji.cz>
	<Pine.LNX.4.58.0504201710500.2344@ppc970.osdl.org>
	<Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org>
	<20050421033526.GA9404@nevyn.them.org>
	<Pine.LNX.4.58.0504202056310.2344@ppc970.osdl.org>
	<20050421042833.GA10934@nevyn.them.org>
	<20050421064931.GA31910@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 16:17:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOcU6-0008FL-QQ
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 16:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVDUOVL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 10:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVDUOVL
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 10:21:11 -0400
Received: from imap.gmx.net ([213.165.64.20]:11444 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261387AbVDUOVD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 10:21:03 -0400
Received: (qmail invoked by alias); 21 Apr 2005 14:21:02 -0000
Received: from p50907452.dip.t-dialin.net (EHLO dialup) [80.144.116.82]
  by mail.gmx.net (mp012) with SMTP; 21 Apr 2005 16:21:02 +0200
X-Authenticated: #271361
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050421064931.GA31910@pasky.ji.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
>
> A little off-topic, anyone knows how to turn off that damn alternate
> screen thing on the xterm level? (Or any other level which makes _all_
> programs not to use it.)

Change the terminfo entry.

The relevant sequence is \E?47h and \E[?47l (save/restore screen) and
often it is paired with \E7 and \E8 (save/restore cursor position)
and \E[2J (clear screen).  [1]

Here it was put in the smcup/rmcup capabilities.

  infocmp >term.src
  vi term.src
  # either remove the sequences or completely disable the
  # capabilities by adding a dot in front of them (.rmcup=...).
  tic term.src

Done.

Ciao, ET.

[1] On strange terminals the escape sequences may be completely
different but these are the common ones.
