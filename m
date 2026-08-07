Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BABA3955EB
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113460; cv=none; b=kiuceisGjFzfoeVB7xWfbJni7MK9YhR6DVkMUwu2SWg8s74GNs/wZoAsRyNg06k+11/ZPJ0MBo9dJN5Wy7/u0xLWtW4AzWgLBDQDJF59dY1GjyQ9aXHLypSvD0JWqiSOFTtP53J09o/74ae3vjp/razSkaFDefMogzS7bZcaNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113460; c=relaxed/simple;
	bh=8ttVBm3wUuNtbwSCIgG3Tppka3yR28nnw2SdMZma8hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t21I/A9fx9GtCLTL+p3AXbK8y+EAPckSbwvJpoPmAXbvEfhOKBHXG5TzZ7rPdgZALAKY3Wsy9sF3VphdYkOi39njnf3LPrkwlAN+uoHZRL/hlPL+gUfhvB09Db8vcue+rHK4f3vF8BVgEtDsNuIwr79C/8Im+RgUubXpH4PvWsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+Ek5wy5; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+Ek5wy5"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so27018846d6.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786113456; x=1786718256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+1xvFAI26WkSzQM67WffQ9sr/qsVdDWC59oxrEjpsEY=;
        b=o+Ek5wy5It7pIY35u9x5r7L0Z6YlSj3gQPrK4LiqZtlzlSJnEH9EPt+zM+7SukuLXl
         xxQOuazzseWZbjxOY/HzqQXErQHmvjgqPiUQ9qNBVTN5r+JM3V4OK6PtngwLynqAcNQR
         UmktLfZlwoQ2yRubxtmEWkl01EgjodmYJ8+fjg2+SYE7xQdQSp4nLDJSYa+NDOmZoER9
         2ObRz/Di9mCeoD+33cApvKXC/H3y2K6E6B7MXBUW4y5w21VT5Sc0HIgq+3NSwgZ8wITz
         tBIxyRvlzcJ/YS8Qhjh8X+XyjMWta8SOmZcy8BEwQ0+x/WyEyRFJJsQdMNDl06fzULNI
         QIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113456; x=1786718256;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+1xvFAI26WkSzQM67WffQ9sr/qsVdDWC59oxrEjpsEY=;
        b=OsIbgE8kb0ZFI27iRmpMVcZC+KeRAobWHMcXe6eehQ8WJnbeKLg6KVNhXWg8lfLXIy
         +LtNgAgnJ3q5TQkfGtdJJHGhrAG+kjq6gh4vOZKyC0iyvUMMlF8wBRZtOIZEegf4nr7X
         MbIkqOF0Y5DIUgCFo7zbP96WXrBTRj0BG3ZWIdWo5jPZjnYcV9bsjciuIUxAvSsY8xp1
         bYIs0Ir/RGe3P0Dn1xFlTLiCF1grrXAgX8ue7c+il+MHw2yc1BAnrgZudrNewqv/x0LK
         JUOFnYAsWy/EK63LHJep5AZNasmG7dOUNX9cqmSjFvXhbWDVOT02D/KLplJgc7rYy606
         D7dw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9tnXt9JsJuiwMpcnaTDryXZlXg47REt0qYhO7/+wxdAuoKt4q/6c1urFUDFOqm14P/gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YydnN6fbzfpGpNOoMNk+9+8lQxjdzGyz3JGivDx4wPZwFQDicOV
	9LmPkW8hju2cg5lgbL6RuRWGED/BxNPl+7L9aXxQhvGLLxKICw8KDlG5
X-Gm-Gg: AR+sD13/sM7C62YubX88lYAGxan+JCxaWmoNK0kHHM+6sIKtLBTs4cWr/i5eVPlP2AC
	EMIQz+NKuYN1Zvndg1fsv0hYD5yUuF37gtM0wwAHDW5BwqwTa5xISd3voMXwJzcf6FZLMyI6m00
	F7I4qGm4vVTdVxXQUS+drjvlSrQE5lHIF3mYV5DbYsPqH5nNpVSc//O3C8JFN9/IHJzxUsXj6q7
	29dgbQQvW9ZyOXuEvBwFH2N4XVU+vxNfJqkbwQgz++CQ0U1pQf8JGog2Acs9ZmNurK2uey48SZN
	c0INm5aeicucVSI4uRIMGek4OaVNArhCna0if6Zsl5tvreUHHm7RR9JMofrOJj6aPlb3ALHr65u
	dikBnQylUivkAuEwQZaX8UMvDML9oxzMaMgu6+h6OihjYHkt9WwlrIYT5T+VG5taA0LvIrTbUVM
	d6wBUSTPVe2CQpXtEJ3W1MW22R6X7nsno9x6rYfc7LAd/f4sJ+OyNoqpalrU3qrlFQzcnw7lcBP
	EvTzOcLVd0tzqIbfCCTx/DbRhqkj42OohCe
X-Received: by 2002:a05:6214:f2e:b0:8df:98e0:4594 with SMTP id 6a1803df08f44-90a34677432mr5718426d6.15.1786113456225;
        Fri, 07 Aug 2026 07:37:36 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a9300db9sm10006046d6.23.2026.08.07.07.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 07:37:35 -0700 (PDT)
Message-ID: <f25e5fe8-cf6a-4d87-9c46-bf5b7490434d@gmail.com>
Date: Fri, 7 Aug 2026 10:37:35 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] gitk: avoid constructing dialog titles from text
 pieces
To: Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
 <1e1bcfaf5bbe66fac364d5b7d3a7ebdc5f37531c.1785998419.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: mark <mlevedahl@gmail.com>
In-Reply-To: <1e1bcfaf5bbe66fac364d5b7d3a7ebdc5f37531c.1785998419.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 2:40 AM, Johannes Sixt via GitGitGadget wrote:
> From: Johannes Sixt <j6t@kdbg.org>
> 
> When the user clicks a color preference, a color selection dialog is
> presented whose title is provided in parts by the caller. The dialog
> implementation must supply the rest of the title. This is unfriendly
> for translations. Provide the full title by the caller. Rewrite the
> texts to be more natural language.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  gitk-git/gitk | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 9e735d91bf..454f54dca8 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -11836,34 +11836,34 @@ proc prefspage_colors {notebook} {
>      set coloruielems [list \
>          bg          bgcolor {} \
>                      [mc "Background"] \
> -                    [mc "background"] \
> +                    [mc "choose background color"] \
>          fg          fgcolor {} \
>                      [mc "Main text"] \
> -                    [mc "foreground"] \
> +                    [mc "choose main text color"] \

> @@ -12014,11 +12014,11 @@ proc choose_themeloader {prefspage} {
>      }
>  }
>  
> -proc choosecolor {v vi prefspage x} {
> +proc choosecolor {v vi prefspage title} {
>      global $v
>  
>      set c [tk_chooseColor -initialcolor [lindex [set $v] $vi] \
> -               -title [mc "Gitk: choose color for %s" $x]]
> +               -title "Gitk: $title"]
>      if {$c eq {}} return
>      lset $v $vi $c
>      set_gui_colors

This with the prior patch should help translation due to use of more common idioms and
complete phrases rather than jargon. Good.
