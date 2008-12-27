From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [git-new-workdir RFC] Backlinking $workdir/logs/HEAD to
	$GIT_DIR/logs/workdir?
Date: Sat, 27 Dec 2008 09:26:07 -0800
Message-ID: <20081227172607.GA22075@spearce.org>
References: <20081227121526.GA12120@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adeodato =?iso-8859-1?Q?Sim=F3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sat Dec 27 18:28:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGcxF-0002cX-8x
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 18:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbYL0R0K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 12:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbYL0R0J
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 12:26:09 -0500
Received: from george.spearce.org ([209.20.77.23]:43828 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbYL0R0I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 12:26:08 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id B73FE38200; Sat, 27 Dec 2008 17:26:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081227121526.GA12120@chistera.yi.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104007>

Adeodato Sim=F3 <dato@net.com.org.es> wrote:
> I use git new-workdir for some of my projects. Apart from the usual
> caveat "don't checkout the same branch twice", I found another small
> issue, surely known: the reflog for HEAD in the workidirs does not ex=
ist
> in the source git repo, hence git-gc will happily prune what it belie=
ves
> to be dangling commits.
>=20
> Would it be, perhaps, be okay to create a logs/workdir/<name>/HEAD
> symlink pointing to $workdir/logs/HEAD, so that this does not happen?

You also need to link the ref.  A log is only scanned if the
ref by the same name is scanned.

So you'd need to create a refs/workdir/<name>/HEAD in the parent
repository.  Using a symlink to point to the HEAD file from the
workdir might just work.

--=20
Shawn.
