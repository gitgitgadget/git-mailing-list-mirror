Received: from mx0a-001ed902.pphosted.com (mx0a-001ed902.pphosted.com [205.220.162.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2544D25BF0D
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.162.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852593; cv=none; b=D/lYGxbaSWzyDqtimx7r6yxrND0UtREGC42yiWScnqu3r8oXkboIRPIlMNVIB2SGZKevyMPw77CbB8PzXtjASpFFgq7z2NOokggv4dqDKSVo40CUq/VuM8eyLaVW8Uan1GTCP09+z1iBXx00FY2zFqRGyFjCEVZEAQoZHr4Rlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852593; c=relaxed/simple;
	bh=Rhz46HmXdTmyUhVF81k3gpWqy2kQT1T7gQpckOS6LaM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hrZvLxUddYyiCcM6tuFL+D4YahRMUTlb5/RRnUjyv1brAjlWmFK6nE8p9gmbwEMyDgFBK84juZfKG6ulag0ab8yo0i1IyQFeiD/8cpKw4uYOUJ7pMNnlmNhaFcpXs8ZGsDrugD5e+sJmJZxAuwQ0INIUNlJrcSMuiEDGi/G0BRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dropbox.com; spf=pass smtp.mailfrom=dropbox.com; dkim=pass (1024-bit key) header.d=dropbox.com header.i=@dropbox.com header.b=jVdORjPf; arc=none smtp.client-ip=205.220.162.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dropbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dropbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dropbox.com header.i=@dropbox.com header.b="jVdORjPf"
Received: from pps.filterd (m0324671.ppops.net [127.0.0.1])
	by mx0a-001ed902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PBJJXT019195
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 11:28:22 GMT
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-001ed902.pphosted.com (PPS) with ESMTPS id 47e9pxujx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 11:28:22 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so7990967a12.3
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 04:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp; t=1750850901; x=1751455701; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O5sFLN3IrRXfuxZJCzE/4a1eQMrz26ZDKMstIoIBZoA=;
        b=jVdORjPfjusQJidfjqdMH7MjGnqITXI6o+QMTxWYuEaXyHcKiZWFhlwYc4QXRdI9OX
         m3QX3dxCZoWsj/YI7NMKg676KPE3AiYfKJLCMoITrWNAst33zMD/EUWU+XPWV0qAiQzE
         FQbl6WBD5e4BSC8M6Z3dbn3CgSFB6gzGg/m6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750850901; x=1751455701;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5sFLN3IrRXfuxZJCzE/4a1eQMrz26ZDKMstIoIBZoA=;
        b=cDswcPA8dJuL2Y/Y+vbYmCk3QZsIL2kwbfsgomVyrh0hwpgLGUO8c4wyBHhaoc+Z2E
         e9kprXThzjK+OFNlQUBIkSjZ0Lzu4D31H/tDAT5fSqvXqwlKptrOVZu3iM/i93Myh/nS
         OlvoAY9Fw3clWD3QQnyIuQdNfiEgodOL+WP54cMmNvuDv3dc5FyRZEqblTw3Aamf+El/
         VUrTofoHvpR/wHi4vxCY/m81QUgfOhRPSjqTafWPt0uI992azOt91ir32EjF6YqJY6sx
         xBpiAo1rSzrVGkbRgdxAWUF3Sp7CNO6TOWEBSbUCQLY48bo0Xk14x3wdQDGGpCBE5KPQ
         W5JA==
X-Gm-Message-State: AOJu0Yw7FfdqqUMlYrLL4cAWQRLVYbFPt8APMGoIznzBQcRtsVU8Udiy
	LbMbA/l8k8BFmkdKdG9RIDJjlqGj7jfbIKhjs+eCR+2BOsVbrbuCEvX/cI8KTEbfEyTvVWLaism
	9hBXIZnh7oHdkUFon9s+KcLmt9OXa6S7B74l8qwI8cVJWfCOm6H8S99U30YOG7haAe5n+qHDqDz
	1vsqf/kt7PstjBa6RCbQG5QgCK1Jtk2VNebSbC3aR0
X-Gm-Gg: ASbGncsJTsVb26XnS1C43uaESrGxyYpvZ9gjRN1Q6VdxNi7eXWXu6qqejE/PERlnXDn
	21toyEzoSo4phAUnuCP+8UVI1Vjc0T6ZqYUqMloqMjtEZEl1duYKAr8iqfXdGGllR3gHxxiQtC6
	vtnXJs1Q==
X-Received: by 2002:a17:90b:2f04:b0:311:eb85:96ea with SMTP id 98e67ed59e1d1-315f26227e9mr4534263a91.9.1750850901005;
        Wed, 25 Jun 2025 04:28:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3nFQty8NMpXLw6egvilN9MBlqyFK1yBAItA/mqDgiDaaR221+47yHtn4PogUxnPz0LWWuony6WZIK65Ndic4=
X-Received: by 2002:a17:90b:2f04:b0:311:eb85:96ea with SMTP id
 98e67ed59e1d1-315f26227e9mr4534240a91.9.1750850900625; Wed, 25 Jun 2025
 04:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Andrzej_D=C4=99bski?= <adebski@dropbox.com>
Date: Wed, 25 Jun 2025 13:28:09 +0200
X-Gm-Features: Ac12FXxPs7MIocIdzEuqa1Z1CDpJ8_-7BfsPvoedl3kIJ4ZvwVQhQzGUVSKK9C0
Message-ID: <CAHKcSH2_Xse3o5Cq88Fu2s26AAJGNJMGeSvgHAyp-RLruVPnJQ@mail.gmail.com>
Subject: Possible performance regression in for-each-ref in git 2.40.0
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4NiBTYWx0ZWRfX82FfP/F+yHbq
 LqF1mGzK1UUihmwWj/H2lftTJWwcTD8E29gWo/YVE169qBd/bonpP3uA524knYgm5Jd7RdPhlyX
 rzfZMrxAw8y6zJRtoxdOaVuHrlo86NeeLemTijMXiRKL4WEhSSOxpd6nOxIIWhD4Ndvgzz8plwL
 USM3biiysBGQ6XNRkqNF+1e8DIplw4T0svWHR3nc9vWGYV20dEydWo3eOiaWxk2VSDrdegSUZrE
 s7F1i8nuYoo87UN4Jf6JGr30hoRdQK9XFppcGkGV7FWVwa0mS3ygfQ964jwW9+wsMiYcODXu+Aa
 w7JyFiaEdqJxKL6brHV52sokdv3B5GZRDFqVIkAGTpw16HYW2xwfs5ZHvulBpy/qJBB5Sbv28mq
 E+/2FMMmVpDRjtMqS0ClTfYhT9dSDswdHtn17JkIaqLnnDkSqo9k8Iomv4X5wk6FnkOY0R1L
X-Authority-Analysis: v=2.4 cv=T9+MT+KQ c=1 sm=1 tr=0 ts=685bdd56 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=M51BFTxLslgA:10 a=kC_G02pF9r0A:10 a=NEAV23lmAAAA:8 a=__rO-Hmz00oE5fPVqDAA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 9rXTp6ZICR6Xp--w26teqzYhfIIbchp4
X-Proofpoint-ORIG-GUID: 9rXTp6ZICR6Xp--w26teqzYhfIIbchp4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=525 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 clxscore=1011 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250086

One of Dropbox SWEs observed that a specific git command in Go
language tooling
https://github.com/golang/go/blob/e515ef8bc271f632bb2ebb94e8e700ab67274268/src/cmd/go/internal/modfetch/codehost/git.go#L758
took over 20 seconds. Internally we distribute git 2.46.0 right now
but the SWE had an older version of git around (2.39.5) and observed a
performance regression between those 2 versions.

We've did some performance measurements and the command like "git
for-each-ref --format="%(refname)" refs/tags --merged HEAD >
/dev/null"
spent majority of time in function "tips_reachable_from_bases"
introduced in git 2.40.0:
https://github.com/git/git/commit/cbfe360b140fe92d9c4a763bf630c3b8ba431522

Similar performance degradation can be observed in git 2.50

Given that the command references tags I've experimented and observed
that the command execution time decreased with the amount of tags I've
removed from the local copy of the repo.

Context: in Dropbox we operate a large monorepo with around 65K tags
right now and growing every day.

The question is, given the same command used to be much faster in
older versions of git is this considered a regression and can be fixed
in future releases of git?


[System Info]
git version: 2.46.0
cpu: bazel
built from commit: bazel
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 7.82.0
OpenSSL: OpenSSL 1.1.1w  11 Sep 2023
zlib: 1.2.13
uname: Linux 6.8.0-1029-aws #31~22.04.1-Ubuntu SMP Thu Apr 24 21:16:18
UTC 2025 x86_64
compiler info: gnuc: 11.2
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash
