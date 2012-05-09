From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 05/19] bash prompt: don't show the prompt when
	.git/HEAD is unreadable
Date: Wed, 9 May 2012 21:45:49 +0200
Message-ID: <20120509194549.GA7824@goldbirke>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
	<1336524290-30023-6-git-send-email-szeder@ira.uka.de>
	<7vipg5rvzf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 09 21:46:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSCpu-0007Qp-Pv
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 21:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760895Ab2EITpy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 15:45:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:57807 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760883Ab2EITpx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 15:45:53 -0400
Received: from localhost6.localdomain6 (p5B1303EC.dip0.t-ipconnect.de [91.19.3.236])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0Lxqhk-1S79nk49OW-015pj6; Wed, 09 May 2012 21:45:49 +0200
Content-Disposition: inline
In-Reply-To: <7vipg5rvzf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:YF1ppTkccvudnQDnWp9Y01eCJGM/Uk66ikMhr+iwBK2
 PIaZ0bGbSorPfOCwzrURuK1VbQxuCgPC4tFpcRbHaais3WHttc
 bqAb3klMcq7bLnrpGUtX1FSBwRVcLS6bd9XdnthTaPnhTMDr2v
 Z87WhwzMwVYdy0hFK4/ImnxolPggU9aTr2KQ6AIPQnKqm/w/el
 mkp0KmkuMNDB2QkjMffdOQOxI8GxQ+TAItP9rCfFML/3VCN9E9
 3Za3l7Tv7IxNieaJ3OrNi1BiJ9XGIVs/5PBvjDbwwmvMvU6SET
 AC6Im5AZNk3hQYVVqrslTY4v3ZwJ+jNtI5c9a6aaBEVjq4CGag
 pc1uzeuWfbJvidnW34XU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197498>

On Wed, May 09, 2012 at 12:32:36PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > diff --git a/contrib/completion/git-completion.bash b/contrib/compl=
etion/git-completion.bash
> > index ab26bdc8..cd6a5f12 100755
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -258,7 +258,7 @@ __git_ps1 ()
> >  				esac 2>/dev/null)" ||
> > =20
> >  				b=3D"$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
> > -				b=3D"unknown"
> > +				return
>=20
> While you are touching the vicinity of the code, could we lose that "=
cut"
> and replace it with "rev-parse --short HEAD", without the hardcoded 1=
-7?

Patch 15 (bash prompt: use bash builtins to get detached HEAD abbrev.
object name) eliminates that 'cut' with some parameter expansions.
While it doesn't respect the 'core.abbrev' config variable, it's much
much faster, so IMHO it's worth it.


G=E1bor
