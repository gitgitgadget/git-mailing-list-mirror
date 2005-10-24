From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: gitweb: charset problem
Date: Mon, 24 Oct 2005 10:56:10 -0300
Message-ID: <200510241356.j9ODuAHn005060@laptop11.inf.utfsm.cl>
References: <nico-linux-git@schottelius.org>
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Gierke <ch@gierke.de>,
	Peter Portmann <peter.portmann@sygroup.ch>
X-From: git-owner@vger.kernel.org Mon Oct 24 15:58:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU2p2-000560-EJ
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 15:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVJXN5E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 09:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbVJXN5D
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 09:57:03 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:14293 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750928AbVJXN5B (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 09:57:01 -0400
Received: from laptop11.inf.utfsm.cl (laptop11.inf.utfsm.cl [200.1.19.198])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j9ODuDLH015697
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Oct 2005 10:56:13 -0300
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j9ODuAHn005060;
	Mon, 24 Oct 2005 10:56:11 -0300
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
In-Reply-To: Message from Nico -telmich- Schottelius <nico-linux-git@schottelius.org> 
   of "Mon, 24 Oct 2005 09:18:39 +0200." <20051024071839.GB4608@schottelius.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 24 Oct 2005 10:56:13 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10541>

Nico -telmich- Schottelius <nico-linux-git@schottelius.org> wrote:
> gitweb (my $version = "247";) seems to send utf-8 as meta tag encoding
> (<meta http-equiv="content-type" content="text/html; charset=utf-8"/>).

> The problem is that the name of the user "HansjOErg" (OE is the german
> umlaut) is in iso8859-1 in /etc/passwd.  This is guessed, but it does not
> look like utf-8, as it's a one byte encoding:

> 00007b0: 3031 323a 3130 303a 4861 6e73 6af6 7267  012:100:Hansj.rg

> What would be the correct way to fix that? Change the username to utf-8?
> (Is this possible without causing problems in other programs?)
> Or tell gitweb that it should convert non-UTF-8 to UTF-8?

I'd be /very/ wary of usernames that aren't plain ASCII, just lovercase
letters and digits, not starting with a digit, at most 8 characters long.
I've seen more than enough hard-to-debug funnies in the most surprising
places otherwise.

> But we also have another problem: Sometimes we have umlauts in the commit
> messages.  Those are also displayed incorrectly. When I switch to
> iso-8859-1 encoding in mozilla, the characters in the username and in the
> commit message are ok.

I believe the Emperor Penguin decreed messages have to be ASCII, or else
UTF-8. Please don't add to the mess by using non-portable encodings!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
