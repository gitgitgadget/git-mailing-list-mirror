From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH 2/3] git-daemon: use getnameinfo to resolve hostname
Date: Wed, 14 Jan 2009 15:17:23 +0100
Message-ID: <20090114141723.GA6984@chistera.yi.org>
References: <alpine.LSU.2.00.0901141147120.16109@fbirervta.pbzchgretzou.qr> <alpine.LSU.2.00.0901141148130.16109@fbirervta.pbzchgretzou.qr> <20090114122536.GA5939@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Engelhardt <jengelh@medozas.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 15:19:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN6aC-0005U6-Vw
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 15:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854AbZANORh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 09:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753603AbZANORh
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 09:17:37 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:1134
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbZANORg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 09:17:36 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 2DE75801C026;
	Wed, 14 Jan 2009 15:17:35 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LN6Yd-0001rt-HN; Wed, 14 Jan 2009 15:17:23 +0100
Content-Disposition: inline
In-Reply-To: <20090114122536.GA5939@coredump.intra.peff.net>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105631>

* Jeff King [Wed, 14 Jan 2009 07:25:36 -0500]:

> On Wed, Jan 14, 2009 at 11:48:38AM +0100, Jan Engelhardt wrote:

> > This is much shorter than inet_ntop'ing, and also translated
> > unresolvable addresses into a string.

> Er, doesn't this totally change the meaning of REMOTE_ADDR from an IP
> address to a hostname?

Yes, I believe so.

However, AFAIK you can obtain the intended behavior if you pass
NI_NUMERICHOST as a flag to the getnameinfo() call. With that, this
patch can be still considered for inclusing if the original "don't
hardcode protocol-specific bits" is still deemed worthy.

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
- Why are you whispering?
- Because I just think that no matter where she is, my mom can hear thi=
s
  conversation.
                -- Rory and Lane
