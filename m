From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 2/3] DWIM "git checkout frotz" to "git checkout -b
 frotz origin/frotz"
Date: Sun, 18 Oct 2009 14:00:53 +0200
Message-ID: <20091018120053.GA11391@atjola.homenet>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
 <7vaazpxha4.fsf_-_@alter.siamese.dyndns.org>
 <20091018193448.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 14:01:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzURf-0002it-2k
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 14:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbZJRMAz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 08:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbZJRMAy
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 08:00:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:34174 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753303AbZJRMAy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 08:00:54 -0400
Received: (qmail invoked by alias); 18 Oct 2009 12:00:57 -0000
Received: from i59F5B861.versanet.de (EHLO atjola.homenet) [89.245.184.97]
  by mail.gmx.net (mp007) with SMTP; 18 Oct 2009 14:00:57 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19/ZFEubHh/nPrMlvhtpKLTnzuoAfoxgGhui+A3Wl
	ucEnCbachFbhVK
Content-Disposition: inline
In-Reply-To: <20091018193448.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130593>

On 2009.10.18 19:34:48 +0900, Nanako Shiraishi wrote:
> Quoting Junio C Hamano <gitster@pobox.com>
>=20
> > When 'frotz' is not a valid object name nor a tracked filename,
> > we used to complain and failed this command.  When there is only
> > one remote that has 'frotz' as one of its tracking branches, we can
> > DWIM it as a request to create a local branch 'frotz' forking from
> > the matching remote tracking branch.
>=20
> In the subject you used 'git checkout -b frotz origin/frotz'. Did you
> forget to say '-t'?

Hm, the DWIMmery only triggers when opts.track is
BRANCH_TRACK_UNSPECIFIED, i.e. -t was not used. And it doesn't change
opts.track when it DWIMs, so it respects branch.autosetupmerge, which
would be overriden by -t. So it seems correct that -t is not in there.

Bj=F6rn
