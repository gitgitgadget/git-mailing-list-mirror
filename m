Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBC751F453
	for <e@80x24.org>; Tue, 25 Sep 2018 07:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeIYNMc (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 09:12:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36921 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbeIYNMc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Sep 2018 09:12:32 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C2BEE21F34;
        Tue, 25 Sep 2018 03:06:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 25 Sep 2018 03:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=QcrbGSGCS1c2lLXXg7itBVI1gVDo7gn8PgSIenbhRuM=; b=OvzHAWcZ
        JG61i2yltxSkdWeE0ovBBG6gwoVUde0mMrl/trSmTXHgZve7mcTZuzmb4CTEucfV
        JqtxOftGFfEhu/rzpgY+00yGTqNasY6I2ENyQRb1h4/KYYOI4KiAsQU1Wdsiwyer
        vvOV+l9B4jDiGuLIi245j7O1xjJcEvFGGMuP1RLsVr1Th1jWHfihd/XZkLLQhF3L
        7GzCUjCxaq3/4MRVkQFAAxncecK3/sHoUahwISxpVBGgzxZnJFH4bhYrG5FBygKA
        B47tQYXT5gBXKNu1uTpafcpObSx8XFZD1D2i8MsOuekFCVZPwmHRMPbbUkMLhTX0
        naUDmkyEc2CGlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=QcrbGSGCS1c2lLXXg7itBVI1gVDo7
        gn8PgSIenbhRuM=; b=dMbko97nKJpL24pQwM6dlvuqmD5jh8c3ihY8cyFX0Al9h
        aVeSX+r6PQsVjUoCtxU5sWxUMcLKB0N9Dd9c4CluO8o5xm3ZKCkLg1tr3TBD7tab
        GQ/AS1BkzqgExJFV9BhYuYcFNpRCdIyKMeLfpE+6kTBeon9zDkEP81YWUQK16GLh
        BuVx87K/O22piGfIT6aQlDFOr2qQeBIxsIOBBchIFQmLnzJNi+x2aMq3Phv/CYho
        Qn5dMo04zTOSAIzGG1hEkfFdaZUp8e+NJxLup5BKeCeiAvJAwjXuMwUAjuBUqePQ
        XTtnrayeUMOoyVjQHgpFypZ+n/5ogUrIoJncUxojw==
X-ME-Proxy: <xmx:b96pW8ZkUAS-O4oxNmycN_PYNLzVphvaCCD3YA9nMK6vyu6Jloc63A>
    <xmx:b96pWybdKB075-anCLm-iINGDiBiIzn6YHMcoyxnkXjv6QhanBBebw>
    <xmx:b96pW9mf5sKr_XKsyecYxNvN872yCm3cEhsOjMdz-h0iT20Ls582Hg>
    <xmx:b96pW0QXJLnYjQDf4wZyOZq5mPGy1a9Fy-Ro-CJbVq2pcBBW5wxwug>
    <xmx:b96pWyUm5vvhNTuERjJ-8ffNasQ4dBhYt_3yyR3dmpJf8Fy3CBiwBA>
    <xmx:b96pW0b-08mjYtnj-Lh6djNKzLOq5OWmBB79JSx9BVNxYnbzUin1NA>
X-ME-Sender: <xms:b96pW3HawK5dFFhijjxOO9vqeRglkuZH5H4eKK9ZaBxyjzxDChauiQ>
Received: from apu2 (x4e3473e2.dyn.telefonica.de [78.52.115.226])
        by mail.messagingengine.com (Postfix) with ESMTPA id 557AF102ED;
        Tue, 25 Sep 2018 03:06:20 -0400 (EDT)
Received: from localhost (10.192.0.12 [10.192.0.12])
        by apu2 (OpenSMTPD) with ESMTPSA id 4b2ce0ea (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 25 Sep 2018 07:06:19 +0000 (UTC)
Date:   Tue, 25 Sep 2018 09:06:18 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com, peartben@gmail.com,
        git@jeffhostetler.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] read-cache: update index format default to v4
Message-ID: <20180925070618.GB1596@xps>
References: <pull.41.git.gitgitgadget@gmail.com>
 <56374128136fe9377503d446daf98e67847194aa.1537823728.git.gitgitgadget@gmail.com>
 <20180924213223.GG27036@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <20180924213223.GG27036@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 11:32:23PM +0200, SZEDER G=E1bor wrote:
> On Mon, Sep 24, 2018 at 02:15:30PM -0700, Derrick Stolee via GitGitGadget=
 wrote:
> > From: Derrick Stolee <dstolee@microsoft.com>
> >=20
> > The index v4 format has been available since 2012 with 9d22778
> > "reach-cache.c: write prefix-compressed names in the index". Since
> > the format has been stable for so long, almost all versions of Git
> > in use today understand version 4, removing one barrier to upgrade
> > -- that someone may want to downgrade and needs a working repo.
>=20
> What about alternative implementations, like JGit, libgit2, etc.?

Speaking of libgit2, we are able to read and write index v4 since
commit c1b370e93 (Merge pull request #3837 from
novalis/dturner/indexv4, 2016-08-17), released with v0.25 in
December 2016. Due to insufficient tests, our read support was
initially broken, which got fixed with commit 3bc95cfe3 (Merge
pull request #4236 from pks-t/pks/index-v4-fixes, 2017-06-07) and
released with v0.26 in June 2017.

Right now I'm not aware of additional bugs in our index v4
support, so we'd be fine with changing the default.

Patrick

> > Despite being stable for a long time, this index version was never
> > adopted as the default. This prefix-compressed version of the format
> > can get significant space savings on repos with large working
> > directories (which naturally tend to have deep nesting). This version
> > is set as the default for some external tools, such as VFS for Git.
> > Because of this external use, the format has had a lot of "testing in
> > production" and also is subject to continuous integration in these
> > environments.
> >=20
> > Previously, to test version 4 indexes, we needed to run the test
> > suite with GIT_TEST_INDEX_VERSION=3D4 (or TEST_GIT_INDEX_VERSION=3D4).
> >=20
> > One potential, but short-term, downside is that we lose coverage of
> > the version 3 indexes. The trade-off is that we may want to cover
> > that version using GIT_TEST_INDEX_VERSION=3D3.
> >=20
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  read-cache.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/read-cache.c b/read-cache.c
> > index 372588260e..af6c8f2a67 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -1484,7 +1484,7 @@ struct cache_entry *refresh_cache_entry(struct ca=
che_entry *ce,
> >   * Index File I/O
> >   *****************************************************************/
> > =20
> > -#define INDEX_FORMAT_DEFAULT 3
> > +#define INDEX_FORMAT_DEFAULT 4
> > =20
> >  static unsigned int get_index_format_default(void)
> >  {
> > --=20
> > gitgitgadget

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAlup3moACgkQEXxntp6r
8Szadw/+J2S5WTV9i4bAhfcw8TBFE5OcQv8VPcc8uO6m8+1xNQQUhsO3zskxkrbv
FWiDH8lea5YpSjURcEEEa89/4mH01gfI1KPY7fwu3a2Ya/YOMpNz1952hZnTWJTd
SdYplNspbbSfiGe3j3N4oiwpYgt9qRz9w2hEInMNGxuyQ+XSkqf2nlvEX0+Xb0Tr
sm5WqxnRDfcDr/OUaldr87dBSpNY3pIvwt5PvO2F8nXhMYKCpgrsulC2YmS8Sfi+
dnuXktrfFj8ivD39Gag9E6TQg7fwJPGqnoilbJYVJAyAWOrszUmdmMegy7ALaBZQ
yGH9EWiu2Qt5kvSRdZhxxUboVh9R61E2wjVUTbIjqP0c1T/vCCJvdrpaSMjXdG1l
oPGIR5kw4V3Ll2JS8SvtbJWv66dCfKZYjXzuaRnoNndGGtYvNK0VcoNgOqZOo5nl
5hk6NOjb0aQI1NZSvfcb7uk4Ym+8aVrGLwMSgJqeeh6gv4XNorKwSZBJ7mNptzgq
HvBqvPQ7/eiga8dxTA9DOeUfYaV0IytyvCGnlbU/pKbJ65X5KuFvzfooT/HArjFm
YC9KigwNNuwb6eQHWBNRuOYFwWa7uNHCueZHmqCdNdVkzhMeKzNUJOd2eRUVBXyk
lYVhDx6bbdPV7OmBEKlTVb0kEveRp2GnvjAIn4Vt5XlvCbTx5P0=
=NrOG
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
