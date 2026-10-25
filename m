Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792951587;
	b=JQETdBlaPCJLivwVcNdAIPVKXB5bh/or7zYWB63GLxWXe6JvSQS6EW6iRvPA0cDmbI9h
	 z8pJOJTAYjV9qKis13LN+Ue41YhScMRByrC7SpsoNv55ccJ2YwQ/nTcBpyXkdVO/BaXn5
	 5q9rRPT/L/GwjbDy3t8L7xOTHWeWuITVrVhhIXy0ACE+OniiDoYr8OUJ0bBu78o4SAQ6G
	 c58GwuI8ORDfjrDMkL49RESDBRDii1BHQh3wD4Wll8MkurJlyVUNFfttyG09QLw0uT0+s
	 6r9V9W3i4IOawqxyaejBVI//WvD2Bo3t7Z6H7BjW5AudpMsbOd7UOU0z1X36v9AeLJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951587;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=K2KJrW9fyqIMUOaV8qlKLiMkuCxS4pOfJSsunOTx9+M=;
	b=aDnFuTS2EW4RyuSrbbLPVHyxB7oMVBfnHkgmf6HrC0Hhu/wuXCdcnqVcJe6Y0qEDhlqF
	 LQFX9K8Yp9Ie2sTXT/4IWXOrpwG8xleXEibYWN6GKF01jTZToDBaLKeT3myjnAQbsrn/C
	 NUDSCfG9eKiG41NIVNkcgWonVAczxNMTet9TtvFItFp3OCDkwDOlxG27TJoTqq2vbYAXL
	 BBkwHTz+81L9VToZzRbUrjbyEqYHTFdmkuqKrBM3l+ihWBWB87y5dDoPrjhF7RDJ9LV2q
	 HTzuZZd4DrcaAc57lue26wdP8c/JBpgRSmnwCFkTZILTFmdGEympnwui2bVnCIsp67Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=rjJGvz4I;
	arc=none smtp.remote-ip=212.227.17.12
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EED606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 18:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86EED606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=rjJGvz4I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792951582; x=1793556382; i=tboegi@web.de;
	bh=K2KJrW9fyqIMUOaV8qlKLiMkuCxS4pOfJSsunOTx9+M=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rjJGvz4IrvXWr7hefnagikc30WWSGKP2HUhEldAn8P3nbhtB5tPD4chwacrXxF5m
	 n2/8TRV+nhSjLK0yybjqQbsLK7JEFhHwVRIQ4RmWnG0vHSOlB+x2zzLYf8lS94m90
	 dNX4WFjYqVLONKzkA6mnBb2R1oMXAo8KS6AQlj+nwInsgIKXSXscXkPo5hg2aBXrj
	 0JhZbPsW6E0LdN6ejjaHxMuDzhMS2y5fpgGLR4tar7g4u7Uz1UmVZX7IGU8y+L/yz
	 GGkJC1kydFtxvOb83k1dowdn8Lif9GoTYnvAhDuM6HRkoCXUB9Vs18bENNoSR5aEa
	 aRuMta4oNkgg26MSJQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2SP7-1wZZvl1oD9-013xiM; Sun, 25
 Oct 2026 19:06:22 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	ps@pks.im,
	taahol@utu.fi
Subject: [PATCH v3 1/1] t1450: use 'mv -f' when overwriting a read-only file
Date: Sun, 25 Oct 2026 19:06:18 +0100
Message-ID: <20261025180618.16899-1-tboegi@web.de>
X-Mailer: git-send-email 2.53.0.154.g7c02d39fc2
In-Reply-To: <atmvASAoaCIpc_ca@pks.im>
References: <atmvASAoaCIpc_ca@pks.im>
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
X-Provags-ID: V03:K1:9jjHiQaDcc3JCysJ5mAJDdh6ctbqfIvvBAfo9F5EfE0ia1HB921
 NgW85pRjBC1aY04DAJDJoBNLEW/PbgAS6zOckk80YJa6S0a+cn/oaaku1I2LdiJB+EQ3Flb
 vUF5XfLhT6VGWbm+oek+9NMgPPr9HCTA1jtT/b4E67qdOSNWeNI9ONqynvFIS7UXNv6wueh
 YB8zYtmbNSdE0sP5gdLWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XRY3zF8EsuI=;RFEFHz41nnx6SvDtULWhNLeUF9a
 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
 qHBlyotMhCT10x2p/Q==

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Test case 38 in t/t1450-fsck.sh ("rev-list --verify-objects with
truncated loose blob") replaces a loose blob with a truncated
version using `mv obj.tmp "$obj"`.

Because Git creates loose objects as read-only files, this step
attempts to overwrite a read-only file. When running the test,
older versions of macOS `mv(1)` (prior to 12.3)
will prompt the user for confirmation (somewhat shortened):

override r--r--r--  user/staff for .git/objects/fc/a75a5be3823dc0560da5?
(y/n [n]) not overwritten
fca75a5be3823dc0560da57ade678f212aeb33f6

As the answer is not 'y', the file is not overwritten and the
test case fails.

Use `mv -f` to force the overwrite and avoid the interactive
prompt.

Helped-By: Tuomas Ahola <taahol@utu.fi>
Helped-By: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
v3: Use a much shorter commit message, as suggested from Junio.
    Mention that MacOs 12.3 has fixed this.

t/t1450-fsck.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 16cc5d5dcb..335dcbf0af 100755
=2D-- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -548,7 +548,7 @@ test_expect_success 'rev-list --verify-objects with tr=
uncated loose blob' '
 		# Truncate the loose blob such that its header can still be
 		# parsed, but reading the object data fails mid-stream.
 		test_copy_bytes 64 <"$obj" >obj.tmp &&
-		mv obj.tmp "$obj" &&
+		mv -f obj.tmp "$obj" &&
=20
 		test_must_fail git rev-list --verify-objects "$blob" 2>err &&
 		test_grep "hash mismatch" err
=2D-=20
2.53.0.154.g7c02d39fc2

