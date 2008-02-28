From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] "git read-tree -m" and the like require worktree
Date: Wed, 27 Feb 2008 16:48:10 -0800
Message-ID: <7vhcftnbxx.fsf@gitster.siamese.dyndns.org>
References: <cover.1204130175.git.pclouds@gmail.com>
 <20080227163810.GA28016@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 01:49:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUWxI-0008HG-CI
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 01:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbYB1AsY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 19:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbYB1AsY
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 19:48:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59632 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbYB1AsX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 19:48:23 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AFDFB26D9;
	Wed, 27 Feb 2008 19:48:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 09A5A26D6; Wed, 27 Feb 2008 19:48:18 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75337>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin-read-tree.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-read-tree.c b/builtin-read-tree.c
> index e78cf69..95318e3 100644
> --- a/builtin-read-tree.c
> +++ b/builtin-read-tree.c
> @@ -219,6 +219,9 @@ int cmd_read_tree(int argc, const char **argv, co=
nst char *unused_prefix)
>  	if ((opts.dir && !opts.update))
>  		die("--exclude-per-directory is meaningless unless -u");
> =20
> +	if (opts.merge)
> +		setup_work_tree();
> +
>  	if (opts.prefix) {
>  		int pfxlen =3D strlen(opts.prefix);
>  		int pos;

How would this interact with "read-tree -m -i"?
