Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792866664;
	b=dMLFN0ELZLgbShWPE1i2OYmOSS063UQZJIMQfxdE53PPYkBKRzkAFC6rUUdQ0C3JFuwD
	 +5lri+yjOfNXq16aZtV58wPYBJzFBaOjEXMnCvCBRebuMGpS3M0Pc/GEcE0ZXHK28RHTZ
	 DY8Xn5CM9oIy5CzpQ02ACvyyDIH5soT41NjuO0F62g14Hid30WKFxDuzk3pkz8xhMrNti
	 m1H6fzbHHwnffs7KSrmv2xYInq01Q2+LIp0bYWS2fY+mJlnlwD6aDZ9psNVAPt1R3xvi/
	 jzr+OXqxF2cMokwLOeJoXUmHU2p10yDr3zBgoMdpChulOG8p4lhLIJfsE9R4GZ5bRIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792866664;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=ewhCdk9/5YO2NBCvOcAnZ7KuziKkMvCw0cZwoWprdxs=;
	b=tAqNiNZKj97HOOQeTbm9DvXicObMgWryk/IpApjD/O3og2cjAbpDFERsFEC44SZvQkCe
	 htLNoXLzgm0OabEYdn+CWNJjotvace5alPEDIiT8WbOQyBbY8cS/Ew+Zdfk/VoSEKHP3D
	 3eZr72HZuEMsM76OAdZjx6c7f4ak1a5nXh+voNCiZtyZdzzfOp0BXbt97JuAsXUDjQgal
	 MChzJVBuNxw1V4ReeomDXh1+tNn+qn5rsnhFxOvN2CfPPOpHkbI7xe5BSGv2pDcl9egjg
	 zxS3Ihr708QPj5d+ChobF3ARlI8kmgjuwJtt4VvHJYQ+/5zgObNsiDjugG6qTiVLygw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=ac0+MTK7;
	arc=none smtp.remote-ip=212.227.17.11
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDD0606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 18:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EDD0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=ac0+MTK7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792866661; x=1793471461; i=tboegi@web.de;
	bh=ewhCdk9/5YO2NBCvOcAnZ7KuziKkMvCw0cZwoWprdxs=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ac0+MTK7ziE29AN9BFdHrfAtydDRtKsma5mxf1a/HBlyiQgdCdAl2RKdHM0Y1XZ5
	 dcpJvTNjgWuFddGDWZ5sW02n//yTZU6cIFAUdp4MqHRIITT5Cxbh3CJIVdPt0Hdj3
	 hdE93pUybPIsPo10Ufm+wHuA/zJydfPDCfepUv8aUK+6TuPb3jk/Z+W77GVVUY34I
	 6xNhQynzLoxUxfsOibQWAF5BLdBMzwGq/iZo8hEtOtXzeDHC2IlqF3Rsx8plgHu+g
	 mNUH/XT3ZbOB7IOdcb5ErlaH8UBr3p8LxRjujCHH6mX9izNVzV+eyu5E1Adk/UVlA
	 7B4WXyibpEGFo7D5Qg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCogs-1xTRwb0BnM-008qdd; Sat, 24
 Oct 2026 20:31:01 +0200
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	ps@pks.im
Subject: [PATCH v1 1/1] t1450: use mv -f when overwriting a read only file
Date: Sat, 24 Oct 2026 20:30:56 +0200
Message-ID: <20261024183056.6342-1-tboegi@web.de>
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
X-Provags-ID: V03:K1:ISuhp+PRUStQPc8+ClxxDd/U2cRVFb5pnVm8uvDWambVVd8JPWZ
 Hzzrt05ES4j8VJuDTLSZv+Lir7ltTjE+4QiEPn2BAYHvxHCK7mCVNA88E8SLtQ+O2OdV9TW
 JAH4GZmL/UHaJGc1+LmmL4MZKQBTPTlbNmctvCn87oYd8hhb1X7FfP8gpzc0N+H3HA6eLVV
 PAAEoTsnQMaYAEhueXtEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zKAycaF4A/Y=;drQJ4mAt85dQe8Kx/etA/acxfqn
 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
 kPc4Ke73jWAGxsB0FOlJ+GChJVwj0=

From: Torsten B=C3=B6gershausen <tboegi@web.de>

test case 38 in t/t1450-fsck.sh replaces a loose blob, "$tmp" below,
with a trucated version "obj.tmp" using

mv obj.tmp "$obj"

This fails on some sytems, like older MacOS.
`man mv`
includes this information:
  The following options are available:
  -f      Do not prompt for confirmation before overwriting the destinatio=
n
           path.  (The -f option overrides any previous -i or -n options.)
and further down:
  If the destination path does not have a mode which permits writing, mv
  prompts the user for confirmation as specified for the -i option.

Running the test case in debug and verbose mode `./t1450-fsck.sh -d -v`
shows this lines (which I have shortened to fit into 72 characters)

override r--r--r--  user/staff for .git/objects/fc/a75a5be3823dc0560da5?
(y/n [n]) not overwritten
fca75a5be3823dc0560da57ade678f212aeb33f6

POSIX mentions that the observed
"prompt to standard error and read a line from standard input"
should not be done when "standard input is a terminal".
So we may blame the "standard input is a terminal" logic to fail.

Side note: Answering with 'y' to the question of `mv` like this
(echo y | mv obj.tmp "$obj")
makes the test case pass.

To make things not too complicated use the most portable form
mv -f obj.tmp "$obj"

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--

So it was not the shell being old - but /bin/mv

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
+		mv -v obj.tmp "$obj" &&
=20
 		test_must_fail git rev-list --verify-objects "$blob" 2>err &&
 		test_grep "hash mismatch" err
=2D-=20
2.50.0.rc0.46.g7014b55638

