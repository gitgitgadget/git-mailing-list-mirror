Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="TN9Exrh+"
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 00:14:47 PST
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EAEB4
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 00:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702282485; x=1702887285; i=l.s.r@web.de;
	bh=ta4CWcUKvT1VbtceUNH4u090AnQRNMdH8rFDEyu36eU=;
	h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:
	 In-Reply-To;
	b=TN9Exrh+wkwwrLqaYql6WTfQt973e6r+Jdi7sn4TmQbGopYDeyI7MB1ySP4v3s/x
	 +dl9YzoCWzZ5RtNqnuXvljcyTSMl8nARMOdByVuHhKfXaU6UssMwv6oNnbZnvN2I5
	 TyT1u2ve0BXcboNpO46H9YdqhtLkhuGY3ffuqIJW7ikaIdspvoi8gi+sJEGNsSkI3
	 L74LT8Hi47Lv4LRmr2VK7tk/7wkoHfbvyfQLPCKPUTfLNA2WAbniu4D09265wQysJ
	 tATQHIxm+WafX9KcC3Vd6A/Ss5/hL6Ryq4yKEbJYRpbqaMzIqOPo+jieeyJoz/a76
	 B8cRdcHuT/PBapNqtg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.38]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmq2-1qxo233Dny-00FIbA; Mon, 11
 Dec 2023 09:09:29 +0100
Message-ID: <e5304253-3347-4900-bbf2-d3c6ee3fb976@web.de>
Date: Mon, 11 Dec 2023 09:09:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH][RESEND] show-ref: use die_for_incompatible_opt3()
To: Git List <git@vger.kernel.org>
Cc: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <e6eb12e4-bb63-473c-9c2f-965a4d5981ad@web.de>
 <CAPig+cR5PKkyC24LkOU4+yzng1xeBOBbADTBHXH61xkAR7kymw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPig+cR5PKkyC24LkOU4+yzng1xeBOBbADTBHXH61xkAR7kymw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9kFy4Sk7rA+tKNqWagGPFHTclklmQnlKBVZwYhWLOnnz/cd1GIw
 HwkxGz7hSDDPFvF9XPQCfRG/Dps1mLul6bEsRtw3ekUxSRtwsQT6pDrhlVDFZAsZW1b1cre
 CasWqw9aLCqu0WGYfl/h0EYaG4gl6mTXSdUKxVbZQPzRXOJU3N6YRRXTGOKHjNA+8BO248o
 6+y0tLha2l78srfJFTcjA==
UI-OutboundReport: notjunk:1;M01:P0:qlbVHdeBltY=;YuGdZzwaPH2iIvIjAJk2FKvLmpr
 WcHHSwUZNOaTYpF8l48H4vR0Xtgj48WWWiHRA8NOd++lTuDP8jryUiHslr7u0qPiJ76/Mcy7E
 As6iYRS8K9qI8/ltfAuiklG0lVH9BDLEWllKSGqwkY+kSyWtevxetFnreig6WBL8WBzs3UzgF
 PCxSN5a2bk0n8BUNpbHih4DfRdy6+59CqgIELMlN1kXBN3Cw4heYGAOpHm55e8PioWlXNsaQi
 XdLHw/4VTNktyrHTNmYPUOH6hWgp4Lzr0yWrCo+xHZHKkzntqoxTZx+v9WeNUTjN+kGxw4wVQ
 lRO3zUyrdEOhL4nbfcR1z9L7H2nA+yiWVbyj2vy41PCIqOGRFICgEygSglSrWux4hmZA3NAnA
 BU78+/zUjqrE9yzwRdBpMMOuzdI7pQCzvwcZKiBKNZmJOG6izw2bke3OwmIGOETWDKZWAVxDH
 E1B8j3XKRyzsux4MILqGSc5KjQ8/J79C0XzBIfTlLcrAdauW1NuN6Mex+L+17FzlDX9AtE4uv
 1XlgTg0Q6xhhtGqa86oxMtiGBtfedQX6YtfXD6leqIImK7jNn1GvYAuScyImT7zORNdyRFQB2
 9qQgQIAK1rOt8L7WD5uLNWOORIyrtqEaToQUsbc5Zl4UskCZ7zEN/I6uIgCMcVcihVEEfpl8R
 fcqLpbayfwpuxgfI+scGkrL+eWHNDnTMGqKoQeOnspdianpM9FoAWv2mOzndKkFg648QZ/W5V
 5/2UwOK2FfGWkZraKtJohXedOPleibmbqT/zNA9E7ETs23JgnKXdwjGs07hLErLYd/0L57fY0
 L+CwK/EZtnv/clFd8AHhzhyuEUZmSNzjah3dnU1QE2K50tpxyizIO1wVBcx5783T0u6fmpUPQ
 vCviRF3ATs1/3NhQDgd9EZ/diHxNIzKzb9hsUKynOWNd/S9sRVUdqkQKJxDmiIStvoI+hrC0Y
 JuQ9LYpITYXW9s7+20B2kUfbj64=

Use the standard message for reporting the use of multiple mutually
exclusive options by calling die_for_incompatible_opt3() instead of
rolling our own.  This has the benefits of showing only the actually
given options, reducing the number of strings to translate and making
the UI slightly more consistent.

Adjust the test to no longer insist on a specific order of the
reported options, as this implementation detail does not affect the
usefulness of the error message.

Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Reviewed-by: Patrick Steinhardt <ps@pks.im>
=2D--
Original submission:
https://lore.kernel.org/git/d1f28272-635d-4638-b0f4-76d64013b0d5@web.de/

 builtin/show-ref.c  |  6 +++---
 t/t1403-show-ref.sh | 16 +++++++++-------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 7aac525a87..59d2291cbf 100644
=2D-- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -315,9 +315,9 @@ int cmd_show_ref(int argc, const char **argv, const ch=
ar *prefix)
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);

-	if ((!!exclude_existing_opts.enabled + !!verify + !!exists) > 1)
-		die(_("only one of '%s', '%s' or '%s' can be given"),
-		    "--exclude-existing", "--verify", "--exists");
+	die_for_incompatible_opt3(exclude_existing_opts.enabled, "--exclude-exis=
ting",
+				  verify, "--verify",
+				  exists, "--exists");

 	if (exclude_existing_opts.enabled)
 		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index b50ae6fcf1..d477689e33 100755
=2D-- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -197,18 +197,20 @@ test_expect_success 'show-ref --verify with dangling=
 ref' '
 '

 test_expect_success 'show-ref sub-modes are mutually exclusive' '
-	cat >expect <<-EOF &&
-	fatal: only one of ${SQ}--exclude-existing${SQ}, ${SQ}--verify${SQ} or $=
{SQ}--exists${SQ} can be given
-	EOF
-
 	test_must_fail git show-ref --verify --exclude-existing 2>err &&
-	test_cmp expect err &&
+	grep "verify" err &&
+	grep "exclude-existing" err &&
+	grep "cannot be used together" err &&

 	test_must_fail git show-ref --verify --exists 2>err &&
-	test_cmp expect err &&
+	grep "verify" err &&
+	grep "exists" err &&
+	grep "cannot be used together" err &&

 	test_must_fail git show-ref --exclude-existing --exists 2>err &&
-	test_cmp expect err
+	grep "exclude-existing" err &&
+	grep "exists" err &&
+	grep "cannot be used together" err
 '

 test_expect_success '--exists with existing reference' '
=2D-
2.43.0
