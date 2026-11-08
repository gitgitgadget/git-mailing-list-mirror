Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794176939;
	b=JKeWqXOfaiAWI/7nrW030wY1Gnhc+hjvtflE2gm/O6vEKBUOXTxpKi1HkEjgngLs/BJz
	 Yp3Ktr8hBDrBX3fcUVLz/tEf8gzX/1xCtaeGYwrQ7kU8X5GNSFJWZMAR0BHDzYtTpbJGf
	 6gT3P0PXpDuiWje+MdkTxUyq5jkyW+xHFVn6Fxkp+yPA/ymSqgkiqT/w1ly3w7qi+/yO6
	 feSy0lfHTAwZ2YygvF2JqMYozG2KUHeWiIfKyFf4Iw0dWdJQKg1sURGAg8zRsvLDTMsAx
	 zIx98tPOFDaozCmKEjadc+ZdoWRJT/8UzcWPW2rcfEDqzCR6vo5dFw7LOE1NrN5hskw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794176939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=mmMvnKhXOpCxjY+iZNCCCrHjHcIF32xCYbczsTfp9Wk=;
	b=yyupQDOGvWt7LKVHR6Q7/aGgtkhFb/ZYMXtPT6HqLxgUdWxlNe8rgZr97h2/x1hFfSIg
	 nCVLXf3stO1GSWjxFHXRiDVUBhrKw0/4jZkeGn8X+vFHko68LWDTJCEPB1lAVUVr+w3HW
	 SDOH12KHB4H8QOVozfQkz2H1pUao5YdzaIgO6G/tYtH3tyxCwHCUw7tj0OAlUNCGvM/IT
	 RNzKn+P6tif4jY0UK8bz6KzFW6OSISfU8Fq3rpE+a/JBVYaySZ8i8Ky29j2cekxOMdSsv
	 7KHpXLTd4kR9nCWpgx74XCy9VMjhdYgxOSHVuuM+7QLBqZMr+I6wnM6Dpcrz+6ZDAmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QRTdxAqA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83CB606A334
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 22:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C83CB606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QRTdxAqA
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6fe4372c5f3so182881eaf.3
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 14:28:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794176938; cv=none;
        d=google.com; s=arc-20260327;
        b=ejE16Mlc4hHNkQNACmui2W9Eiy1CSo6Si7ZmthvgDKUmRe5l9B505u1FjDG5x+S7b2
         qMfb0UNUERMPQOnjvdd6dLo09i8Ez4U9EqkiMRbeEGk00yFoPNMBkw6uBpJS2X1xrSY0
         B5rWF2kPz7hcVRHHTfowT7MRWUNBe845srm5g66VWharBAXDbITSvVi0ntx676vlQpNL
         pw0AIhMgGznhn9HGJQIlmgm6bfB78dIONIXze7oT7kNVDgsH+L2CZPDT51n5lzeD9VpV
         te6aphso/0cu7t4w/ktig9+qhgoM7KK3XkcW1k9Ou5ht2fk/fAFhKNi1bKra/RIwD+jh
         rCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mmMvnKhXOpCxjY+iZNCCCrHjHcIF32xCYbczsTfp9Wk=;
        fh=RibIwiGwtzKC2Y0GHyBA/uOkHiJQGVNqyxcdxyQpGb0=;
        b=hI6RrUqBSgJBGV/Lk+eWafipCoFds5MHzCHzD6qvmJqc5D3ubhqTtYXrtWQe3gIAdx
         2sHFnyqSEhgpsJaU79OdS0Gai0T3z+uooDQTyPgefYbDP9/wN4tn3bS4HyffTdW8h5xp
         Bshjk5SPym5KSZV1JaceNBENdAu9CLp8usDTWtTkbV5ySMTQRyxyY4MOa+sfGnEmmPry
         VxKjoeSDxXG0JSMoPoqWfejVIetkya9bL+buraU2sOa+qqgtIq9/QBQG2sQiZ1Q/oTnC
         T0iffaaTsA2jPzpomSVqdVvv9FGBT/n4k3Q7fXQFM0B9u15CBN00WNPbyDC/AG1qwaz4
         EmZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794176938; x=1794781738; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mmMvnKhXOpCxjY+iZNCCCrHjHcIF32xCYbczsTfp9Wk=;
        b=QRTdxAqAMjzeNwDr145sV2fIermdhYn/gNlZLOBT8rc6X+H6FW3u5oZsYrfKn++f70
         Og8seCPyphGRmw2DFFn73qdmZXjsHaBvwohlMKK4jErXwFRq3arSxgPcr8zsLCiXjBK9
         JSKa/BkAGzoLzqrJY+kFSZOVuCd/oCH0Il6V6dGOdPt56odF4E3I9lKq/OCc/aqN31/7
         nVSk0Bd/Y0lEgP9Q7v1Cexp+3VYN6p2pVDcKC7llMkcvhnguy/xJC9EqQLt7HerXGe5o
         1nAX6Rfpy9V5EnJ7c68jRuSN+y4PuMTFuF5EX42+7y8kunw9GKu8mvsGm1uhVQt46z+J
         fG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794176938; x=1794781738;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mmMvnKhXOpCxjY+iZNCCCrHjHcIF32xCYbczsTfp9Wk=;
        b=nTmEQ0l1EhjuQhhx6auUcBujrRtoVBB/Pd6t/18CY5Jejwkmdxw52sETmnvhOUaCnV
         qClrjb2QCXp/p1UiWdKi3n+8fgaQNKaBVfieFKFJ82hqFKMGRDKkV+atsSYAkCR6EwfV
         Mv31hoUyit/qYUQJs4JQT4CYMFOCxWIwq7VH3ggPLR9orL71VE+hwXHSA3bv1VocOSN0
         9q6XMDMwh0MlMAh0QVMzpdt6dBzSB5jvX/kd8lgLR8CumcyQMjo5rU0niuRkO3VLX9zM
         TZMBjsiveoqz3fCpbO5mhyMatBgPd5gQWWNkgeHPAhNi2gxcERw0YP93Jl/PCyKhjz59
         LFEQ==
X-Gm-Message-State: APuU4Z9uUGvSnoXoQZlzJpjT0pMbotp0d10dhjxMM1JX9/634EFL/1on
	j2eQLkusvO0pePdonBapBteo4nV/repgiZ/gGWEqY9tsUnFeOUNBcwyz9g9ScTR0RzBvWQ9M1hU
	DMk2L6JxAR2EFAL6982QW9UE6Bjv53TFWUKMS
X-Gm-Gg: AYBFou0dCHf/sxNwC4nfCN+LzkyM86YP9tkmMMkZMTh1p7UpfMTjMApOlrTJs1WinUc
	JX7SD/t3KpP13pCuTuWNaiXmZFfR9f5LkqLdhnr1NAKBP4q88++NlZhkJNihJrgP3q9uTz7/eDD
	TSucpcoJF+Uy7VOZ6E5NqgFJ+8t/OObgB0hsMx0c9MFNAoCMloyFgtKTsXQTf2Z1FM2lIK8JkLi
	KvWFo9PO39DpzfAOc7asm69vCCguUTkW84W5porPsYeCfnujFHpgCETo7mUMK/DPDwUyekVP1aM
	6fJYQch+4Xy/DNkFdrDyXA/k/JkpGCXJa+hfvvyjusym4YRaUjLL81QNijN86pKCrmWMLMr4qCM
	xf193wccWty2ASNtv4zneF2NI1Be3AQEmgCFyied+HBpKfJ7NXV9umNJz1lXLQCKXhS9aXn9LiX
	FdjObU9AbISqpUCMxGwh8esBYTjM2V4KOyETPZ60xkMRit3YCJ//6zxQ==
X-Received: by 2002:a05:6820:328a:b0:70d:ae12:71c5 with SMTP id
 006d021491bc7-7170f333ce8mr1020190eaf.66.1794176937654; Sun, 08 Nov 2026
 14:28:57 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104202228.24642-1-edsonwasswa54@gmail.com>
In-Reply-To: <20261104202228.24642-1-edsonwasswa54@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Mon, 9 Nov 2026 01:28:21 +0300
X-Gm-Features: AclHuK9JFCaiS_LY4ICUcSRfc0kZxOv2ODx-X7OU7hLNTrJVTkGs1mz8c_HdRao
Message-ID: <CAKrRMNqsh=d+_C8u+q1EBeQVwDZaywGQGZ89oYLyyvmB=8u1jw@mail.gmail.com>
Subject: Re: [PATCH] credential: parse subcommands with OPT_SUBCOMMAND
To: Wasswa Edson <edsonwasswa54@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Edson,

Thanks for working on this, nice work adding subcommands completion for
"git credential".

On Thu, 5 Nov 2026 at 03:59, Wasswa Edson <edsonwasswa54@gmail.com> wrote:
> Besides making the code
> shorter and more idiomatic,

builtin/credential.c goes from 52 lines to 140, so maybe "shorter"
could go.

Overall, the patch looks good, but most of the new lines are the same
parse_options() call and check, repeated four times. Maybe a small helper
would work here?

> +     if (argc)
> +             usage_with_options(credential_fill_usage, options);

One small thing: no test covers this check. When I removed it, t0300
still passed. Maybe something like this?

test_expect_success 'credential subcommands reject extra arguments' '
        for sub in fill approve reject capability
        do
                test_expect_code 129 git credential $sub extra
</dev/null || return 1
        done
'

Thanks,
Tanga
