Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47953F412A
	for <git@vger.kernel.org>; Thu, 14 May 2026 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778756974; cv=none; b=O7NUCoXDj8Cpp8+zR704uC+Lq5FAarsffxy8EA8zoY16CfCdGgnLyH9mN2zm5Ma/czaK7jMG8ik7+qtAEWxab9yni3EjpItp/SJtJ4GRV5TMmDO9QSv69fqdCbWenBvHplhAiB6lU9o6ZFKhitYNLkABIg0Q/KuRDRsvLiBbkSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778756974; c=relaxed/simple;
	bh=TUxdR/S0g2UYAFC8jeNU+ThAuYMT6FxfLa764YNnZ2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guM1Wkjn4F4Lt05FKHlg2NDNMpJOzreNqfTty/sSDmZU0R0pPK+/NPTtnrD13fJFTPKhyPFS4l7ceyRyQnAXJmMPBVBt8EDenZvEpRkJ3Ry3orlasWqcxOwCvdTFceIrxKUTUUVCf3K85itk9fbb9pj8XJSQtq0gNxDTx+yo9k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=iBG4jA2R; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="iBG4jA2R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778756965; x=1779361765; i=l.s.r@web.de;
	bh=yFxpRs0ZqaHY8ZJKkSIPs46gcj4SEOlYyL608WLdIiY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iBG4jA2Ri7OAfQGXUUSFvmOwkolbrN1L3g5cwVXwkP0Ii622d7o7+pAkmrs4KyAK
	 xq8cWFqPXdhNydl0zVEgEnY6d0hYMRUw60CF2cF5ZgxUttnxJGDQrRPvM6P0T6Q5M
	 RygA6Wg7qjb0hZc3titOhid+FX/8I4u3A/O9do/Y5Mx4YNFFcbHImQmqirvD1xmG2
	 j448eiOGKXqvQnx2k4Vc/MZMvlVXzbzMYLUOyEgEvTlGIk1shQSmkBc4PH3mTZhd/
	 x+x5N1yz2yGxEoH/1uXrUeXwcpvi7yAD7TStPQmabmH+HJAr2Ugr6Ke+NX4HoZGEE
	 AWeq15dUXHcLKJVoZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QUL-1xSCe819zR-00zBIt; Thu, 14
 May 2026 13:09:25 +0200
Message-ID: <f51cdd89-dab1-44f3-8f63-7d34f6fbbba5@web.de>
Date: Thu, 14 May 2026 13:09:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] strbuf: add strbuf_add_uint()
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <20260512115603.80780-1-l.s.r@web.de>
 <20260512115603.80780-2-l.s.r@web.de>
 <20260512184238.GC70851@coredump.intra.peff.net>
 <60b1ef2a-3b12-449e-be0b-cb206425c80c@web.de>
 <20260513162232.GB103037@coredump.intra.peff.net>
 <20260513164948.GE103037@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260513164948.GE103037@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PCj/M13VOT8HTCGmxqujl7cRmlmVXbYsj8X4QzG+zx006HhG8wO
 r0ZK8uskgLQysi6ZcU0JfWgrjvtydUo6yFLlLeWZ/9THFlMfH3QKigjDgaf8EzYS28UmE5+
 vOoAMZRfUrCJPiTC/xuN4MWBz3BTrqBTGaTRZI3cOtIgU0wNtnSnE0owy6CQvuGlzf/jpi2
 rrCJ68GAcY5HD17hBhDug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D/lIQemVIek=;ZD7t9+F2l1VyxyqBenvt3Ory7w+
 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
 Nx

On 5/13/26 6:49 PM, Jeff King wrote:
> On Wed, May 13, 2026 at 12:22:32PM -0400, Jeff King wrote:
>=20
>> I guess it is not too surprising that they all come pretty close in
>> whole-process benchmarks. These are all micro-optimizations of a
>> relatively small portion of the total work the process is doing. Even
>> the strbuf_grow() checks are probably slower!
>=20
> And btw, one final thing to look at if you are interested in
> micro-optimizing strbufs: using intrinsics for overflow detection.
>=20
> Right now we use unsigned_add_overflows(), and then do the actual add.
> Using __builtin_add_overflow() might be faster.
Curious.  Clang and GCC emit the same instructions for our
unsigned_add_overflows() vs. __builtin_add_overflow() on x64, but clang
on ARM64 fails to elide the comparison: https://godbolt.org/z/91d35KofM

Which explains why this patch:

=2D-- 8< ---
diff --git a/strbuf.c b/strbuf.c
index 3e04addc22..4c2bd1e66f 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -106,12 +106,13 @@ void strbuf_attach(struct strbuf *sb, void *buf, siz=
e_t len, size_t alloc)
 void strbuf_grow(struct strbuf *sb, size_t extra)
 {
 	int new_buf =3D !sb->alloc;
-	if (unsigned_add_overflows(extra, 1) ||
-	    unsigned_add_overflows(sb->len, extra + 1))
+	size_t len;
+	if (__builtin_add_overflow(extra, 1, &len) ||
+	    __builtin_add_overflow(sb->len, len, &len))
 		die("you want to use way too much memory");
 	if (new_buf)
 		sb->buf =3D NULL;
-	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
+	ALLOC_GROW(sb->buf, len, sb->alloc);
 	if (new_buf)
 		sb->buf[0] =3D '\0';
 }
=2D-- >8 ---

... gives a speedup on my Apple M1 with Apple's clang:

Benchmark 1: ./git_main cat-file --batch-all-objects --batch-check=3D'%(ob=
jectname)'
  Time (mean =C2=B1 =CF=83):     119.6 ms =C2=B1   0.2 ms    [User: 112.9 =
ms, System: 5.6 ms]
  Range (min =E2=80=A6 max):   119.3 ms =E2=80=A6 120.1 ms    24 runs

Benchmark 2: ./git cat-file --batch-all-objects --batch-check=3D'%(objectn=
ame)'
  Time (mean =C2=B1 =CF=83):     117.3 ms =C2=B1   0.2 ms    [User: 110.4 =
ms, System: 5.8 ms]
  Range (min =E2=80=A6 max):   117.1 ms =E2=80=A6 117.6 ms    24 runs

Summary
  ./git cat-file --batch-all-objects --batch-check=3D'%(objectname)' ran
    1.02 =C2=B1 0.00 times faster than ./git_main cat-file --batch-all-obj=
ects --batch-check=3D'%(objectname)'

... but has no effect with GCC 15.2.

Ren=C3=A9

