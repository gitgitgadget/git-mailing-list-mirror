Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3923D7E7
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771100; cv=none; b=EoSDCZrUYomtQ7wMK+m7zYCqt6INqxMmfD3NrXezAil2d7Pfd2FTfwJ3Sc6S4vwCx4Rip3AoKhKZdX3IvzBEpgfVydxS/8mbN/yaJNqnNFd1PUjeTcXga/Jin2rvd4c0fWaMCK99ON5YWlJ9v/SPjQix1GgVMPV4oKJVhvXuRtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771100; c=relaxed/simple;
	bh=GPj1cFDpH4fCNIZhgCN0O0LKqbaIys0xH02fLdZ8Q6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=S5YtkihGCsXzyNUkXV0ZkolXDgvZOGKgbC95npK/8aL06R9x4IjPfTCNQjYQiawVScUKA/0lNtRVwmZnaPhoQiza0KWqyzfEwhTpYwqNoxzRHwH9Zlgc7s91q4UnebIDnF0F+fFPkm+s4C5d09uxeyjIP9kAy6+aSk1RP4tFZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=pt5StV5Z; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="pt5StV5Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759771091; x=1760375891; i=l.s.r@web.de;
	bh=B+dDMhPBNMLIkHuejrNgwxlh80h1rpzvbuxt8fMchVY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pt5StV5ZaKwUwJtA3F7UxvqYgr9pKg1TE7cXWLKPp+fo1LiqUqAtmwpU+Fspq/s1
	 pC9U3fBFqiyzqqKA4e0MpXnlZb7ArtuxiGcWsF5Og3+1OrEsjKTeuT0+v5DzY4aaV
	 Os7HXHazpmTXqQ1EaAwBiy8AhoMiQ5cNGIezvr77OXrkeP3EhPLMD7IwCR3Ag5vVZ
	 Lgnd2IqKpH/T0mHYKbiWwquVfJ6JJHzEY1Y4y81RhtUsZ6oNkltOZsbdGL9BFT3+p
	 fZ4rkuWMDNSaXN0W8kLkLChtSCxUbs2B1s+o0cm7pfCMhCF5Cv8/fPVKm/OKrKL7e
	 FHe/t3CHulfDpAZBVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVJRl-1ufb8O1NbT-00Ndft; Mon, 06
 Oct 2025 19:18:11 +0200
Message-ID: <fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de>
Date: Mon, 6 Oct 2025 19:18:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 0/6] add-patch: roll over to next undecided hunk
To: "git@vger.kernel.org" <git@vger.kernel.org>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
Content-Language: en-US
Cc: "Windl, Ulrich" <u.windl@ukr.de>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d4ALqSgQk8l9XDRqDtCEut3mI+OiK66vR6UegG2l07/fhpqdd3F
 +qxNjRe//rvjd2yiEHSz/q4zOiXwfqIWOQke8lxFRUhkBI14euaAz1haXEROO5vDvn2Sh6i
 4bTAogK+zG219wEZrD5suglJceqW0XSSFrRxUY20FdvvCySvpfCvhT0VXBSHQU14XPv3Zdy
 WOarbMApOxDo9QXLMa3ZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1d5yxLmC49w=;S+XM2Vpe+If+UF+r6qbDoTJU+48
 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

Changes since v1:
- added patch 5 for a and d
- made error messages direction-neutral
- removed stray "only" from commit message of patch 2

  add-patch: improve help for options j, J, k, and K
  add-patch: document that option J rolls over
  add-patch: let options y, n, j, and e roll over to next undecided
  add-patch: let options k and K roll over like j and J
  add-patch: let options a and d roll over like y and n
  add-patch: reset "permitted" at loop start

 Documentation/git-add.adoc |  8 ++--
 add-patch.c                | 75 ++++++++++++++++++++++++++-----------
 t/t3701-add-interactive.sh | 76 ++++++++++++++++++++++++++++++--------
 3 files changed, 118 insertions(+), 41 deletions(-)

Interdiff against v2:
diff --git a/add-patch.c b/add-patch.c
index 7b489d0a75..45839ceac5 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1418,6 +1418,17 @@ static size_t inc_mod(size_t a, size_t m)
 	return a < m - 1 ? a + 1 : 0;
 }
=20
+static bool get_first_undecided(const struct file_diff *file_diff, size_t=
 *idx)
+{
+	for (size_t i =3D 0; i < file_diff->hunk_nr; i++) {
+		if (file_diff->hunk[i].use =3D=3D UNDECIDED_HUNK) {
+			*idx =3D i;
+			return true;
+		}
+	}
+	return false;
+}
+
 static int patch_update_file(struct add_p_state *s,
 			     struct file_diff *file_diff)
 {
@@ -1573,6 +1584,8 @@ static int patch_update_file(struct add_p_state *s,
 					if (hunk->use =3D=3D UNDECIDED_HUNK)
 						hunk->use =3D USE_HUNK;
 				}
+				if (!get_first_undecided(file_diff, &hunk_index))
+					hunk_index =3D 0;
 			} else if (hunk->use =3D=3D UNDECIDED_HUNK) {
 				hunk->use =3D USE_HUNK;
 			}
@@ -1583,6 +1596,8 @@ static int patch_update_file(struct add_p_state *s,
 					if (hunk->use =3D=3D UNDECIDED_HUNK)
 						hunk->use =3D SKIP_HUNK;
 				}
+				if (!get_first_undecided(file_diff, &hunk_index))
+					hunk_index =3D 0;
 			} else if (hunk->use =3D=3D UNDECIDED_HUNK) {
 				hunk->use =3D SKIP_HUNK;
 			}
@@ -1595,22 +1610,22 @@ static int patch_update_file(struct add_p_state *s=
,
 				hunk_index =3D dec_mod(hunk_index,
 						     file_diff->hunk_nr);
 			else
-				err(s, _("No previous hunk"));
+				err(s, _("No other hunk"));
 		} else if (s->answer.buf[0] =3D=3D 'J') {
 			if (permitted & ALLOW_GOTO_NEXT_HUNK)
 				hunk_index++;
 			else
-				err(s, _("No next hunk"));
+				err(s, _("No other hunk"));
 		} else if (s->answer.buf[0] =3D=3D 'k') {
 			if (permitted & ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK)
 				hunk_index =3D undecided_previous;
 			else
-				err(s, _("No previous hunk"));
+				err(s, _("No other undecided hunk"));
 		} else if (s->answer.buf[0] =3D=3D 'j') {
 			if (permitted & ALLOW_GOTO_NEXT_UNDECIDED_HUNK)
 				hunk_index =3D undecided_next;
 			else
-				err(s, _("No next hunk"));
+				err(s, _("No other undecided hunk"));
 		} else if (s->answer.buf[0] =3D=3D 'g') {
 			char *pend;
 			unsigned long response;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 8c24a76e59..403aaee356 100755
=2D-- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1364,24 +1364,24 @@ test_expect_success 'options J, K roll over' '
 	test_cmp expect actual
 '
=20
-test_expect_success 'options y, n, j, k, e roll over to next undecided (1=
)' '
+test_expect_success 'options y, n, a, d, j, k, e roll over to next undeci=
ded (1)' '
 	test_write_lines a b c d e f g h i j k l m n o p q >file &&
 	git add file &&
 	test_write_lines X b c d e f g h X j k l m n o p X >file &&
 	test_set_editor : &&
-	test_write_lines g3 y g3 n g3 j g3 e k q | git add -p >out &&
-	test_write_lines 1  3 1  3 1  3 1  3 1 2 >expect &&
+	test_write_lines g3 y g3 n g3 a g3 d g3 j g3 e k q | git add -p >out &&
+	test_write_lines 1  3 1  3 1  3 1  3 1  3 1  3 1 2 >expect &&
 	sed -n -e "s-/.*--" -e "s/^(//p" <out >actual &&
 	test_cmp expect actual
 '
=20
-test_expect_success 'options y, n, j, k, e roll over to next undecided (2=
)' '
+test_expect_success 'options y, n, a, d, j, k, e roll over to next undeci=
ded (2)' '
 	test_write_lines a b c d e f g h i j k l m n o p q >file &&
 	git add file &&
 	test_write_lines X b c d e f g h X j k l m n o p X >file &&
 	test_set_editor : &&
-	test_write_lines y g3 y g3 n g3 j g3 e g1 k q | git add -p >out &&
-	test_write_lines 1 2  3 2  3 2  3 2  3 2  1 2 >expect &&
+	test_write_lines y g3 y g3 n g3 a g3 d g3 j g3 e g1 k q | git add -p >ou=
t &&
+	test_write_lines 1 2  3 2  3 2  3 2  3 2  3 2  3 2  1 2 >expect &&
 	sed -n -e "s-/.*--" -e "s/^(//p" <out >actual &&
 	test_cmp expect actual
 '
=2D-=20
2.51.0
