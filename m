Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416270;
	b=TJMh/BizdBFUlfkJgy/Xa9UHV5oq47LWs5QeLsBEi2T+DPhlZwARLwg3lhSdDSmw4ko4
	 1/gTbWie6c588Dq+jlZFxM9zPgMVzpFgfL9apiA3r3FGqP1DH/jndiPq89sYJ9/wDUMq5
	 b1Sn5o7rRkFSYzGX6wLspmhxB6TV+1A6iUrLQOKUirIL0pzE4ZWvfbJ/lnl2ex20WDZtI
	 7r9q3O1jgIHHdwafYrIgkktgD5qO/xOXE/lhLwAeCVXnZgBv+Xa7cbOq7tQ4qyyUiE+Pe
	 zE/I9UZwQwI+JOXuesy1Is/VO7nRRLLeZZ3gye831H9pX+GhtDO0WwObpqYqYxLKndw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XbGKXLC2NMPU/w93QkZU0bXkptOmYDxf6TnTRBu1uk0=;
	b=3RXIE4VgyE1T5EHhXGw5bCDXKQNtY0iWjrpYFBhOHcCQEgI9ZkHeSZXiIIYUhmbZYq5R
	 9QDjo3/cnW/Vvaw2G5AwLNRHmcGT/9D3xDWXeMpmSQsNxKx9F8FpTIM/dhbYkak4jA55S
	 IsZHvdVG+0s0JrUnbjYHNAQto85SpECqkKQT4pDEiMjeETSnYt3oPvgAI0Y0Mf2HwlHvP
	 8LxQj2XiXUSxGUkZtwvGWylyVEZ7csDefyqS+asCpvQ+tgR+cNDUE/LRAGjskOKETcYAi
	 YR/qZ6Er0bkPaLmz0Z3Nc7xbtHHbs4hVJjt8IB9/I8D6w6ztixFD6P+NXCg08OUl49w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bRNhU6QR;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA604606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 06:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA604606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bRNhU6QR
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so1352935b3a.0
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 22:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416269; x=1796021069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XbGKXLC2NMPU/w93QkZU0bXkptOmYDxf6TnTRBu1uk0=;
        b=bRNhU6QRjrYMnmboAJPEzjgMfm29c+c+2vOIbGwgewrwT5y0j5jaZ0iGYhYixCVhFZ
         Si/toXtQ+zYfFfWrmPC8BQuEE4SyuME4b4rz+/nALQi0ZtHXyCLZJqTkx79tXRxv/hIb
         LgUGQ8r0D4fHNk2eyp2p+lHK9IwmKhQqHeMoJHDJceFcLqLeeDzYwRVyFs/V0PxQEVY4
         EGKfwjYt/ZkIUP4IM1pGk2/QelFS3NVmS52LAlIs2jl9YTDiaRtYkzE9xVlHehcP58cT
         Q567IHl6TI+Z5j+aNBETHZl8+yEmZ1FwB05Bp52S4qQdtK06Mp4rFUDaJd+wr/2XFCwW
         hiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416269; x=1796021069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XbGKXLC2NMPU/w93QkZU0bXkptOmYDxf6TnTRBu1uk0=;
        b=CY3xQDYWlTVwWDSxcbbemPKUbb5v+tERrl6CFQ8Em0Ax191/vwGR3Iia4Ys9cRmjAi
         X3R5k8GvOkHDrBTHh/q7xfzgsZ9OXqmzXC+dhDm3QQK19km3YLXQrxSFHGpesvJh4Jx/
         6hIMb8UVL68FlhBHWQo9kB3WON8eI/AKlWcfkmkr9CRr82H9h8MVf2BRYV55JDzeTVdl
         dNhT0MaElWMIk7mU2qOOcF+vUY3QdYPcnF8grXd3T3mLW07B8IkB+1I765UM75gnAwBn
         d1lzI/+C17zZgihEKYbrz3yiXdYX2wJUg9fdIm1JMavqPwC7U8O5a4bs80s2p8RfMABk
         ekPw==
X-Gm-Message-State: APuU4Z/jB5tx3zNon3xERb8R8Qf4Cg/l49/CjfrunwfsM6Ycp9IIf5VX
	Ms2AxIzIaiRhUzBZClQDOr/W1DzPo+QJRTygCL/xdCYyMFPteo7bEDUGwvd5VEbL
X-Gm-Gg: AZFdTZew8jigdUg7sMKyICUFZbYWPCNYgKHi51QqVWj8828eHT1zecBoRSXVrro884Y
	BElCShkRKkEBGWhFxCvaKYLWGWwwqT3i//da4Axet+lTYAOSFxnpgYxRGk0TJ1r75ZaYHjYqUl2
	u1J/iAyOCdvnov02oYCj9lpW/UAlkVVW+p/po2h22YWXyBRVx3y/7GMNjoIndrPHvIPKxfkLlMP
	jeDSBAfjSa+zxVeBVwE63ZDJH4unFIuuAnmAMxddBNckDADWP+9XdQGv0dWjWOmcaUeeArIwT89
	71OK26fsiYRFbfaGsjFncI2ekFJY31Q6CbMBzQEfTECWVij2+Z8MS6iDIGhGGmjrW6JyxVChunM
	pZA0sAquqEzz7uCpm2lpWJuwZmOMtZZvWCbuAzANHQKP5RqbCrFBYfQGDRBo+Q2nGOy8xzrd3xV
	rfjdXSXj7cla/+m0Op0YEZK9VeIujSsZ19IcN3a2LMpIrT/KEMtSTX8gMCsJ3lSeJbthD8FENLR
	D6iEeoi4qwvcQ4PgAr2chN1OsfGpCbGi9xQPA0A9H5RST5gGXqmnzwbWx9rCIL2C8oeob6nWZUp
	YXN92LUsz6FVgAw7Pe2ziah9VwpSl4PWq1bFN7+Cmx0VtivOmumnzJBO66MCKUP0irmmYZCIxLm
	j0XScmR/2XkkD3slrWuyP2Q==
X-Received: by 2002:a05:6a00:4b03:b0:89e:3ff1:920d with SMTP id d2e1a72fcca58-8c87d01fba2mr8920300b3a.45.1795416268924;
        Sun, 22 Nov 2026 22:44:28 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1e2f3sm4798671b3a.54.2026.11.22.22.44.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 22:44:28 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/3] bundle-uri: do not die on unresolvable relative URIs
Date: Mon, 23 Nov 2026 12:14:19 +0530
Message-ID: <cover.1795415793.git.aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105152842.566318-1-aniketgupta3001@gmail.com>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bundle list can contain a relative URI that cannot be resolved and
one such entry can result in the entire clone dying. This series lets
the bundle code report it and the clone carry on.

Changes since v3:

 * Patch 2: dropped the part that hides credentials as Stolee was not
   convinced it is needed. The part that names the URL that was passed
   in stays, as Patrick wanted. The patch has a new title and its test
   no longer uses a password.

 * Patch 3: fixed the commit message. Previously it said that the
   clone carries on with the other bundles. That is true only for a
   list that a server advertises only for the bundles before the bad
   entry. A list given to --bundle-uri is rejected as a whole. In both
   cases, the clone fetches the rest from the remote. No code change.

 * Rebased onto current master, no conflicts.

Stolee's idea of having a toggle to bring back the die() is not part
of this series. Happy to take that as a follow-up :)

This conflicts a bit with tb/config-null-values in next, which adds a
"!value" check in bundle_list_update() right above the line that patch
3 changes. Keeping both is enough, "!value" check first. I tested that
merge (t0060, t5558, t5750).

Aniket Gupta (3):
  remote: add relative_url_gently()
  remote: name the original URL when relative_url() fails
  bundle-uri: do not die on unresolvable relative URIs

 bundle-uri.c                | 10 +++++++++-
 remote.c                    | 34 ++++++++++++++++++++++++++++------
 remote.h                    |  8 ++++++++
 t/t0060-path-utils.sh       |  9 +++++++++
 t/t5750-bundle-uri-parse.sh | 15 +++++++--------
 5 files changed, 61 insertions(+), 15 deletions(-)


base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
2.54.0 (Apple Git-157)

