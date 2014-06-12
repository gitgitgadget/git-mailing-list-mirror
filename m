From: Caleb Thompson <caleb@calebthompson.io>
Subject: Re: [PATCH v4 1/4] commit test: Use test_config instead of git-config
Date: Thu, 12 Jun 2014 08:51:31 -0500
Message-ID: <20140612135051.GA35824@sirius.local>
References: <1402511079-17735-1-git-send-email-caleb@calebthompson.io>
 <1402511079-17735-2-git-send-email-caleb@calebthompson.io>
 <20140612084152.GA6095@hudson.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
To: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 15:51:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv5Po-000239-8s
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 15:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933888AbaFLNvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 09:51:36 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:56647 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933885AbaFLNvd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 09:51:33 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DE8D163C
	for <git@vger.kernel.org>; Thu, 12 Jun 2014 09:51:32 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 12 Jun 2014 09:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=date:from:to:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=mesmtp; bh=v7RV/itSdYdhdALfseHSavNE
	rXc=; b=imJpftDL8+4MOYojq5+SYfsf+AI6J5/NwowjSj2cOblA3kdwyT7n5po/
	NjAKCPlDd+p97ttsvniuanswe85Kn7UOk2BdsukQucSl1ZGhcFl2QFprYwveTteb
	oXQKZ54DMO5Ug5EAd8UwvUFNYS5axqtj0PmZ2nE3bM5n07Zp5kE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=v7RV/itSdYdhdALfseHSavNErXc=; b=JLB/XjSZNfPg4kh9X7WW3vNmIua7
	eYCY5UVoiaSc/LJzY+pv++S9bFGqlIGfR3x8IcFIVPoAakoOyF9GpQoCxAbMV22H
	/wuAUDA+JpIn7p+vgCRnuNy99jvPBOlDFpjYDJRpg9FWXikf53uwEly71BiON1AH
	5XFQ5n+halYNWVU=
X-Sasl-enc: 62G/ltB/CG1dpGgcKlkegZMYwqWH9sGdRlN1nGOEZbnI 1402581092
Received: from localhost (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 56DD4C007AA;
	Thu, 12 Jun 2014 09:51:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140612084152.GA6095@hudson.localdomain>
X-PGP-Key: fp="B432 C068 2FD1 C2D0 6A8B 3951 1621 ADC2 A0AC E70A";
 id="0xA0ACE70A"; get=<http://calebthompson.io/pubkey.asc>;
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251406>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I assume that you're running it against master?

I rebased the branch yesterday, but I'll give it another shot. Obviously I
didn't use git-am, but I can try that.

Caleb Thompson

On Thu, Jun 12, 2014 at 01:41:52AM -0700, Jeremiah Mahler wrote:
> On Wed, Jun 11, 2014 at 01:24:36PM -0500, caleb@calebthompson.io wrote:
> > Some of the tests in t/t7507-commit-verbose.sh were still using
> > git-config to set configuration. Change them to use the test_config
> > helper.
> >
> > Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
> > ---
> >  t/t7507-commit-verbose.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> > index 2ddf28c..6d778ed 100755
> > --- a/t/t7507-commit-verbose.sh
> > +++ b/t/t7507-commit-verbose.sh
> > @@ -43,7 +43,7 @@ test_expect_success 'verbose diff is stripped out' '
> >  '
> >
> >  test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
> > -	git config diff.mnemonicprefix true &&
> > +	test_config diff.mnemonicprefix true &&
> >	git commit --amend -v &&
> >	check_message message
> >  '
> > @@ -71,7 +71,7 @@ test_expect_success 'diff in message is retained with -v' '
> >  '
> >
> >  test_expect_success 'submodule log is stripped out too with -v' '
> > -	git config diff.submodule log &&
> > +	test_config diff.submodule log &&
> >	git submodule add ./. sub &&
> >	git commit -m "sub added" &&
> >	(
> > --
> > 2.0.0
> >
>
> It is probably something dumb on my part but for some reason I cannot
> apply this patch using 'git am'.  After I save the patch to a Maildir
> from Mutt and run git am...
>
>   jeri@hudson:~/git$ ./git-am ct1.patch
>   Applying: commit test: Use test_config instead of git-config
>   fatal: corrupt patch at line 15
>   Patch failed at 0001 commit test: Use test_config instead of git-config
>   The copy of the patch that failed is found in:
>      /home/jeri/git/.git/rebase-apply/patch
>   When you have resolved this problem, run "git am --continue".
>   If you prefer to skip this patch, run "git am --skip" instead.
>   To restore the original branch and stop patching, run "git am --abort".
>   jeri@hudson:~/git$
>
> The second patch in the series applies fine.  And I have applied other
> patches this way without issue.  Can anyone confirm this problem?
>
> --
> Jeremiah Mahler
> jmmahler@gmail.com
> http://github.com/jmahler

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJTmbBjAAoJEBYhrcKgrOcKYD0H/jd1Af03IN/u5RSqewji9kBK
vMZ7UIXS/6YUdoIcEUATUUkujOhbdqf3ghKDa+Nv7E3g7Dq7O05bA5SF+DcB+Qps
rib+Ick3UzEYXIdnwy7kX2Ma8LHyM5KFM7220c44LSwd1VWdy7i5aXM3Rh+ucVvR
GvXSzverrSHtwpJtxXx3ap5qy3DvlFUL1WjhVeAm79r5ATkH552EAZwBPmn+NLtr
n5UroMlH8HlvrHojBWcxu5WF0LpgNEuILrKY2oGnhphP0wQb0+X4rQzjCHQ6E74u
FUHyTYg+9pt3WdKVtdSwSwd3O6lF2iE3XRWTAqGbV4FO2+j01HmeCpEySSapCjI=
=X3Lr
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
