Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B233291F
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680257; cv=none; b=rETa/O1Y5DOft9GdpRD5062pjJsJUp/v2++Peh6bEpcuNohCjCfmZNxa/8oWlQtPlg0og2hnFk9i6c2dOJFFu0ji5T0qBD9SS788Qb2T86JeYtTg/3KzZQTC3pb3a2DZKR8wdnMIfshse7mbZqwOL+F/MwCRNJtdrCanc6NXPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680257; c=relaxed/simple;
	bh=77sw9HNyE5Xcc1YrF00VMBy53PCgcHngT9D22zXRCuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSmjS1vfb5NycY8Zof3Up5zTaaAz5uplQ0alGO/oq8WuGiOQOjzdyAmRQKF94Vxfe91kobDM2K0JoKr8ko7Tgmc8t64pvGmr7kXbu+0OATebVJHYucmI9aZUONxJws3YYaYRVQyzi9mPaiHmYJk/BooMF0kS/AQ9HppWEa0nVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htjVkjbr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htjVkjbr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4855dbfc129so23644455e9.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773680254; x=1774285054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=umm1way6SOAvSdDM5le2ICO6VoYevosKMgUCabHSBhU=;
        b=htjVkjbrntMzLpAHsveNqN2mBYXM4dmyN0Rq3AXg84ZO2QGEZEZIJ11A55lsr6culU
         9zXwTX6E8tyfoZ2G21wD/+tzfnWU9J8NAkckxhmc3FS8jS9/jFQRBxa+aAziFLVP+eQx
         /WOgrJAB8zYgwUgVzDS22uhM+1zbmM1jNaEiGKXUazteM6yWzNithGWa5fTmh0Cf0llJ
         s1yuVr4uPKKokJonV83kokgvOTX+YSdGfwpxVXV2zVAXayA9oozDn8tkZJPMdUessg2F
         CXA+uqvVvdX/opKKfpKM0SS2AqW+mI/fdBTk0da1AfHR9r53//7zp/gZuGjptewCNkyy
         MJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680254; x=1774285054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umm1way6SOAvSdDM5le2ICO6VoYevosKMgUCabHSBhU=;
        b=od/SyQtrlV4SanFyEVctRJOQfjuxch3+i4srTf6kGFh3EWW263THnHt5RhHuqxUJOD
         M++Kcw9cR5xnD8KhxLQXEjFWRI7W0sNFLexgmB+UlAkJhdavYkd2crXXex/L0w+H6pT6
         bzNHntT6h08JJ1K3wQDGylIDGQr9RQXMEf3wnDyWHjoGzS7yqQgW6J/3NG5NWO1xQnUe
         6RRbGT4xW5eiEvYePehduiVphA9Zy/hhpX8UYcqtURu+0X9LCGrYsEFUs6KgknMUmQaa
         Dk15h7fOkQ3Qoi5vg69s3jOtB3+h3dC/QvCd+rlB3GTJoWBAeTiqptiUvPXOeRWYTnf8
         XeYA==
X-Forwarded-Encrypted: i=1; AJvYcCXfzwjfP1DiAOwO7WcubErIsXIJetU3i4vSMPVHV2PgOEwx+SzfrCuyNIXx393WJr7xPjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx52s5DqS8KC6frD6NKMwvzpMaTjzsZNnYapak/BbfnBB6SkOTv
	E4Ha0RCTUq/1sfoyKvSuY02GJyCF9VMmynr0oWzN7P1mHxFE+MXWJoVw
X-Gm-Gg: ATEYQzyQbpyLtcEaaA/y4NIBZqV6ME3AVvM3vEFk12tZoH4ko7ipVHEayQjgCOb6FUf
	AD6+2CmNW/JXsW3x9rEJPwiieWiboePMw4XX8sUMeMzfV1Rx271tjkiLi0xScbzicWJICrOIK+Z
	sv9zn1KUs0VMVGfhDgWDixi5cgGUXWTrEMlfEGZJKoNis9yc94m1fOgdGMcNkHFDhWZ9OUMFZ5t
	KoG/MCNaW1ye2gE+aaBJL9GUJbD5MremJUG0eWJE8RmxyX5VwQH5zX0R6+794QBi1xRlfDUQ2Ji
	CvMvWpZQY6x2u9GedARFj9G9cAGIaq5xINYT6w3SBzmY6FNf5h5msBGS18Rrsz11wUJwOkXPNfc
	L/mFSs30KTLnDFDi05FG9KHyOJORZOb9qAHycRisFP3Dxfhub3Qw+k9LbJ4EGz9/1TETDDTA4Gr
	6lfYz5SSkL8kIfggiAETs4U8bPC7fpk4UOUSgxTuhyF97vfT0NiMS7g4bpVoNyf0o8dytFf7eb2
	5P6te7zozgxCLFi
X-Received: by 2002:a05:600c:c8d:b0:47e:e2ec:9947 with SMTP id 5b1f17b1804b1-4855671052dmr229335715e9.33.1773680253783;
        Mon, 16 Mar 2026 09:57:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8fad1sm10011425e9.1.2026.03.16.09.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 09:57:33 -0700 (PDT)
Message-ID: <6033b9ea-f219-43cc-9ce0-901594364ccd@gmail.com>
Date: Mon, 16 Mar 2026 16:57:32 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/2] sequencer: extract revert message formatting into
 shared function
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, karthik.188@gmail.com, johannes.schindelin@gmx.de,
 toon@iotcl.com
References: <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260313054035.26605-1-siddharthasthana31@gmail.com>
 <20260313054035.26605-2-siddharthasthana31@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260313054035.26605-2-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/03/2026 05:40, Siddharth Asthana wrote:
> The logic for formatting revert commit messages (handling "Revert" and
> "Reapply" cases, appending "This reverts commit <ref>.", and handling
> merge-parent references) currently lives inline in do_pick_commit().
> The upcoming replay --revert mode needs to reuse this logic.
> 
> Extract all of this into a new sequencer_format_revert_message()
> function. The function takes a repository, the subject line, commit,
> parent, a use_commit_reference flag, and the output strbuf. It handles
> both regular reverts ("Revert "<subject>"") and revert-of-revert cases
> ("Reapply "<subject>""), and uses refer_to_commit() internally to
> format the commit reference.
> 
> Update refer_to_commit() to take a struct repository parameter instead
> of relying on the_repository, and a bool instead of reading from
> replay_opts directly. This makes it usable from the new shared function
> without pulling in sequencer-specific state.

This looks good.

> +/*
> + * Formats a complete revert commit message following standard Git conventions.
> + * Handles regular reverts ("Revert \"<subject>\""), revert of revert cases

Not worth a re-roll on its own, but for future reference in comments you 
can use single quotes to avoid nesting double quotes i.e. ('Revert 
"<subject>"').

Thanks

Phillip

> + * ("Reapply \"<subject>\""), and the --reference style. Appends "This reverts
> + * commit <ref>." using either the abbreviated or full commit reference
> + * depending on use_commit_reference. Also handles merge-parent references.
> + */
> +void sequencer_format_revert_message(struct repository *r,
> +				     const char *subject,
> +				     const struct commit *commit,
> +				     const struct commit *parent,
> +				     bool use_commit_reference,
> +				     struct strbuf *message);
> +
>   #endif /* SEQUENCER_H */

