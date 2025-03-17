Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379211537CB
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231544; cv=none; b=DkzcdOcAN+kpTZD8PtaaCtjmc2iY2RoJ71nAAetkhdv4iK4eSStOq4WjXdf9b9Ck0emzHSlD7hQhI3tAyF6VYPTZxZGPnU91+aW5KiyC0Q5xf+3HJK3FNtx8Xrf1nkTwX4ynzJIqNaCoWmPD26wY7+3/3E+N0XHiiqsXlqR70+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231544; c=relaxed/simple;
	bh=VFXCHEhTWnkoFdQjaTNk0WYvWnhEhW1qJ8u8zgh1Hjw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qTxnwH6E4BTdct9SsBefrKbWt0LOB+hVs/o61XydWW+rmZQero/neGYXSa4aCJlT4GdkbPta49rSfWPIi2VpdgfJaWTe9EaMX49PExEWoQYU69cCEzZTUJmfpUdD/H/yWYRVd4WEj19Q81YJUPcM95DoxuT3fQgOPgkiIdXOF1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRxHz9TN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRxHz9TN"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223fb0f619dso77626205ad.1
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 10:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742231542; x=1742836342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=57zIa7JdEUfYK9yw3ke8ZTtJo8P13H2UAl/TGRozXCo=;
        b=nRxHz9TNNtSZWeMFo+jVkB2sZZzF2xZnBRTn1XRqaIHHZUNhtYV5il+jRbrTjh+wzR
         v8J+PBOW3XUeVMI3h33ojXJ2GNQQ/qyRCj7vtqJPQFsrrEgoqTM/Uc5XK+WPQ1v9jh/u
         KDG7iHqgNMBDonzW8MMftccgS4PC/VRuqGE08m7EA8A/iMer0jGgaakgRcbrv6DhOUlv
         yFnrQmo9VdOjgC39I0qHKMWIBlp0KJFDGwDlORSb8yBACcx+zl5wUoyfR3q6BE3aFX8b
         erszEzCbdrHjgW4OQ/cjTcT7Pw5I0z8eigbu+QCUgFKpeMFymPnHNXlm/VjgqoTVksY8
         2z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231542; x=1742836342;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57zIa7JdEUfYK9yw3ke8ZTtJo8P13H2UAl/TGRozXCo=;
        b=ppO7ziD5ValyGPEakCGnvuT2d45t1Kgv3kVYicvyPjsrQI6Bh0cIGog6quHYF54H6b
         fLF1EC2wwgoquH2uZEGI8t+QHbB5nmGRHGXj0PIR76U+vVOeyojggiWHXYspPcnCeTgH
         dw3a5qYvQKkYzDl3xW9C7EBNCjDVbRWpe1jbcAnWmonzNY5LNgkxHrD9BURkZtpxDWmi
         ectQyWNrQ1m/XpnkQ14T4lIjgD/WaEwelD9FSU3pwiVi9oZLyue/9DGeKfjG1vyCcAyf
         Qh63vcD6igy68W3ETDJje+lSwjHAphYMPWpBCd4vYPIK0/rGp0m7TfXa4FrbGxaJhMW0
         mw1A==
X-Gm-Message-State: AOJu0YwvaEFlLUlYR295VaoDdeYqrTkW/S2kda8tFj69UIEORy5SihMU
	ePELhzPTl2YfFZ4hPuIaaDGBSrAZK4jvyUObNUTITazx8NbL6K3Q2Fc0Uw==
X-Gm-Gg: ASbGncuylUidQ+Sf2QVCFTYRiGUkqnZE4nZdUBbzoMBD8rEgAUfVK6uuatIDxTLwvKp
	yx2YCUfe/x2oKXgXHzCae0DYFjd/+bUxStNLZZxnALJ7PfRKXTaquEwL8gjzWXvIoJjpQuPylih
	DyF9P/WVYfcx7L+rA5m2k1q6AiPZ37wT9LJewahvioroMUNokzKy3BYjqZACskiuMRiH4438K76
	8fwfGCa+6omndlb2+Jm0gtHLU6hegFeqjkYITLtzPKP9xgSuSsGCKSVo8GtexeePWvjneyb+DMr
	zZZrrD1HnxwSN01WLLWeDAcn0ICW27Mf8gzS6qTcTETraMidpX/BAJEJgvePF/o=
X-Google-Smtp-Source: AGHT+IFQGEh1Jac3KyhkB0G8AnW/R9XBzt60Kb5kHPB3NhyQJsNhqQgCvLeWmtwQRo91vFAeycKhpg==
X-Received: by 2002:a05:6a00:139f:b0:736:9e40:13b1 with SMTP id d2e1a72fcca58-737224726e5mr13886824b3a.23.1742231542199;
        Mon, 17 Mar 2025 10:12:22 -0700 (PDT)
Received: from [10.53.2.153] (125-86.iitb.ac.in. [103.21.125.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167def8sm8116355b3a.90.2025.03.17.10.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 10:12:21 -0700 (PDT)
Message-ID: <a6cd8557-6701-4aa8-af07-8fb90bf7f846@gmail.com>
Date: Mon, 17 Mar 2025 22:42:20 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v3] rm: fix sign comparison warnings
From: Arnav Bhate <bhatearnav@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
References: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com>
 <71098ea7-9136-4ab2-8e15-27017773e054@gmail.com>
 <306aa7d0-3621-40ba-93c3-77536e56b73a@gmail.com>
Content-Language: en-US
In-Reply-To: <306aa7d0-3621-40ba-93c3-77536e56b73a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Arnav Bhate <bhatearnav@gmail.com> writes:

> There are multiple places in loops, where a signed and an
> unsigned data type are compared. Git uses a mix of signed and unsigned
> types to store lengths of arrays. This sometimes leads to using a signed
> index for an array whose length is stored in an unsigned variable or
> vice versa.
> 
> get_ours_cache_pos is a special case where i, though derived from a
> signed variable is never negative. Move this part to the caller side
> and make i an unsigned argument of the function. Rename i to
> pos to make it descriptive, now that it is a function argument.
> 
> Replace signed data types with unsigned data types and vice versa
> wherever necessary. Where both signed and unsigned data types have been
> used, define a new variable in the scope of the for loop for use as the
> iterator. Remove #define DISABLE_SIGN_COMPARE_WARNINGS.
> 
> Signed-off-by: Arnav Bhate <bhatearnav@gmail.com>
> ---
>  builtin/rm.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 12ae086a55..a5c9fc644e 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -5,7 +5,6 @@
>   */
>  
>  #define USE_THE_REPOSITORY_VARIABLE
> -#define DISABLE_SIGN_COMPARE_WARNINGS
>  
>  #include "builtin.h"
>  #include "advice.h"
> @@ -40,14 +39,12 @@ static struct {
>  	} *entry;
>  } list;
>  
> -static int get_ours_cache_pos(const char *path, int pos)
> +static int get_ours_cache_pos(const char *path, unsigned int inverted_pos)
>  {
> -	int i = -pos - 1;
> -
> -	while ((i < the_repository->index->cache_nr) && !strcmp(the_repository->index->cache[i]->name, path)) {
> -		if (ce_stage(the_repository->index->cache[i]) == 2)
> -			return i;
> -		i++;
> +	while ((inverted_pos < the_repository->index->cache_nr) && !strcmp(the_repository->index->cache[inverted_pos]->name, path)) {
> +		if (ce_stage(the_repository->index->cache[inverted_pos]) == 2)
> +			return inverted_pos;
> +		inverted_pos++;
>  	}
>  	return -1;
>  }
> @@ -58,7 +55,7 @@ static void print_error_files(struct string_list *files_list,
>  			      int *errs)
>  {
>  	if (files_list->nr) {
> -		int i;
> +		unsigned int i;
>  		struct strbuf err_msg = STRBUF_INIT;
>  
>  		strbuf_addstr(&err_msg, main_msg);
> @@ -83,7 +80,7 @@ static void submodules_absorb_gitdir_if_needed(void)
>  
>  		pos = index_name_pos(the_repository->index, name, strlen(name));
>  		if (pos < 0) {
> -			pos = get_ours_cache_pos(name, pos);
> +			pos = get_ours_cache_pos(name, -pos - 1);
>  			if (pos < 0)
>  				continue;
>  		}
> @@ -131,7 +128,7 @@ static int check_local_mod(struct object_id *head, int index_only)
>  			 * Skip unmerged entries except for populated submodules
>  			 * that could lose history when removed.
>  			 */
> -			pos = get_ours_cache_pos(name, pos);
> +			pos = get_ours_cache_pos(name, -pos - 1);
>  			if (pos < 0)
>  				continue;
>  
> @@ -314,7 +311,7 @@ int cmd_rm(int argc,
>  	if (pathspec_needs_expanded_index(the_repository->index, &pathspec))
>  		ensure_full_index(the_repository->index);
>  
> -	for (i = 0; i < the_repository->index->cache_nr; i++) {
> +	for (unsigned int i = 0; i < the_repository->index->cache_nr; i++) {
>  		const struct cache_entry *ce = the_repository->index->cache[i];
>  
>  		if (!include_sparse &&


Please ignore this one, I sent the old patch accidentally.
-- 
Regards,
Arnav Bhate
(He/Him)

