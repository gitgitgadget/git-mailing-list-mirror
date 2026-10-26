Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042730;
	b=4xJFX4yjya+FakN+Shie2Wiyl1YFq2tXrbXvEUoFAx3QHfTOPxrsLATEWxoL8kKcj9xQ
	 bG1CnSluZqmbWfrC6mw8qN0E/bBKUHwgxdCG1BCxANjCL5HDa+wpkKC4LJUQcOUuLwsHu
	 FV/hj5NBJOwhcwl5pEZiEzx6IOoFMfGWai0GxmTNI6VZfwa4wVZL8NvTvsoJBss1Td3KB
	 RR7hcO24f1mwPCdV+pdfLPIvVV/3mlhBY7l3GQIvEWYqyDDBOT+BIDQxpbEXKjptuHjQW
	 2tbT2P6+G6OooXYNTFvXQiumd2TTLMKpYoUHhfaRaZ8D6HxY5OHYlOfbsWmOHFP0EZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042730;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=gCsPzRr+NYzuTQjaLb5fn4jbTvJTtRwp2OcFK7Je/0w=;
	b=pmtNIREl9QBl97kLr4Q0U6BWSr53zqk726MRJZLI0+d93+GhqZM+0z3uPC9nk45Z/at9
	 PqJMLiS+jofUBGz9NjbQODRnlHs0BFtcapMwC7FjZjNS/XkPi/XIb7EKyiDHiziWsdKVL
	 OOC3VfVdw49JQAM/ni+3d4YkFqfQMAMTmgpsTKhLjg1HsNkjz2QgfpUsQDDUD1Ji7XRQJ
	 oioeVYnGrnkGhDioQrTW+iS7/drDpkqZDrowqae5SLZo0KroPrQFefgpwoqlpTr+JShD9
	 wCjPRkGek09L4WdcOf4Lx/jEHkQjonstp8pDU2wgzaAHM9zFcFqWYLUQdHZzhPwXfrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b="Cp4/M6/N";
	arc=none smtp.remote-ip=212.227.17.11
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640E4606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 19:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 640E4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Cp4/M6/N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793042720; x=1793647520; i=tboegi@web.de;
	bh=gCsPzRr+NYzuTQjaLb5fn4jbTvJTtRwp2OcFK7Je/0w=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Cp4/M6/NDfakp7Q3UBppLStKX3NUff3QokPN0gLzi8eOLyOLsopPrwjPgMmsxO7e
	 CAoqRACFvzi2iLZhgbRHAde1zUZqkXuHZOUEsTNVc6CVUU4DGdReKwnOD3C3kH1Hx
	 jzkK7iNODiTUTZeo9u9Lm3jsutxH/86yZj/nwO8D3E858ion75p8/LpnD8+ivCzUU
	 tBIvbaTq1RkNi97HOjcUxOFZLRqkAeo7BV3N99lWzMY4vqYm9ItBLSScBMdDHtlRF
	 THZMW2gvraOWeYo6Vo0Kc6XskgXRS+y6a/k4AXjA1PDKb4XAkBJ1j9AVynYZV4fK9
	 494qXD+xHV+zhMEotA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mft7j-1wfDon1zuT-00gDcq; Mon, 26
 Oct 2026 20:25:20 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	curtis.allen.smith@gmail.com
Subject: [PATCH/RFC 1/1] read-cache: optimize  file size change when conversion is active
Date: Mon, 26 Oct 2026 20:25:19 +0100
Message-ID: <20261026192519.15860-1-tboegi@web.de>
X-Mailer: git-send-email 2.53.0.154.g7c02d39fc2
In-Reply-To: <xmqqwm1no29m.fsf@gitster.g>
References: <xmqqwm1no29m.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cG3/xvP3e+GCHzQ858kWLYTDkI9HnMJao1fDVB908RsuYqFpwuq
 gXGWCayhQ1eL4EbBP4QVTWXkqdGTJrUpgqTEylTezFgoh0yy330g7/XD68bpU9NhzjSU3zS
 EbcCX1JFm96g6jbs7it+oM38jeviEv3hVl9P7eW5saPA1GANrBxJ5eVKzwrzecZvcSnC4dW
 7GdBbsPGplUIdX2kYhygg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YkIJ84TzScs=;MuwCiF1yBeIB9lhKuZeB8OICjXz
 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

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Commit
"read-cache: do not trust a size change when conversion is active"

corrected the case when the file size in the worktree has changed.
Input filters may convert worktree files with different sizes into the
same blob.

Optimize the new code:
The call to would_convert_to_git() can be skipped since the same check
is done in ce_compare_data()  for regular files, which is called from
ce_modified_check_fs().

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 read-cache.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 70f4787de9..3497997bda 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -9,7 +9,6 @@
=20
 #include "git-compat-util.h"
 #include "config.h"
-#include "convert.h"
 #include "date.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -456,13 +455,12 @@ int ie_modified(struct index_state *istate,
 		return changed;
=20
 	/*
-	 * Immediately after read-tree or update-index --cacheinfo,
-	 * the length field is zero, as we have never even read the
-	 * lstat(2) information once, and we cannot trust DATA_CHANGED
-	 * returned by ie_match_stat() which in turn was returned by
-	 * ce_match_stat_basic() to signal that the filesize of the
-	 * blob changed.  We have to actually go to the filesystem to
-	 * see if the contents match, and if so, should answer "unchanged".
+	 * When the length field of a regular file is zero or changed,
+	 * this does not necessarily mean a changed blob in the index.
+	 * All input filters (CRLF line endings, clean filter..)
+	 * need to be applied followed by a hash and oideq().
+	 * This is done in ce_modified_check_fs() below,
+	 * which calls ce_compare_data().
 	 *
 	 * The logic does not apply to gitlinks, as ce_match_stat_basic()
 	 * already has checked the actual HEAD from the filesystem in the
@@ -479,10 +477,9 @@ int ie_modified(struct index_state *istate,
 	     * So let's just special-case symlinks with a target path length
 	     * (i.e. `sd_size`) of 4096 and force them to be re-checked.
 	     */
-	    (!S_ISLNK(st->st_mode) || ce->ce_stat_data.sd_size !=3D MAX_PATH) &&
+	    (ce->ce_stat_data.sd_size !=3D MAX_PATH) &&
 #endif
-	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size !=3D 0) &&
-	    !(S_ISREG(st->st_mode) && would_convert_to_git(istate, ce->name)))
+	    (S_ISGITLINK(ce->ce_mode)))
 		return changed;
=20
 	changed_fs =3D ce_modified_check_fs(istate, ce, st);
=2D-=20
2.53.0.154.g7c02d39fc2

