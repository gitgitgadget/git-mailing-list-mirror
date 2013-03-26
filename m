From: Jeff King <peff@peff.net>
Subject: Re: git ate my home directory :-(
Date: Tue, 26 Mar 2013 11:04:28 -0400
Message-ID: <20130326150428.GA3847@sigill.intra.peff.net>
References: <5150C3EC.6010608@nod.at>
 <20130325214343.GF1414@google.com>
 <7vboa7w2vm.fsf@alter.siamese.dyndns.org>
 <384BCFE976364F1EA6E56306566D003A@PhilipOakley>
 <20130326094844.GA32583@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Richard Weinberger <richard@nod.at>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 16:05:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKVQr-0005H4-IN
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 16:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934541Ab3CZPEd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Mar 2013 11:04:33 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40292 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756862Ab3CZPEc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 11:04:32 -0400
Received: (qmail 3146 invoked by uid 107); 26 Mar 2013 15:06:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 11:06:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 11:04:28 -0400
Content-Disposition: inline
In-Reply-To: <20130326094844.GA32583@duynguyen-vnpc.dek-tpc.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219162>

On Tue, Mar 26, 2013 at 04:48:44PM +0700, Nguyen Thai Ngoc Duy wrote:

> Something like this, maybe?
>=20
> -- 8< --
> Subject: [PATCH] git.txt: document the implicit working tree setting =
with GIT_DIR
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 7efaa59..ce55abf 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -671,6 +671,8 @@ Git so take care if using Cogito etc.
>  	specifies a path to use instead of the default `.git`
>  	for the base of the repository.
>  	The '--git-dir' command-line option also sets this value.
> +	If neither GIT_WORK_TREE nor '--work-tree' is set, the
> +	current directory will become the working tree.

I think this is a good thing to mention, but a few nits:

  1. core.worktree is another way of setting it

  2. This can also be overridden by --bare (at least in "next").

  3. I think having core.bare set will also override this

-Peff
