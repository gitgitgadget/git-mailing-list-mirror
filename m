From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: fatal: protocol error: bad line length character: GET <<<<<
Date: Wed, 26 Jan 2011 07:59:55 +0200
Message-ID: <20110126055955.GA13304@LK-Perkele-VI.localdomain>
References: <AANLkTimDbHdOwkPu6qihdgJFY0bS0XTVatLCriCmM1nX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alan Sargent <alsarg72@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 07:00:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhyQa-0007gK-US
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 07:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480Ab1AZGAR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jan 2011 01:00:17 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:33448 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab1AZGAQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jan 2011 01:00:16 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id B2A1713B407;
	Wed, 26 Jan 2011 08:00:14 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A03B64ADD2D; Wed, 26 Jan 2011 08:00:14 +0200
Received: from LK-Perkele-VI (a88-112-56-215.elisa-laajakaista.fi [88.112.56.215])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id A0DFD27D85;
	Wed, 26 Jan 2011 08:00:12 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <AANLkTimDbHdOwkPu6qihdgJFY0bS0XTVatLCriCmM1nX@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165502>

On Wed, Jan 26, 2011 at 12:53:11PM +0800, Alan Sargent wrote:
> Hello,
>=20
> The "fatal: protocol error: bad line length character" seems fairly
> common, but in the archive and the faq there isn't reference to this
> particular instances - GET.
>=20
> alan@toaster:~$ git init myrepo
> Initialized empty Git repository in /home/nev/myrepo/.git/
> alan@toaster:~$ cd myrepo
> alan@toaster:~/myrepo$ git daemon
> fatal: protocol error: bad line length character: GET=C2=A0=C2=A0<< j=
ust hitting
> F5 in the browser
> fatal: protocol error: bad line length character: GET
[...]

Git daemon serves git:// protocol, not HTTP, you can't access it from
web browser.

If you are looking for Git repository web interface, look at gitweb
or cgit.

The error is because HTTP begins the request with "GET " and git
daemon is trying to interpret that as length of packet, failing
and spitting out a fatal error.

-Ilari
