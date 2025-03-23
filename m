Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C518F2DF
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742763895; cv=none; b=R15/z44qPNoEvuGpOctlyS/e+UIePjgvNEnTTR8WRfrlc/G8iEyv3xMctdI+sRh/iJzDI4fiLF7dUU4sLnEAX5JUthU+g4CAtpFU3iLTTCThSZKareUvDE4mFYHvKQVJ/Elr3QEZ8IsD/QnZzoKGqvX4rQlp2g70ytLuYZstMoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742763895; c=relaxed/simple;
	bh=2Dj5ovAqfDY7M3++Tq9DM5l8qCR6h1AW5oQjbpmXa38=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cP6Gs3OiuVV+h9R2axnhDGJhyrQ25/CUCp9wv0CcgPQ4pl+trg3nvqwUebvPGkKWzWIwXeN+XbYPhaBIZg1DLUtsuNCpIF62x9YkUVinmkfYyXua+Tl+r2AnKcwSlLgtr6+c1HmZpHSk5KnDy8NKXhU375sXWhS1T18/rSxvF/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=UZSY0Pyd; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=bknT7bZD; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="UZSY0Pyd";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="bknT7bZD"
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-85b515e4521so123869639f.1
        for <git@vger.kernel.org>; Sun, 23 Mar 2025 14:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742763892; x=1743368692;
        h=content-transfer-encoding:message-id:references:in-reply-to:subject
         :cc:to:from:date:mime-version:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/V3Y/PGSiUZMBlj7MGKkFF0BP+00636S+Kz6VCt54+c=;
        b=YAlgnzE67Dcp8HX/BckO+cBu7BpNM66DqNxk+fNNFvHoXSgSrKMGHu4xF8Fl15tgcT
         FCrMCQoFJ/Oj59PSPh6ZmD51fwSjtjJ874YmIDfaKkjEN9GwSXKbTGD1N8rzhguH1oeO
         XFdiU/U7Dt7RNnUwuZsLW52ASrAjx1ICfBdgNfdBRGZLtHI6N8d2GRoi+WNKfkeldp3u
         2Q8SogkjkU+vwecIoxKpS7btPN8HVEtizc3WIbBLkuHki8MqA88YmVRjNdpzn5klftWf
         8a9LAu15ZLdVudcDQB5w1Zow3/IvNZLFYALmWIpUAx/PNRMBnhLyG7hJpn36pj6gcOWS
         jGtg==
X-Gm-Message-State: AOJu0YzG9ZSRlamBfnyuwPuBfRkVTlAHMh4ofk4CHnZyUz6hFDg8IbuS
	tsBBtIkPh0KfO5ylu8OPOWkGtK3ZXw38QFKAU35aXqsYJOB2C3gF386sqTtWBsThgE7iSkhmzxK
	timIdlL8SdXVtoFLFXesIWZ9P7rlLrgsSyyOvI8XDly/4oe70
X-Gm-Gg: ASbGnctqTENf5uAxC5pZqZSHzlYpCcL4zZJCEjGkM9MGdQIc2sX1hiLmJ3z4keUjp7B
	TEZojcBaVxciS9GGGtGhKvu7jkGB10clPsvLQviGDuKetefrB2fZ0FN17ohOUBgxrkzJuYxN6Cz
	B3qjZnaxKmIjR8pzQBBU74kzRITUivraiLUZYGTVlv3Db6+IxsttX49Jy+m6dXPE9dwWLtgD3dM
	jpUmCF8Z0aJINvtRYhHZ6yaTTXQn9RbVtBcM8bCoingifVFUerygIz/ancEn2Ks8vnD/x0shPje
	XG/l3eChGao61bCW5TspSYoHPl0JDh7Vt08kcU0h
X-Google-Smtp-Source: AGHT+IGEnZ5/QG6cjsSDmdMznW4L7gG7L5K1Pw5exaprujqMyLf7hRhi7bdWGLeL5RII99rg/HIyC2TyHwe6
X-Received: by 2002:a05:6602:298b:b0:85b:3fda:7dbf with SMTP id ca18e2360f4ac-85e2cb4607dmr981933639f.9.1742763892397;
        Sun, 23 Mar 2025 14:04:52 -0700 (PDT)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org ([2600:4040:52f1:f606::8])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f2cbf28b7asm280505173.69.2025.03.23.14.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 14:04:52 -0700 (PDT)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1742763891; h=mime-version : date
 : from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding : from;
 bh=2Dj5ovAqfDY7M3++Tq9DM5l8qCR6h1AW5oQjbpmXa38=;
 b=UZSY0Pydc+MnlkMjhVU6oYo+oHaGavakBhxBPb0THz8Mo9pMZjDu5SEp3pm2WgBnB0IpW
 Ib5kaR/8PwqBSsHBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1742763891; h=mime-version : date : from : to : cc : subject :
 in-reply-to : references : message-id : content-type :
 content-transfer-encoding : from;
 bh=2Dj5ovAqfDY7M3++Tq9DM5l8qCR6h1AW5oQjbpmXa38=;
 b=bknT7bZD3HH+vVFXYTnKXdPTC3YtQuwUQoO9RIuQnrSxTxk0uPp91NZeEP2jjx9mPChBo
 V4fiED235KbM9soCgtm9z41X6CShYOOE2DZ5ArvCzJo4eR7pei8bkOhtnnazTXdBe9fZFzJ
 ojkPED75BpQ1Qvyyfxed6p/wrb6OS4JvYymBdHtPqI+Ni9Rr79hcf47wqU/BTKC1stpmAoA
 YYvPtWoKKwrUWWXcbpL7v3KtDKPitewp/HbqR6ADl2sdAXiRQBC+n+cp7khR71PDGlU65ri
 JckjgloZ10R9wXaBs0/KCB5sOkzXoGjlRt5aV2iknwzFdA0XkQGex9gICCpA==
Received: from webmail.mandelberg.org (mail-web-d031b246.virgo.mandelberg.org [10.0.6.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4ZLTGC40N8z10dZ;
	Sun, 23 Mar 2025 21:04:51 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Mar 2025 17:04:51 -0400
From: David Mandelberg <david@mandelberg.org>
To: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>, Junio C
 Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/2] completion: fix bugs with slashes in remote names
In-Reply-To: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
Message-ID: <17274df2746d304db876ebd82ad8d932@mandelberg.org>
X-Sender: david@mandelberg.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Another minor change, as suggested by
https://lore.kernel.org/git/xmqqo6y3dzno.fsf@gitster.g/

I'm not sure what the expectations are around updating patches that are
scheduled to be merged to next but haven't been merged yet. If it's too
late, I'm happy with the previous v3, or I could send a separate patch.

David Mandelberg (2):
  completion: add helper to count path components
  completion: fix bugs with slashes in remote names

 contrib/completion/git-completion.bash |  49 +++++-
 t/t9902-completion.sh                  | 206 ++++++++++++++++++++++---
 2 files changed, 226 insertions(+), 29 deletions(-)

-- 
2.47.2
