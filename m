Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488391;
	b=dLRHC0F+FpIqsIR0d3myYBhE1JnV81wZ1Em1fOLiNgZp6FN+8+0CfdrxMWq+L4u6VmSK
	 J/WBN2t68H7sAWFnB4BdGV7HAHPN0B1QH28JB7ubNEZ4X/kQEj9s8F3Iv1+KKyZfAOwdq
	 dga32BeBL7uPEw0v+uGI8GP+RfKTnISVB0Paj2F5v8odS9JuEGCmDI4pUv4yIGtEYxrBr
	 lXoHiJo8LnWYKc5U20yGnHdVz14yC9YYZkQrMClZYiRNG+v1ZdT0Ywvjv17y8mXVaEwxx
	 qxYdK8WMYdgNLlyRxPdAefVMVDxaVtTZfVjvAu+4opWrgL9p5r169TVwO+GbnTZgiXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=SOS1D3nqmqpMZj6MIS4Xt9MTMm5In7I705zFpcBy6lQ=;
	b=a4phe2VsDfFbxh5vdxTaAknM4nbwuPKfl+S3AUo5jJLNv1h9AOYiVkLl/sxxLgyJf6Kd
	 88cyi/C5PIjMGZCisJEjm4nbTbWL41416+8IPMJkFFBRlKu7Qx9WQdMm6RsS75vNTwTsS
	 p5eUJuGdDl6qgtQXtgdmt5+eYiTHGcycq6hD3cJSDTZ3vN/3t0D55azCbbOrAYt6oJYhE
	 CmsflwBPD2/1afpjx/PyoUJ2pMAPi7TbGq+PzLO/EqD6Cu996l3xNYnq8NicVX6zADoW4
	 /3lE8Yvo2JGvItkA/e9tZmt3ryUbKaXO+6avRuVUb51y0WvpS+w/ZBm4Otsk//Ulz/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m6w6NDu5;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA51F606A320
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA51F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m6w6NDu5
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f2049ea7aso213733285a.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 02:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792488390; x=1793093190; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SOS1D3nqmqpMZj6MIS4Xt9MTMm5In7I705zFpcBy6lQ=;
        b=m6w6NDu5uLKHWq5AkT+SlVjfVk3XntN7RT3P0nX2dB7FyaPSsHwqqWK34BsjmJl4so
         m3MCMhpL1GKj89bGPDbHF8DDx0z4xCjoxM6cTLJGqQbqApN3G+VqTu9ZiUJsw4tNGtnK
         F1aauexGxHgxnVU/TduK2CGEZifiDJ/OM1TGZwIU/CGTFmN+ficY7YWwvAVD7eVNHPN7
         s5S0AEQ0JQNInl7M87lMV8hY/VryDA+kNbTKOViFjMRUm+IqpC8UzcVJYNddRTZmzFze
         8HpC98I37elfkCRZ/tB2vizJALnboxPp0gVfoOQLjHG661Uk7tXk50akljLgrtrIGb/a
         826A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488390; x=1793093190;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SOS1D3nqmqpMZj6MIS4Xt9MTMm5In7I705zFpcBy6lQ=;
        b=gaNSCkZgiPOJtXEDc2x6//vObGZQRGpIZ64fE05qPvSuS9FCnTsBUb4Drw0kPBACIR
         qFms6rtjN7bEyBb5uW+DAhKyBH39qsDsfKL5cfo0TJM6dzpcE280MOulEUXwqs2JvYkN
         eKeBDDAyX/oVOa+3ZHpH6DUDP3guCBgZP1ekd9p4UL0dFXjVp2hVZqYKa0s2I1MQ8wt/
         2V8uBH3eX7w/XWVsgQ4us2FuEdZYmMZ9nOITQ/JjppkSZaX2GtCSAXB8PP0JpZVI9m6O
         btdQ2p6HwW/L7bv8z+QdaPw69bUTy/KBp+RQ9n813WYkTLMesBstzm0LZDeMj8G/WcCQ
         Jzng==
X-Gm-Message-State: AFq9FYKXZCSRwxZqBhHH4Jxs3DLJC9/5lhGyPnmQbny9FtKHkfhYxeQy
	IHbXZ9HGu4Sem5id5W7Vs//oPVVYBWgr3KSWyNcf98A0mezSEB4o2Ou77oe4PJfu
X-Gm-Gg: AYBFou02CT9glOrjh+/h9lCdSS15s54dwQKi+2qZK1Qii4546VbHh5Xg9lJ6ARhrDVd
	BNuJ1JLJ4e+PCMPuwkXbGBOf/iNcUitxfi4vsTBsn2jPvL0w25s6vXMuIoyljZ+HTG1IrT5iNfE
	OrGnqFoI5fVIjZHcO4iyv85+IPgRT9XkugS0ARzdispKGDWSdSf6vNz6k22fjFYwLfXG6qldh/8
	fEayxA+u0ll/3sBai2T6ykzuyx6ceYsj+B1xUf4GvXdxpdv7OEQHFufEUZy24ZgLDUpjl9ay3BR
	iR7+f1vb1OwdTMpuqieeIoyk729aEjsZP8sn9+44aoB2bRLLDLbaIxHnpuumTd4toFNjKVP6pyP
	Mf6MKCCj47AeL3CyPb2+RIID8fTE9d1pu0bs1cOulOQhEIG5v2tWqHd6ujIuOdgauH/JXqh3hRb
	tbWn4Kv7vsa9aLeG+ZURYxsvQIexRQU349l5/wH4Tgg8AjwYHH5YhVrRRfXd+K1NL6J3jad3cJH
	H6Q/GXqfQjE
X-Received: by 2002:a05:620a:6410:b0:93f:24e6:4052 with SMTP id af79cd13be357-93f29b7604fmr1603166685a.10.1792488389494;
        Tue, 20 Oct 2026 02:26:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.127.134])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4b0d2dc7sm178898385a.34.2026.10.20.02.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:26:28 -0700 (PDT)
Message-Id: <pull.2269.git.1792488388022.gitgitgadget@gmail.com>
From: "Roger Koranteng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 09:26:27 +0000
Subject: [PATCH] t5301: use test_path_is_file instead of test -f
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
    Christian Couder <christian.couder@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Roger Koranteng <rogerkorantenng@gmail.com>,
    Roger Koranteng <rogerkorantenng@gmail.com>

From: Roger Koranteng <rogerkorantenng@gmail.com>

Replace raw 'test -f' assertions with the 'test_path_is_file' helper,
which gives diagnostic output when the assertion fails.

Signed-off-by: Roger Koranteng <rogerkorantenng@gmail.com>
---
    t5301: use test_path_is_file instead of test -f

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2269%2Frogerkorantenng%2Ft5301-modernize-path-checks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2269/rogerkorantenng/t5301-modernize-path-checks-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2269

 t/t5301-sliding-window.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 3c3666b278..b6868229bf 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -22,7 +22,7 @@ test_expect_success 'setup' '
 	git repack -a -d &&
 	test "$(git count-objects)" = "0 objects, 0 kilobytes" &&
 	pack1=$(ls .git/objects/pack/*.pack) &&
-	test -f "$pack1"
+	test_path_is_file "$pack1"
 '
 
 test_expect_success 'verify-pack -v, defaults' '
@@ -48,7 +48,7 @@ test_expect_success 'repack -a -d, packedGit{WindowSize,Limit} == 1 page' '
 	git repack -a -d &&
 	test "$(git count-objects)" = "0 objects, 0 kilobytes" &&
 	pack2=$(ls .git/objects/pack/*.pack) &&
-	test -f "$pack2" &&
+	test_path_is_file "$pack2" &&
 	test "$pack1" \!= "$pack2"
 '
 

base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
-- 
gitgitgadget
