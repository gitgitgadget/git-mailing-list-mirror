Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941EC1FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 06:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbdJLGX0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 02:23:26 -0400
Received: from resqmta-po-12v.sys.comcast.net ([96.114.154.171]:50476 "EHLO
        resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750774AbdJLGXZ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Oct 2017 02:23:25 -0400
Received: from resomta-po-09v.sys.comcast.net ([96.114.154.233])
        by resqmta-po-12v.sys.comcast.net with ESMTP
        id 2WtteRWOejaVo2WtxeLPiB; Thu, 12 Oct 2017 06:23:25 +0000
Received: from mail.tremily.us ([IPv6:2001:558:600a:ce:480b:3bd8:dc5a:403a])
        by resomta-po-09v.sys.comcast.net with SMTP
        id 2WtveJJHqelnr2WtwelckM; Thu, 12 Oct 2017 06:23:24 +0000
Received: by mail.tremily.us (Postfix, from userid 1000)
        id BFCBBFED338; Wed, 11 Oct 2017 23:23:51 -0700 (PDT)
Date:   Wed, 11 Oct 2017 23:23:51 -0700
From:   "W. Trevor King" <wking@tremily.us>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?Q?=C5=81ukasz?= Gryglicki <lukaszgryglicki@o2.pl>
Subject: Re: [PATCH] pull: pass --signoff/--no-signoff to "git merge"
Message-ID: <20171012062351.GB11004@valgrind.tremily.us>
References: <18953f46ffb5e3dbc4da8fbda7fe3ab4298d7cbd.1507752482.git.wking@tremily.us>
 <xmqqefq92mgw.fsf@gitster.mtv.corp.google.com>
 <20171012053002.GZ11004@valgrind.tremily.us>
 <xmqq60bk2a7t.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jn9UjnPB79FDtyKu"
Content-Disposition: inline
In-Reply-To: <xmqq60bk2a7t.fsf@gitster.mtv.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Envelope: MS4wfDK9IfvA46O/JszFYhC449bpM6qiLczVUSXYiPIzLXodgit72RsjGfY3NP72O7EZRROnRTgUL6qDtzfacbKCIVvrHr+2NbzWEu8P94mNoFC2klYgJZx7
 8GaLgynQKCzuKOsOdYUG5PWgQyK2LyF0uajFhSj5qh1jkkjOSoAf9nlsi+VhE4lL6BJtLtFTXAVaHJzju858rnwS9/m2TTp1lPU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jn9UjnPB79FDtyKu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2017 at 02:42:30PM +0900, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> > On Thu, Oct 12, 2017 at 10:17:51AM +0900, Junio C Hamano wrote:
> >> "W. Trevor King" <wking@tremily.us> writes:
> >>=20
> >> > Following 09c2cb87 (pull: pass --allow-unrelated-histories to "git
> >> > merge", 2016-03-18) with the tests also drawing on 14d01b4f (merge:
> >> > add a --signoff flag, 2017-07-04).
> >>=20
> >> I cannot find a verb in the above.
> >
> > I'd meant it as either a continuation of the subject line, or with an
>=20
> Never do that.  The title should be able to stand on its own, and
> must not be an early part of incomplete sentence.

=E2=80=9CFollowing=E2=80=9D to an imperative =E2=80=9CFollow=E2=80=9D it is=
 then, unless you want a
more drastic rewording.

> > Sounds good.  I'll add a patch to v2 to make the same change to
> > the existing t5521 --allow-unrelated-histories test.
>=20
> Please don't, unless you are actively working on the features that
> they test.  We do not have infinite amount of bandwidth to deal with
> changes for the sake of perceived consistency and no other real
> gain.

By extention, I'm guessing that means that while the:

  test_has_trailer $OBJECT $TOKEN $VALUE

and:

  test_has_no_trailer $OBJECT $TOKEN

test-lib-functions.sh helpers I floated may be acceptable (or not, no
need to commit before you've seen a patch), you don't want me updating
existing tests to use them.  I'll just use them in my new tests, and
folks can gradually transition existing tests to them as they touch
those tests (if they remember the helpers exist ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--jn9UjnPB79FDtyKu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpgNNa8H/zemHkt2gprXBz9Wld7YFAlnfCmwACgkQprXBz9Wl
d7YnjA/9FzgKt3RhPkJd9n5Qdjeb+WenkQ7m8Pghy9v+KH+wOkgxHjEBVptJ/Mow
gILjXTqw0rLGnRqy8irAVwAAuDqZgsAhbefUj+8HpID+dETaavs5mkicgoPD68o5
InM33LnEU66zqH7OlAy+QpU5BIU1pGpM2Cl4wizjCK6lYVC7MoZevh7RIGt2hFCa
e0YvE61Tb8pOwobRcSfAE3frPmdpFu/y9ua6Ejc9Mc1ubLwrXOQaZ6LutO3pk0Iv
z950P+ZJ6RYe2jn8ijyc7VnJAEi8hzotyhSu74ImV5UuvvOV2E0uXp9M1oWEpdt2
ebu9+dusf/JkitugLhhT/U98RWr9IQ3AOPlAStAA0AYytEXuWWuLsfBq93oarDSE
Xbw4XGb/q9dz6X7BHSI3GlMo42heBSoEy1TaDB57WfpjxKX8RlyJmxnPo6bzLLmg
wp2AW710B80LLPSgZ7+3/2JpFvZvJVicefNc6cneZda37dVnooh1RFqHxw+9qjOM
L2Pb9lFS+5wcGJZvQvb9YeVLRzEjdCIs6sAe/1DphOl9nUusCW/iM+A9NOlhuMZX
rTTqrykNBOstxEFJzCRFjOs572oQx27mEnec9nkV3j1FFHgEPWe+ZbVW6Beg/MNp
/7v9I5JsgCXpLHIUNfC8ra5CdD4GQS8IlAIDi5QzUd2FlzlUwXQ=
=x0kQ
-----END PGP SIGNATURE-----

--jn9UjnPB79FDtyKu--
