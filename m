Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218313;
	b=CyCE5hBTAs+Ew0mNbJKyQDxuq9ebVMuta82U2Als7ExQQjiah4HGKx7MxlDx8agzAArS
	 mkDiqDdQEDFX+VfDCf3mVInbXeLL/BaylkQlWAH+FfmBPNXCHHSIceMQP/N8iyAXKbFZ4
	 0KuPn6DM7icRYV5P+/f391V7r0ILP79s8KHkbg7LC9dsyjFbT31fSkwlRK2WMd9bxzrAW
	 CSPwvV21bkGhV529AZffwxLQp5PScZ9Kl6jU6ufNowXOSg1O1VcSYFoaOWjxmDk8cz8yH
	 FgY6ZBNwXIg07Sb8B0q3/wMHC1wMfcWPcRNnZGtH1wdXGASbylUAQ6p08dZWUw/uv7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218313;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer;
	bh=J1h4q6NWla0uZq0aL0AzcqRzKi8/W4Kc9IXbIDr7cQY=;
	b=LKoHyXF9wHFahwK5+FW6rOf2ChSov3F3cpb31DltavJwIsTMidoKRUAJomvbR8q/hQ08
	 /0t4Vwdh09GEuQEtibB6pQzvFFmAzSa5c1yIh3kTd01ObLeaZA9ejAePU8/bjtbccci54
	 JGpRK1XAlJzrUJGklQfmYznsTw7iDw+BnmyYDFHSKmjg2r6B7Jdn9J6hLR5qOcBnQJ4MX
	 fiinXIoUeGiVFOJl6P6eDkOIG7AHdqRuvX8KfU2MHsVbJK0ZpJgi5cf63AzHzXW5xkpOq
	 bLd1gEg4UwQ98B1aLb1tvmw4Wf4FO/iSTQplgu724VJxx6Joxt6p0uWD6FjZg0NCU0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=d5GykWEG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mWFrTaaw;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE1606D801
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 09:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1DE1606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=d5GykWEG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mWFrTaaw
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1837F7A0072
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 04:58:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 09 Nov 2026 04:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794218311;
	 x=1794304711; bh=J1h4q6NWla0uZq0aL0AzcqRzKi8/W4Kc9IXbIDr7cQY=; b=
	d5GykWEGStF34nN29+xhC0mX2fpNtG0m4k4Stp+GEbfgFSSsPDGtyNbSZ0gwb0NQ
	uD9hLWiwB/ftBkwGl1zPgTA2T4z40FFCNVzJ4hgfjQTSsg3Dxxc3JjwXJg817hLS
	nLMQiCXp1FN09Nj8mUxEsD0fHxOiS2nSVzXDKLwfaxTd2Qb+g+jZvAKyrUPgam9Q
	ybPHyaiUjLr+NBUJNyWbPg+/uQ6mFDqySow2wO/o+Vg28z9c2f1nFfyyZpnaM5Os
	ML/LMV54VMQfK2Kinbky9s8qtyr64LGg6aC8lx/T3k+gAUXdXtjiRwoWrDyo4xd8
	ZmHWpGBjKsmv6cZ9nvxGgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794218311; x=
	1794304711; bh=J1h4q6NWla0uZq0aL0AzcqRzKi8/W4Kc9IXbIDr7cQY=; b=m
	WFrTaaw5gFjWzX0RH3Mo3BF+X27Qd/AZ/JIUrrmZZmjnqDXK2GG50v1u3bQUYZ3j
	vwieSxbceiiFwFB7XblGaMd75qSe6Qk8d4yqgU+doZn0x9Quzmxr5RvILG32JVAR
	S5oxv1vQDURc872DcBfgrB8MKPHHvAvDpNtH96lfP+xlv/ZunasnxeWzBbFVHCae
	UqJ7cSEEn2LSrjXzc1YR1a4zA02cs5PnIGLnSb8hDOh0OHxg3oTzmCgj5YZKxrgh
	2ThLfFKb1gp+n07GPzJMaqDbe8BKp/E6rjR9RnARhi2JwNLg0YuEO8WKWepeK/Go
	NVUfAk3kJK6k1Qqoa1Sog==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794218311; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:QF8JGOSXjy7wFq9//WXUlXEkhHwv2nD6FOmdL7mkZDs1aly
	V7NmHpgYFkIwNCyRAEOr7KQG7EyfX8LaHZIzNqditFA+Jhs+B97py+SfGk13ZgaG
	AugztL+XTrtzB4CMURgnAUwL1V8DevARujaapDz6LJQNEWY8yso5pPmfM0ZkDAl9
	OhslCkbC8Vf1oMKNbHYcsQtU+eBmbyUyO/0qSPDGsclAbn4J3SZndd2B5EYX2EQt
	JWsyHUdjBqDHVBySeLxVOOGeY5C8/Rlc1oPdAS33LF2Nj+o7zc4dsIieS1fnSVe8
	J3olbzhpkTtWYyxXyxgc07ItpENf4gqyehmSHvg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:OiAKSp0INn8A50dVXrALXzdgXwnrbH7qbi/QlW/1pms=:j4h6sR/HexVf/bigkGOTcHaTvycxiKTXMBOTJj+C/sk=;
X-ME-Sender: <xms:R5nxatjNMIBnbG1V9N9pOuBG4qFmzHeb80JZY-9BVar2QVlaJvRhIA>
    <xme:R5nxapB1BuRtNSkmxrC45PEII-wkyUgZznu5XK-jI0E1xHLi4IsUP7eM3aIzNfFMw
    KePdiD82ZOjFPNYj7ueUUnGZk7AMLzTw_6VoyZfP2XQkKieVaSRVS4>
X-ME-Received: <xmr:R5nxaiF8CZPjsQY62nUr4SdkrrjDveMnVjqg2JvARI8SGmVuyCtVRg8VEUXoKPLU34yDRSA>
X-ME-Proxy-Cause: dmFkZTE+2dBr+4UpP8oY6+CodxwbyLWkGxakS1A7i7lB9kvpI7rERy/c/KYaHxDc4GBQwP
    BBOx3MP5+EhlElw4oFtzvnTgj+nPyopbw5NO41HX8p+lKJU9BBY51UUlWhWtMuuiPcLhmT
    IwggE8MLjw4JpLBr9t9vvZtzEIujePfnwjZKIWPp/TluLwwxQ6dWsJm0yqtPueZRfS2jVs
    UEJd6JgqcyxIFXCvrKVUVhtuLaGXhwGnac85E1ENL9mJJSOw4iogQsDd+1ZlTcTkJNDRJS
    peLwlq5DzTb5wozsXqwmJDSyx16bqbSgHe9FB1OEXVsDN+N1DhibTJCBBwv6iMnXKobdKT
    U5LXll7GQL9mfDVHR5KgQMO6znZyQT6wF3zy/cui7jNhxh3tQpYt2rlpKmp24YXa9+cDVD
    APVNUhFQO0hKq/RHN/sZkFGF47VFTaaNNfbmZOn+kY18wpF7sYgRnL54lpOtmt7jGeqaC6
    CGe+4ygjNWRQc69QfDDsYl8z2HFZL4dDdtANMxkmGbEJTgEUxmSS3+GFQGrxpUnBUB1E9T
    FC9W35eLJeI0GeRbAXmddWyLdLIEbuu4cCFJLXyoYIM/3bK0JCXXGldrapEOc/1AbhpqDK
    MsKviQpUdSk5ye2Z+ikpMT3p2JPKT7L3K23XpY3UTrcXvxINERLUdVXH+qnQ
X-ME-Proxy: <xmx:R5nxahKOGwaHYtOgLY9XlV_PXolFKmSqW5_GsgQ_LOFMIPXFaU5Ygw>
    <xmx:R5nxamnfOJ08D5JmjUmBtpcw7hFssl-Iuhbi4E_y85UkTEnm5uvMiQ>
    <xmx:R5nxapTDUVuAbW70BgmIFdtOmUwxsMpEBqsNAvznYU356Hmm11FpdA>
    <xmx:R5nxaoJR4oOPF3up73aIQfA938c4ct-BaEr4EcvzrlQ2QuZadqgvoA>
    <xmx:R5nxanZE0JFy2NsdvNBrICpw8RNg9qNY4DPE1s8IqtAY5A2y_-3oABnm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 04:58:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84f06ec9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 09:58:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/7] ci: some speedups for slow tests
Date: Mon, 09 Nov 2026 10:58:21 +0100
Message-Id: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBBGr2Jm7Zi2EIquvIdhAWWA8QeaDhAN4
 e4WPIDLl7zvfQsIBSaBy2GBQDMLD30EczyA68q+JeQ6MhhlMq1Vhv4h2PL4LCt0jOKJ6skLqrN
 L8lRTpW0OcewDNfzew7fixzJVd3LjVtuMjmUcwmd/nvXm/T2ZNSrUTakSmzprcnuN4olfUKzr+
 gVYU0j9ywAAAA==
X-Change-ID: 20261106-pks-gitlab-ci-speedups-09c3841eb178
In-Reply-To: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: b4 0.15.2

Hi,

I was staring at CI way more often recently, and that got me annoyed
real fast because it's just painstakingly slow. So I decided to have a
look and try do something about it, the result of which is this patch
series.

The series contains a couple of bits that are specific to GitLab, and a
couple of fixes that are generic. Some highlights:

  - Installing the Git for Windows SDK speeds up from 3 minutes to 10
    seconds by using tar(1) instead of Extract-Archive.

  - t0027 speeds up from >10 minutes to 6 minutes on Windows by avoiding
    the overhead of spawning redundant processes.

  - t5551 and t5559 both speed up by a factor of 10 on macOS, going from
    20 minutes each to 2 minutes each by using reftables in a repo with
    100k refs. "osx-meson" and "osx-clang" thus go from 29 minutes to 18
    minutes end-to-end.

  - "fedora-breaking-changes-meson" speeds up by a factor of 2, going
    from 35 minutes to 16 minutes. Turns out our SHA256 implementation
    is quite slow with "-O0".

Unfortunately, our Windows runners at GitLab are still atrociously slow
by themselves. So the critical path only improves by about ~10 minutes,
going from 60-70 minutes to 53 minutes end-to-end. But hey, at least the
other jobs now give feedback a bit faster. And I guess on GitHub it may
be a different story because Windows runners are way better there and
are typically not on the critical path.

A test run can be found at [1].

Changes in v2:
  - Drop the cache for the GfW SDK again.
  - Drop repetitive paths in t0027.
  - Link to v1: https://patch.msgid.link/20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/734

---
Patrick Steinhardt (7):
      gitlab-ci: speed up installation of Git for Windows SDK
      gitlab-ci: exclude intermediate outputs from Windows artifacts
      ci: build optimized binaries with Meson
      t0027: optimize how we reset repository state
      t0027: cache expected output files
      t1092: set up repositories from templates
      t5551: use reftables for repositories with many refs

 .gitlab-ci.yml                           |  4 +++-
 ci/install-sdk.ps1                       |  6 +++++-
 ci/run-build-and-tests.sh                |  1 +
 t/t0027-auto-crlf.sh                     | 26 +++++++++++++-----------
 t/t1092-sparse-checkout-compatibility.sh | 34 +++++++++++++++++++-------------
 t/t5551-http-fetch-smart.sh              |  6 ++++--
 6 files changed, 47 insertions(+), 30 deletions(-)

Range-diff versus v1:

1:  e25adb1b8c8 < -:  ----------- gitlab-ci: speed up installation of Git for Windows SDK
-:  ----------- > 1:  582a9ab6468 gitlab-ci: speed up installation of Git for Windows SDK
2:  116c8b8a716 = 2:  bff0a624127 gitlab-ci: exclude intermediate outputs from Windows artifacts
3:  a035b8a902c = 3:  713e69bfb59 ci: build optimized binaries with Meson
4:  1a1238f4be7 < -:  ----------- t0027: optimize how we reset repository state
-:  ----------- > 4:  e421eb2a275 t0027: optimize how we reset repository state
5:  c652f5b380a = 5:  16905b5be62 t0027: cache expected output files
6:  9a90272c620 = 6:  43f355fbb02 t1092: set up repositories from templates
7:  187128e7d5d = 7:  960716da178 t5551: use reftables for repositories with many refs

---
base-commit: 0ffa3e35c7c82ab8d0de226149fb03b3f7674d05
change-id: 20261106-pks-gitlab-ci-speedups-09c3841eb178

