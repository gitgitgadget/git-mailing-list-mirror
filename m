From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: Header files not mentioned in the makefile
Date: Mon, 3 Mar 2008 19:55:24 +0100
Message-ID: <20080303185524.GA26790@auto.tuwien.ac.at>
References: <20080303072424.GA25623@auto.tuwien.ac.at> <alpine.LSU.1.00.0803031146310.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:56:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWFpg-00083g-GF
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 19:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122AbYCCSz2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 13:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757141AbYCCSz1
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 13:55:27 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:51255 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756427AbYCCSz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 13:55:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 90AC9680C0C0;
	Mon,  3 Mar 2008 19:55:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9S8t4G24xRfi; Mon,  3 Mar 2008 19:55:24 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 7089E680BF98; Mon,  3 Mar 2008 19:55:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803031146310.22527@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75969>

On Mon, Mar 03, 2008 at 11:47:01AM +0000, Johannes Schindelin wrote:
> On Mon, 3 Mar 2008, Martin Koegler wrote:
>=20
> > When I modified fetch-pack.h I was surprised by the fact, that it d=
oes=20
> > not result in rebuilding all object files. In fact, no file was reb=
uilt.=20
> > It turned out, that fetch-pack.h was not mentioned in the Makefile.
> >=20
> > A quick search (on next) showed, that other header files are also n=
ot
> > taking part in dependency checking:
> >=20
> > $for a in `ls *.h`; do grep "$a" Makefile >/dev/null || (echo "miss=
ing: $a"; grep "$a" *.c|grep include) ; done
> > missing: branch.h
>=20
> Somehow I miss "wt-status.h" in your list.

There is a dependency for wt-status.h, so it does not show up in
my grep:
 builtin-revert.o wt-status.o: wt-status.h

But this is complete:
$ grep wt-status.h *.c
builtin-commit.c:#include "wt-status.h"
builtin-revert.c:#include "wt-status.h"
wt-status.c:#include "wt-status.h"


mfg Martin K=F6gler
