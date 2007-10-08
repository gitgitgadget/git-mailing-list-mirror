From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 6/6] Let some commands work with detached HEAD
Date: Mon, 8 Oct 2007 17:34:50 +0200
Message-ID: <20071008153450.GA12247@diana.vm.bytemark.co.uk>
References: <20071008085430.9734.75797.stgit@yoghurt> <20071008085540.9734.60137.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 17:35:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeudQ-00076N-Ut
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 17:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbXJHPe5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 11:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbXJHPe5
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 11:34:57 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1616 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbXJHPe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 11:34:57 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ieud8-0003VQ-00; Mon, 08 Oct 2007 16:34:50 +0100
Content-Disposition: inline
In-Reply-To: <20071008085540.9734.60137.stgit@yoghurt>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60327>

On 2007-10-08 10:55:41 +0200, Karl Hasselstr=F6m wrote:

> --- a/stgit/commands/diff.py
> +++ b/stgit/commands/diff.py
> @@ -42,7 +42,7 @@ rev =3D '([patch][//[bottom | top]]) | <tree-ish> |=
 base'
>  If neither bottom nor top are given but a '//' is present, the comma=
nd
>  shows the specified patch (defaulting to the current one)."""
> =20
> -directory =3D DirectoryHasRepository()
> +directory =3D DirectoryHasRepository(needs_current_series =3D False)
>  options =3D [make_option('-r', '--range',
>                         metavar =3D 'rev1[..[rev2]]', dest =3D 'revs'=
,
>                         help =3D 'show the diff between revisions'),

This hunk shouldn't be here, since diff does use crt_series. (The
commit message also has to be modified accordingly.)

So, we don't have a single test that tries to run "stg diff". Duh.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
