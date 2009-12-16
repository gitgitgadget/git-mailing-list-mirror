From: Sean Boudreau <seanb@qnx.com>
Subject: Re: Git on QNX
Date: Wed, 16 Dec 2009 22:38:39 +0000 (UTC)
Message-ID: <loom.20091216T233122-388@post.gmane.org>
References: <905315640912151323s4b158565o2e74ce018b64dc72@mail.gmail.com>  <7v6387zzfi.fsf@alter.siamese.dyndns.org> <905315640912151413g10ee5befh58fbd171237e7659@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:40:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL2XW-0000d0-MA
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 23:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935432AbZLPWkJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Dec 2009 17:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935165AbZLPWkI
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 17:40:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:38819 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935197AbZLPWkH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 17:40:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NL2XM-0000ZV-Eh
	for git@vger.kernel.org; Wed, 16 Dec 2009 23:40:04 +0100
Received: from CPE000102c510cf-CM001ac3117044.cpe.net.cable.rogers.com ([174.112.215.61])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 23:40:04 +0100
Received: from seanb by CPE000102c510cf-CM001ac3117044.cpe.net.cable.rogers.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 23:40:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 174.112.215.61 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.15) Gecko/2009102815 Ubuntu/9.04 (jaunty) Firefox/3.0.15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135343>

Tarmigan <tarmigan+git <at> gmail.com> writes:


> >
> > Other hunks are QNX specific enough but this hunk is worrisome; you=
 cannot
> > tell how you are hurting other platforms with this change. =C2=A0Ca=
n you tell
> > declarations of which functions are missing on QNX without this cha=
nge?
>=20
> strcasecmp()
> http://www.opengroup.org/onlinepubs/000095399/functions/strcasecmp.ht=
ml
>=20
> I agree that this change could affect other platforms and they've
> gotten along fine without it so far.  I'm surprised no others have
> needed it.  Would it be better wrapped in a #ifdef?
>=20
> Thanks,
> Tarmigan
>=20

What version of qnx is this on.  <strings.h> is
now brought in by <string.h> and the lock() /
unlock() prototypes have been removed from <unistd.h>
AS OF 6.4.1 (the current release).

There's a package for git-4.3.20 here that also has a work around
for the SA_RESTART issue.

ftp://ftp.netbsd.org/pub/pkgsrc/packages/QNX/i386/6.4.1_head_20090724/A=
ll

-seanb
