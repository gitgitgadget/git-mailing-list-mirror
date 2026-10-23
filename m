Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762088;
	b=hwOpM3ZKeLqRNmgnTnam5bV84dlSTxcylZiEpTjNuRO8itBnm7gU+GuvwdRf/4gcdyX1
	 UK2GNPfuTyvIL8Zk2hfiZD3KCSKZ2lfgcUsCNYXJd/4z1GNwJZJGaLmU+GEAMLBwPeqo9
	 4vQ8oWkyCYfPYaQHUE6BECN48z+xbFdNq8NGQ9F38pFE/ZWgab/SaZf/iYJsXyYKMqnNx
	 Lap4Kl4af8DEkMDStYQ1giAuyCGzZohZaS4Z8XZ5othvLfEOzDbwFKuHp295w8uE9NN+4
	 6WJqq9vCDCR5c9C7tk2Skbpu6wj55JQkuRIiXBcm1jbWQnX7b1Fp4lfTbnePPbrfOfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=etS4qvUWrTJJbIguP8J+1r3nFLi96hKTbMQTTFVPBOk=;
	b=tfKOp7cTfbobnW+x2nPb3AXoo2g1H3S/VBWIatTezhhwxH+cbWgZpfKV4K28iPkwupFN
	 hsldWYBnQ1J5cdot28w0+RJsa6DaafPhPlw3zHfxVm0Cg+Pg6wgIdqsnASuH4bywIpVrK
	 wdEeq4Y49ZDN5CWh/C022tv/cdKmxAII31eYR3JEV/RzTN/aOILNaD9aK7CpqhV2Ho987
	 s41MKvbvP8zzQi8NPW+SZ527BqoQHFBUIPNgDOTzjQv7rk/6NY9Ugn2gMwCjvYa6jUTQX
	 4kYYF72MH46qavl5mxi48aCSIFzBPci+CkWBwkqeQgRCnf04wsdetnNUwc0RrG1TDgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D07aO6KW;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD363606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD363606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D07aO6KW
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8acda240937so7391667b3.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792762087; x=1793366887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=etS4qvUWrTJJbIguP8J+1r3nFLi96hKTbMQTTFVPBOk=;
        b=D07aO6KWHW5pG+kJmrBhCWCV444qZOJETjhCEdSMWaB24GyaGFJadRqU63uxRmqXGo
         ByyG4K3Hk+NqzjHBDkg3ebvSHSyuMQbffgmxV/21hZTnJ6W9rgU4kTdac+qyFrCS+WO5
         rdx3KgcnDNVRs3+cx1tIrPOEBx9557jhfBOkBRzvDoXcHhlLMT52mZ9dxjYoEvgcUaSe
         w5V+tHybDp+/SvKSjgXVKVU+UuWsX0f05/kuO4+fDSY58Azib5tdmeHwQW4UHtDBIjb7
         VIrk1SYiUXvuyvrJgKGCriMYp4EpH9XJwPUsRF0FFcboUpO4TZ3CBySbR8Yf0L49rcCt
         kTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762087; x=1793366887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=etS4qvUWrTJJbIguP8J+1r3nFLi96hKTbMQTTFVPBOk=;
        b=rfGuXUs/xYQ49DvzJ3Sc6YzZXDgMdR1pfbb1aWvYFh8FCaufslNR1mbPB3wTGnPmWV
         Dj4wnUDdVfAW4Trwg8xubmken/2PKuuLk3IepZmeymF1jKbAUwL0vykYLAhxPFTGP+x6
         zZi5G0/Jo76laC8P4kyaAeWHuvlTu9HdttUqE8/Dzk/+FQq69ahRMIhQ73O5soNz83+W
         i3vhLdF4OLK0godO4PkR40zb23/EYHy74Bh0zSUgQ8hijKs2ki8iPSv9Tp/i3/IwpmHJ
         VwGaFs2uhHV1A/wDgwCfTnYKhvCa/upcDfNj2OHOMJVRrsPHpzveR137YIVaOsL8HZ+K
         sEYg==
X-Gm-Message-State: AFq9FYLQ4LKEGwnhdnpjNQL1kOne02kueX9mhs/YasM21jKp+3ZPLlR2
	FctlTdh24V7afHCjDe27aYRyRzIUGx8n35xgkgDpUY5ASNddNhKFvp6mVCu1S4k5
X-Gm-Gg: AYBFou3yu4hPDus5oJdmAf32XWzUNnStbmsXHnKiFzp1M3NQOtuiFdtlgbBiie8LmFm
	6X1VLehaGhfzGJDpO3DrDP8SKUlRKmw0uKU/GL85eIuCn7f3pGvtkU2kbd+2ECG78oK/aMbAbcK
	c7m9Y4MDGnIl+SJIW66wqqM29ELaNqQ4OX1Nxub8VEYU/hu+mKtat9C36X/Pxw02Ce6E0yhlqg0
	qWcOfV1ZZUxaOFVkknKVvbv83rdDjNYZBEWOaKgtNqgHIT6eRr3w4I9HWUN632lmnQ+k5RHrIjh
	WEEBKQh3UF66Ic3tzC+P9z0tDCuy4K8TOz17aVaOn9/pzxPEvJy7OLz0KBgfVt1btpLfqLHCVfx
	x4oNxiljqlEp8eQDuw3WyZ8sGVOPsdnaNW0dnsxTC+J3cG02YVyvmP4w3R9B8NjAyMclCmqmd3m
	F/0KrDUeLGWss4ZO0AfO/LLC8l3+phxQTlMH8ZX2sHDeh5bGXS4aAW4+i74KqW8mnxZDl9H3cow
	9orxAJhoD97LYfcUa0JFu73GLV/ICr0LbWBupDHbDDibbQRG+Vd2QrNMvf78EkknzVGWsSQ9h77
	9XciQmp+RB0NGQyi+0H1jToPfZZJy5EmQAg5yqkkbe2AJZnCoEQFNJHZfYNWsZF6ydjWyFlJC1o
	B/Dw=
X-Received: by 2002:a05:690c:e1c9:10b0:8b0:a5d3:7198 with SMTP id 00721157ae682-8b157e6ef6cmr12632557b3.47.1792762086730;
        Fri, 23 Oct 2026 06:28:06 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9d17:3000::3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b156183032sm12898647b3.34.2026.10.23.06.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:28:03 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/5] completion: fix Zsh handling of stash names
Date: Fri, 23 Oct 2026 09:20:53 -0400
Message-ID: <f4f6b89ff6584e3d5dcc8a0ade81e05d3203a55f.1792761643.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.237.g5414b88716.dirty
In-Reply-To: <cover.1792761643.git.ben.knoble@gmail.com>
References: <cover.1791827304.git.ben.knoble@gmail.com> <cover.1792761643.git.ben.knoble@gmail.com>
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

When Git completes stashes for Zsh, it eventually invokes something like
this (via our redefinition of __gitcomp_nl):

    compadd -Q -S " " -p "" -- 'stash@{0}' 'stash@{1}' && _ret=0

Because of -Q, the braces are unquoted, and Zsh will leave us at (for
example)

    git stash show stash@{
                   cursor ^

From here, the list-choices widget (on Ctrl-D by default) will show
stash@{0} and stash@{1}, but the complete-word widget (Tab) will just
add another brace. Zsh thinks we're trying to do a brace expansion, I
think! Interestingly, using menu-complete (Ctrl-N) does cycle through
matches, since it's taking a slightly different completion path in Zsh.

We might try to fix this by passing surrounding single quotes (using the
-S/-p arguments of compadd, which we can do from Bash in our code via
__gitcomp_nl's other parameters), and indeed Zsh will generate

    git stash show 'stash@{
                    cursor ^

but completing here won't find anything, and I'm not totally sure why.

Instead, though, we can let Zsh quote metacharacters (removing -Q) and
everything "just works." It changes the output format a bit (users see
stash@\{0\}, for example), but I find this an improvement over not being
able to complete names at all. menu-complete is unchanged aside from the
extra backslashes.

So, override stash listing completion in Zsh with a working version.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index d5c526665b..2aea7770d2 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -135,6 +135,11 @@ __gitcomp_file_direct ()
 	__gitcomp_file "$1" ""
 }
 
+__git_complete_stashes ()
+{
+	compadd -S ' ' -- ${(f)"$(__git stash list | sed -n -e 's/:.*//p')"} && _ret=0
+}
+
 _git_zsh ()
 {
 	__gitcomp "v1.1"
-- 
2.56.0.237.g5414b88716.dirty

