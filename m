Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793891723;
	b=fAZWAbBgiMMUskXN71DN9c34nOLA1puI849Ze25Gg0gM+9kPTLDUQ6pXGhVN4BIBKbCT
	 Wb1lRaRzYvxcNbCJceQCdYn7KSXURTFNIewkMLfa6KUhcWCXrAMz8NdhAimYBPs111Ji+
	 OrpfW4iJhaML8FsYHmgWDW0o4nb4A9/5bBSEZ0TiF6CSWokSd0YmWPXrpwSzrM1ou9+wP
	 g2NL4WPIsBtyoFCvpoY/4xgzw88P0X+OVE3dXD/4b0GT8HxZVue7PwxlT+widBemBc3ph
	 a369Aj8kLOUhWZE4nLeNrcCjb9kzULZlC8ku0gwZORJqskm9xqJsY89enZD59B1utBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=fqDJpHHEzEWV74VuQ10hBa8t9oHkv/8RmJMSbsGJs4c=;
	b=M+dKQT17v2b3yS1VNAQy10DPiDPQFwgTi09SJIJGnx/n8X3sWQfozTj9L0gIQ2442V5K
	 K00Wzyj13rIHqzYubJ8O2j40S0wQUWiOKh/FBvz1nR1cLT04oqcZGccephquZjDq0Jjsh
	 iFBKcRKk+OddKtwEx/Fj1DHgnqJr8mML1AukI/TWA9RWeuOW5Zs02nuVzXe2JZaFW8cZr
	 qhY9JOA4z+9JN+waViVhiBG5k7dak/+Q/CbPpdc76Cm89UERuOhID1V8TIHFGTrQ9ADEp
	 amBm/dx37l7hNqoaatrZ+k8ygryBnXuYcRykGNM2eD4+YbSaoRPuaQtDnm3ot0x9Igw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWZCZnRk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BAA606A32C
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15BAA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWZCZnRk
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6deb848ddd7so1421993eaf.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 07:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793891722; cv=none;
        d=google.com; s=arc-20260327;
        b=tDb8Pq9+9PpQXivIf5V6dMSlWoGnygc5Lqxfrqd+B2efVN9/NzubCxdNUK93JRXLGF
         zeaaGQ+KleB5/y1f/Y7lBByRZ9i384y5e8+nbPutsZSwfeecX+iW/ywPXnrHulOIOGAz
         IA/1FrDLECOfnepGMNTRM8kP3vnCe+3XQ3VDmB2rrdyW4j9+3Z+vNLRt6Q1RIgXhcP9m
         2haGi7HzU6bXQ+w/zLLky6t4fWxq198sr46Zj/AOtFr5BhGPU/TzIt7LZ2HYQlLmL8DD
         qLQkDK0bapmwCTK3SHHda1mtKyGmzxT7O8UMPyCjE0jn/f3RNsz12v3X0v+U87lA3JDj
         RvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fqDJpHHEzEWV74VuQ10hBa8t9oHkv/8RmJMSbsGJs4c=;
        fh=ICvZTX0tdKyzLbSSFMpFZqzraM/inHTRu40QabgEu7Y=;
        b=FnHdse4rf8S08JSOfXPGM7LNjOV67qZpoFMjwEwNycIxG0dif3YAYgsQa5iiVyj+5X
         Q1HVFCOXOnta1ecLwEFq2EBEPhj4hIIMPxjLD0LZ9ppIlXWJTDtpL3aAjOKIVmcSEmA5
         oZu012ssnhhNZLR7NpcJk5Hl1JDT3IsQamz/ZNvsnexYw24/yRZxxFyb8Yd8dwtojQBt
         tBi2C8IhlXesSQhaL6BwesOMJfGq/L1YnTDHJoQsmGgBIgqSwN+pj6aPhNgbEU5kfbgd
         xzKgyBNIE48QlSlJrUU/3k9NdG9c7rTDQQYsP9KZifvtnJykDqIx+RTXB25bWCEYLNVg
         fuPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793891722; x=1794496522; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fqDJpHHEzEWV74VuQ10hBa8t9oHkv/8RmJMSbsGJs4c=;
        b=lWZCZnRkZgULXeAkwC6gbKyADDVbHUIdZOgeZnZ37Zj0r7e8iFxnuCbCn93l/lpISw
         ViYuAAOFuqJjoe+6BuIykIOKXTJvxP7wdFcbZK0t5cld3bBxxicXXj9liSX02L5OT3H7
         HK6CtVF0epyELBXVnjBZoVzuf4qUevVVHamtaMsXhDVuzW8vy1GwgTMYUcHvS+T5Kk+p
         GFxBcRYQxUofej06wHPV+qp+Sp3gXyFtmAxeyuXHZsdY2Gk+BK9Vtdu/UC8gWjubray+
         usPynz/lyQb9VKANym7Pt1IIQvydov8ZriGhAF3JjNDgNySVGrMb91DRaOB7ZH2NxFFZ
         oCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891722; x=1794496522;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fqDJpHHEzEWV74VuQ10hBa8t9oHkv/8RmJMSbsGJs4c=;
        b=TbrjZzsku9yCWBbXRHOqgI1r0QY/Ul2HoB3Fc0xjpWKwCboleQ/yyb4nVfhAG7nO8p
         cPzBq5qW7lgwNF/5gJpNgCRwfAOlqWDgUS3+Ufja/Wzfqezmm+lZ0cbX0rcvNFCUujwd
         CX3cArDPlkXuZgJV1dXeTsoq3sBqoRe4uV5MD+/PaTT5BR2HzOFoC7LO0RdK2UqimxZ7
         fTHNEXfybonLlQLpOVQhJHQagBWmO0SNlgbAY7pzpO5rfSQqpa6Oa9hHWv+9JkjY0xGQ
         7CaTeYgs9Tga8jlTwb4c54I0IU1FZTR4vu9g0rCFNk8MDO/MMlE2oNVBOYuxe6y5Ca/1
         5xFA==
X-Gm-Message-State: APuU4Z8Ke17Y5rqLNRDwMGj3NrypEMyFr29u9ZSJLyFcXZrBJed3sLaa
	qPMmlsqPWr608AMbslsDS+YUF1NvGaaGoZRaiBR9f3UYDZdS/F4vxXGXq9DgM2o6dpK5OcEAicG
	GvG9l5/boXoTin42c+4oHywdp0ZImjPA=
X-Gm-Gg: AYBFou2unvNeHBUn3mh9HrW22GKneiTUX4xqA4oWFgSRcuBKRPzcPoKZPrAUl3FZMJ4
	FGB0663cpv3iv5xbzUTg4ZstuckQ9hSPKIL4CNoQhoqUDR57Q1DRUPSjrBpNoUVLu1zfqTWi/WY
	NXoe2iQcZhfpDFyBM7+i0MqrBzStaNszn3w+EUhydiW7pvtQ4I70gjxDTRLbKuGPHVSPh7Fbqcj
	PcNf7WrSB5AFZSnAK3y4VYswJ79mSFxOsxXjolIgR8O3LDBrTyYlF5e+jotTrzvMzOKQgn6u+q7
	kVx5T/YcQWQipBh1fOeBeo7frc4wMDEMlEQucmUa52N16gRHXrtggZx776hcLy510GdD3ES9dJi
	rMYiCmdFFasZ025SXjbElqG+KgHoyVi07hvK5MyY38aZUGLYtTortqwnfBXyEmJzaiF8dQkwqHp
	Qbk/8gh1sQ0TIcqWDsjeItsyzXLIpy7mBPdJRlv+AX4tiMo/X2rHyXDAQ=
X-Received: by 2002:a05:6820:7084:10b0:708:d449:47ae with SMTP id
 006d021491bc7-714f255a64cmr8749367eaf.75.1793891721396; Thu, 05 Nov 2026
 07:15:21 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
 <pull.2271.v3.git.1793710118.gitgitgadget@gmail.com> <ba34e82a0a6a99181637e2fe33be5506f2a1bdd0.1793710118.git.gitgitgadget@gmail.com>
In-Reply-To: <ba34e82a0a6a99181637e2fe33be5506f2a1bdd0.1793710118.git.gitgitgadget@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Thu, 5 Nov 2026 18:14:44 +0300
X-Gm-Features: AclHuK8guKYgSkfJhK08ZxDEMteVflI7rEvIBVFbuy85Ge8jgbWRx8n6DMcxa78
Message-ID: <CAKrRMNqzOX=vUUMrMf5P_Atar8_qCSbGdtBktfT+iL4hJfFX-Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] config: move pack size limit into repo config
To: Joy Gundu via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt>" <ps@pks.im>, 
	"Kristoffer Haugsbakk>" <kristofferhaugsbakk@fastmail.com>, 
	"Christian Couder>" <christian.couder@gmail.com>, "Usman Akinyemi>" <usmanakinyemi202@gmail.com>, 
	Joie Joie <soniqjjj@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Hello Joy,

Thanks for the new version.

I fetched v3 with the Fetch-It-Via line and built it. t1300, t5300
and t7700 pass, and pack.packSizeLimit still works: with
"-c pack.packSizeLimit=1m", "git repack -ad" on three 700 kB files
gives three packs.

One thing you may not have seen: Junio has a patch,
"repo_config_values: freeze the structure for now" [1], resent to
the list on 3 November. It adds a comment to struct
repo_config_values saying not to add any new members until it can
work on a repository other than the_repository, and Patrick acked
it. It is in 'seen' as jc/freeze-repo-config-values, and 2/2 goes
against what that comment asks.

Separately, v3 does not merge cleanly with 'seen' because
object-file.c conflicts with Christian's cc/pack-index-v3.

On Tue, 3 Nov 2026 at 16:14, Joy Gundu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> +       unsigned long pack_size_limit;

Since 2/2 adds a member to that structure, I think it cannot go in
like this for now. 1/2 does not add one, so maybe it could be sent
on its own? Christian or Usman probably know better what to do next.

Two small things in case you send another version. 1/2 leaves two
blank lines in a row in repo_config_values_init(), and 2/2 removes
one of them, so that fix belongs in 1/2. And the cover letter still
says "Changes since v1" and lists the v1 to v2 changes, so it does
not say what changed in v3.

[1] https://lore.kernel.org/git/xmqq1p917kwl.fsf@gitster.g/

Thanks,
Tanga
