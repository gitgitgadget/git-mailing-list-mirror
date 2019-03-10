Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B2F920248
	for <e@80x24.org>; Sun, 10 Mar 2019 06:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfCJGTS (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 01:19:18 -0500
Received: from mout.web.de ([212.227.15.14]:57979 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfCJGTS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 01:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1552198756;
        bh=n0P9+owwCAkd0BpgAhtKGxJoRT2mRY5skMeglCz7Ezs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=kFen7B8M4mJDYiRdOn9rJpse09xP2EXFVGlO5nbRtTmq17uJB3gnjf3J2tly0VUgD
         /fFi+6sQ3Y8Vij9ufErbpTH5BPLBlemoDra0p3ZvbaBIZcS4rgHAO0k8r6K1PTcoB0
         RRFdR2BZac/RPTXChwzAMhNyaleoN3wicTJMBxZA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([195.198.252.176]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MGifp-1hGKCD3Jvl-00Daq9; Sun, 10 Mar 2019 07:19:16 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC v1 1/1] convert.c: Escape sequences only for a tty in trace_encoding()
Date:   Sun, 10 Mar 2019 07:19:14 +0100
Message-Id: <20190310061914.24554-1-tboegi@web.de>
X-Mailer: git-send-email 2.21.0.135.g6e0cc67761
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OS7+rBFu4q0g2xmyunE5Huw9bpTaWVP9jbLlb3k2gFxD4Yv2EOk
 J9wYojBxufoMyFv3NLa36AzYGt3ILreKDM4xTL+9m4U7JVxt1eQ+GrBNR6x6YKNWXv4rqar
 xF46VQiJynYyfOaupyb+ua0B5VMpll6L6sqJOMBmH7v9mrAbDkIi+2JNGn/3nyGDvFFAcXf
 8+GpDkshqLm9uVR0TPlfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i0uLT8KLX2Q=:X3P519S9tmYhBxZmpPvL/A
 QyeJrKyKH+avaXTOecbjl4rgge4E8Xzf1ffalFDA/w4NiHeStEdgvzTjFD7O9p5p3Ct+lXFZL
 mMr++7CnQNLEEY94Udvf2kYttW5F56NhNiyDLLqpAtfZl0WAxPa97+10F1VC9VGpgg7/Acbs0
 6MpMOPErTJnBe0YKSdSM/fZvv6wSHM4Mqky1+3Im9BhyY0JUxWUdi3PBMEqh9IAW2K16dVCA1
 yHv+NvMvxl+IK6YFhD30uE+YtFUvY6wJBU55tUam1rP0NhQO9NE5HA9Gw/djzeXQkVPVbAxmS
 PdTS+rOwFIs8Kc5sZCWdhOvxSszHIu1NxB8n5wuWIl+Kl3yWZ5cXyx/suPM1P11N1k1JvydoL
 M7Pdk7zdNBYA/AegWy92KG4a1FMT4UcDA+Z98ZeUVKObvaZyh2k5v3dQyPdKazFaP88kLvIDm
 VWwpmAM3mBpCoWqQ1BLfcpiFwPF+s2AqBnGs5jLLozHpnd/pJ6bTUJoRbQoUT1YzTISMowQTy
 U4C9K3UWzpggK35TwPrsWB16q63Usck5puD3Cf7iJqQlZNDwGxHmb10ZELhrWo9weoDler38t
 52LU5dYSvXeT8n+qEGm7VJxRYdrqzluNbBjsZUSiSMdh6Ee+SuZSBzDQ0GRFtpROgJgYa6GMS
 u2hOihMf3dcKd2R07MaZ5Ukc0RteafXjTKYrYGEwbVw7y0S/W+ajY59mpVcuDhxzhnVwMaVTF
 t7F5NRd9cC6nnG+ecv7ZEYRFuFLpv+LCYhRLG9ZS4a3tCNGPB4vbt0TRCTLFJCKJfBPyDJqHn
 Yqg4KE3NeLYAR9FTPhYkMDhwUIBMv4cLAwKf7PwgYtcS5GC8EoPJgO33Zo/hQUUr/2P4JfGx7
 woXsORmA0kxv0nyekJLyFiXTKxNktvgNqb0coab/bVIy9+15OLXiFHqzCt/VK5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

The content of a buffer can be dumped using trace_encoding()
before and after the encoding is converted.
The current function trace_encoding() in convert.c tries to
make the output easier to read:
The byte position and the character itself are dimmed, allowing
the eye to focus on the hex values in the byte stream.

ANSI escape sequences are used to "dim" the display temporally,
and to restore the normal brightness.

When stdout is re-directed into a file, those sequences are not
working as expected (but shown in the editor) which is disturbing.
rather then helpful.

Disable them, if stdout is not a tty.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 I am temped to remove the "dim" functionality all together,
 or to remove the printout of the values which are now dimmed,
 what do others think ?

convert.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/convert.c b/convert.c
index 5d0307fc10..70e58f1413 100644
=2D-- a/convert.c
+++ b/convert.c
@@ -42,6 +42,9 @@ struct text_stat {
 	unsigned printable, nonprintable;
 };

+static const char *terminal_half_bright;
+static const char *terminal_reset_normal;
+
 static void gather_stats(const char *buf, unsigned long size, struct text=
_stat *stats)
 {
 	unsigned long i;
@@ -330,14 +333,23 @@ static void trace_encoding(const char *context, cons=
t char *path,
 	static struct trace_key coe =3D TRACE_KEY_INIT(WORKING_TREE_ENCODING);
 	struct strbuf trace =3D STRBUF_INIT;
 	int i;
-
+	if (!terminal_half_bright || !terminal_reset_normal) {
+		if (isatty(1)) {
+			terminal_half_bright  =3D "\033[2m";
+			terminal_reset_normal =3D "\033[0m";
+		} else {
+			terminal_half_bright =3D "";
+			terminal_reset_normal =3D "";
+		}
+	}
 	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding=
);
 	for (i =3D 0; i < len && buf; ++i) {
+		char c =3D buf[i] > 32 && buf[i] < 127 ? buf[i] : ' ';
 		strbuf_addf(
-			&trace, "| \033[2m%2i:\033[0m %2x \033[2m%c\033[0m%c",
-			i,
+			&trace, "| %s%2i:%s %2x %s%c%s%c",
+			terminal_half_bright, i, terminal_reset_normal,
 			(unsigned char) buf[i],
-			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
+			terminal_half_bright, c, terminal_reset_normal,
 			((i+1) % 8 && (i+1) < len ? ' ' : '\n')
 		);
 	}
=2D-
2.21.0.135.g6e0cc67761

