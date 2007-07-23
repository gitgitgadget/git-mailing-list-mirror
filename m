From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Mon, 23 Jul 2007 11:42:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707231141080.14781@racer.site>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222223460.14781@racer.site>
 <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222255010.14781@racer.site>
 <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707230000020.14781@racer.site> <20070723035644.GC32566@spearce.org>
 <7v1wezohi4.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707231129010.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 12:42:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICvN6-0002mP-QH
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 12:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632AbXGWKmd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 06:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756381AbXGWKmd
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 06:42:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:32914 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754449AbXGWKmc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 06:42:32 -0400
Received: (qmail invoked by alias); 23 Jul 2007 10:42:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 23 Jul 2007 12:42:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+NsL9+bR2N5N/iX4wlLSkfvQxBse4SOD/4Q/9evm
	1DC36Y9ObTQrfq
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707231129010.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53425>

Hi,

On Mon, 23 Jul 2007, Johannes Schindelin wrote:

> 	struct stat st;
> 	int i = 0;
> 
> 	while (i++ < 10 && !lstat(path, &st) && S_ISLNK(st.st_mode)) {
> 		ssize_t sz;
> 		static char target[PATH_MAX];
> 		sz = readlink(path, target, sizeof(target));
> 		if (sz < 0)
> 			die("Cannot readlink %s", path);
> 		else
> 			path = target;

Probably this should be "make_absolute_path(target)" after applying the 
minipatch I provided elsewhere.

Ciao,
Dscho
