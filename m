Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE441EEA54
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950234; cv=none; b=AbN1h1Yh5HkYMBboygMKaz3bZ5ogkJGftt3YwTwLknynUR7aCTX0bam5qg99jQPnLMYLUcXbHC9lZRa9gocPyyDrmIbUEiMDwcAXECAMrYJtU8jVk9QR28zMtaHVwbyLWaACJoMGcI+2HqV2JpXEZG8YEsv8tOcA2wmh3JTyW2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950234; c=relaxed/simple;
	bh=fHHJtP3l3VYJdVLLut8C08hzM/PG5QRK3qXz7vzvXR0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=M92Wrkh6FYLo3WW4Hb7oXZkWNTMN5rMK+LcqoYNvWmrCfLIwgv3KRJHiz32JN6sThOssVV1idv3IagX0L4lj0Pt2ljsZPai0FU5BjEQlGqfiwaTsIbXAYN0CauurXVExwSXEwgIAZUes9cm/DHitP+04bCbhomfBlpr8rUXj480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCisdy6X; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCisdy6X"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso48662515e9.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774950231; x=1775555031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2s/1AKmJ4291WZApuP7dWP2Hjf2XJupMJKR29fwbBkk=;
        b=YCisdy6X4nhdEdP8Z3NkQDHbKXYEBoOvcyOzoGctxflfWvw/F7HkmpbP+F9TFLNaUE
         rb4d0K7z3mJENqyhciZPn52/jNz9ml0r8BWPNfEBBmYkEqGB9oDZdH8eQBlbU1Wkxj9k
         c0TseZnx7oR5RC6Fy7fuvaRbNCxoQ+sVdNP7IK30m6Oe/fNZw+TEaySDzVUrlAWFS7oK
         rOLMY2nVK972fiSFc3+uCCWoiEypSJRAcSmSbsqUZ1mY95PKesLBQCTM4F5MMB8t52YW
         FXwRzkZAriX5B19HZVjxX+QlkuhDcHJ/Fzyi32n/61PeZ8zT8opn05XBM5HwBGY2hQ4E
         fFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774950231; x=1775555031;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2s/1AKmJ4291WZApuP7dWP2Hjf2XJupMJKR29fwbBkk=;
        b=hh8xmp/M75zfxdoNiq2c7qQh+EZtkd/Z+6s3cTO2UWk8/pn3AULWgrPFLsp0xyJ8iz
         HtGSJzkKuoPWZ5hbmBmTPVnaHgMbYlkfAtpghmZE8XTKPt0GHpWnbQ9PxeBCiOp0LbOi
         0L00lP5BOtqcHGsSMk+K+MgLwyQB0X/7EyjUS0a97T2Jt2GA3AMRg0R31UKV+F5xpXic
         eBBY+fd1OoLhgGD6CMXu5KcfSnV/mV+GyWZaksCaLeF+vDqLWJscCAJ7dCr2rxpEEcbF
         8jWfFpjEyaFOHxthol4Wi7Dd5148HttIAUy27/i6YGUa45pQkEQVVbEKCf2Pgkfc+VQ3
         OqMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr64pB7xTXL7WjB66YtBRWNiQn+Z8LMTlJeMF+yVN3s387sptegmLk+aRfa7yE9GgXD/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcbv/9W1pvf775gIsk1S1vrPYcYPGd/Ul2i8qd3pEvWMvqsvre
	gVYj+2TMJ9FUj43PEHIW5ovK5aqes5Khd2bpCbEqmeh3LIYQR54uZ3o+
X-Gm-Gg: ATEYQzwN1VURflT88FPkBiCPU261bybocvducrK6bxVeAH+C3lZtii2SaYyoxKAcac/
	5TZNz9HRshvayaF6ygTJJGzPv8K2nSMNx1fZWS8EZqqEUQWJ8kdEmd+onKcb15PvPDmZfGgyNNJ
	dyIw9NjT+edfItxSO1vfM+z17eZ01ZCPZvkVKlDTcw7umKnmRJFjYIg4ZoZx6srIGW76kKzYSlw
	8EiM9Fpg+vhRrkrM9oLxkq5NJ+wyHpCFy87sLJu0d76efKQHQ+6B7S/iXOR0I6+JZgcBOHWLtQ5
	ao7MaEpRDgDUIwQx0GW7+phEB0IKqCJRItztEwWIzfcGdY/f3LACxljTU9/3YBdIAxFdL/moA2W
	Up2a9/B6pARt9r3LEM5fQsOA125SlRjYTWkrsZEZKq0KOZllKRTMCkwj7NZnIPBbU5xGrirNQI/
	EashTuegAPNbkeza2q4HCX3eeTZiCVmDgZjfZXFJGYwuSz+uTXz9QulfyOPLO2f0wjEf7EJ2Kcq
	5MRaUaTwo3f/A==
X-Received: by 2002:a05:600c:4e08:b0:487:1fb4:7b3 with SMTP id 5b1f17b1804b1-48727ef0cc2mr292074105e9.23.1774950230951;
        Tue, 31 Mar 2026 02:43:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e81a20asm25393705e9.7.2026.03.31.02.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 02:43:50 -0700 (PDT)
Message-ID: <40589b6f-6694-4d9c-8367-3f6352e45e7b@gmail.com>
Date: Tue, 31 Mar 2026 10:43:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 6/6] xdiff/xdl_cleanup_records: simplify INVESTIGATE
 handling for clarity
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Yee Cheng Chin <ychin.git@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Jeff King <peff@peff.net>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
 <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
 <fd14ccafc494aeda4bb9d05b83ac09f35bec8b52.1774890003.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <fd14ccafc494aeda4bb9d05b83ac09f35bec8b52.1774890003.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

On 30/03/2026 18:00, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Make it clear that INVESTIGATE is turned into KEEP or DISCARD based on
> the result of xdl_clean_mmatch() which reduces actionX[i] into a
> boolean value.
> 
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xprepare.c | 34 ++++++++++++++++++++++++----------
>   1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 471d9567c9..1f2e8c6b4b 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -329,24 +329,38 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	 */
>   	xdf1->nreff = 0;
>   	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
> -		if (action1[i] == KEEP ||
> -		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
> +		if (action1[i] == INVESTIGATE) {
> +			if (!xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))
> +				action1[i] = KEEP;
> +			else
> +				action1[i] = DISCARD;
> +		}
> +
> +		if (action1[i] == KEEP) {
>   			xdf1->reference_index[xdf1->nreff++] = i;
> -			/* changed[i] remains false, i.e. keep */
> -		} else
> +			/* changed[i] remains false */
> +		} else if (action1[i] == DISCARD)

As one clause uses braces, they all should. Apart from that this looks 
like another nice improvement in readability.

Thanks

Phillip

>   			xdf1->changed[i] = true;
> -			/* i.e. discard */
> +		else
> +			BUG("Illegal state for action1[i]");
>   	}
>   
>   	xdf2->nreff = 0;
>   	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
> -		if (action2[i] == KEEP ||
> -		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
> +		if (action2[i] == INVESTIGATE) {
> +			if (!xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))
> +				action2[i] = KEEP;
> +			else
> +				action2[i] = DISCARD;
> +		}
> +
> +		if (action2[i] == KEEP) {
>   			xdf2->reference_index[xdf2->nreff++] = i;
> -			/* changed[i] remains false, i.e. keep */
> -		} else
> +			/* changed[i] remains false */
> +		} else if (action2[i] == DISCARD)
>   			xdf2->changed[i] = true;
> -			/* i.e. discard */
> +		else
> +			BUG("Illegal state for action2[i]");
>   	}
>   
>   cleanup:

