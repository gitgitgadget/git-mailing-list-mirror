From: Mike Hommey <mh@glandium.org>
Subject: Re: git rebase bug?
Date: Wed, 7 Jul 2010 22:51:26 +0200
Message-ID: <20100707205126.GA11240@glandium.org>
References: <20100707150545.GA24814@glandium.org> <20100707180004.GA3165@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 07 22:51:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWbay-0006nx-85
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 22:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756283Ab0GGUvr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 16:51:47 -0400
Received: from vuizook.err.no ([85.19.221.46]:56207 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755854Ab0GGUvq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 16:51:46 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vserv6.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1OWbac-0000uo-HG; Wed, 07 Jul 2010 22:51:44 +0200
Received: from vserv6.glandium.org ([192.168.1.10] helo=goemon)
	by vserv6.glandium.org with esmtp (Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1OWbaY-0002vX-It; Wed, 07 Jul 2010 22:51:27 +0200
Received: from mh by goemon with local (Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1OWbaY-0002vU-8P; Wed, 07 Jul 2010 22:51:26 +0200
Content-Disposition: inline
In-Reply-To: <20100707180004.GA3165@atjola.homenet>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 192.168.1.10
X-SA-Exim-Mail-From: mh@glandium.org
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on vserv6.glandium.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
X-SA-Exim-Version: 4.2.1 (built Wed, 25 Jun 2008 17:14:11 +0000)
X-SA-Exim-Scanned: Yes (on vserv6.glandium.org)
X-Spam-Status: (score 2.5): No, score=2.5 required=5.0 tests=DNS_FROM_OPENWHOIS,RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150505>

On Wed, Jul 07, 2010 at 08:00:04PM +0200, Bj=F6rn Steinbrink <B.Steinbr=
ink@gmx.de> wrote:
> On 2010.07.07 17:05:45 +0200, Mike Hommey wrote:
> > See how the security/manager/ssl/public/nsIBadCertListener.idl file=
 that
> > was created by the original patch is created as
> > xulrunner/examples/simple/content/contents.rdf.
>=20
> The "problem" is that nsIBadCertListener.idl wasn't actually created =
by
> the cherry-picked commit, but was modified. It was an empty file befo=
re,
> created in 4292283190983fa91b875e22664a79a3aa9ea45d.
>=20
> And as nsIBadCertListener.idl is missing from the xulrunner/2.0 branc=
h,
> git does the usual rename detection, finding another empty file and e=
nds
> up patching that one instead.

Oh, makes sense. Thanks. So that's a quite troubling corner case...
I wonder if empty files shouldn't be special cased...

Mike
