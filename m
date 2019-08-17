Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BCE61F461
	for <e@80x24.org>; Sat, 17 Aug 2019 16:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfHQQYA (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 12:24:00 -0400
Received: from mout.web.de ([212.227.15.3]:44347 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbfHQQYA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 12:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566059033;
        bh=waSB8/aHqHMsVjuJRT8m8AWj4bRHv7rgrqOmJvDZ6d8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=ly40i7gHtE6UOmomzr2kw1WP3zY2SSEwL6BcvrBUlRaUT1eXGasWTLCmy9L0ffRU3
         jAXK6KcqY+WhwDeBLfzBfh7YcoRt8C+lhC/gyxeaVUklO4kTiZ6K63K790fW0rh1xb
         5BN+UUlSfjpg00b5jpLpSOO2+sdwv1eexR9h/2jk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LyOuM-1iMrbr2xjq-015oZu; Sat, 17
 Aug 2019 18:23:53 +0200
Subject: [PATCH 1/4] archive-tar: report wrong pax extended header length
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <c77a0081-93ab-7b97-e322-9616f6e7f86c@web.de>
Message-ID: <c9915187-cb18-2619-f50b-12fe93c2578c@web.de>
Date:   Sat, 17 Aug 2019 18:23:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c77a0081-93ab-7b97-e322-9616f6e7f86c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4kX3AVhKbDdZQcqI4KUNFl7L2XtMODV45joMupGeOfN73zocpw4
 Al4IZbm0ZqYqrUyWsFtb8vGEVmP13lTMT+jnLWyBwOM4lrPdE4tNrWkg27FvHec/JnTB4vv
 xbPIFZf+VfspPYscBewuTuYcd2KHN3CBGRNPbL/eASoRwNJp70rf5R0TOwtuE9IsCagf7Yk
 +9eBLPMwmeEEM0ZRkhLYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ti4zYi/3jP4=:rbgGCvAhh19WxF9+kNp/ZH
 0FGV9/mxOsFPoV/u8t8lpOmeqJ7IB26ew/HGIierqtQ+ADjL8foLG5IHWBoLGMTmebwswfY+E
 1ipO7KUd1ACWn2rSE0Z2VCDvVhAwqFw6RVAUQKxpI8jvviet54snKc884+fi92NMHtSuC+byt
 CHoQjYcMfyOKss7XohDm1tA1/r3vs2bGMc9zNvONaav7jtMLWvxewRBGW9TXJPeXuQ2m/KDTm
 mOMRM2KoMf+JCQJk9E+bUMi2+/hixkhfsnZD/0CiBAbrY7SzbltfIjTKV7AMPeKT3dTw5cftx
 Uwq6FjbJTxKYRWZbhWpspXGLPKQ2cLdp+ADkIIBpnkUQ/TzeDSlod4SkDvi6qP+Ovqf7eva1K
 VMj6oJEwpKSNzN60KThEBy9RKNsDAblqPuf6j6eHzw2qPDKP+S2+gT/+MzXkUHocOkF5O7Bo6
 4hMARgOJFhBaVb6sQJTqnmXmy6HZ+C6dzaxW46S0433oQ8a/1BrY/R8dS6Uw4S0/HQrNa9TFm
 zbCMek95PBxyHNCQPmQV2vsn0oc25RWnboFwyn+TogSsXjAIok0lx/1RfwjQdlRzClGBM1hE/
 nUfUNCYp3MeC1zXftANz0flWiT5cS9th4reqTc3UaB+k0YzQhSrX9hnrsOwI6p1MuewMEo1UD
 xrjnp9EQklOYMHEMdQ7kKFDENVyS5kFdCsgzqmHa7vKkKJeGqdq2ozjyDqWntjX2p9Sw0ljUH
 oamtUsVkxbK+vWdPu5HJR+7B7PNpNDAVBNzrLxtjZ8mNRuyCOR99pVabceWtC/OxHgE1Y9wXx
 X0ni3ii0LLAm1XX7fDqYexSqBe9tHNvYVO0NB5e8n9FDiGtizr2fEKJVE+Ok7CpL2koBE93Do
 qKNm4rmMdzxbQ/cb5T1hnxrLmJmqfxJ2GhJ/g9UYEHE0DXNyoPVn/VfQUs0y8DpGDzut4OfUl
 miT5A5GydnlJuUNdACBdkwdkVHyI462X6yC0JVyMeDWTpX6lLZ5mDaIYxpAY2oh0VMxVfw7T/
 XyQ4rKZ2edxnNkErigj1hTU8qswDUHxWbwdJBvnJllPR27Opucgyn9W+fs2ETBECiisi8Z2CE
 svVptN/4yLvhHUIQU/31R3gooBMzKqkqliUfj+2wG+t4KdYYdwk4kFGeNW1HAhADHIXFh3QTm
 /Xx+ru+L05S3TGSVUo96BPVlfHhxJ6rSC7nJYT6i+BxBr8Zw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extended header entries contain a length value that is a bit tricky to
calculate because it includes its own length (number of decimal digits)
as well.  We get it wrong in corner cases.  Add a check, report wrong
results as a warning and add a test for exercising it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive-tar.c                   |  6 ++++++
 t/t5004-archive-corner-cases.sh | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/archive-tar.c b/archive-tar.c
index 3e53aac1e6..355c8142c6 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -144,6 +144,7 @@ static int stream_blocked(const struct object_id *oid)
 static void strbuf_append_ext_header(struct strbuf *sb, const char *keywo=
rd,
 				     const char *value, unsigned int valuelen)
 {
+	size_t orig_len =3D sb->len;
 	int len, tmp;

 	/* "%u %s=3D%s\n" */
@@ -155,6 +156,11 @@ static void strbuf_append_ext_header(struct strbuf *s=
b, const char *keyword,
 	strbuf_addf(sb, "%u %s=3D", len, keyword);
 	strbuf_add(sb, value, valuelen);
 	strbuf_addch(sb, '\n');
+
+	if (len !=3D sb->len - orig_len)
+		warning("pax extended header length miscalculated as %d"
+			", should be %"PRIuMAX,
+			len, (uintmax_t)(sb->len - orig_len));
 }

 /*
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-case=
s.sh
index 271eb5a1fd..2f15d1899d 100755
=2D-- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -204,4 +204,24 @@ test_expect_success EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZ=
IP_ZIP64_SUPPORT,ZIPINFO \
 	grep $size big.lst
 '

+build_tree() {
+	perl -e '
+		my $hash =3D $ARGV[0];
+		foreach my $order (2..6) {
+			$first =3D 10 ** $order;
+			foreach my $i (-13..-9) {
+				my $name =3D "a" x ($first + $i);
+				print "100644 blob $hash\t$name\n"
+			}
+		}
+	' "$1"
+}
+
+test_expect_failure 'tar archive with long paths' '
+	blob=3D$(echo foo | git hash-object -w --stdin) &&
+	tree=3D$(build_tree $blob | git mktree) &&
+	git archive -o long_paths.tar $tree 2>stderr &&
+	test_must_be_empty stderr
+'
+
 test_done
=2D-
2.23.0
