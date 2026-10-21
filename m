Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792576814;
	b=j24dHPzNIwQZMhl4o9+/yswLIgN87L+Q2+n3KxVK0wwAcfaz8fifx1zFJaQtH2jtVPUt
	 osH1+csZyIZ+CDXadWlTPqtaYr4oVA5FOc/BTP8sGkw+9LZGpqa0hzYHaZUw5IVf8661T
	 R9nUe6qlCqdHP4X+Vis+K4HHHxNF9YOy0Rb0tuzKXB3g1u+BULK5Q2pjgr2jdVJjdVrYF
	 LwRNFK/eXtvf2/Qa+VnFthyhilFKebK4qde1dYHiZuvEuYups9PXP0DNcZvv3lHKFJQWO
	 Bh6neLLlwCHUaKIHU3F14FSuBBM/pCkeT8DCCEuuFdxQ9o12gLwks0E4X8mF884jMkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=QCZX00krut0NI56J5BNVG21Qu3bE+/egx+fzVuNJ7pI=;
	b=L2WTsXnUqKoKe+y6YjfCrQfVajdUxclFYoc3fmu9Ukfu7Hbp/k8OvSqYtCy9w8XHyfhQ
	 CPAIxHS64iwYcXfa2NROM8C4NQsZQsLbdtl5rnuHvEQPhehe5goPTF4ivCaPjLeqJdjw9
	 PRomZ4XHAEBh69hGGpRYHm7k3Q+QtEhvHB2SO3KYyv/ZywFx7Z6Os4sg7hKhOtCkAeegz
	 cqDDVkpP0HyYU8sjG6Tcb5rRuhg3obg7OViP2g+CxCCnv7el3UdPp6vzEefjQ9t5bP3a4
	 UZlJaJvHGx4Wyf1T6/mUyuJz+4Wobp/dW+cQLJrwFsz+zybjCN+ldwudBFjrpx+fPMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QgTyriNV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E876606A31D
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 10:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E876606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QgTyriNV
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso844470a12.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 03:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792576813; cv=none;
        d=google.com; s=arc-20260327;
        b=M1hNB9L3FbBiw8Ipc3hacM4+iJPRlSukDlcK+sR7hMHU8lcbCubDNMnr7PoHAG3w/2
         cPqYBfjdir0Cod0SGbi3/454ZXy5+L66tzNQAnMvlJ7eF0QJawGRJN/+4QE2UwnKl/2b
         T56O2VD4TO2i/7b3qe+fyZhRg+OceZJ/HeN8tgBHl/uVFZ0z7Uhpt0E5WlfHVpt0IaCL
         BZbFCoyxFZ5II/4qYIi8+j6sDgRq4LKo0QGGJDzdQBmx/1uQ3DeHtT7xRn+GaZS9vlaB
         AMVutF0tiKSek2YTBYjt69xrbMkBSTSKWimP08uz7FAZE2A21Iu2fLzF/EM8Iravs5bX
         CPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QCZX00krut0NI56J5BNVG21Qu3bE+/egx+fzVuNJ7pI=;
        fh=UIMjZx1ip2FAzMkx8b3ocJHGsxPar79eklurTfd+UHM=;
        b=ItE+vhz3QdqJlB6vvdSPnbKRjxZB5NstAGdKcclF1TAOo2JaThAg0IX2Zs4E9o+OnU
         SqFGccBLOkQGIEvDwUWLbkEJN9lWMXrWx4zvTc+gq2B+5rA7GkoUe5FFC8mYQuvePOgz
         EYSFNwolVBQJyw/cBjxCC1ShJX3qoJ05XJNLxlaoU+HXnzi808zGZKZDvoIqiZ47L+QB
         IwGMznkCec73kZsTrUh34wbeDNufHGRaYba83OJwRHiDViQdR065TCKpOxgwrow6RWMo
         z+N4d7F8SmA/cMVySMoL0J8ElpvGJJyCs81Vc6iDUb1av5VUmHmzoK/ktXaYn2wL9iTR
         Httw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792576813; x=1793181613; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QCZX00krut0NI56J5BNVG21Qu3bE+/egx+fzVuNJ7pI=;
        b=QgTyriNVYVqUuTDJoLv7A4F/HH8t5nDWHeBBcIimwM397l18Ec1LooTDvD48AwMFM6
         evlNYF6+zqMafG9ttK7Kfu1AiOHsc7mX3Ln9ZiI2kHQDxqc1lK6HbW73oL5vZGTtEhjo
         har3/O8adhGRMWuOdMj5OGEX5RZsURDUqUHOK2kKIzSFunVjgYN0YJk/tYJ5t9qu6zPO
         lSA4FgiHKvdlKWRSc4IyA4kBFy4VdcjVxAcVhHtlvubjDbLLr6Rh5f7F2J+LZUlMJ++m
         bXFqnbbeZfpoR1ls3hwBVV3dfqBb1SBs5Y/ez46NLmYJ1qyZLwC5rPh1uN+IDGMznhc7
         C61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792576813; x=1793181613;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QCZX00krut0NI56J5BNVG21Qu3bE+/egx+fzVuNJ7pI=;
        b=NDJvgSGZ52YiiGyGw4kU30cpMPNthG8uQUzndH8c5z/3MM960lKZnnF4BDUE8FJZyL
         bQzbVAc5kHZ16MPVs/zZzODP/ppaTbI/d3ej+2xK/Ls4IgsA85PDl2w1sPK26A773snf
         uKWwSSMuEY9xGDQHZmiFzB/ZKWF/Ya/1HNZ6g64UXuNS3JIy0th1dCPeLssvyQFret7g
         Kze4gP8n/WhV2TVVIVTvoaaqvuoit+hLD5sDq8fqsgL+MzmgaHzJ5kUOdsnVBXACB0GF
         /eXUmS3nZbSJ3f5JD7UwRMlL4HR42tbqmiXIUB5KhbZ1A0DzgB1rSYOjVDAs6Ze0Penz
         WxVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJtQws8Sj0l4MWzUzjsE1vISv/qc6NL9j6aZERrA0e+G1UgMymcJynIlef1Ho0o6ZRB10=@vger.kernel.org
X-Gm-Message-State: AFq9FYJn0fZhdywZaln+y3PFsKYGs7Xgjf+T7Y8rQzFS1N1bpyBPPQXp
	Z7+X2FTGvITOY3OMQjZw+ASJXGL1mCAcYRE8DFqb64boGaW+uKtKUNYlC0BLAgZO9BKWkBAXFRa
	cKW4kZeOOqLV0ejsVFxqVJ6Y7ZE5MuzJCvw==
X-Gm-Gg: AYBFou0lHz3mol5vlpOpSvo6wIIQyWfIQv8q56draWC8iVVVMzsHn7cnEGXdX3Q+94v
	DGwwSwJsKg01oHerXGC8iZMGiH1Hie73rBz0ABEWZGsb8TPIejKoE4Ha5LfMl2l0/ZjjrBlpwJV
	zSLxA6xcEzh1JUccdM/bp27w2F4q3s7neP6swx8ykMm3xHxdB/WfxmMMt9K/+236pdSL02qFkqf
	PQj7I2z2wliY2s3Eb8lrM5TCIUBtFBT/FZyHbBhCQ4rmfAgB0ZLgkgZwpYEf/5KHvy82vrgBU3q
	QV2MpVncCp6KQF75MUjJjPMPxVAn/DuPYSIU9Ubo8pSlNQOvvLOvIvB4FcFB68eQ8o6EqgAnfhB
	PfUCIp8G4GZkKkQTYOa/tpV9ZDnvEjLvvDEd0
X-Received: by 2002:a05:6402:434b:b0:6b3:d0a0:39c9 with SMTP id
 4fb4d7f45d1cf-6b408e86a39mr1142231a12.6.1792576812738; Wed, 21 Oct 2026
 03:00:12 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <pull.2456.v2.git.git.1792566469.gitgitgadget@gmail.com> <c42827a1225e49db2e0855638e4e76a06f7d9eba.1792566469.git.gitgitgadget@gmail.com>
 <ath23vYy0n8UFLUB@pks.im> <CAHwyqnUwbq3XkLajsurk=X_=s3a8Z85Ai2raVmpsxK8HavfwZw@mail.gmail.com>
 <atiHnUoDf-_h50V2@pks.im>
In-Reply-To: <atiHnUoDf-_h50V2@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 21 Oct 2026 11:59:35 +0200
X-Gm-Features: AclHuK-eqyDMx9At_OjzP51osM_twV8Dvpc_ywQkpKg5UuKSDBzjiTUkeOdb7nw
Message-ID: <CAHwyqnV3bse7pNiesYz_Tx2onT-SqVt+zdUoJ35LmafhQzDZ+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] imap-send: accept messages with Subject before Date
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > What do you mean here, do you want to remove the tests?
>
> No, I rather think that we should have this at the beginning of the test
> file:
>
>         if ! test_have_prereq PERL
>         then
>                 skip_all='skipping send-email tests; Perl not available'
>                 test_done
>         fi
>
> Then we can drop the $PREREQ from all tests. But I just spotted that we
> do some more gymanstics with another prereq that we optionally add
> later, so this doesn't quite work as-is.
>
> Overall though this is fine, we don't have to fix it as part of this
> patch series.

Alright, maybe better to have this as #leftoverbits ?


Harald
