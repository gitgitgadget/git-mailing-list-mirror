From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: is gitosis secure?
Date: Sun, 14 Dec 2008 21:24:31 -0800 (PST)
Message-ID: <alpine.DEB.2.00.0812142121090.9552@vellum.laroia.net>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org> <m3zlizdofy.fsf@localhost.localdomain> <87prju5m6s.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Mon Dec 15 06:25:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC5xr-0003sO-4C
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 06:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbYLOFYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 00:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbYLOFYh
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 00:24:37 -0500
Received: from rose.makesad.us ([219.105.37.19]:59612 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbYLOFYg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 00:24:36 -0500
Received: from vellum.laroia.net (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id C5BB8A0115;
	Mon, 15 Dec 2008 00:28:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by vellum.laroia.net (Postfix) with ESMTPS id 473BE3A6294;
	Sun, 14 Dec 2008 21:24:31 -0800 (PST)
X-X-Sender: paulproteus@vellum.laroia.net
In-Reply-To: <87prju5m6s.fsf@hades.wkstn.nix>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103130>

On Mon, 15 Dec 2008, Nix wrote:

> On 14 Dec 2008, Jakub Narebski spake thusly:
>> BTW. is outgoing SSH transport (from network to outside) blocked as 
>> well?
>
> *No* ports are open. All they have is a (non-transparent) buggy HTTP 
> proxy. These guys really don't get the Internet, despite their sales 
> literature banging on endlessly about it.

If that's the only way you can access the network, you can take advantage 
of the way HTTP proxies deal with HTTPS: they typically let it through 
byte for byte.

"connect.c is the simple relaying command to make network connection via 
SOCKS and https proxy. It is mainly intended to be used as proxy command 
of OpenSSH."

Run sshd on port 443, use connect.c, and you're set.

(Except for some really smart SSL-aware HTTP proxies that verify that it's 
an SSL connection of some kind.  In theory, you could then sslwrap your 
sshd and then be set.)

-- Asheesh.

-- 
Q:	Why did the astrophysicist order three hamburgers?
A:	Because he was hungry.
