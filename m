Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900703563CD
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787696109; cv=pass; b=as7sitb6C0wJWOBkdt7tGwGN2hFHHqpgmbedMqloZpjsf34qrTxEXHzbXSF8c54HuF0QGH9NfF2Gf3XB1YDFdPKVQD43k5QfkVCEmiOxIL+FXXH1+4IarV61AjSpMafA+S9mSW18hcIaN4gMq+eiWQnKwDfiVQCJplEEC8+0t20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787696109; c=relaxed/simple;
	bh=FRyKpuBRBU42blfKwRFemNFzClwFyi0t+Bd201ru1cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulNgmVOMkhuMQgw+KqU09sypw5quO2+aYINTPAEoriV12BkQ48OCRLjCz5CC3qcezNpgg52p5pppVu+Tif16M9JbiOZtUiaUNoFrjjCCOlhW1fxf9oQQp3P+IzwMakEDQlFZzzyeax/783F2x1uSHzpTSD1RcyFXQaFR2ujI/60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCa6QoxN; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCa6QoxN"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4b21f71613fso307242b6e.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 15:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787696107; cv=none;
        d=google.com; s=arc-20260327;
        b=OMebcIjrLn3pejGc2KdljUVX35onhhjOBsdiFq67Mq4Yx2wanTxZtwUzaPJZnUbo/H
         C5jN3d4hfavRUU49KUBMsaGlNnxDPS51Yxt+IVOgCw8obQ7/8UHyA83gxYZj1M0raDFF
         m37t4F3UD6dSsY5iZgPEW7EjzxeO7bSdtSJ/N2Z1miQpb/FON0UhAhXy0Q+nLXRydbV7
         oZt2KG+7qxzugFQS1cjdz25mDhVakcTbLmmGOiXi5/dV4pqgw0MNyv7P+Yjr9rtecHTY
         2GgnWnkZNXwoRiDkZD1nXJLoLcH4tLgThTKTjp/bvVhgFQbw05jWUxzO329rG4nCs5nk
         i95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8S1RVHzHyp7sUqdX49yxokh5S9s59g5Zc6HhiG7NGFo=;
        fh=8kE2VkWfDdS5fLCIXYYt7RvkWfuys8Lc4lEVxWzzsJQ=;
        b=dkQ+qh4EYu0WxvRoZIV+jNbGI0FHw+DqBDRm8q3gal58Z6X33mVwO/0ticDSc1MXtD
         AcWqjN9oCu1BIS1s8Kiyv7AQEGGQBenLIlv7HSxIIaaU2ggd7KxPzpJRWl49Q7ly5lxt
         JJ3+8c9ASsv4IoG6KAmZNmouk/2VEdLos27TaxvQxC1ZebMT7Ct/UmjyLux4hlT9MuIo
         D23goCChUyIyHapKJbjspxyPtuOAByJ88jCHY5i6oOuCPnMqbT8IVoe1i3UCVvMET6y3
         g1li2NVno7JlBriD8woM2kEAXht951PUdNv4m1jYh3sPkcgnSKLSg0JUfo8lHSK0ummh
         oznQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787696107; x=1788300907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8S1RVHzHyp7sUqdX49yxokh5S9s59g5Zc6HhiG7NGFo=;
        b=nCa6QoxNLw/xlU5vBHP1LNrHt7RT2J1M0kASy4ih0xeyX6fj/EERJ3MW7+NwLG8j2N
         J98bygDsddDS7DITwjcPO54ZyqjknLerLRFPQOTuSYn6p6eVSiA/HDZDtUrjFkqo6NKC
         z2S9OlxcEwBkSbKYdAzRm5Uhe//SL/THH7pWq8G+YfE1Fihj0Qo28dIwy5JNMPxhKhtz
         CZJ+EQj1jR3ieL5EdVPXajVqnVLHvYY8x6ILg9NYuAvosGjgZ1HytqCmlvbkMHJ/g7x+
         bciOqrpW6v9vsgZvWB1KJDWpVyb1/H92CKTtvUJXzMCAyzjKRqhR0mRNxNvTfgJQdcEN
         IIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787696107; x=1788300907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8S1RVHzHyp7sUqdX49yxokh5S9s59g5Zc6HhiG7NGFo=;
        b=ZMWP0xf4l8SybcJ41wwDGqlIOpxXAOmkY/GMcEfLJ4NitKfZidAWmaqUa0Wb2JPfCv
         a3YW7y0Xeac+7FSqQuVErMLFPuQihsaArlIIEfxxsr3AxZY+2i/dIh0YNW3oVvtSFLfl
         Ph2rfrA8IiHAk7DSeahf9UpQfOKlf9dfCjsdrxyuDe90P/1+GUVzV54JXP8NxCZzixhF
         G7x7tP8TOoZMbFlzitqi1yLhSAqfLSy6EAZMB9LZLXajuxP7fe+NZHqbzm1Zy40IYIR7
         ac0wBHinWBS0r1QECcxtE7+QVvu/PqFNHdVuuhQbFcWgGQVVhZG+hrBhxX+jT94DArlx
         pnUw==
X-Gm-Message-State: AFuF++kQeN6nTj+B70Uxp58SFW7crrT/DAm+IT6xgJHYuVqt1KvaZSTG
	ktHqhAhh/bL4vvTqCuUyu8xFOMnqucXsfXo/suYbac/kav8Tyo9jlRG/kqjVMGNnU+cnMsYWRtJ
	yzkF6FAgh2hd1SrqSQm9Bc+zBORKwTRI=
X-Gm-Gg: AR+sD10GEIByYseXmZa7rI4/ZhVfJui8sLD5n/aacVUOIJ9jcNi977OTVb5Og0VFlH+
	wwnP4myCE4PLoiR/VYk3gpsfxGIywwWRNkldGj8nnC5OlamCiRjIQTZ9wIvDjdU8rILQKx4LtdL
	9EfkEz0fGhKptLVzz/M/Z9UaNW7dpWZpRf8YwWXcosVth+QXqwXjv+hppAUkzF8onx8QdpGVO+F
	AIFSF8cLliWUFz5zadyF11CbIZ0t0YIV4yEvav6oIF/JrKX7Flu3HDPFJJADGg8Bhqvx5I14Mjo
	ots1sI+JBVItRRrBoGZ0hnmJGtx8+/Hxs1eQwMd2ZJSm1L630/kKS1Bu8d/EvnlXu2wyTBieHCE
	H9emPpcPVIjDwrgLzCusawtk6BAqw2MsRd4ZOwzitgY+AgN7gja6QEoqsd4nI
X-Received: by 2002:a05:6808:1815:b0:497:c1f1:1511 with SMTP id
 5614622812f47-4b366b5c134mr2728288b6e.16.1787696107434; Tue, 25 Aug 2026
 15:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com> <120cf1967bde4e719a781c391b285c718553ad58.1787684181.git.gitgitgadget@gmail.com>
In-Reply-To: <120cf1967bde4e719a781c391b285c718553ad58.1787684181.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Aug 2026 15:14:55 -0700
X-Gm-Features: AcwNN1XIEukHn00l92Uc50ZemIrujbzJlTd7FfnINT52SYjp_twRH__UqqMBUqE
Message-ID: <CABPp-BFsSPJutOKManq-55ri=ddBpWLfN16xSNVs9O7+c2z0cg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] trace2: remove use of ALLOC_GROW()
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Taylor Blau <ttaylorr@openai.com>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 11:57=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> The ALLOC_GROW() helper can call die() on a failed memory allocation.
> We need to remove this from the trace2 API code to prevent a recursive
> die() handler.
>
> This helper is used to track the nested region stack. Use a new
> skipped_regions member to track how many times a region was entered
> without being added to the stack, and decrease that amount as we leave
> each region. This allows us to avoid a failure and instead stop
> deepening the stack, giving as much nesting behavior as possible without
> failing the entire process.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>

Checking out this commit and running

   GIT_TRACE2_PERF=3D1 ./bin-wrappers/git status

dies with

   no open regions in thread 'main'

Seems to be fixed by 7/7, though.  Maybe a bad splitting?
