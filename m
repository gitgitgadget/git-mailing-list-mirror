Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403322022F
	for <e@80x24.org>; Fri, 24 Feb 2017 23:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbdBXXZ2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 18:25:28 -0500
Received: from sunbase.org ([178.79.142.16]:36310 "EHLO sunbase.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbdBXXZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 18:25:27 -0500
Received: from sunny by sunbase.org with local (Exim 4.84_2)
        (envelope-from <sunny@sunbase.org>)
        id 1chPDw-00083F-Lz; Fri, 24 Feb 2017 23:24:28 +0000
Date:   Sat, 25 Feb 2017 00:24:28 +0100
From:   =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Santiago Torres <santiago@nyu.edu>, Joey Hess <id@joeyh.name>,
        git@vger.kernel.org
Subject: Re: SHA1 collisions found
Message-ID: <20170224232426.3737imr4qxtlioxd@sunbase.org>
Mail-Followup-To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Santiago Torres <santiago@nyu.edu>, Joey Hess <id@joeyh.name>,
        git@vger.kernel.org
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com>
 <20170224225350.xb7rudyhowmsqdbc@LykOS.localdomain>
 <e0ad3c81-aa2c-2eea-eb9e-17591b6b592c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ao55ug5oc2xjox3e"
Content-Disposition: inline
In-Reply-To: <e0ad3c81-aa2c-2eea-eb9e-17591b6b592c@gmail.com>
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: NeoMutt/20170206-255-40b62d (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ao55ug5oc2xjox3e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2017-02-25 00:05:34, Jakub Nar=C4=99bski wrote:
> W dniu 24.02.2017 o 23:53, Santiago Torres pisze:
> > On Fri, Feb 24, 2017 at 11:47:46PM +0100, Jakub Nar=C4=99bski wrote:
> > > I have just read on ArsTechnica[1] that while Git repository could=20
> > > be corrupted (though this would require attackers to spend great=20
> > > amount of resources creating their own collision, while as said=20
> > > elsewhere in this thread allegedly easy to detect), putting two=20
> > > proof-of-concept different PDFs with same size and SHA-1 actually=20
> > > *breaks* Subversion. Repository can become corrupt, and stop=20
> > > accepting new commits.
> >
> > From what I understood in the thread[1], it was the combination of=20
> > svn + git-svn together. I think Arstechnica may be a little bit=20
> > sensationalistic here.
>
> > [1] https://bugs.webkit.org/show_bug.cgi?id=3D168774#c27
>
> Thanks for the link.  It looks like the problem was with svn itself=20
> (couldn't checkout, couldn't sync), but repository is recovered now,=20
> though not protected against the problem occurring again.
>
> Well, anyone with Subversion installed (so not me) can check it for=20
> himself/herself... though better do this with separate svnroot.

I tested this yesterday by adding the two PDF files to a Subversion=20
repository, and found that it wasn't able to clone ("checkout" in svn=20
speak) the repository after the two files had been committed. I posted=20
the results to the svn-dev mailing list, the thread is at=20
<https://svn.haxx.se/dev/archive-2017-02/0142.shtml>.

It seems as it only breaks the working copy because the pristine copies=20
are identified with a SHA1 sum, but the FSFS repository backend seems to=20
cope with it.

Regards,
=C3=98yvind

+-| =C3=98yvind A. Holm <sunny@sunbase.org> - N 60.37604=C2=B0 E 5.33339=C2=
=B0 |-+
| OpenPGP: 0xFB0CBEE894A506E5 - http://www.sunbase.org/pubkey.asc |
| Fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5 |
+------------| 41517b2c-fae7-11e6-9521-db5caa6d21d3 |-------------+

--ao55ug5oc2xjox3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliwwKoACgkQ+wy+6JSlBuVm/wCfUF+JrbYIIpseU+h6pU01UEEZ
t6wAn1LfnItvW9571hsK+BePmaA7cLXW
=ETYw
-----END PGP SIGNATURE-----

--ao55ug5oc2xjox3e--
