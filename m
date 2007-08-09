From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] checkout-index needs a working tree
Date: Fri, 10 Aug 2007 00:35:30 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070809223530.GA29680@cassiopeia>
References: <Pine.LNX.4.64.0708042319470.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 00:35:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJGbY-0005S2-2Z
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 00:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbXHIWfm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 9 Aug 2007 18:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbXHIWfm
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 18:35:42 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:34238 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762730AbXHIWfk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 18:35:40 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IJGbT-0003gs-7w; Fri, 10 Aug 2007 00:35:39 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l79MZbQ3000011;
	Fri, 10 Aug 2007 00:35:37 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l79MZX70000010;
	Fri, 10 Aug 2007 00:35:33 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708042319470.14781@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55481>

Johannes Schindelin wrote:
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>=20
> 	This fixes "git --work-tree=3D/some/where/else checkout-index".
>=20
>  git.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/git.c b/git.c
> index 25b8274..f8c4545 100644
> --- a/git.c
> +++ b/git.c
> @@ -315,7 +315,8 @@ static void handle_internal_command(int argc, con=
st char **argv)
>  		{ "branch", cmd_branch, RUN_SETUP },
>  		{ "bundle", cmd_bundle },
>  		{ "cat-file", cmd_cat_file, RUN_SETUP },
> -		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
> +		{ "checkout-index", cmd_checkout_index,
> +			RUN_SETUP | NEED_WORK_TREE},
>  		{ "check-ref-format", cmd_check_ref_format },
>  		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
>  		{ "cherry", cmd_cherry, RUN_SETUP },
With this patch I'm not able to do

	git checkout-index --prefix=3D/tmp/exportdir -a

to export an entire tree as described in git-checkout-index(1) in a bar=
e
repo.

(Not that I need it, but I claimed on #git that it works, ... )

BTW: I didn't try if reverting this patch helps, but probably it does.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D72+PS+point+in+inch
