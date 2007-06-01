From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Fri, 1 Jun 2007 18:13:16 +0200
Message-ID: <20070601161316.GA19526@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: julliard@winehq.org
X-From: git-owner@vger.kernel.org Fri Jun 01 18:13:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu9kn-0005AF-Md
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 18:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757954AbXFAQNW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 1 Jun 2007 12:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757732AbXFAQNW
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 12:13:22 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:59527 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757954AbXFAQNV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 12:13:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 7DD128427EC0;
	Fri,  1 Jun 2007 18:13:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gf87eKimRG+i; Fri,  1 Jun 2007 18:13:16 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id D9653842B706; Fri,  1 Jun 2007 18:13:16 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48870>

Alexandre Julliard wrote:
>Junio C Hamano <junkio@cox.net> writes:
> > I would say that the patch is an improvement from the current
> > code so it should hit 'master'; I was a bit busy lately and then
> > am sick, and also we are post -rc1 freeze now and I was being
> > cautious, just in case some nacks from more informed parties
> > arrive late.
>=20
> Sorry for the late nack, but it turns out that this patch breaks diff
> output on the Wine server for files that are not utf-8.
>=20
> The cause is apparently that decode_utf8() returns undef for invalid
> sequences instead of substituting a replacement char like
> decode("utf8") does.
>=20
> That may be considered an Encode bug since we are running a fairly ol=
d
> version (1.99, coming with Debian 3.1), but I'd rather not upgrade
> perl on the server. Could the patch be reverted, or done differently?

I hit the same problem:
http://marc.info/?l=3Dgit&m=3D117978122420441&w=3D2

On my system, I use this patch as workaround:
http://marc.info/?l=3Dgit&m=3D118038526531694&w=3D2

mfg Martin K=F6gler
