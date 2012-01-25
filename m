From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v2 3/3] git-p4: Add test case for complex branch import
Date: Wed, 25 Jan 2012 07:34:25 -0500
Message-ID: <20120125123425.GA3406@padd.com>
References: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
 <1327105292-30092-4-git-send-email-vitor.hda@gmail.com>
 <7vehutd59p.fsf@alter.siamese.dyndns.org>
 <4F1A98A3.2090607@diamand.org>
 <20120121171130.GA6235@padd.com>
 <CAOpHH-W1LY3Q50otrcNJTYWN67k_pCZHEOkgbKy7kPgfUbGeQw@mail.gmail.com>
 <20120123224012.GA10626@padd.com>
 <CAOpHH-V2nZ8meh7x6vCVGUQCKQqJ+sPcnGRo+8SqfNavg7F87w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 13:34:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq23g-0006JP-Sa
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 13:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002Ab2AYMe3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jan 2012 07:34:29 -0500
Received: from honk.padd.com ([74.3.171.149]:47061 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665Ab2AYMe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 07:34:28 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id F3FFFE8E;
	Wed, 25 Jan 2012 04:34:27 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3F2F931453; Wed, 25 Jan 2012 07:34:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAOpHH-V2nZ8meh7x6vCVGUQCKQqJ+sPcnGRo+8SqfNavg7F87w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189110>

vitor.hda@gmail.com wrote on Wed, 25 Jan 2012 01:23 +0000:
> On Mon, Jan 23, 2012 at 10:40 PM, Pete Wyckoff <pw@padd.com> wrote:
> > How about taking what's below and just squashing it in. =A0It's
> > incremental on your changes and would go well with Luke's series
> > that fixes a bunch of scattered quoting issues similarly.
> >
> > The change to "describe %s" is unnecessary, but makes all the
> > invocations look similar. =A0You can leave it out.
>=20
> I've squashed your patch, but kept the "describe %s" fix in a separat=
e
> commit.
>=20
> >> BTW, and on an unrelated topic, are any test cases failing on your=
 side?
> >
> > I do run the tests regularly, and your series is good. =A0There's
> > the 'clone --use-client-spec' one that is broken until my
> > 2ea09b5 (git-p4: adjust test to adhere to stricter useClientSpec,
> > 2012-01-11) is merged. =A0It's on pu.
>=20
> Tests in t9809-git-p4-client-view.sh were failing for me because I'm
> using dash instead of bash. Please check patch below for a fix.
>=20
> Test 15 of t9800-git-p4-basic.sh is still failing and I've not been a=
ble
> to pinpoint the problem. I can send you the logs off-list, if you wan=
t.
>=20
> Thanks,
> Vitor
>=20
>=20
>=20
> diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-vi=
ew.sh
> index c9471d5..5b0ad99 100755
> --- a/t/t9809-git-p4-client-view.sh
> +++ b/t/t9809-git-p4-client-view.sh
> @@ -31,7 +31,7 @@ client_view() {
>  #
>  check_files_exist() {
>         ok=3D0 &&
> -       num=3D${#@} &&
> +       num=3D$# &&
>         for arg ; do
>                 test_path_is_file "$arg" &&
>                 ok=3D$(($ok + 1))
>=20

Yes, thanks.  Plain old $# works fine, even if the arguments have
spaces.  I'll hang onto this with some other work in the same
area and submit it eventually.

		-- Pete
