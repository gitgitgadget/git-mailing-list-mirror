Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9931F461
	for <e@80x24.org>; Tue, 23 Jul 2019 20:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfGWUIv (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 16:08:51 -0400
Received: from mout.web.de ([212.227.17.11]:51905 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfGWUIv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 16:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563912519;
        bh=nqgPickk0lqWmBeA4juZzGUJ4NniaMmh5sYhtfbmw/k=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=lk2LjbVWNO+YvVyPelGRrySS+uavD+xMpE3QO8Y6wcwCBUYn1j90sgIeEn+361+bc
         IWC0b8fMDLveEeNQh/l3arnbuMlpEWrUM6Y54ZjdTzyyc4tlEoEGrSdhoIRrYGMq6j
         7Buv2JEHC6MZcCW8jDMmGdGDFXXnzZD7MVrZU3mg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LyUgM-1iS1Sb1psU-015pD5; Tue, 23
 Jul 2019 22:08:39 +0200
Subject: Re: [PATCH] archive: Store checksum correctly
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Matt Turner <mattst88@gmail.com>,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190723025736.23036-1-mattst88@gmail.com>
 <xmqqd0i0u253.fsf@gitster-ct.c.googlers.com>
 <14410e00-4701-40d0-6960-e481fea50ed0@web.de>
Message-ID: <9a0c89e4-b216-86f1-c721-c54fb2ee0a10@web.de>
Date:   Tue, 23 Jul 2019 22:08:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <14410e00-4701-40d0-6960-e481fea50ed0@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b/p6/S18PjtvAZPVjP5KGtBhhxl6VKWRYSwXg4DyCGeBITfIuee
 v1VN6XeeWl1fht4rojrP0EySLTXr793k6vORPotYan5/3xuNla1UujxxgECwj8qMScNPHc9
 ZisSh2Jy1EkicWwvB/AHW+EYiy0f5pghwWmB7Yu5VugD0W1m6Ciw1pMjQObxqFGsdf5iklE
 nyg5r0tdXmKk42/yUdxCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dwIUaURHdVQ=:9NCMuTuNqfS7JgUzesa9+8
 xMW0F242uEkhcjG6PhrslBkDtubqHS9APAzuz39Ih/u75/GDG+6lGV7T/6J0ORUhJnsOEii2Q
 RDMCdvoIpe/FtXe2ydG9ngYGjFnetb/gEsCq1KbLR2jh/jGZZZl7IC0TuumOzzNvnWNsfGvF7
 ypnokk9AErnhJE6826y3uwLYqF4/CNeBVNKkAa4H1kZWlTIWM+Z0OhN6i3HuHEZBm49vttBWm
 V6B4uQYAmGAUKIZO5Qv2SsU2oGs6U+cP6ZQDlYhIx6XsaM8FQIsuyQNgxaATgBUBwngFaeye1
 GoLmqegNQey11nlL0SP7Z+LWRgBGGIAIL6/c6ysj74zhFW403JpHNy+1mKJhFO25qR8lFKkdL
 4XKeroviD3YJUlE/+1vqzORcrYWTbycP3DetS2s+9nJNzR3JcgRPbfIdT9RmQaue0j+049KQC
 o8XWBpTKVuGPzFkvWhkvrNByT0WvBFU9wjioLixBw/Vo2j6i6/2LZrxO+Hodw9FyvEjl8CFVx
 LCW4uuGahfYdtQSKJpfKN85Xs6Fv4scVeqg+8kSf4uUdzpjWLZDsqiqA4cCJ3r1ZBZS6M6qHO
 beOt0UISWvh9QPsoz2imfuVjOiwrSV88+nx15wIPPjMoEJ2nKKCyxJot7IbRR31tFcwG+hTML
 GOxG3BKZhQmHv2EMbZBQSF4UUt/Xz+LCRFb0uooNptRd0EJAUJ4xXXTP45R4+xBddohLmVlQ4
 KrWrxea6fic3j+wj99oeAJSOm+iTIf5A2p/6pEOghBIwzKrPtJv8PkwTAvHfRSkH3qPzCoeP9
 jj7OxZ/iy4qQPQqUAjDdQH/8Eo93mnwRy0Zzn6bnRax++6q+yBMi2J8tb20jq0BpRzsh0PKSM
 E7gdiKDXkRWlLoWHVzekM3ZJH6MS1OVe5QLCovF6QgkMnoV/+HivTrb5G49iSglq4StNK+Kkv
 rYw3de+HzbiQfRFJlCnCpGaHISyB+otLrxhyJzlMDvK4nDS2umPyQdP+KJh2vO5IYbAGC4HHr
 SPRUM/DX2S2RIZPkjfWdgGMDhXw3+2pnzpqeD7JqHltgR5MNiJBBWEt1lvYPwnBoMl0yJV1g8
 yvPFQ7ftpVT6uE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.07.19 um 21:38 schrieb Ren=C3=A9 Scharfe:
> is_checksum_valid() in
> https://github.com/AgentD/squashfs-tools-ng/blob/master/lib/tar/checksum=
.c
> compares the formatted checksum byte-by-byte.  That seems
> unnecessarily strict.  Parsing and comparing the numerical value
> of the checksum would be more forgiving, better adhere to POSIX and
> might be a tiny bit quicker.

I mean something like the patch below.  Code and text size are bigger,
but it's more lenient and writes less.  Untested.

(Side note: I'm a bit surprised that GCC 8.3 adds the eight spaces one
 by one in the middle loop with -O2..)

=2D--
 lib/tar/checksum.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/lib/tar/checksum.c b/lib/tar/checksum.c
index a2a101a..af94ab4 100644
=2D-- a/lib/tar/checksum.c
+++ b/lib/tar/checksum.c
@@ -1,15 +1,27 @@
 /* SPDX-License-Identifier: GPL-3.0-or-later */
 #include "internal.h"

-void update_checksum(tar_header_t *hdr)
+static unsigned int get_checksum(const tar_header_t *hdr)
 {
+	const unsigned char *header_start =3D (const unsigned char *)hdr;
+	const unsigned char *chksum_start =3D (const unsigned char *)hdr->chksum=
;
+	const unsigned char *header_end =3D header_start + sizeof(*hdr);
+	const unsigned char *chksum_end =3D chksum_start + sizeof(hdr->chksum);
+	const unsigned char *p;
 	unsigned int chksum =3D 0;
-	size_t i;

-	memset(hdr->chksum, ' ', sizeof(hdr->chksum));
+	for (p =3D header_start; p < chksum_start; p++)
+		chksum +=3D *p;
+	for (; p < chksum_end; p++)
+		chksum +=3D ' ';
+	for (; p < header_end; p++)
+		chksum +=3D *p;
+	return chksum;
+}

-	for (i =3D 0; i < sizeof(*hdr); ++i)
-		chksum +=3D ((unsigned char *)hdr)[i];
+void update_checksum(tar_header_t *hdr)
+{
+	unsigned int chksum =3D get_checksum(hdr);

 	sprintf(hdr->chksum, "%06o", chksum);
 	hdr->chksum[6] =3D '\0';
@@ -18,9 +30,10 @@ void update_checksum(tar_header_t *hdr)

 bool is_checksum_valid(const tar_header_t *hdr)
 {
-	tar_header_t copy;
+	unsigned int calculated_chksum =3D get_checksum(hdr);
+	uint64_t read_chksum;

-	memcpy(&copy, hdr, sizeof(*hdr));
-	update_checksum(&copy);
-	return memcmp(hdr, &copy, sizeof(*hdr)) =3D=3D 0;
+	if (read_octal(hdr->chksum, sizeof(hdr->chksum), &read_chksum))
+		return 0;
+	return read_chksum =3D=3D calculated_chksum;
 }
=2D-
2.22.0
