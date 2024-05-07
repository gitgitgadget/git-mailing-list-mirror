Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3465137E
	for <git@vger.kernel.org>; Tue,  7 May 2024 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040695; cv=none; b=knMygsuSPqELcEz+66VVkjvDTtGi4VRL6ki9b8ByLXNrVL5OKO0sFZ6pqipSc6HCztrUlxlRsuEo6P9bBJcsNw6L0Fwa33uZ0TH1je8DSUYaQPPBjQte3RIsSl+ltIVWXAuCmUCmBJ/PSOydLNYwmgxXe2/HhBazmlTHifMGrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040695; c=relaxed/simple;
	bh=4KNZNAnrNaKwbRiajS93u/1At6AgAaHhSyvJ8B57OBY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PXzpytB/8IfVD0nrm54h11r5j/YWKwGgQJ6wlwgvapgczBGbLC7gJYnMcjeSVmzk1Yj0MiboULm7FOf58X32z2luYRfoLdMKE9UPO/G588g93LdCwKSZs3Arq6WxbZHRij76eIi1MrNIqnyEjbDhjDbxjMBjB65BF96sa+q7sEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=s6qkyT5y; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="s6qkyT5y"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1715040689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqf4zt2dThQwFmiglSZr3gOBWwYRTIW7vwbzbBL9oDY=;
	b=s6qkyT5yGKPTKBDsG+EmfL57FMGJ86jfljiM1EzJG4rync+gryf7CmY8se5BbYAmsyeAja
	XNwBz/eom2SETgL6sswJWqWmZFsTk8CZvs0L9oZmPfKsf5u0/KthDNId/gylZOpIMz8CvH
	rjJinb3lV4zhdJaqCcfXjWfUWXsHgXwsAOMThyCNOxeM+Tlyqk3rL19ZQQ4MEcuT579HpG
	v0fiWmXcY5DkSAjyxcpRtUPUhAT5LWID4GdFLRVc0iKdJTFAAngqLqvsFQib7XpWBg+n2O
	TShfGaf9aWHSBWua/a4VIwaq9dLYYC6nk7VUivXD71pYvC2izmv+/p+A6LLEJQ==
Date: Tue, 07 May 2024 02:11:29 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Eric Sunshine
 <sunshine@sunshineco.com>, James Liu <james@jamesliu.io>,
 git@vger.kernel.org
Subject: Re: Re* Re* [PATCH v4 0/3] advice: add "all" option to disable all
 hints
In-Reply-To: <xmqqbk5i3ncw.fsf_-_@gitster.g>
References: <20240430014724.83813-1-james@jamesliu.io>
 <20240503071706.78109-1-james@jamesliu.io>
 <ab604f4b73eab1d9aae4e2a20ba0630e@manjaro.org>
 <xmqqjzka7p2t.fsf_-_@gitster.g>
 <CAPig+cRZEQjwhnMYvQ_0BjvXaR=3x=LQeJHzFOxC+ZPyOy9yJQ@mail.gmail.com>
 <xmqqbk5m65i8.fsf@gitster.g> <xmqq4jbe64l9.fsf@gitster.g>
 <CAPig+cT-xk13jGEUmpT5QmwVYTxKNUZsu9xJ=Ph3h4AzKHg6pA@mail.gmail.com>
 <34d77e4d-6edb-99d0-7fc5-fea5224654c7@gmx.de>
 <xmqqbk5i3ncw.fsf_-_@gitster.g>
Message-ID: <5665eef37193e8a6894f100a554bce4d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-05-06 18:40, Junio C Hamano wrote:
> So what's the conclusion of this discussion (have we reached one
> yet)?
> 
> to me it sounds like everybody is on board to raise the default used
> for format-patch.  In the old thread I said "I use something
> unreasonably high like 9999", but my "unreasonably high" number
> these days is 999, which was used in the earlier weatherbaloon
> patch.  The old thread ended with an academic "we know different
> defaults are appropriate, but what is the right number then?" but
> anything higher (like 999 or even 9999) is better than the default
> for range-diff which is 60, I would think.
> 
> Here is the patch, this time with a bit of documentation stolen from
> the old weather-balloon by Ævar.

After going through all the linked discussions, I think that introducing
the new default value for the creation factor in "git format-patch" is
the way to go.  However, I still have one remaining concern.

See, the creation factor is described in the documentation as some fudge
factor, specified as a percentage.  Without going through the actual
source code in detail, a question that pops up in my mind is why do we
need to use 999 or 9999 as the new default value?  Shouldn't 99 or 100
be good enough instead, if it's a percentage?  I'd assume that the same
question might be asked by other Git users.

Admittedly, I haven't produced numerous range diffs, but for what I did,
90 worked very well as the creation factor value.  I even created some
aliases that specify 90 as the creation factor value.

> ----- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] format-patch: run range-diff with larger 
> creation-factor
> 
> We see too often that a range-diff added to format-patch output
> shows too many "unmatched" patches.  This is because the default
> value for creation-factor is set to a relatively low value.
> 
> It may be justified for other uses (like you have a yet-to-be-sent
> new iteration of your series, and compare it against the 'seen'
> branch that has an older iteration, probably with the '--left-only'
> option, to pick out only your patches while ignoring the others) of
> "range-diff" command, but when the command is run as part of the
> format-patch, the user _knows_ and expects that the patches in the
> old and the new iterations roughly correspond to each other, so we
> can and should use a much higher default.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-format-patch.txt | 5 +++++
>  builtin/log.c                      | 2 +-
>  range-diff.h                       | 6 ++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-format-patch.txt
> b/Documentation/git-format-patch.txt
> index 728bb3821c..b72f87b114 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -346,6 +346,11 @@ material (this may change in the future).
>  	between the previous and current series of patches by adjusting the
>  	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
>  	for details.
> ++
> +Defaults to 999 (the linkgit:git-range-diff[1] uses 60), as the use
> +case is to show comparison with an older iteration of the same
> +topic and the tool should find more correspondence between the two
> +sets of patches.
> 
>  --notes[=<ref>]::
>  --no-notes::
> diff --git a/builtin/log.c b/builtin/log.c
> index c0a8bb95e9..73608ffef9 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -2274,7 +2274,7 @@ int cmd_format_patch(int argc, const char
> **argv, const char *prefix)
>  	}
> 
>  	if (creation_factor < 0)
> -		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
> +		creation_factor = CREATION_FACTOR_FOR_THE_SAME_SERIES;
>  	else if (!rdiff_prev)
>  		die(_("the option '%s' requires '%s'"), "--creation-factor", 
> "--range-diff");
> 
> diff --git a/range-diff.h b/range-diff.h
> index 04ffe217be..2f69f6a434 100644
> --- a/range-diff.h
> +++ b/range-diff.h
> @@ -6,6 +6,12 @@
> 
>  #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
> 
> +/*
> + * A much higher value than the default, when we KNOW we are comparing
> + * the same series (e.g., used when format-patch calls range-diff).
> + */
> +#define CREATION_FACTOR_FOR_THE_SAME_SERIES 999
> +
>  struct range_diff_options {
>  	int creation_factor;
>  	unsigned dual_color:1;
