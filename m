Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792902815;
	b=luDbx15uyW9uB7Um9DbFnM8ZhIHafmpYxRYKb4D99Wsdl4l/9+ea5STZawgmBpVikIIG
	 UsLWCHHET9xm4GbZYi+eVH/u19hF3W12ieP4q1xQxWLdwFO0jcRTaRIljBOgFXo8q/UjU
	 MBP6+6JMRBS3wOWlvMzxI30DrVh0BDb1nkfXz3jhreydXTSkv8eEP4G+KHgQUDwjQlQnK
	 GPFL9nbSFvfbUIvJhx3QK6lSMnpjkmnPtI97qRguBFYS0KVQAu4D74DxNe/iToW2SLz+q
	 eOY1vfGHHf4Ersb3rGyepPyoCQwtzLaz+sbdxIC0b7Krquhi1cPgonQwK2sCv99WBvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792902815;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=IqXGeVbk9NJbgzk2c3h1I5WMZO0Cu/soSDZDnug6t6U=;
	b=kP9ht/InZTawsmMxgFn4WSx53LE5C5TqaEafXmfV4Fing4ip+TKyEuWmw+3ioi/3EldS
	 lYwvfu1MgsRP2jDXCxzsiAqqa52bR7TnKyT4aZAanox3VgMKiyXzyETf9jAnv9vDg5yzD
	 D2JOn9dX+we1KvQP/Dx6NhrcnY1VxphGFwKJXdKL68B43SH32oc5BDP61F9bznKIAVKgk
	 ig8DdHCSzvMVaXsO+5pYyxPCbQ5LAVCBATzSKzzSOqkI/jv7GAGDTH1ECjLuO+m7pJDcs
	 vXdueFdE7PK0UzYuiV9HJl28sftNDwiza44BF3atEEv+hEF3bkpkn/38wEPxnDTXBmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=FnLw0HgA;
	arc=none smtp.remote-ip=217.72.192.78
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7B6606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 04:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD7B6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=FnLw0HgA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792902806; x=1793507606; i=tboegi@web.de;
	bh=IqXGeVbk9NJbgzk2c3h1I5WMZO0Cu/soSDZDnug6t6U=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FnLw0HgANTIOZZ66pOknM0kIzY68pj2w4jnHmLhXH2Fcb/5UZxA8IlDQVPkx4BCY
	 mEzoaXvY0uoYTfv/S+GLTH1jRoaZhgE/vQbcXrzZb1zZZytvzHhDPvJdYNhlX2HPl
	 +Yfp32rDBGwo6rovSEw+9YWOtYnC7Qw3vFODMfEJ4XvozW7PfdVQO3Fxta31jqw5k
	 bBDPD5IYQW1oYyPF37KyNTJE83WjlrpKAfsCIfESNbu5TP2Hne88C+rRB96gpeuVI
	 DNDLTHN5u5jmaVAw4OKSy7itG4NDEA+VsxELRsnNEqC2kVGa0r43UsoyovDg93mlc
	 u9ZSqVb265x9TnAEhw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRF3W-1wxot00sxo-00NAgL; Sun, 25
 Oct 2026 05:33:26 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	ps@pks.im
Subject: [PATCH v2 1/1] t1450: use mv -f when overwriting a read only file
Date: Sun, 25 Oct 2026 05:33:22 +0100
Message-ID: <20261025043322.1766-1-tboegi@web.de>
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
X-Provags-ID: V03:K1:nRzxoXZRI9/odtVTjGhKeI7p90DLSjMlKY0tyDTRKj4KktqsNiN
 K+pSu+KaeCvfNJXJchhn4jG/sgeQ6T1qkv6xkjUlGEO+UK58G1ndn3tIyHV704LHG4GkXmR
 K+Kq/iiECG92BQD1HzvaP7Juxvogpz1Cm8gX8ZAfx6/4VL6ChLImRMvWZ4I/ebb90ea6gcY
 7lHMIF9XS86eGL6HaFSVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QzpFo8PJ2LI=;shG3arRMblmGz5GKgJ0lYNjbuEl
 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

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
should not be done if "standard input is a terminal".
So we may blame the "standard input is a terminal" logic to fail.

Side note: Answering with 'y' to the question of `mv` like this
(echo y | mv obj.tmp "$obj")
makes the test case pass.

To make things not too complicated use the most portable form
mv -f obj.tmp "$obj"

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--

Thanks to all reviewers.
Changes since V1:
  "should not be done when" -> "should not be done if"
  Fix "mv -v": it must be "mv -f"

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
2.50.0.rc0.46.g7014b55638

