From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Fix for rewriteRoot URL containing username.
Date: Sun, 15 Feb 2009 16:55:25 -0800
Message-ID: <20090216005525.GA20625@untitled>
References: <1234394042-11577-1-git-send-email-devait@mailbox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?D=E9vai_Tam=E1s?= <devait@mailbox.sk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 01:56:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYrn4-0002mP-LI
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 01:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483AbZBPAz0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Feb 2009 19:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbZBPAz0
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 19:55:26 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:38317 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754079AbZBPAz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 19:55:26 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AF4B1F794;
	Mon, 16 Feb 2009 00:55:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234394042-11577-1-git-send-email-devait@mailbox.sk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110105>

D=E9vai Tam=E1s <devait@mailbox.sk> wrote:
> If the new svn root URL given with the svn-remote.<repo>.rewriteRoot =
config option
> (or by the --rewrite-root option to 'git svn init') contains a userna=
me
> (such as 'svn+ssh://username@example.com/repo'), find_by_url() cannot=
 find
> the repository URL, because the URL contained in the commit message d=
oes have
> the username removed.
>=20
> Signed-off-by: D=E9vai Tam=E1s <devait@mailbox.sk>

Thanks D=E9vai,

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/git-svn.perl b/git-svn.perl
> index 001a1d8..83cb36f 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1693,6 +1693,7 @@ sub find_by_url { # repos_root and, path are op=
tional
>  			my $prefix =3D '';
>  			if ($rwr) {
>  				$z =3D $rwr;
> +				remove_username($z);
>  			} elsif (defined $svm) {
>  				$z =3D $svm->{source};
>  				$prefix =3D $svm->{replace};
> --=20
> 1.6.1.2
