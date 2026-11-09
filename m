Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794236894;
	b=4pCzJ4Rj/5ozKrTJtnl2WiG4bpxBeWJZP1pr0rtNNneRWuLxGBFVa+VR2WjLp+dUSXKT
	 NmHcpwE3GYtO6tAMGISkYVQIip1KwJKuJi/YirucaOBWtnA+b6eiJ1FOHVpYJOQESK0xu
	 S93j1RWJu+yZPEp1FqoyyO0+SrKgV6VrtxQ7UncYAEdKUEf/Fr9Y3x0wkSNeoyYCZXm4E
	 Rd+csJcwd5/klDqB/4QJ/kjitncex5E8AaIt4dBkVj2HPytVrGu7USWHd0w28bpbBzcW6
	 zjHgfDfBnzh4WfBTZ5Siefcob/YlRKv7ITVQc2JzVtv7dXW+L4dL3Ur+LNBf10rkuLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=9ov/uBo7ELqsThMVC4w5jsOko+ihuwXRQ2OgolAgpZU=;
	b=XwO1lyY56TwloCa4sZBLPyre/Tm29K7IEBLO9doJ7CL0QYjUxw4LqbmU/FYFZP8opT/v
	 zS+jIyUcZsbdg4xtIGo4aL9dnlk2rWejMsyVv64SBHWqGnDbnhs1HkMRvRnJrYcTpOyDj
	 Uxf7ekHsbyu002UroKu81vXVo4gG5svPfdn+JxqBUdbWw5Edakv+Lj9iCzI/Z7mcIpa7e
	 JNZ/E/nuTtfuCc0s6rf2axfInp9dB7+9r/Sg7g6/G0vcbiwrkEW4EFF23h8Rsy9QAyHpi
	 dzbXN6fX901G+V3DShTifG7yvFvXZ5d3TK8ko8JbGB26tpcQG2MlIdGhBuE7onFNNCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bww/c/5Q";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC8606A335
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBFC8606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bww/c/5Q
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4922dbcee23so508992f8f.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 07:08:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794236892; cv=none;
        d=google.com; s=arc-20260327;
        b=SC5YZrwac1OgmOmlZq5qQ6/6QmvUS1oyyF41C3SpOmIGOnrzajwDm11g13v3UdsTsN
         3TR6n11TfPYDuXGU+exM9w2JVTFN7R7xi0d7pRgbV4FfYUEoqrQeeIPG2Fq+1HTfcAJa
         vnKYNYZtff1ai64dmLwazfJiZB8K2fR8IUvN7EpMg8GDGji/4EwbCDFcrK5k8m0JtSdy
         UGYkfY6ecctSfASabpaSKitgsijRkajB0Tx3wNWOWqRLs6UDiCzFAdV6cSSIkQ2Ft4fB
         pcQyN1EFcAs8UYeIxkrpGrWhGcVSZ05V3zaBrlvMOCAb9UxGm1cxOEgGItxCclIy/clE
         PwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=9ov/uBo7ELqsThMVC4w5jsOko+ihuwXRQ2OgolAgpZU=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=ej6h7hpf2IZLtzmForOL5W1QjThgFMJY1B7q8xc2pQKWuCCqMNfjQQYEViqcJsd3Ci
         s+TE0qp28YXeaIZevZUPq9KmL5ly1KDNEN/hcxX4mqKkDjeEDf6syACHoEYWX53YrN8g
         9HPJDSgOIH8xiu3f3BPIgZ79xDEi1B45YX03N+/xNkg2h2hPH0g0buc6PhxKso+hdq3O
         5hv8lAqlwxs9xdKSo/sfzkcfVGD8gYySda/CSYuf3K6sPIuosHLvMdhx/cqUGfjkH7LB
         ESFqz0PbpWNfRNLGJBT4WwNHOFR3JMK2awBmiuAg70fB/9O2GY3gNyIrvKSNzH0cFMvR
         Lk1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794236892; x=1794841692; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9ov/uBo7ELqsThMVC4w5jsOko+ihuwXRQ2OgolAgpZU=;
        b=bww/c/5QrYJlX+YmgoUplNNsExajp7buQmS9/E2BD0AFD6iQgpu3bh9RrKhE/e7XQs
         KJKh/SYojrWdmOhiY2IOBJBBxmmX/mLIAjSLs1Xo8UBB77Qr0KimgdySaUFlupokPUST
         a/6oS9Ha50x0D58+hqwXt+eQK/GvPpdBLR1nOdYxm/RgrHeuD7opaZaonXH6JDA4b+Zu
         rDopyH4PNMZk6DUqbWhoSYUZttfsOBZjdH0M9vvb7RurhSZyUOOln+/FUqkOR/sscKg0
         8jDY7RmkImqdHsBYfO+UVq000bl5b04o9WMz3wpDhFhfbmsP3Llz4+Gnfvyly3KmpkKb
         zCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236892; x=1794841692;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ov/uBo7ELqsThMVC4w5jsOko+ihuwXRQ2OgolAgpZU=;
        b=v/4uxio7Q19/aP86YerVXRFGpW9TZEXXJzVAw+SkpFZhSwe/V4QfzKhzH3yMGHs1US
         l6Yku+KzcRMLqT/htgqcwFhvCKGzpo/jU+uKQnI1VRKBkOAjKg7lnbzu+q3CI/kHRis2
         hX/F420SpsKW54XWr4wrWrzcKmUpBeleRYdFmbQ0GD+HKsOUS1t6isjH+AQzGRyYCeC/
         h3lk6tD72fjSV/QotRg1CNyswa+Q8zDeJnG6fOVYPtsDBYi1mmCiEURpjHqoSFguOm7A
         miyKLrWUyEDEsn/W1VwzctKnqworzvWxcKXwkESRAF0oymU0QQ5RDQDngjcb1sEBtRkf
         /w3w==
X-Gm-Message-State: APuU4Z9o3a9JmUNVfSjjgMUDbVWQHdAtd11msvngf7oGrV/gDLu77gF9
	daRSiHuxypU7nBbNzWfTccb2qRg13EW/NW041BdnAPbNrtL1/JR2DjC4n2TxnT9EMTLTLFA4Pfw
	P/tvXoEoEGjH8kYIBg1Y4SxJ4MKbuWyiXlw==
X-Gm-Gg: AYBFou32n3jLq4UbtK0miwOaAYnQNBuajcLzYnTt1S2ib8w6NO+UcI4wzHie4n8FvoT
	hjiOsv1U+iUu8sF3H3sthW3uRdYULzBR65XwMJCFs2FDESFjg3lUu5oMT26vLcxJrx6JyU/xGhv
	wgZLKTd5LEZzegJ1SR4mp2MXUB5wVmIW5RRNypgdKbYLoW+yXY9GT6Xdc3hzAwFQuvKg6usapry
	gptzeYhg23uGqTVkYzev//5tg+qw1EWwchvkg6AeGEiCZkILsAUdO6v14Jj9zQgyXO+Ovy5nFBI
	oBKZqa/W1+VMIFxjjpzCWfjuUhCJo8J/2nFSSHsxH7iEeYiw1SyOKh+KEH/v22WpOJ+XmE+eYy1
	xaz6Bpf9HWI33Kwy9FTe2CvbEpxQUJIGVhso=
X-Received: by 2002:a05:6000:2dc3:b0:48b:db7:86a7 with SMTP id
 ffacd0b85a97d-495846906b2mr7214115f8f.50.1794236892070; Mon, 09 Nov 2026
 07:08:12 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Manoj <manojkumar148700@gmail.com>
Date: Mon, 9 Nov 2026 20:37:57 +0530
X-Gm-Features: AclHuK9FED4nmsEpDAD0futP1cZRLM_9kCoNfC16zdC1L2qPi7lOrfefcivoIwk
Message-ID: <CAOVdN544jyuLG7XNE8jTBeA90iSBS_NanW-Cfn3XgOqTFgQJEg@mail.gmail.com>
Subject: [GSoC] pack-objects: plural-aware thread message
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm Manoj, a third-year CSE student interested in contributing
to Git for GSoC 2027. I've had a few open-source contributions
merged, including uutils/coreutils#15558,
kaelzhang/node-ignore#175 and bitranox/igittigitt#48.
This is my first mail to the Git mailing list.

While looking for a possible microproject, I noticed that
"Delta compression using up to %d threads" in
builtin/pack-objects.c uses _(), whereas the path-based
delta compression message in the same file uses Q_().

I tested this with --progress --threads=2 and
--progress --threads=1. The message appears with two threads
but not with one. I also found that ll_find_deltas() returns
early when delta_search_threads <= 1, before reaching
the message.

The path-based message has the same early return, so its
singular form cannot be reached either, but it still uses
Q_(). This made me wonder whether the first message should
follow the same approach.

I understand that Q_() provides plural-aware translation
based on the count. I'm not entirely sure how much practical
difference this makes for existing translations, though.

This wouldn't change English output or runtime behaviour.
The original message was made translatable using _() in
2018, while the path-based message was introduced with
Q_() in 2025. I also understand that changing the
translation string would cause existing translations to
need review.

I checked current master at fb255012ac. On 9 November,
I fetched origin/master, origin/seen and origin/next and
grepped builtin/pack-objects.c for "Delta compression".
All three still contain the original message, and I found
no other in-flight change touching it. I also searched
Lore for existing discussions and patches concerning it.

Would this be a reasonable microproject to work on, or is
it already being considered? I'd appreciate any suggestions
before I start working on the patch.

Sorry if this has already been discussed or isn't worth
the maintainers' time.

Thanks,
Manoj
