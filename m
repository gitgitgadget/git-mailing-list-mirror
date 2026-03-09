Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0342E285072
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077275; cv=none; b=eH+bR3j4FvLuR+jw0ymSuIlKl0/p/UZiTeebbQrCN0bwPWqJmyN4a7IDSGmWl5eg7onKnECZqmDR14hy2epkgYxChhvxW81UgxqlMI4KA879Po53SowLfujJSFJHmnJQAujSyCNPz9B+zxIz3CSilJCttSIM3wHKWJAkTAUQc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077275; c=relaxed/simple;
	bh=dHgNG91rH4HCt8pGXrThUteaOfjahZ5Jmi88q8aQSWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spPzPhuNnLUCzhdaj727n3pPNoInrTM5nKdojWVqlnIJW8/Jwm+xT7acYTFol+5A4I/ZKx1AYdGXDMxtY+b3aJn6kTCjbxo1wy//WzyHLpS/Gg2c8N+p3PgkqIGxhvEs6AtnhsX0tmUPTnvhLWNmEXgwMWrD/vzennbXr4RsIiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=HGEGQJyw; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=dO6R5VwK; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="HGEGQJyw";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="dO6R5VwK"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=HGEGQJywNn5MNpincEMELiKshLQrX3b2z06nEQEG8e/THG7q/l/ifHqmgVk6cIQxozw4TDvLe4AEoh5dLD6vaYG5ibaWAlZh6uzBQ2BDpHMLeoo5Ba/bbaR6nkewKuoydM/dYgnNA+XX+JDDtGq91mtzRw/Fb9zI5TDQ7sCXuzpc8fNaBMlyrKwQIPhjGPeJJo4pg4sCJBJrEI1mw0fJY6dM7UI0DCV8BXsaz34lFJPBRxIH3u0s+/nGCwcKfa9hnnNaqbAaYX15/OMSlEoZO5BWIvmdQuvx80T79t9P8DW89d1R6OU5NOEJaRaS/O3bQCpRBJhfb7ySiqFuIYC7lg==; s=purelymail1; d=malon.dev; v=1; bh=dHgNG91rH4HCt8pGXrThUteaOfjahZ5Jmi88q8aQSWg=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=dO6R5VwKkbgoFFIx6y9f02AIpeE8xV7ch0XhBMoJj97rFXjHGtq0d0INi92M+dFfP79RoJ74zhkdF8Okct53tuGby0fvLMBlbvItXqTu37WbbDxlJ0U39t3+H55pojS5qkRMjFWjmOjYOvlThlkXM86+L5+rzyo4bwQ3GD6cMGfaHwDsmGV7RlHY+pu8VZT28NCWOcqwm0Qz4bbi2Wo5tQKjLvEeDEPyLbbqehFTtVSMwvOIFD9yE3jlR/DNysC45Enc168bbs0cPtNEA92OZN3jGUkOABNruztEuhMzpKY6Y4IeYjbepuk0gdWkkiJvpuNRtQMRAgl0cFACbWX3ew==; s=purelymail1; d=purelymail.com; v=1; bh=dHgNG91rH4HCt8pGXrThUteaOfjahZ5Jmi88q8aQSWg=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1848533520;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 09 Mar 2026 17:27:51 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v1] diff: document -U without <n> as using default context
Date: Tue, 10 Mar 2026 01:27:19 +0800
Message-ID: <20260309172719.125419-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqh5qswo45.fsf@gitster.g>
References: <xmqqh5qswo45.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The documentation for '-U<n>' implies that the numeric value '<n>' is
mandatory. However, the command line parser has historically accepted
'-U' without a number.

Strictly requiring a number for '-U' would break existing tests
(e.g., in 't4013') and likely disrupt user scripts relying on this
undocumented behavior.

Since we are retaining this fallback behavior for backward compatibility,
update the documentation to explicitly state that '<n>' can be omitted
for the short option '-U'.

Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 Documentation/diff-context-options.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/diff-context-options.adoc b/Documentation/diff-c=
ontext-options.adoc
index e161260358..655496ec3a 100644
--- a/Documentation/diff-context-options.adoc
+++ b/Documentation/diff-context-options.adoc
@@ -1,4 +1,4 @@
-`-U<n>`::
+`-U[<n>]`::
 `--unified=3D<n>`::
 =09Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
 =09or 3 if the config option is unset.
--=20
2.43.0

