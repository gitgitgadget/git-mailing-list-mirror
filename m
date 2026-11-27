Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795808574;
	b=h5b7+W0Z52zHVSvqbjookSkPQBtgXwyAXgPUbrjU1N/xEsvC5mHkwzbYKfxKnHGdbrfP
	 FYG5no895S1+oJvpZNRZMnkekhKKlsJkz0znHyyGBmpbmooAc1gOhZ9t6vHW1Wz4MPZJA
	 hcH3+A+aJokwLFYqGyH9hf5TjgQBc0fJAx13YV7Qwd65ZikQqAobvtoIGah7XT7O7HBau
	 Jn9pnT8UKgqgrG5YUJoTQSWEe9s1Hm+j+aJzzRLoyKbmFvJqQRFb47xxzdLC+81Fu7yew
	 ZOeQx/qRUN/eINkA/dkVgpUH68Dp2SlcZp2RLD+HcEl7HJdVJF3za5oacKZFxJ17Zrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795808574;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=F6+8MGXDc9VxQCux3mDREgPL2BRjixPPxZa3VzLWThQ=;
	b=18b5Nr7XlW5Do6JHG4vXdeMiQN7MdzO9vjIA06OGdOFU985Dv11/fZo7DpGMZMPfinvc
	 D+iH6F4wt09SRySOmmHJZLjF2Lr7/a74Ik9k2KIaBTCDZ1cpojdQF4jB3yQtqQl6OHx72
	 eoLkMTEQg6ShAYqWcvU2YptT7h+Te2H9RGRpRIY7VCWfReUCG8IAUmgG10jMDv5KoBnC9
	 LUJm0BpOQ3GZBulWMxrOZkdiX83SHvC7loPp99q0IEf+k4xFhoOtHtn1KpqSc0taxvBPg
	 EReZfa1BZzw/CrhzhsE4eIdB9hFfeWLoO+rcEYejLRZFglpd/lQkH1+PcwjBb5W+k4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=W9i8bB+x;
	arc=none smtp.remote-ip=212.227.15.4
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81C1606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 19:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B81C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=W9i8bB+x
DKIM2-Signature:  i=1; m=1; t=1795808565;
 mf=PHRib2VnaUB3ZWIuZGU+;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:hXsaxTsJQWbwHjFuv2h7T8V5RXMv
   kebT0+maTHzaPwnfD1hEGj6N6bQxscA+6yWuPBaNXDJSSjZB11PZQSnx1Bzc+UYn74vTiscZy9v
   klaGdTH+xBepEAzNYJmNVSxNRm0PszPberHnBD74CS3nOeLSc4x5f67TPW8+1Seh76WFNCMgOFC
   e35VP99fq3zTyVc0iNkw2C/Z0u+JsfikNwR7zdVxhE6htAOF1pCcn8pP91q+8rY971RPMaO7hAj
   AVgUoVi4O2jI2bQOav7oUaWw5d4A6QdN5Br65a/7qIrXAQQaZvtK9Pt9QJ/SCG90Tq6Kiqegjuh
   J6eQD47OwXlVJg==;
Message-Instance:  m=1;
 h=sha256:
   ZsHbWxOrNj8WPIBGrf7UsiDq26XWGBtd2/Al5JbGmgY=:
   Dd0t1CNk+ycoKKNqCF74CYwnvCFNymVuF4hUGhQ83Ug=,
  sha512:
   sESYYQ+U5hjhoQOy/D/nAQa58C7CEmoQxJyNEjqzefcIc4Uuy+l7NTpzqxwE2PMUEYZAYMDGUvAAfcF8YAvFew==:
   pgjuVT0T3o/9hdgnCHfIwVRdZES1HmMl3vdKwf8gUR3DR2c3MsE/nf/QI/x/jP4OvS0o5vgdJa0s1KXMQCIdwA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795808565; x=1796413365; i=tboegi@web.de;
	bh=F6+8MGXDc9VxQCux3mDREgPL2BRjixPPxZa3VzLWThQ=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W9i8bB+xqbAbpIVsZQioezGSFBxhAPqf91jtADi4Au6Y7NuCpz37KFKmHHg6G8CC
	 v04sdsvnxZa1IZU0Dn5eXl1cHJM7HbHe0Q6s2w/vyEwRG29YeuKPakuPIAZrmAX2G
	 Qsq9ueXC4rSK/kllk8duqgJMdb/UhVCeyuqvDeqCnYKYXl/IK06tr2nb5J7fCJBXr
	 7uNY2eAsjxPq/Cz7iyzdx50xxlR9kLvaSyD3JJLfXMbvCoiI6PChDwTufCcueveUS
	 mAr5iO8NNRcGvsIngf0SyzGk0kQlexc6pftStw7c2R+oi6Ead9tKq7UxSXJc1msm1
	 bb8JkMUJHQ/3KUmN7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mm9VU-1yEvIb1YPI-00lSdW; Fri, 27
 Nov 2026 20:42:45 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	curtis.allen.smith@gmail.com
Subject: [PATCH/RESEND v6 1/2] read-cache: do not trust a size change when conversion is active
Date: Fri, 27 Nov 2026 20:42:41 +0100
Message-ID: <20261127194241.10085-1-tboegi@web.de>
X-Mailer: git-send-email 2.56.0.236.g7e34d8174d
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
X-Provags-ID: V03:K1:LjlT6OUh+Q9KpIiTXyUirQRTfgF0hQrvkXv1eEi5VyMTtxjBWFt
 3gvRjXja6kEC6G6osNiyjfLmKSfDYwjAGJh9niOBg6f0C2jBRZtz1cp4bVfGfBYjidPWvwS
 ITX5riwBPhPn+IOyhF9rgVagdQbaNF46Jb8xMnd+4UB3SiMOYVLYNwWvxIoKV+5WRSD7rab
 AjlxjePZ2l66NbuqF+08g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DWz/LCREr64=;y4cOWG9357TlauSTZjkuR7h5DQS
 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

From: Curtis Allen Smith <curtis.allen.smith@gmail.com>

"git status" can report a file as modified while "git diff" and
"git add" agree that its contents are unchanged:

	git init t && cd t
	printf '* text eol=3Dlf\n' >.gitattributes
	printf 'one\ntwo\nthree\n' >file.txt
	git add . && git commit -m init

	printf 'one\r\ntwo\r\nthree\r\n' >file.txt

	git status --short      # ->  M file.txt
	git diff                # -> empty
	git add file.txt        # -> nothing to commit

ie_modified() takes a change in the file's size since the index
entry was last refreshed as proof that the file is modified, without
looking at the contents.  A size change proves only that the bytes in
the working tree changed.  When the path is subject to conversion
(the "text" and "eol" attributes, core.autocrlf, a clean filter),
different bytes can convert to the same blob, as the CRLF rewrite
above does.

For such a path, fall through to ce_modified_check_fs(), as is
already done when only the mtime changed.  Paths without conversion
return early as before.

ie_modified() runs when the index is refreshed, so this reaches
every command that refreshes it: "git update-index --refresh" now
succeeds instead of reporting "needs update", "git ls-files -m" and
"git status" stop reporting the path, and "git rebase" and
"git pull --rebase" no longer refuse to run.  "git diff" itself is
unchanged; it already reads and converts the file and prints
nothing.

Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Curtis Allen Smith <curtis.allen.smith@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 read-cache.c    |  4 +++-
 t/t0020-crlf.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index c4cf08a3a3..70f4787de9 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -9,6 +9,7 @@
=20
 #include "git-compat-util.h"
 #include "config.h"
+#include "convert.h"
 #include "date.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -480,7 +481,8 @@ int ie_modified(struct index_state *istate,
 	     */
 	    (!S_ISLNK(st->st_mode) || ce->ce_stat_data.sd_size !=3D MAX_PATH) &&
 #endif
-	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size !=3D 0))
+	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size !=3D 0) &&
+	    !(S_ISREG(st->st_mode) && would_convert_to_git(istate, ce->name)))
 		return changed;
=20
 	changed_fs =3D ce_modified_check_fs(istate, ce, st);
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index fd1cae09ed..9c8d07cfc4 100755
=2D-- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -397,4 +397,43 @@ test_expect_success 'New CRLF file gets LF in repo' '
 	test_cmp alllf alllf2
 '
=20
+test_expect_success 'status does not report a CRLF-only rewrite as modifi=
ed' '
+	test_when_finished "git reset --hard autocrlf-checkpoint" &&
+	echo "eol.txt text eol=3Dlf" >.gitattributes &&
+	printf "one\ntwo\nthree\n" >eol.txt &&
+	git add .gitattributes eol.txt &&
+	git commit -m "eol.txt" &&
+
+	# a generator rewrites the file with CRLF, same content
+	printf "one\r\ntwo\r\nthree\r\n" >eol.txt &&
+	git status --porcelain -uno >actual &&
+	test_must_be_empty actual &&
+	git diff --exit-code &&
+
+	# a real change is still reported
+	printf "one\r\ntwo\r\nfour\r\n" >eol.txt &&
+	git status --porcelain -uno >actual &&
+	echo " M eol.txt" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'status sees through a CRLF rewrite of a file with a =
lone CR' '
+	test_when_finished "git reset --hard autocrlf-checkpoint" &&
+	echo "cr.txt text eol=3Dlf" >.gitattributes &&
+	printf "one\rtwo\nthree\n" >cr.txt &&
+	git add .gitattributes cr.txt &&
+	git commit -m "cr.txt" &&
+
+	# "git add" keeps the lone CR and drops the others
+	printf "one\rtwo\r\nthree\r\n" >cr.txt &&
+	git status --porcelain -uno >actual &&
+	test_must_be_empty actual &&
+
+	# the converted length matches the blob, the content does not
+	printf "one\rtwo\nthrEE\r\n" >cr.txt &&
+	git status --porcelain -uno >actual &&
+	echo " M cr.txt" >expect &&
+	test_cmp expect actual
+'
+
 test_done
=2D-=20
2.56.0.236.g7e34d8174d

