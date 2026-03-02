Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35BD4219ED
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470871; cv=pass; b=W3PBNGyxmmUpxadoNieUL1Q2WMY9b5+qvx4vZ0hLc2HrOmmtI4rVIP93FiihU1zipAFdir2K162cCC6SOKxSPs2eTRj0N8eqvrvKbXKBCT2ptiKBMi5hRDTltN07Qj9Nxtd3fhVG1t+KHl3KIj6KT9f0NlhcP+ZPlZFgEHlaR7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470871; c=relaxed/simple;
	bh=z4GjTBp0047FTk4klKJw58CTrWNyjYU7z4boSkF3uWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFQxTZRZWyFZInHQ0c+QyrIZTblBc6Vev7qsKpqXktqtrzZeDIB0WlvGIITQmrBQlxyJ9wbwi5Qo3USVaClkPYnrFujaF6GmJ1gMlDJJjvhXczd/Qysh+U8MTzx0vSAKC4FW8PpoVtmCAaJsdHQYr5jUT1Ht1WT+Z2sqkl/fdzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhCxQ8A+; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhCxQ8A+"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3598cab697eso749223a91.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 09:01:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772470868; cv=none;
        d=google.com; s=arc-20240605;
        b=awKRXgnmtlm8OaGPhRzsfu7dzlMcWAxSLGmQt8AuVlWYB51TmqA0A/RfhRpIakzbS1
         1Xb/kk2k/JkruhN/eDt/pewePNusUKSQp/LxtxewYAntVipE/O+twjgX3yFfJ0vpm0oq
         0EmJEcARWKhh47A2/g8lOOfdgUZqIya9enOkID/gFwaxlHSzIzYe74RipgZ1kObrk+N8
         SmrLaryJEVJ6S18Rnr9BtbZp6OCL/IY3WYcsi0NSdEpY2gH8j72n1kTkxPrXeHo+ctGi
         1mEOjcPQR6hgU5fTVei1Ri4k6UlKr4Z7+cf7RJm7qcZCg4ks5iXdLIxwNPDQn5N/TV7v
         UCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2DEb0JYVu1dtN1aahNfJKb9IGsdT+eKAhdynSWEB+PA=;
        fh=xBfXKAEsVxGrMrrec7UKjbNQGXgl3ochkZ8xsHsidhY=;
        b=elLtxfYtM1mhkN6uIJATSmxOdFpGW5QAFQOmjyzt+dr/GVxsR48g3v184tz/OAsQvM
         dvDZ2CMWIfolEhmRKSeKIzyrUOecliefRQfLN3R8ocH1Y/ZwvnCtucALf6Z+WM87XEx8
         x9C6mqtTa1Qi3x3/QinAE6C+ifLuDZAIdLSlUctTv8zjhSMxWFmKO5KOQCoUO8pw7cUN
         qZ6QACV4AMjEXQ6lsRqUkJs1lhUIzk0nJ/4MHlgqs61We/7kBVzGe7gpy1tWh4MbXkaZ
         yI/hzoyYbTxzDZOCcZxGaPhTvsWAMF+92iSEwGMJ0CRgRuDtHeu8vew37tglZn6sqaEd
         i0ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772470868; x=1773075668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2DEb0JYVu1dtN1aahNfJKb9IGsdT+eKAhdynSWEB+PA=;
        b=PhCxQ8A+u6rXRWoJgb7LXMc6SiNKG8WdopX6x+0UqSsFzPEXpV3Ewvd2XQYRoNm8f7
         1MdxX+5UWlDP6Fts7i1W1XacdjtfmRcfGuVOtfG7ofF17asw8ggq+lLjUc5xwtHWSX36
         8tkocsIwchtO/HqVaBuhQweOjLcSRrG4LLMwyDr6ZfG0NkhpOEYR1ASeazIrdJF6GSZM
         wG41YS2e3xr3tj+2H7IDyNMSf6orp6tmg41KyfUQKJSzLLSRsmlvfAVo13jWoxpLqLGG
         JYkhVoSSUSGt7aymdnnnRuKS/tjmr79lpHew6EHPM8awAUkCNUSjWmtTV5LVr1TQlirI
         QOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772470868; x=1773075668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DEb0JYVu1dtN1aahNfJKb9IGsdT+eKAhdynSWEB+PA=;
        b=KJhCp0r5Ly5t+zextd/XJGcHw7k38kkSTFTt/Cabb8y1fsyzxSLzP/zb79S63wLQy1
         pL1aCazwhZiZ/kJajYp9ojtqXyr6T+C5yu74C4RQicRA7UBssf8wssd0vesZgvK8FXSa
         YEmYahAqwnku8OK5PDMhEenQxyTGTIa5L6E95oG0Ny62oI3WBW2Lz3fX57aKLvhKZp4Z
         I4ixUml9P+Hp+2xxxpbtqx3Mf/A6ytCdAZrD5XplB7z/o7faCS0g21wylkV2FAmY4g83
         FGxCMpQMCY2OeuQUSI9W5AMiK76q2+MA13sVUG1yg4JWcqEuAnXRRvNPPSRsxv7wg0y4
         ijwg==
X-Gm-Message-State: AOJu0YyH6gtaiaHUp0b6jbMBCO/yizSG3cLsm64+Wj8PrTMg0tqm87ha
	r1FyWqmV0fJBSHJdWzin9XzsClunElsw59Sxrjx9HdOl69dDW0scPACuHDE6ryvLlu8LJfiGYHY
	wchjjVJMWBtBD48ciwOzh2/HxgWBu0+HkEmsr1bZAcw==
X-Gm-Gg: ATEYQzytqwOb5acp71J2PGsKqurigmhhfwJJvWe+0z3XzPItSF6TIYzEmD+wJUaddE2
	bpsD2fZZ3RlyT6pfhmmFP6cpyjrFpDHvop5YfRnEwUJpU9L5GgX8rx9ahb5qos9bkV3TrwoBtSa
	/QlcRT7cvQNIlV7gbUgTai956/AXfpZC9cJAb7uNd9LkvB5Or+BK69lktM1UlHXRAvyQd+C5dVb
	emS5c2eN+CpVF7Vvp2vKp+85+ZyHQihBc79punCGXCMuSI+NX11i7/17PvmIrvOS8zEVPoM7OG/
	HOF/qNn1YxtzQA1KkPfSaW8NfyBT79fiuBUFQYAy3g==
X-Received: by 2002:a17:90b:4d10:b0:356:21e9:73ff with SMTP id
 98e67ed59e1d1-359690182femr10536841a91.11.1772470867516; Mon, 02 Mar 2026
 09:01:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302164521.79148-1-r.siddharth.shrimali@gmail.com>
In-Reply-To: <20260302164521.79148-1-r.siddharth.shrimali@gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Mon, 2 Mar 2026 22:30:30 +0530
X-Gm-Features: AaiRm53kvr6BBnUHzIA5SM49qHiCiLgws5vazEUozOS0-sRzXE3KqPbnyT_NZPM
Message-ID: <CAGWgyh-_SUP67tA+ArzWd-WWYbpoeNDmVV_k+bvB7TSuWBJ_XQ@mail.gmail.com>
Subject: Re: [PATCH] t: fix "that that" typos in test comments
To: git@vger.kernel.org
Cc: algonell@gmail.com, gitster@pobox.com, jeffhostetler@microsoft.com, 
	Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Apologies, my previous CC to Jeff bounced due to a typo.
Adding his correct address now for the review.

On Mon, 2 Mar 2026 at 22:15, Siddharth Shrimali
<r.siddharth.shrimali@gmail.com> wrote:
>
> Several test scripts in the t/ directory contained "that that"
> typos in their comments. Updated these scripts to use "it", "the", or
> a single "that" where appropriate.
>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
>  t/lib-unicode-nfc-nfd.sh          | 2 +-
>  t/t0019-json-writer.sh            | 2 +-
>  t/t6416-recursive-corner-cases.sh | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/lib-unicode-nfc-nfd.sh b/t/lib-unicode-nfc-nfd.sh
> index aed0a4dd44..201ab9b24c 100755
> --- a/t/lib-unicode-nfc-nfd.sh
> +++ b/t/lib-unicode-nfc-nfd.sh
> @@ -75,7 +75,7 @@ test_lazy_prereq UNICODE_NFD_PRESERVED '
>  #
>  # Note that I've used the canonical ordering of the
>  # combining characters.  It is also possible to
> -# swap them.  My testing shows that that non-standard
> +# swap them.  My testing shows that non-standard
>  # ordering also causes a collision in mkdir.  However,
>  # the resulting names don't draw correctly on the
>  # terminal (implying that the on-disk format also has
> diff --git a/t/t0019-json-writer.sh b/t/t0019-json-writer.sh
> index 3a4e1cc7e3..0d30cd36d5 100755
> --- a/t/t0019-json-writer.sh
> +++ b/t/t0019-json-writer.sh
> @@ -290,7 +290,7 @@ test_lazy_prereq PERLJSON '
>  '
>
>  # As a sanity check, ask Perl to parse our generated JSON and recursively
> -# dump the resulting data in sorted order.  Confirm that that matches our
> +# dump the resulting data in sorted order.  Confirm that it matches our
>  # expectations.
>  test_expect_success PERLJSON 'parse JSON using Perl' '
>         cat >expect <<-\EOF &&
> diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
> index ed20de8ea2..63de0fc6cb 100755
> --- a/t/t6416-recursive-corner-cases.sh
> +++ b/t/t6416-recursive-corner-cases.sh
> @@ -775,7 +775,7 @@ test_expect_failure 'merge of D2 & E4 merges a2s & reports conflict for a/file'
>  # it feels sound to say "B and C do not agree what the final pathname
>  # should be, but we know this content was derived from the common A:a so we
>  # use one path whose name is arbitrary in the virtual merge base X between
> -# D and E" and then further let the rename detection to notice that that
> +# D and E" and then further let the rename detection to notice that the
>  # arbitrary path gets renamed between X-D to "newname" and X-E also to
>  # "newname" to resolve it as both sides renaming it to the same new
>  # name. It is akin to what we do at the content level, i.e. "B and C do not
> --
> 2.51.2
>
