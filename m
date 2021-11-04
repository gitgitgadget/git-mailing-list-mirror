Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFBBC433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 12:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A801461076
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 12:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhKDMlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 08:41:22 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54829 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhKDMlV (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 Nov 2021 08:41:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4409A5C0112
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 08:38:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 04 Nov 2021 08:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:mime-version:content-type; s=fm2;
         bh=rnVl5AYZbiVD9K0V9rbtCRVVBQxgiYdLx4ohVEOpILE=; b=qBiRRVbvdAsK
        rYwRE6x+++qq6LYbznK7FVtuqkcNMIrc+gViB7SZI2ZB2PYa+r3NbGzKxzOfFnnC
        cHVMwm2jmE8AWudRQeUWoXJMuzR7M3YI8VJpFc0RkDveVbtz36/0X7xKzRg+EsE6
        xaClNkY30IrpYFDsVaKWBeXFdHMUCvUqLojq3dcKEWmOrgpFXllcW1twsg8d3u23
        idpbD/GmfYQpp3fx8ZD7fLenG0LpNLd6+/ss8Mznzq0Izj9h9mkJSjKiWnjNtcfW
        pDusNL2x5lfcA97RD8xgHsIqvWxbSj3Di3q6IKLT8GQjTjdNoKd8b8bxpqVoLgRT
        9XsUEhuEDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=rnVl5AYZbiVD9K0V9rbtCRVVBQxgi
        YdLx4ohVEOpILE=; b=kj7hEO3tB/B+azrYDmEo1WruVfo/ekVK1+v0R5kFbyvZe
        BVVo8XK0kxhScFRIjPLJK9GyRo7+u8tLQeH6S1SxDD5wolnysFSDPqAC05P6ONbd
        oygujgkng8/8/eT6Fgp5pxgra8AaxupAFCyBnlEby9udgN9/uBuSuVWtkkhlV7Do
        NtSse95NZTD5THHF4DPd+4XJa0+4FDv+F3AFV0/tu9lNjuTvo1Abzwa3PtT24hAt
        WHFyt/y88w7TDaVKHjKHN7xU5RqVDXJYs4lkrpkCHpzo/ZxZLRPyK1WSOAzV9kYS
        snUcCObbSzM8OzkMiYjxTGk+u7/WzrB3KcPJacwdg==
X-ME-Sender: <xms:UtSDYdOScG7BdrAsPSwe9pDOTv8RWZV3Sq3EXV5ApYpJim7t9BrV4Q>
    <xme:UtSDYf8xUsYUGsUpuTyphPVlc2iX75Ply3lYdxQbBDlhUDaQ0Xu4ktryTd4xexU8h
    mvtYjnAfGgB7SgpTA>
X-ME-Received: <xmr:UtSDYcS7XnpTb4IBAeYEUYmRZ0d0FmwoId--XwMb007qv5oJiOuDWw0_oVquh5unWmAbNSjkW7n9dfYmB3oupN3Abp0-ZgcyHWs3kN_p0VNXPBWwI6RniA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtdeggdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeffjeehvdfgudefffefffelueekgfevieektdejvd
    dukeeugeekudehtdduffffjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:UtSDYZt2m4znZR2fTfh_8lW8jXfLKSU6v5u1zkhMXK8j90-EFAAStw>
    <xmx:UtSDYVeG6IfcS3K8xLdW5QDqyGHqIc8mjJF-c1HNhaAQS6EGB4tI2w>
    <xmx:UtSDYV35zZFVu3_EFGDceiVFvG42qVIeClUvtmjgl0ae9sAZjnN_tg>
    <xmx:U9SDYboFRaj0x_o6QjLtXDvIGOI1_Z_r65dOUdeZDjE5ro2ipjOWJQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Nov 2021 08:38:42 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 693e8966 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Thu, 4 Nov 2021 14:26:49 +0000 (UTC)
Date:   Thu, 4 Nov 2021 13:38:22 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH] refs: sync loose refs to disk before committing them
Message-ID: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C3L1vaivyyL9M/+0"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--C3L1vaivyyL9M/+0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When writing loose refs, we first create a lockfile, write the new ref
into that lockfile, close it and then rename the lockfile into place
such that the actual update is atomic for that single ref. While this
works as intended under normal circumstences, at GitLab we infrequently
encounter corrupt loose refs in repositories after a machine encountered
a hard reset. The corruption is always of the same type: the ref has
been committed into place, but it is completely empty.

The root cause of this is likely that we don't sync contents of the
lockfile to disk before renaming it into place. As a result, it's not
guaranteed that the contents are properly persisted and one may observe
weird in-between states on hard resets. Quoting ext4 documentation [1]:

    Many broken applications don't use fsync() when replacing existing
    files via patterns such as fd =3D
    open("foo.new")/write(fd,..)/close(fd)/ rename("foo.new", "foo"), or
    worse yet, fd =3D open("foo", O_TRUNC)/write(fd,..)/close(fd). If
    auto_da_alloc is enabled, ext4 will detect the replace-via-rename
    and replace-via-truncate patterns and force that any delayed
    allocation blocks are allocated such that at the next journal
    commit, in the default data=3Dordered mode, the data blocks of the new
    file are forced to disk before the rename() operation is committed.
    This provides roughly the same level of guarantees as ext3, and
    avoids the "zero-length" problem that can happen when a system
    crashes before the delayed allocation blocks are forced to disk.

This explicitly points out that one must call fsync(3P) before doing the
rename(3P) call, or otherwise data may not be correctly persisted to
disk.

Fix this by always flushing refs to disk before committing them into
place to avoid this class of corruption.

[1]: https://www.kernel.org/doc/Documentation/filesystems/ext4.txt

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 151b0056fe..06a3f0bdea 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1749,6 +1749,7 @@ static int write_ref_to_lockfile(struct ref_lock *loc=
k,
 	fd =3D get_lock_file_fd(&lock->lk);
 	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
 	    write_in_full(fd, &term, 1) < 0 ||
+	    fsync(fd) < 0 ||
 	    close_ref_gently(lock) < 0) {
 		strbuf_addf(err,
 			    "couldn't write '%s'", get_lock_file_path(&lock->lk));
--=20
2.33.1


--C3L1vaivyyL9M/+0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGD1D0ACgkQVbJhu7ck
PpTv5xAAg+kjxspBcCpXYfu3GzDrNtoA4yZMbYzC6wGbb20ng+MQKJa1Bg0L3Fvi
EWTGNPcBzJLDmhdp7qplMJeSwRHwID3JdaWX6OOqdLEawFbw3cl5GSB8SFdGMXZU
1U/fUbxGqIK64ahZioxRpSw19/3mNsrb9DJCkkEt0+sVkbRVPqAUIWM360NsIjOy
Nft9Qw6t5Hsj0HqvmtCJXXjhpYJBHrJAoEoFCY2VunUTNZSJSKoWjcQlUVodNUBR
3W4V7rgRV2isFRKTcT+2hfQbnrJvkE1UbbNs8SMTqzSYEawZ/3ycLa/o3Axi2MtX
S8KS/pDrNmho36kxiJCbRyfBVBJIw6shXW68SJvK/wvFl2dTB5/Np4idqO5dyxHk
I23qOGKcWe/kGjxXFcKdI2b4yAsYoN/dhQvC1nl69rBRUoeDuqU/F+A/ZnIRVdRK
mhYoMbYp6hE4dgbwtHpLlZFXbyV30VwhiMSeDd1xY3zGuMOeHOMXhCTV/8Ky+MJt
E58WuJBvfk9sGLtj+lnax+bsiSYvn3pLu0scODTU3RRfERnN/3vCMJgrZmjP5SUb
vyjApEQ0Gtoibw6hxFWO4xkBcnGHdS5DEGvehYxxRsWFUzbHgOyIAfTaQl/JAoNx
IUZ2VvSV7UEi7B+83LvZUcUEM8N791+c1VXp9aHql/jEjiS36bQ=
=+FUU
-----END PGP SIGNATURE-----

--C3L1vaivyyL9M/+0--
