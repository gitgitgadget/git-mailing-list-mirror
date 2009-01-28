From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: (beginner) git rm
Date: Wed, 28 Jan 2009 21:17:27 +0100
Message-ID: <20090128201727.GD7503@atjola.homenet>
References: <1233137498146-2231416.post@n2.nabble.com> <Pine.LNX.4.64.0901281133380.645@ds9.cixit.se> <1233140751523-2231622.post@n2.nabble.com> <49804385.908@dbservice.com> <1233144045221-2231849.post@n2.nabble.com> <49804D41.3010801@dbservice.com> <1233166992184-2233892.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Zabre <427@free.fr>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:20:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSGtI-0000fG-Jh
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 21:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbZA1USh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jan 2009 15:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbZA1USh
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 15:18:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:40655 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751519AbZA1USg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 15:18:36 -0500
Received: (qmail invoked by alias); 28 Jan 2009 20:18:32 -0000
Received: from i577BB3F1.versanet.de (EHLO atjola.local) [87.123.179.241]
  by mail.gmx.net (mp059) with SMTP; 28 Jan 2009 21:18:32 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX199nVcSV9R9veFqRJ6qmwpBVxMYlqMZiFve7pq5kE
	OkGCD3IVplxeLN
Content-Disposition: inline
In-Reply-To: <1233166992184-2233892.post@n2.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107568>

On 2009.01.28 10:23:12 -0800, Zabre wrote:
> Tomas Carnecky wrote:
> >=20
> > Oops, sorry. git checkout HEAD -- d.txt
> > You have to tell which version of d.txt you want. In your case the=20
> > version in HEAD.
>=20
> Thank you for this precision, it makes me understand this command bet=
ter.
> (Sorry for my late answer I've been unable to check my computer for a=
 few
> hours)

The "git checkout -- d.txt" is also a valid command, but that restores
the file from the index.

git checkout -- paths
	=3D=3D> Copy "paths" from the index to the working tree

git checkout <tree-ish> -- paths
	=3D=3D> Copy "paths" from the tree-ish to the index and working tree

So, for "rm d.txt", a plain "git checkout -- d.txt" would also do the
trick, as d.txt is still in the index. But your "git rm d.txt" also
removed the file from the index, and thus that checkout does nothing.
But "git checkout HEAD -- d.txt" works, as it gets the file from HEAD
and puts it into the index and working tree.

Bj=F6rn
