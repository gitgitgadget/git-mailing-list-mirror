From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 12:22:37 +0100
Message-ID: <20091209112237.GA27740@atjola.homenet>
References: <20091208144740.GA30830@redhat.com>
 <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0912090941420.470@ds9.cixit.se>
 <20091209093758.GA2977@redhat.com>
 <alpine.DEB.2.00.0912091150470.470@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Dec 09 12:22:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIKdG-0007AS-B5
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 12:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbZLILWh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 06:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754019AbZLILWg
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 06:22:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:60403 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750792AbZLILWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 06:22:36 -0500
Received: (qmail invoked by alias); 09 Dec 2009 11:22:41 -0000
Received: from i59F5468C.versanet.de (EHLO atjola.homenet) [89.245.70.140]
  by mail.gmx.net (mp013) with SMTP; 09 Dec 2009 12:22:41 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+LK65MFGeLEwpC9dfF1skx9KIQmpx/SSvmA4Pcff
	jng1yKiK3tGsrt
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0912091150470.470@ds9.cixit.se>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134959>

On 2009.12.09 11:52:41 +0100, Peter Krefting wrote:
> Michael S. Tsirkin:
>=20
> >>Maybe this could also be used to implement a "git merge --squash
> >>A..B", a.k.a a "partial merge".
> >What exactly should it do?
>=20
> The same thing, apply a set of changes on top of the current branch,
> just using the "merge" name, and not "rebase" or "cherry-pick".
> "merge --squash" is just "cherry-pick" with a different name.

Err, no. "git merge --squash foo" merges all changes from the merge bas=
e
of HEAD and foo up to foo. "git cherry-pick foo" takes just the changes
from foo^ to foo. For example:

A---B---C (master)
 \
  D---E---F (foo)

git cherry-pick foo # Tries to create a new commit with the changes fro=
m
                    # "git diff D F"

git merge --squash foo # Tries to create a new commit with the changes
                       # from "git diff A F"

Bj=F6rn
