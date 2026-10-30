Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793356995;
	b=syCvdWc71ZRz+wa353y65NQdxYWDNsbPg7qC1S+dzwauKMF4kRNdyUry3kP5KIVpF8f7
	 pyDZxczcfOWOHvsVchKPEVgWPqv8P0S0QKfjLm5n+5LpmStNmYxXE8LVs9KLrRK2yV9vx
	 ltsSyr3jDT8x+zd8kIxprGBDaR4wrz74G4zdVOPhJOkkcizFflsyEt7DVPN23t/NY85qY
	 5vsW1AXPA5ZKTIYPOSHsvK9mFkfrN0c5sIKEMSGosIGYrRYhQ+Pjkfhh6IYluyGLiApyV
	 oBvX0J+ANtviXfvMcm+H3ev2lYxHlBuK2ARTUme2wR9uq3MVDZ+jTp12LUdIlzeP3ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/k/+3mnt9I3Ym9Ad6b2Iegv+E1b8+Rnxzk9SDNi7+nA=;
	b=2JFBUtb1/b/Od74FoiMw/gX82P+pMmkSlPRmVWcCFroiE6wy03OFdXPOOagjpNn7my1f
	 SlVe8/takk9vxFWkPPHLzl+aV5VFD4ukqOkiaU6Axu1dqEl099A63VmO+ZPott82Y4r1A
	 fQi2oAZXD9yqnFlIpGsRZhG2QkB7+LxbONewARt+cjLg3t3ypUgZuFSKonu55Ccv74y2Z
	 x2QDt9p9dYdbKpCEV3r9VC/i8SMk+DkW5K+eIwYXaAOuz0bRUQnHzm0WhdZw7/ele83F/
	 eQhWoXRnuMbTZDoq13rmtEawAhb3H+28U3byHu8dvLT+bdQTuVP/oeEc54i3LCBQe6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=niwTLz7E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4C9606A31D
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD4C9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=niwTLz7E
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ec3561b07dso580100e0c.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793356994; cv=none;
        d=google.com; s=arc-20260327;
        b=AyPXKsWj3edog95/vjZUW9yg4uNORDASj2AVTuLFQjj/9ZrwSJBJ/ERmYrR4FG97sF
         RuCgCK9+kSRkTpKSAv5LaGrdaQxuw0vVJ8eCrCWNqsbrdfdelkCbrusKM+6tFc601H1V
         A+nVI50i+HZ8b21hxjiNDenfeIofC3ROUCmUv3QvZ4qzBAkhkYM4ruc9jUPemybUpwuW
         eiPp6+z+MTakXglOw/3u85EjlmQeY2vdyt5HAsXAu+9fZl5+SwhGkhW3s09wCD0q7i4+
         DAInQsM1oFtwqHg8VT62BhYqkr6vpnqB9sU3pTdalUXJFEtMnk9448AmFcKXViXeratC
         4X2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/k/+3mnt9I3Ym9Ad6b2Iegv+E1b8+Rnxzk9SDNi7+nA=;
        fh=Qgfa0I9v386oGP6YvZo5TyVvAe04L8tVR6apI0QzwQI=;
        b=XXOTv3oOfqurlxbUrs8isdm1PhQ9qc2uWRTrEq8Y30MdqPQDwfHclf6aeMqcl8b55c
         XxZs7pqarzyj8/QVtit+DnkOoVd07v0P9EiR/XEMlNi7rtrjQVHUutMkB2dpm9xGB6U9
         bXvRAGzre7JQarVLSbuFNqIbg0vHlF/pzTEs0eDGVhJ1DEwiJpFfFp5j/BW6ZLnQXWeb
         x/FNmj7MBrxgOOGeeJvXu/bauVfBr5Wpu+qd+QFKnMlSOss8iPH4C9nBgKHKEZWm51pB
         7/Iaobf+l+3oVqvH6XWXRT9CWM0jg5zVLlAUPWpJEkZ5z7KYpHKYdJmqLbaNbT0u2JBf
         2vtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793356994; x=1793961794; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/k/+3mnt9I3Ym9Ad6b2Iegv+E1b8+Rnxzk9SDNi7+nA=;
        b=niwTLz7E6CdXGxw5+3eBZMVpKUZIRe8jlhua5z8dCZfIEd0J5KphfZ0uJT4jqB9mQr
         NNVyHdoK19zj4QMKl7pKExOqoBQNQ9tNQsjuVTMxrBZ4J+hbyR0G2iPSAGiGiHUvl1m0
         gWa4dRRv6t58YykdknvtQe26z/l4ScKWgxS4eveElEnswXqIvVLec7a6ssHUKJZhCVAv
         PDEHQz+8bSBuxZdT/yQGgLwhSER4Bte9r5m6r0+j2cE35diCn+CaDHlW4oyV92dbS5Z6
         AIRDwZbTzMIFp5HW9VP9Nh2vUoiqLBhOsSnloCDJo6r3vXR9UmVdSH2NxUXwjpq2dUhA
         +MFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793356994; x=1793961794;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/k/+3mnt9I3Ym9Ad6b2Iegv+E1b8+Rnxzk9SDNi7+nA=;
        b=g2+cs44f0vxRri1F1AneffT9tnRMIQw9icI01f8TQIiu35nOgqfIh3g4qNVbWP9ltN
         O1oxCsePPhX9QYx3DasSDqne2gIzrUsZcRIs58Zszg5XoOJR2V0zcxhPf0aODiYatN+L
         OL35XOkIvVH7anrpfZ/ZuGfh82uiQtd8URKKJDgTF0r7QSkmanp2n28ebmGJekF+1TiF
         wzKeU46hALDD7INeWa6q1cYo8WeViuFcDlSkRmdgdjo9IeOwll136tQ7ThDQReTLGITY
         M0peRiwpUwTmRqSM6mrAe+1i/xtn1kiizbiZ2cP85OPe2Ton5E8XVsjUY5P5CZVOczwk
         7iMw==
X-Forwarded-Encrypted: i=1; AKwUvBwgbxgMekLlwgwzoY8t8c5vii1HQJXHQcQ7z3s39oSjaXnHCo7BWZyKLJbqit0VjGXcx2E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJi4qLZJJXad7600+bPgNsCYgGRtrDcx4a5YgnOQCWRRZCpUrmX
	lDgiYpdGbYBsV2ulV2AQsS0gK/zfOCOaujThdqZKyKeRxnOKvSb6s68wYNGh+bluZKsrC/+B8Tw
	kEJqgC1vjExTG6Id4mN7vz4NulkHRnGrBSw==
X-Gm-Gg: AYBFou2Ew7aeA2R3IKZmHRFrfUK1+OXfUmADZ2p0IaR5W73o89CDvxDkPaZIjXCA3iW
	glGY1Qyh0Kqu9acXFvDAtiE8nZbyIA5zbddfUfEdTfGPQLNQ3ULxEsXHTun5saDrL5DBbi5FeaC
	5a3baMmlEJyQ9xtz0103N8NWHwJafMnTMnOyZNqDiXUCxmcAKt10Abrp0PoBsPcg183vJ+xXOD8
	zoUW8Bm39vSDWZEPvZ8cjdZZwxXCNlYh/APmUfghWLBFfOgBhAcgs0DIRTypI8E0s8sNCkIoDEK
	bobb/4fq1XktKFv33JpTM4g5UGBe+1MWXlGaWgbJMRvYM4soqLhCBazy7ruIrkOLIqVEO4a9Qfa
	iQiWE35jmcHbL58G4wZhNYLqQ6CO9EDJSXTNy2Ujf4HTgaZBzcqQWOIXWxxLKj/GOIPRYVylEPm
	ibbXx7BXIomWd5Q5fXySfPRYVw5Z8=
X-Received: by 2002:a05:6122:e193:b0:5ea:c984:5ad4 with SMTP id
 71dfb90a1353d-5ec6851637emr646317e0c.2.1793356993845; Fri, 30 Oct 2026
 03:43:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 19:43:12 +0900
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 19:43:12 +0900
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261029232220.1245827-2-jltobler@gmail.com>
References: <20261029002413.3291184-1-jltobler@gmail.com> <20261029232220.1245827-1-jltobler@gmail.com>
 <20261029232220.1245827-2-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 19:43:12 +0900
X-Gm-Features: AclHuK95wIUISREq7r-qwS-D8iN8qv42UlzGx6irEBVPlyBVEJ06kbjDzw2QmSM
Message-ID: <CAOLa=ZSs05h9h+5+tdE=PA3ebj8U_8oj+qcstxZVcefpSY+Rcg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] loose: use finite timeout when locking
 "loose-object-idx" file
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000009300e5065f0c7644"

--0000000000009300e5065f0c7644
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> Loose object index file writers first attempt to acquire a lock via
> `repo_hold_lock_file_for_update_timeout()` and specify a timeout value
> of -1. With a negative timeout value, the lock acquisition retries
> indefinitely while the lockfile still exists. If a process dies while
> holding the lock and leaves a stale lockfile behind, every subsequent
> writer of the mapping file hangs forever instead of reporting an error.
>
> Introduce LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS to set the timeout to 1000ms
> and use it for all callers that lock a "loose-object-idx" file. A value
> of 1000ms matches the default timeout used for "core.packedRefsTimeout"
> and should provide concurrent writers sufficient time to acquire the
> lock.
>

I was wondering why we don't use a config here too. Seems like Patrick
also mentioned the same in his review. But this is a good middle step
and we can add that in later.

#leftoverbits

[snip]

--0000000000009300e5065f0c7644
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f97da8c6081a1202_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ya2RMOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdzlXQy85U0RHV25tb2dxbDd0ZVpwNzVwc000L3hXUApDTXVpb01Yb05F
d0pITk44cDhlMUZDVWZIeFdkVm56dVNMVExJSzNSNlNkcXZRbWtRWktyMXZTbTU2WmhRWnZvCkxR
YXBTckthbGJIbmpIUmVCOUtJOCtFMkdlQzhoN0lIZFBWZDhkVWs1Qi9ZNXZnNERueDk3N0hDeWNZ
eXcwbG4KcWFKb0M3RDlic3Rzb2F6TTNjNi9SU0FwT0hWRVZqQ3ZST2xXUEthNTVDTnRUTlg1bWRk
QTcrbU5qUTYwSTZERApQanJoVHVHQUVCM2hqam42b2VnTDRldEU3ekZOZll3WS9aN1lTK2d4TlVV
ek05RlVXeXVMTE9CRkhRald6VHJnCjNSUjBmUXZNMnRLeXBkd0c4M0Q3TVU4cG1hZm44TUFyandY
blRpdjcvTXBHYjNpU0xURzZwc0NHWTZQYUNmMGEKR0l1bFRMSTFUN0VqZ0duaFNFbzI3aVNYajRx
WUNsdExEVzRPQjQ4c3dQazJudi8wSUJCZUJUOEdBZU9TZXZzbgp3cXVERmt5Zm9WOVU0R2hZVTl2
VFhFLzZKTysxQ0pXdE9BblhHWksxeThMRUFPVnBxd2prUkI5b2FpMEJ3RUlTClBhTlRxZlZZa1M5
NXVheFBYSE56aU1RSU5jMlVrcGtjYkdRSGk0Yz0KPXdCUmkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009300e5065f0c7644--
