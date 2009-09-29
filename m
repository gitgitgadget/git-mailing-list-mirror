From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: clone from url with email address as username?(escaping @
 symbol)
Date: Tue, 29 Sep 2009 19:48:57 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.0909291946520.23903@tvnag.unkk.fr>
References: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com> <fabb9a1e0909290725w616c3ea9vcb1d2c53950f7788@mail.gmail.com> <vpq1vlp962h.fsf@bauges.imag.fr> <fabb9a1e0909290732h5119170ew133d906b67e49f99@mail.gmail.com>
 <970bc7c80909290831l59b7fc4at4ec0082f42f3ef87@mail.gmail.com> <vpq63b1u1p6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Ben Bennett <benbennett@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 29 19:57:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msgx3-0000DV-JW
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 19:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbZI2R5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 13:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbZI2R5H
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 13:57:07 -0400
Received: from giant.haxx.se ([83.168.254.42]:50876 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752287AbZI2R5G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 13:57:06 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2009 13:57:06 EDT
Received: from giant.haxx.se (giant.haxx.se [83.168.254.42])
	by giant.haxx.se (8.14.3/8.14.3/Debian-9) with ESMTP id n8THmvwl007689;
	Tue, 29 Sep 2009 19:48:57 +0200
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <vpq63b1u1p6.fsf@bauges.imag.fr>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129318>

On Tue, 29 Sep 2009, Matthieu Moy wrote:

> Unfortunately, it seems the complete URL is passed to curl, and curl
> is the one doing it wrong. Indeed:
>
> $ curl -v https://user@email.com@server.com/path/
> * getaddrinfo(3) failed for email.com@server.com:443

This is not exactly curl "doing it wrong". This is a user passing in something 
that isn't a URL to the command that asks for a URL to work on. The user part 
cannot legally have a '@' letter in a URL, you must encode it.

> In short, you have to use %40 to escape the @, and curl does it this way 
> because the RFC doesn't allow @ in usernames.

Exactly. So curl is not "wrong", it just can't work around this user-error.

-- 

  / daniel.haxx.se
