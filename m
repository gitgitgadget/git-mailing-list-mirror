Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188092942B
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gcwuo7p1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pGzJ94ZU"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B54D10E5
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:11:18 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 8B6FE32009BC;
	Tue, 24 Oct 2023 09:11:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 24 Oct 2023 09:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698153077; x=1698239477; bh=ZI
	ulf8p5P1sFr8OpHPLfmknQk3p2DIrP9qjZXRmkxNk=; b=Gcwuo7p1ZVZQfanT3W
	U9d6ZE8EufYpjRXCuBaoJKby6Vt0Q0VDRb+SrRXci+XYYdLucOjT7mABfou5VII3
	h/YN+v03vcGDfPIVdhK1hpwcUKMkkgIdz3iuwn6Wf/ts/7tqLbTI76LuBGWfdPcg
	lXAJ2sUlaaR7l/hqCPbtoGtUBtCNmyYQmq41+phBrt77vxtB9AqZJs0qACyCj5HR
	MQhvExMW6n8fyEgB2dENIGEXeDcTSxPRdyXHRxklKjn2u0R62RgTyCPJqYbFZrBy
	kfT1XpGt07mcWSuYMwYQksI95eBcvfw/3Zj/Jx9YkBcSsLC7nFLXnJ/0zxJD/4Wt
	bhZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698153077; x=1698239477; bh=ZIulf8p5P1sFr
	8OpHPLfmknQk3p2DIrP9qjZXRmkxNk=; b=pGzJ94ZUwm/9DQl2sVcZLf/XTlbpM
	Gbzq3hy3MoqOEqY7pwWRPhzsNgoyIcf7MlLfQEjKNsJxaRB9+v/tGXeiBFPtgLsf
	FkMY0e4rUab27tuh0JlQZ7FI8xE5zx5BQr0aDrW7/w5FYAX4dxFeKiaVxEJpL+gg
	AKdStW7UqsPkfjNGtZfQ/ewzOHthj8TNtN21h88tn7MFjD6eDhb/eQDKzRhweOc5
	VFY3f7ltz6y+HALCEzwDc4BukrYhFMVXKmD6TN75aHBs+ymOT0WF53NneVBS3jjx
	OYK5EoRhB2ubINuuprvHrpy1dAJ/pC3LbwUMMMiUI6NXSKSrk+aAM8mmQ==
X-ME-Sender: <xms:dMI3ZRKso0jUNmenrFawoZ2xVwmjG2Z8oQXBuTr1pSbjfJnnmQNcfA>
    <xme:dMI3ZdKL1n5mMpxQq2OOHcdu6DqwChuQ_7R--N1EovSFlkT-7ygCuYD-6_8T4Fmc6
    cWpUMqXXyaAvFWGNA>
X-ME-Received: <xmr:dMI3ZZuM8LtfzWtHBYUPkIpmlA14TXipXqdEYd1_dO7gJuG6c3oxHzVh25qLMx4eyXrWLBlyQ3CCybyA2z1j_kYfddKDNjYRLyfU4EMfkHYMSNE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:dMI3ZSaMhnF8VjqgZ3SzajP96Y0mN1XXFyqRT-pVnzYP5Y4e-yOqFA>
    <xmx:dMI3ZYaUf5tC6FLu9ZZ1s4x8bwNdqxCid0TiProTydOjUYB6JgQixw>
    <xmx:dMI3ZWA9MXUerzoFJPicFtzhHW0u-iJLnWSviNJWkFzq1wnL3UpkKw>
    <xmx:dcI3ZXls2rZ3kcUT3JjxI2PR3uLNmXGjfG1j6L2lr6Qu_QIGNUY86Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 09:11:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b36975e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 13:11:11 +0000 (UTC)
Date: Tue, 24 Oct 2023 15:11:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 09/12] builtin/show-ref: ensure mutual exclusiveness of
 subcommands
Message-ID: <d0a991cf4f892e73e4fd62ef3fdae3fa73277321.1698152926.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="48xZLuLJDLt94qo0"
Content-Disposition: inline
In-Reply-To: <cover.1698152926.git.ps@pks.im>


--48xZLuLJDLt94qo0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-show-ref(1) command has three different modes, of which one is
implicit and the other two can be chosen explicitly by passing a flag.
But while these modes are standalone and cause us to execute completely
separate code paths, we gladly accept the case where a user asks for
both `--exclude-existing` and `--verify` at the same time even though it
is not obvious what will happen. Spoiler: we ignore `--verify` and
execute the `--exclude-existing` mode.

Let's explicitly detect this invalid usage and die in case both modes
were requested.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c  | 3 +++
 t/t1403-show-ref.sh | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 5d5d7d22ed1..10d0213e687 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -269,6 +269,9 @@ int cmd_show_ref(int argc, const char **argv, const cha=
r *prefix)
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);
=20
+	if ((!!exclude_existing_opts.enabled + !!verify) > 1)
+		die(_("only one of --exclude-existing or --verify can be given"));
+
 	if (exclude_existing_opts.enabled)
 		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
 	else if (verify)
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 9252a581abf..3a312c8b27c 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -196,4 +196,9 @@ test_expect_success 'show-ref --verify with dangling re=
f' '
 	)
 '
=20
+test_expect_success 'show-ref sub-modes are mutually exclusive' '
+	test_must_fail git show-ref --verify --exclude-existing 2>err &&
+	grep "only one of --exclude-existing or --verify can be given" err
+'
+
 test_done
--=20
2.42.0


--48xZLuLJDLt94qo0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3wnEACgkQVbJhu7ck
PpS71w//UmrDFm/jhD7BHMImArRjQgFAuEiocvUCZTU2iAtGG1zyGvhRWZFHwbEI
HTJExa/EpHcGHAX5RnLhLIMvtHdg76/7QlxFhE4FhWr3Zp4yNF53e4smzRz+ADHr
pPnHPTtMMcRVimRURNmmhP/bJ08RDUA11fBbsFxZQE+PfBkj9qyuqVOsdtDnhk+8
4MD7vmD7oPiVs/UOZN+9ch+DcO/NfDfXxoXk/7AYjNdoFAnHgmphDJEhJH7Abn1g
iMXk7R+pKcODgTDh3OtM5/mGS5xnXhZsBFtIjptn9YKDAStlEmSXwgIvCua71G9N
FQGOLlzLXy61x3adUhw3OnAN0szsNXm5zcXE8Kxgt1BUCYSc5fK/EFa404xcEOym
FRFKVEFgjZpIOCWjMbp89P4ZbBRwO5oXPe5ieBAB1ZLDUlVxi35CQcHo+J5vKiXz
sEhUFHddEddVn7bFx5tHqKrLF5bnNmMfFpJp1ait/98MvTMkUBdUloWmvmFPNmNr
4a4Bw7mZz1rj9+RwHwN40+yIjUVMNfEMw99irREU8Uw6qFmTJgmRlDU/W9BwWhFl
mNo3kddh7GRVlfmmjyL5w8ZPYZpwFOlj9yxuAKwbk4uVwoMnSG6hRu3HlORKCVtd
A2dT3Thu7bBK6QUI5CR0sDZjeIEdRb0mI0ZYVYwdntGr6oUQA/w=
=iOV7
-----END PGP SIGNATURE-----

--48xZLuLJDLt94qo0--
