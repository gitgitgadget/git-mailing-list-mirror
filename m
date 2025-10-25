Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1449E218EB1
	for <git@vger.kernel.org>; Sat, 25 Oct 2025 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761371214; cv=none; b=RbGoOZzqadGw59oXmOULIgL0bjtEtZ3NEu+bMPbTXm2Nvj0mx9oFcp43rc5TqwG+1pTGQcxTqaWa/Jupa9m1A9dWOJHcIC8OGTbC2xkKTHRWga5VpVuBTPPPfCLcl+8CbuNugrqOZ7t7KqaAaXX/CUhkZ1U3TCLJ86nkgUVHof0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761371214; c=relaxed/simple;
	bh=hcyQM58RPHDfT1rE/X7X91Bi3femkFLQll8dQnc38S0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=hIEJS911+Ts1a8o1bGu5p+otKDR+3O9pBy1vtjwHh+11+YOY3jEqLMThFLDYkwEYue721kw+GOt6oERV7Bz6pQ4byUjQv2EIG8JzWu5MRW4rFkj6d+oBRbN21shsRZ6p0Y/3yj3E7+5C4sHRPQo/RH25nPGbdgk3Bj8kSEQDo+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=f3sixkOY; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="f3sixkOY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761371202; x=1761976002; i=l.s.r@web.de;
	bh=ob75t/HRsYWrf7+wJzBwGe21rRO93KtspcErBYvQYC8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f3sixkOY9HC/RFtzC80pq4hiIt/oZ+PE/LpRM5EFDA9OspJidKXXE3B9aXvPGvWT
	 iQ+eDb319jdyssacs7vqErbXTZN4/aFpvUgzEYA54T7odi50Og8aQyTWXXLrhwx47
	 VS3NjBcCyMCVWMUo/6k1CheOF8ZUENNSRrT+VhHdD9BE+tu8dUlJxr5Q6wXj7jNQX
	 jgY5CMr4LUGLXZXaumxo8sYUS/60N4cuCq9qURfF/nVcMruQd9nI/jaIBDdgrLgBS
	 NItPKt0hCGTZelBwG+A+27iWLMp+4QXXu1YUln9JoXpL2XLLw5AFlwbzcdlktIFDy
	 3EYVtGbBjZ2qomYzMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.30.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MElVH-1uxxCT2aBH-003Jcd for
 <git@vger.kernel.org>; Sat, 25 Oct 2025 07:46:42 +0200
Message-ID: <0985f775-fb01-4de0-99a8-4775b602829a@web.de>
Date: Sat, 25 Oct 2025 07:46:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] add-patch: quit without skipping undecided hunks
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9PZqoV2QKprQSb2lgOHO5tRdz4u5eMHYpBTBJawkvSFwtxsJYS7
 rVcoz9yVWB6fA3zxxNW6YaZXGNxd/tTQRPVSYinklE/gl7wnyiZpggcGF/iI+zPkMDJgzhg
 SFvBgafF1QHdNdO+UceXRSYNmojEZ4d5lQ2VX+ai54/Ym6I/DaqTj46TEcmcyOlM9S2fRDz
 QeTvAo92+rNlZ5xJZL7AA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:reBwpHWB75w=;qeqUIc9t7xw3e9kLjel3YDv8zJd
 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

Option q implies d, i.e., it marks any undecided hunks towards the
bottom of the hunk array as skipped.  This is unnecessary; later code
treats undecided and skipped hunks the same: The only functions that
use UNDECIDED_HUNK and SKIP_HUNK are patch_update_file() itself (but
not after its big for loop) and its helpers get_first_undecided() and
display_hunks().

Streamline the handling of option q by quitting immediately.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 add-patch.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index ae9a20d8f2..a70def1f81 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1601,7 +1601,7 @@ static int patch_update_file(struct add_p_state *s,
 			} else if (hunk->use =3D=3D UNDECIDED_HUNK) {
 				hunk->use =3D USE_HUNK;
 			}
-		} else if (ch =3D=3D 'd' || ch =3D=3D 'q') {
+		} else if (ch =3D=3D 'd') {
 			if (file_diff->hunk_nr) {
 				for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
 					hunk =3D file_diff->hunk + hunk_index;
@@ -1613,10 +1613,9 @@ static int patch_update_file(struct add_p_state *s,
 			} else if (hunk->use =3D=3D UNDECIDED_HUNK) {
 				hunk->use =3D SKIP_HUNK;
 			}
-			if (ch =3D=3D 'q') {
-				quit =3D 1;
-				break;
-			}
+		} else if (ch =3D=3D 'q') {
+			quit =3D 1;
+			break;
 		} else if (s->answer.buf[0] =3D=3D 'K') {
 			if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
 				hunk_index =3D dec_mod(hunk_index,
=2D-=20
2.51.1
