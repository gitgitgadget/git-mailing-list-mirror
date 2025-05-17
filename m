Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2A04B1E7B
	for <git@vger.kernel.org>; Sat, 17 May 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747501364; cv=none; b=dA15CKndCeGqlyiRjp1K6NjV+IwaaQuJKt5vpKOcVJ6DgnQmJIZWAIvZIuWJMQJpxI3tiZIrEfhNwm41nlylCn110gF7SEu5xz6y7dEDnmj/0a9l7WJtkkDc1YvJStf84HCZNsyeGezUnYCeJWuSttbsrgfAbSIraBtobCsRqcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747501364; c=relaxed/simple;
	bh=j+iQJ5qsZbD/z4KkdfdnIeWMVxjP/UzOK8+b0zd+kjw=;
	h=Date:From:Subject:To:Cc:Message-Id:MIME-Version:Content-Type; b=MvJkqrp4XOxiE13LR+6NKu24TgV17C/VwLDtxPUGH1Jy1fNWxn9hlbFJJvr9/MpbVB6QrEtgtQmaGvcznjH795WGEMFmVxzCP5f2BgYipAXLGhkpGuBaVNTaZnvwkdcToOxBIfpRpnkosrnLBDFUEWezN9XBlBgkvx2uMTlvoN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=Prq7/nZ0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="Prq7/nZ0"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-231ecd4f2a5so12521855ad.0
        for <git@vger.kernel.org>; Sat, 17 May 2025 10:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1747501360; x=1748106160; darn=vger.kernel.org;
        h=mime-version:message-id:cc:to:subject:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j+iQJ5qsZbD/z4KkdfdnIeWMVxjP/UzOK8+b0zd+kjw=;
        b=Prq7/nZ06P8j81gzMbHJ8R+KkWH82ThGa+gxdHEN7WxF8ObmScF/FJRSHlbTF+D01t
         NOxFAA8TEzvkRims9yRV+OgdsqSMQ0WoBlWHbENdCC8Nm0LaScnjBSyETIslz9J1PC+L
         vQ0CG3137n0g5sCs/j97ONTpAn8Io310FwmA04JvmCBAct8XjeBr92um6HPaHXD+f4nl
         i+vfzxbym8sKEmO3ExK8rcCZs7SVW5Lry0FvVIqwAm3V4jNm7uUPrfPKK7IUrsOVLrb0
         dgf+FEpBQSrxV2PBaeOVc0IQONJQrj8H98g0xRhfLKRC0wWSBFi33rw/J5UChhemZBsE
         fxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747501360; x=1748106160;
        h=mime-version:message-id:cc:to:subject:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+iQJ5qsZbD/z4KkdfdnIeWMVxjP/UzOK8+b0zd+kjw=;
        b=F5ea4NH9By1TCCFGnKiY2Rzd+GydUCUGPnFnuRZYqc1nx1OEdnJOAZX39Rd+PAWi6s
         qqMzRs9RE940M3g5ZAkF8F9sL5mPID/3NLkc7YPq6lIQRTNuQ1SULOhMAg3MvCPQQYTg
         qXPsfUbXK4xtWSbTpT1JDAc281D3ga5G0r1Sfsgr0lP/JOsmEUKJOop9pa2zY2SfolJQ
         n3g5HBA8TpdBRIBT6567H/tgkzvXkH1HNzZcX6S8G6/rqTNE9J3QOufUwyFQRXAoHGuE
         JchlnuqqXfaDruM6NqiSZ/gQ9ysPthGNbdprv1DyCiwhgrb22syYttpFkIFYZcfYl7so
         6qYw==
X-Gm-Message-State: AOJu0YzwUAS7d+inq35zCeimhr64ttFTOlghrIYqlR8b2saz6AwruEf3
	QvbqNhxddsne0JUGoWYATOyiT2N7H9hASFGF3Rits0Pi2w2w2Y2NCbZy01LttfDuYTX7HpLEzOS
	V6zZ2
X-Gm-Gg: ASbGncuwNAwyehJB6WvITS31fB+bWluqwI5Y6PKwMk6qRd35MdHm+HBjQsnxpdRxyuQ
	xDWOcEWR772P0Gh+JqCs3PCfVqEChbqxC607DUvYFqlACA1poZMbsf60YCwlQuhr6mTEz9rzcrR
	6jHcNqCw43slbdfNpkCIMJlozZ/wteMrz4cdB0w/494DvhdvlTYCHTqaMZthy14uBIWC0zktMwa
	vdLHHAOkUCrSGz+ct6wLUqfCSOeKwfxs8pnMUENvR9kS8phKbr9HOKKpKfYb8Vb2B/WYWauVuzu
	e4CgSeGJua9w7LPB1ktmlNpYcDOjVAFo9KWakq5+Gw9mjAKk7R3xCT2+z82Z8bdABYQNp5gO324
	=
X-Google-Smtp-Source: AGHT+IF/szJG7qpA5IuE5vQaaXO28IL9KO+6r5uvv7MpnthU1u5P5rQvjlnmxvO5JVQZNQMVwQcEKA==
X-Received: by 2002:a17:902:f706:b0:21f:6a36:7bf3 with SMTP id d9443c01a7336-231de3001cemr112047245ad.12.1747501360235;
        Sat, 17 May 2025 10:02:40 -0700 (PDT)
Received: from muhammads-ThinkPad ([2402:1980:245:6ef:bd3e:6a19:ff75:ab35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97defsm32494185ad.118.2025.05.17.10.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 10:02:39 -0700 (PDT)
Date: Sun, 18 May 2025 01:02:30 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: PATCH v2 [1/1]: MPTCP support for Git on Linux
To: git@vger.kernel.org
Cc: "phillip.wood" <phillip.wood@dunelm.org.uk>, "brian m. carlson"
	<sandals@crustytoothpaste.net>
Message-Id: <6O0FWS.8JJP67DO2U1M1@unrealasia.net>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-KusR8qS7pSQt1ByS3hSy"

--=-KusR8qS7pSQt1ByS3hSy
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi,

This patch is about Multi-Path TCP.

Multi-Path TCP (MPTCP) had been in development for the past 15 years
which started with MPTCP v0 (version 0) which initially had issues
for middleboxes and NAT Gateways.

The current iteration is MPTCP v1 which has a fallback mechanism to
regular
TCP to avoid issues with middleboxes and NAT Gateways.

Started to add this code change as a need as i have large git codebases
with around 50 gigabytes and i have multiple WAN links which i can
aggregate
bandwidth across and even when network one path (even in between my
CPE router
to internet) is down, i will not get interrupted.

Also i am using a Linux laptop that has WiFi and 5G module. So this kind
of adds my reason of adding support for git (on Linux)

To get MPTCP to be fully working, both ends of client and server must
implement
MPTCP.

My implementation adds support for the basic git protocol.

MPTCP helps in situations when one of my WAN links have a high latency
and
automatically choose a link with a path with less latency.

Also, MPTCP aggregates the MPTCP connection by using subflows where two
or more
links can be utilised with subflows. A single flow of data can have
multiple
subflows across different IP interfaces and thus increases network
throughput.

Apple for example had been using MPTCP for their cloud services since
MPTCP v0
which had issues with middleboxes (not MPTCP v1) since 2013.

The downside, even though i had never experienced it for other
applications
on Linux like Google Chromium[1], is that the fallback might induce
delays
in connectivity, if i've read it somewhere which i cannot recall where.

How this patch works:

This patch enables MPTCP protocol option only when it's built on Linux
with
IPPROTO_MPTCP support in netinet/in.h.

On Linux, if IPPROTO_MPTCP is not defined in netinet/in.h, it will
skipped.

IPPROTO_MPTCP should and never be enabled when it detects being built on
an OS other than Linux with defined(__linux__) check.

Another challenge is that although "getaddrinfo()" is a POSIX function,
not all glibc "getaddrinfo()" implementation is written with
IPPROTO_MPTCP support out of the box, especially on older glibc
versions.

getaddrinfo() IPPROTO_MPTCP support had only been added to recent glibc
in 2025 eventhough IPPROTO_MPTCP definition had been around for
much longer in netinet/in.h.

So we run getaddrinfo() which is a code in glibc and check for errors,
specifically "EAI_SOCKTYPE" return value which tells us that the socket
type
is not supported and fallback to regular TCP (IPPROTO_TCP)

Also we will also check that we are building on Linux and depending on
version number of Linux we will initialize the socket() accordingly and
if
there is an error return value (like
EINVAL/EPROTONOSUPPORT/ENOPROTOOPT),
we will fall back to regular TCP.

Enabling and disabling MPTCP:

By default on the client side, MPTCP will not be enabled in git client,
however MPTCP
can be enabled by setting an environment variable "GIT_ENABLE_MPTCP" to
any value.

Persisting the configuration can be done in your shell.

Also for server side git server (daemon.c), there is a flag to
optionally
enable mptcp with "--mptcp", example:

git-daemon --base-path=/all/my/repos --export-all --mptcp

This will tell the git server daemon to accept mptcp connections but
fallback to regular tcp when mptcp connection is not available.

PS: Can someone point me about having a "knob" in Makefile or is this
already sufficient?

[1] https://chromium-review.googlesource.com/c/chromium/src/+/6355767

Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin
<zaihan@unrealasia.net>


--=-KusR8qS7pSQt1ByS3hSy
Content-Type: text/x-patch
Content-Disposition: attachment; filename=git-mptcp-v2.diff
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2Nvbm5lY3QuYyBiL2Nvbm5lY3QuYwppbmRleCAzMjgwNDM1MzMxLi44NDZm
YTMxODUzIDEwMDY0NAotLS0gYS9jb25uZWN0LmMKKysrIGIvY29ubmVjdC5jCkBAIC0yMyw2ICsy
Myw5IEBACiAjaW5jbHVkZSAiYWxpYXMuaCIKICNpbmNsdWRlICJidW5kbGUtdXJpLmgiCiAjaW5j
bHVkZSAicHJvbWlzb3ItcmVtb3RlLmgiCisjaWZkZWYgX19saW51eF9fCisjaW5jbHVkZSA8bGlu
dXgvdmVyc2lvbi5oPgorI2VuZGlmCiAKIHN0YXRpYyBjaGFyICpzZXJ2ZXJfY2FwYWJpbGl0aWVz
X3YxOwogc3RhdGljIHN0cnVjdCBzdHJ2ZWMgc2VydmVyX2NhcGFiaWxpdGllc192MiA9IFNUUlZF
Q19JTklUOwpAQCAtNzkzLDYgKzc5NiwxNiBAQCBzdGF0aWMgdm9pZCBlbmFibGVfa2VlcGFsaXZl
KGludCBzb2NrZmQpCiAJCWVycm9yX2Vycm5vKF8oInVuYWJsZSB0byBzZXQgU09fS0VFUEFMSVZF
IG9uIHNvY2tldCIpKTsKIH0KIAorc3RhdGljIGNvbnN0IGNoYXIgKmdpdF9lbmFibGVfbXB0Y3Ao
dm9pZCkKK3sKKyAgICAgICAgY29uc3QgY2hhciAqbXB0Y3A7CisKKyAgICAgICAgaWYgKChtcHRj
cCA9IGdldGVudigiR0lUX0VOQUJMRV9NUFRDUCIpKSkKKyAgICAgICAgICAgICAgICByZXR1cm4g
bXB0Y3A7CisKKwlyZXR1cm4gTlVMTDsKK30KKwogI2lmbmRlZiBOT19JUFY2CiAKIHN0YXRpYyBj
b25zdCBjaGFyICphaV9uYW1lKGNvbnN0IHN0cnVjdCBhZGRyaW5mbyAqYWkpCkBAIC04MTYsNiAr
ODI5LDcgQEAgc3RhdGljIGludCBnaXRfdGNwX2Nvbm5lY3Rfc29jayhjaGFyICpob3N0LCBpbnQg
ZmxhZ3MpCiAJc3RydWN0IGFkZHJpbmZvIGhpbnRzLCAqYWkwLCAqYWk7CiAJaW50IGdhaTsKIAlp
bnQgY250ID0gMDsKKwljb25zdCBjaGFyICplbmFibGVfbXB0Y3A7CiAKIAlnZXRfaG9zdF9hbmRf
cG9ydCgmaG9zdCwgJnBvcnQpOwogCWlmICghKnBvcnQpCkBAIC04MjcsMTIgKzg0MSwyOCBAQCBz
dGF0aWMgaW50IGdpdF90Y3BfY29ubmVjdF9zb2NrKGNoYXIgKmhvc3QsIGludCBmbGFncykKIAll
bHNlIGlmIChmbGFncyAmIENPTk5FQ1RfSVBWNikKIAkJaGludHMuYWlfZmFtaWx5ID0gQUZfSU5F
VDY7CiAJaGludHMuYWlfc29ja3R5cGUgPSBTT0NLX1NUUkVBTTsKLQloaW50cy5haV9wcm90b2Nv
bCA9IElQUFJPVE9fVENQOworI2lmIGRlZmluZWQoX19saW51eF9fKSAmJiBkZWZpbmVkKElQUFJP
VE9fTVBUQ1ApCisgICAgICAgIGVuYWJsZV9tcHRjcCA9IGdpdF9lbmFibGVfbXB0Y3AoKTsKKwlp
ZiAoZW5hYmxlX21wdGNwKQorICAgICAgICAgICAgICAgIGhpbnRzLmFpX3Byb3RvY29sID0gSVBQ
Uk9UT19NUFRDUDsKKwllbHNlCisgICAgICAgICAgICAgICAgaGludHMuYWlfcHJvdG9jb2wgPSBJ
UFBST1RPX1RDUDsKKyNlbHNlCisgICAgICAgIGhpbnRzLmFpX3Byb3RvY29sID0gSVBQUk9UT19U
Q1A7CisjZW5kaWYKIAogCWlmIChmbGFncyAmIENPTk5FQ1RfVkVSQk9TRSkKIAkJZnByaW50Zihz
dGRlcnIsIF8oIkxvb2tpbmcgdXAgJXMgLi4uICIpLCBob3N0KTsKIAotCWdhaSA9IGdldGFkZHJp
bmZvKGhvc3QsIHBvcnQsICZoaW50cywgJmFpKTsKKyAgICAgICAgZ2FpID0gZ2V0YWRkcmluZm8o
aG9zdCwgcG9ydCwgJmhpbnRzLCAmYWkpOworICAgICAgICAvLyBJZiBzeXN0ZW0ncyBnbGliYyBn
ZXRhZGRyaW5mbygpIGRvZXMgbm90IGhhdmUKKyAgICAgICAgLy8gSVBQUk9UT19NUFRDUCBhcyBt
ZW1iZXIgdHlwZSBpbiBzdHJ1Y3QgKGxpa2Ugb2xkZXIKKyAgICAgICAgLy8gZ2xpYmMgYW5kIG90
aGVyIGxpYmMpLCB3ZSBmYWxsYmFjayB0byBJUFBST1RPX1RDUAorICAgICAgICBpZiAoZ2FpID09
IEVBSV9TT0NLVFlQRSkgeworICAgICAgICAgICAgICAgIGhpbnRzLmFpX3Byb3RvY29sID0gSVBQ
Uk9UT19UQ1A7CisgICAgICAgICAgICAgICAgZ2FpID0gZ2V0YWRkcmluZm8oaG9zdCwgcG9ydCwg
JmhpbnRzLCAmYWkpOworICAgICAgICB9CisJCiAJaWYgKGdhaSkKIAkJZGllKF8oInVuYWJsZSB0
byBsb29rIHVwICVzIChwb3J0ICVzKSAoJXMpIiksIGhvc3QsIHBvcnQsIGdhaV9zdHJlcnJvcihn
YWkpKTsKIApAQCAtODg5LDYgKzkxOSw3IEBAIHN0YXRpYyBpbnQgZ2l0X3RjcF9jb25uZWN0X3Nv
Y2soY2hhciAqaG9zdCwgaW50IGZsYWdzKQogCWNoYXIgKiphcDsKIAl1bnNpZ25lZCBpbnQgbnBv
cnQ7CiAJaW50IGNudDsKKwljb25zdCBjaGFyICplbmFibGVfbXB0Y3A7CiAKIAlnZXRfaG9zdF9h
bmRfcG9ydCgmaG9zdCwgJnBvcnQpOwogCkBAIC05MTcsNiArOTQ4LDIxIEBAIHN0YXRpYyBpbnQg
Z2l0X3RjcF9jb25uZWN0X3NvY2soY2hhciAqaG9zdCwgaW50IGZsYWdzKQogCQlzYS5zaW5fcG9y
dCA9IGh0b25zKG5wb3J0KTsKIAkJbWVtY3B5KCZzYS5zaW5fYWRkciwgKmFwLCBoZS0+aF9sZW5n
dGgpOwogCisjaWZkZWYgX19saW51eF9fCisJCWVuYWJsZV9tcHRjcCA9IGdpdF9lbmFibGVfbXB0
Y3AoKTsgCisJCWlmIChlbmFibGVfbXB0Y3ApIHsKKyAgICAgICAgICAgICAgICAgICAgICAgIHNv
Y2tmZCA9IHNvY2tldChoZS0+aF9hZGRydHlwZSwgU09DS19TVFJFQU0sIElQUFJPVE9fTVBUQ1Ap
OworI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig1LDYsMCkKKyAgICAg
ICAgICAgICAgICAgICAgICAgIC8vIE1QVENQIGNoZWNrIHJldHVybiB2YWx1ZSBmb3IgTGludXgg
S2VybmVsID49IDUuNgorICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHNvY2tmZCA9PSBFUFJP
VE9OT1NVUFBPUlQgfHwgc29ja2ZkID09IEVOT1BST1RPT1BUKQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb250aW51ZTsKKyNlbHNlCisgICAgICAgICAgICAgICAgICAgICAgICAv
LyBNUFRDUCBjaGVjayByZXR1cm4gdmFsdWUgZm9yIExpbnV4IEtlcm5lbCA8IDUuNgorICAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKHNvY2tmZCA9PSBFSU5WQUwgfHwgc29ja2ZkID09IEVOT1BS
T1RPT1BUKQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKKyNlbmRp
ZgorICAgICAgICAgICAgICAgIH0KKyNlbmRpZgogCQlzb2NrZmQgPSBzb2NrZXQoaGUtPmhfYWRk
cnR5cGUsIFNPQ0tfU1RSRUFNLCAwKTsKIAkJaWYgKChzb2NrZmQgPCAwKSB8fAogCQkgICAgY29u
bmVjdChzb2NrZmQsIChzdHJ1Y3Qgc29ja2FkZHIgKikmc2EsIHNpemVvZiBzYSkgPCAwKSB7CmRp
ZmYgLS1naXQgYS9kYWVtb24uYyBiL2RhZW1vbi5jCmluZGV4IGQxYmU2MWZkNTcuLjc5M2Y4YTQy
MTkgMTAwNjQ0Ci0tLSBhL2RhZW1vbi5jCisrKyBiL2RhZW1vbi5jCkBAIC0yNSw2ICsyNSw3IEBA
IHN0YXRpYyBlbnVtIGxvZ19kZXN0aW5hdGlvbiB7CiB9IGxvZ19kZXN0aW5hdGlvbiA9IExPR19E
RVNUSU5BVElPTl9VTlNFVDsKIHN0YXRpYyBpbnQgdmVyYm9zZTsKIHN0YXRpYyBpbnQgcmV1c2Vh
ZGRyOworc3RhdGljIGludCBtcHRjcDsKIHN0YXRpYyBpbnQgaW5mb3JtYXRpdmVfZXJyb3JzOwog
CiBzdGF0aWMgY29uc3QgY2hhciBkYWVtb25fdXNhZ2VbXSA9CkBAIC0zOCw2ICszOSw3IEBAIHN0
YXRpYyBjb25zdCBjaGFyIGRhZW1vbl91c2FnZVtdID0KICIgICAgICAgICAgIFstLWFjY2Vzcy1o
b29rPTxwYXRoPl1cbiIKICIgICAgICAgICAgIFstLWluZXRkIHwgWy0tbGlzdGVuPTxob3N0X29y
X2lwYWRkcj5dIFstLXBvcnQ9PG4+XVxuIgogIiAgICAgICAgICAgICAgICAgICAgICBbLS1kZXRh
Y2hdIFstLXVzZXI9PHVzZXI+IFstLWdyb3VwPTxncm91cD5dXVxuIgorIiAgICAgICAgICAgWy0t
bXB0Y3BdXG4iCiAiICAgICAgICAgICBbLS1sb2ctZGVzdGluYXRpb249KHN0ZGVycnxzeXNsb2d8
bm9uZSldXG4iCiAiICAgICAgICAgICBbPGRpcmVjdG9yeT4uLi5dIjsKIApAQCAtOTc1LDEwICs5
NzcsMjQgQEAgc3RhdGljIGludCBzZXR1cF9uYW1lZF9zb2NrKGNoYXIgKmxpc3Rlbl9hZGRyLCBp
bnQgbGlzdGVuX3BvcnQsIHN0cnVjdCBzb2NrZXRsaXMKIAltZW1zZXQoJmhpbnRzLCAwLCBzaXpl
b2YoaGludHMpKTsKIAloaW50cy5haV9mYW1pbHkgPSBBRl9VTlNQRUM7CiAJaGludHMuYWlfc29j
a3R5cGUgPSBTT0NLX1NUUkVBTTsKLQloaW50cy5haV9wcm90b2NvbCA9IElQUFJPVE9fVENQOwor
I2lmIGRlZmluZWQoX19saW51eF9fKSAmJiBkZWZpbmVkKElQUFJPVE9fTVBUQ1ApCisJaWYgKG1w
dGNwKQorICAgICAgICAgICAgICAgIGhpbnRzLmFpX3Byb3RvY29sID0gSVBQUk9UT19NUFRDUDsK
KyAgICAgICAgZWxzZQorICAgICAgICAgICAgICAgIGhpbnRzLmFpX3Byb3RvY29sID0gSVBQUk9U
T19NUFRDUDsKKyNlbHNlCisgICAgICAgIGhpbnRzLmFpX3Byb3RvY29sID0gSVBQUk9UT19UQ1A7
CisjZW5kaWYKIAloaW50cy5haV9mbGFncyA9IEFJX1BBU1NJVkU7CiAKLQlnYWkgPSBnZXRhZGRy
aW5mbyhsaXN0ZW5fYWRkciwgcGJ1ZiwgJmhpbnRzLCAmYWkwKTsKKyAgICAgICAgZ2FpID0gZ2V0
YWRkcmluZm8obGlzdGVuX2FkZHIsIHBidWYsICZoaW50cywgJmFpMCk7CisgICAgICAgIC8vIElm
IHN5c3RlbSdzIGdsaWJjIGdldGFkZHJpbmZvKCkgZG9lcyBub3QgaGF2ZQorICAgICAgICAvLyBJ
UFBST1RPX01QVENQIGFzIG1lbWJlciB0eXBlIGluIHN0cnVjdCAobGlrZSBvbGRlcgorICAgICAg
ICAvLyBnbGliYyBhbmQgb3RoZXIgbGliYyksIHdlIGZhbGxiYWNrIHRvIElQUFJPVE9fVENQCisg
ICAgICAgIGlmIChnYWkgPT0gRUFJX1NPQ0tUWVBFKSB7CisgICAgICAgICAgICAgICAgaGludHMu
YWlfcHJvdG9jb2wgPSBJUFBST1RPX1RDUDsKKyAgICAgICAgICAgICAgICBnYWkgPSBnZXRhZGRy
aW5mbyhsaXN0ZW5fYWRkciwgcGJ1ZiwgJmhpbnRzLCAmYWkwKTsKKyAgICAgICAgfQogCWlmIChn
YWkpIHsKIAkJbG9nZXJyb3IoImdldGFkZHJpbmZvKCkgZm9yICVzIGZhaWxlZDogJXMiLCBsaXN0
ZW5fYWRkciwgZ2FpX3N0cmVycm9yKGdhaSkpOwogCQlyZXR1cm4gMDsKQEAgLTEzNDIsNiArMTM1
OCwxMCBAQCBpbnQgY21kX21haW4oaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2KQogCQkJcmV1
c2VhZGRyID0gMTsKIAkJCWNvbnRpbnVlOwogCQl9CisJCWlmICghc3RyY21wKGFyZywgIi0tbXB0
Y3AiKSkgeworCQkJbXB0Y3AgPSAxOworCQkJY29udGludWU7CisJCX0KIAkJaWYgKCFzdHJjbXAo
YXJnLCAiLS11c2VyLXBhdGgiKSkgewogCQkJdXNlcl9wYXRoID0gIiI7CiAJCQljb250aW51ZTsK


--=-KusR8qS7pSQt1ByS3hSy--

