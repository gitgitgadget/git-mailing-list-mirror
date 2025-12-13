Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1A720B7ED
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765612991; cv=none; b=ZouknxZ9YnjzccPJTjJSi22o9dv4W1Yaoss63XUMfz2cSN2cUml2nGiJZGNWfdiJ5hWkbEuRp6slB+16j3Yo8jmeOFuWTmqXz0JYsl3LDk8n2oO5t3L9wfoosIPndZ+pxlA9zWyI+Z29/OLTr8T7Al4C+eVFS726xvu7j2eb64I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765612991; c=relaxed/simple;
	bh=jJYSl5Jj25ckLBZsHqS6NTY7DQVMAWebO2N6uN4YTAg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WXu/HGX9yEHmjHqKnYzUf1DB/88FxaIT/GMv7CrRZL0GDZLtb3tU78Jba9vtLSGeJztRnyqk6gmZ3NmDjEj8a31b7rez3Ew0Rm2M9+orNkK8UEkyeOuPG80NSpFHN7NyLmargfpwxH6WfN1f7Aeou++aKpv31aPOIFTHdocn5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=XyFBqeCn; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="XyFBqeCn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765612981; x=1766217781; i=l.s.r@web.de;
	bh=zc7ZpWJo1+U9ojrUJZhAa+37IFZVjORFY2UkXcJNJV0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XyFBqeCnWTcZYGZRQij612zyoz//l4e2Z/fbbW8le9ssbHs61pprr6R3UibGDZMp
	 95H5b3cjElcRP6+rbWnX3A0txTHSoJ+gJzp9iUEoQ99HRhrSYPks0jGSnRMiHXCUF
	 AOOzbDJi2H8B1gMIwZHm5KsSAgrm30qUiF8Y1MOZ+/lzBXKuZN2xxn7RTQMQcOtyz
	 VAy+55zZGBT8RLISTIPV5QYw5u30TMeukumdJnjkzBtVxp2Y4c+wcflx6P0ELGHya
	 9dyiL9Q2XAIm8+S+2CQeM2huJlNJF7cYx8DImE6MvuVEQKSCWn9Ng3t84LQBE1m4q
	 FkhwlNPCdBV3BzEYCg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N01Za-1wGMfS3zGQ-010cSI for
 <git@vger.kernel.org>; Sat, 13 Dec 2025 09:03:00 +0100
Message-ID: <eb0e6533-44ef-4b85-b1aa-f43f6d4174a4@web.de>
Date: Sat, 13 Dec 2025 09:03:00 +0100
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
Subject: [PATCH] t4014: support Git version strings with spaces
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vS6bdFGvWN47cci6F+aW9FsCOAAoENzMzOJ/4HHj8WByVd/u+TO
 cjqqUOjACZcYiBMrBT5St1Bcv7LgqX+AJm+L/1X/2F8EIPh//F2hC0zaxUZmX8a1xI4dwA7
 X0WOwgT4zflrF34KHfO5rMiDZFPLJynoE/UrLqotAoZpOI/EEX9LfMRG++9F8sqSMWTKcO9
 4mP460RnsZe2dxjHiVZCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n07jwLmG19E=;zoN13SroPpERqcSGinfnlwWvLBL
 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
 V0kTBAYCPWOM5A17GCTfxTNlPlUQDcnITTcz6K

git --version reports its version with the prefix "git version ".
Remove precisely this string instead of everything up to and including
the first space to avoid butchering version strings that contain spaces.
This helps Apple's release of Git, which reports its version like this:
"git version 2.50.1 (Apple Git-155)".

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Not an Apple patch.  They use sed(1) instead, which inadvertently hides
the return code of git:

https://github.com/apple-oss-distributions/Git/blob/6b2f9bfe72d6d4b5c9bcc1=
c2d0236c026d321cba/src/git/t/t4014-format-patch.sh#L982

 t/t4014-format-patch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 2782b1fc18..21d6d0cd9e 100755
=2D-- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -980,7 +980,7 @@ test_expect_success 'format-patch --ignore-if-in-upstr=
eam HEAD' '
=20
 test_expect_success 'get git version' '
 	git_version=3D$(git --version) &&
-	git_version=3D${git_version##* }
+	git_version=3D${git_version#git version }
 '
=20
 signature() {
=2D-=20
2.52.0
