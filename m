Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E424317D
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774063908; cv=none; b=dxYwwyJRguqrsPbWo0EDK81xxN5rFwgo/O2yeNPjefxl4plo+KWiuVtQ2z8fC3YOY3Do19gM5je5ZW1eiUkrMvyZeocV6/GxnKToTqLCiW9QDvn1XSxNrA/+F/ue2NMUqJI/ajFaGV+T7vK6thws+m07FLVh/24eNOuLCfGYlrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774063908; c=relaxed/simple;
	bh=4hkI+bj8/FDDUi3jLH/3MuTUHJ/YzHlEsfsbhBmkmKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrOYGgKOLZvlhl9kdRHkqGYNcxJx1SwDWfTfsjXCI0HHLuFOMCj+vN1TwEjwSR1DoY+pQSOYo887Z0X1kBAA5Z6t3jNnolUZk7LJDqwPEuxlL8c9jRY4Suf5uMOx48QKAh3mxKk4881w4z9wDYbfrWqS6SmyiiMVmcTglqnpJAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=J1aGtklu; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="J1aGtklu"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-793fdbb8d3aso24748037b3.3
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 20:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774063906; x=1774668706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eijfxrd/nU8Fxmb2WWIm6Je/mBGD+szJ93AcILeshfw=;
        b=J1aGtkluSqGTgQOd/2nbH+RcajzBgy7ximYN8B+uK+WasG//oorXkNiaIi5StWA0AZ
         3wH25FMaIeaypt+gVGEjlwnNcvNL+rUGCns48Zfd01iVcmxihSc3gmIKJTEE7vQzjtT4
         Gx3FYwlvHGWGk8vxwCSayPKSWb9PI9eq635DM71voH1oeV4Fzp6UE/il1mpwHE3BMKhj
         hmQKIjcuj7q1mrmyurprh0egjsMgxsiFNIJCOB+rb8BzrrnC0jKWLjNPZ7yPw09A6kgM
         smaSXuohrNQLlsFB8hYt1lBVvxbpblHjPMkycjsxYOpudzStGEiibyddOWlxOpTSp3PM
         9jaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774063906; x=1774668706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eijfxrd/nU8Fxmb2WWIm6Je/mBGD+szJ93AcILeshfw=;
        b=BCAFikUHRDLa8CoF82UwelHZG2lgn4mOqG50rjMxE/n3zJyqPW26mTvdrfIl+A8mrZ
         5ne6ZVIxGHIBxGdXGdKPHoj3585FpE3On4WMS93/wzCid/3s8Xxga5/3JFU3UnPhPc1M
         k99ugR+WklMhAfpmk2MzQe076JsSc4YinGvBuDZ4R0ZFZR1k+UYiS8BjGjHTCp8SGvF0
         Nd6OcnHL0tGN+WECi+s4P1Mit3MPZOoD2uTSDv0KQ9EU7H0pIpbgS+5oLvnb9ebAedzi
         nQ1qG76fm8GBOkPzzcFpSisLftur3SWbhhucHLVPk+IaHN3sHS4itelXdQFGQEsE997f
         MMUw==
X-Gm-Message-State: AOJu0Ywl5QcGtZ4dCatOZCgNDsVU/Y5QMPbNj+bFIuw7RsEoAI9kvyF1
	nHgvDuCjOhsxs/r0o/0QrLsmNeUFNpvqrHINW3LlOtmqeJrcMBdUabF7e1ohFMNslhM=
X-Gm-Gg: ATEYQzz6RIgcEPKFdjprN+wZ/oARMwFJbAuRuw5Vmy/XBDKJI3ADkn4M8y1jYXyBle9
	Zj0sImBo6Erzp1lVVpL11FF2vWezJIIHZpAsmXn/181C8vtr9SGk9jWF9dKbASTz/nDt6PPXdpM
	sMv+ge5ote7y2VBUH8KrOcuvhoWq/dyIosdI+GJRIVZht2XHz8wMHfOzWrlEvaPxpgyEhhcZUM+
	HHAu7AmMekjkBeSxFynWLt96+iY/Tg6BLSpgWHsWt/Q3zRwMfzMeS4Nn44k7Tbzx+GYTHNYky6J
	a0hpkV1V6tPQVjA2T+ZuQ/yaJr108IyX50gxDvBKzf6fjm4AknF4yFeXdvhf3r9kM3GmMU3jG8L
	G1vgrb134t4KPLAn4AKbh1c7ziDBKx/VBrGx/g0pscOZv+/NRKjhUCkV/62RJ/a1NXlD55+Na1i
	fSIKp1HrTtq5vBvjxrqfPgNTWUzzMZ4Dcaar4xN6DQO03wz67bmW0BAHIlo123A7y2+MnV8pzHM
	tOLbKx+hf5gceMLTFfCtwbMD0AxMQ==
X-Received: by 2002:a05:690c:a04d:b0:798:980f:6706 with SMTP id 00721157ae682-79a90aeabc5mr45058277b3.22.1774063906611;
        Fri, 20 Mar 2026 20:31:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a903f3a6bsm26067017b3.16.2026.03.20.20.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 20:31:46 -0700 (PDT)
Date: Fri, 20 Mar 2026 23:31:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Subject: Re: [PATCH v6 0/3] http: add support for HTTP 429 rate limit retries
Message-ID: <ab4RIZr7b49VKjR9@nand.local>
References: <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
 <pull.2008.v6.git.1773752435.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2008.v6.git.1773752435.gitgitgadget@gmail.com>

On Tue, Mar 17, 2026 at 01:00:32PM +0000, Vaidas Pilkauskas via GitGitGadget wrote:
> Changes since v5:
>
>  * drop show_http_message_fatal() preparation patch
>  * drop fwrite_headers, restore fwrite_wwwauth
>  * move CURLINFO_RETRY_AFTER from finish_active_slot to http_request
>  * move retry_after=-1 init from run_one_slot to http_request
>  * replace retry_after_out param with http_get_options field
>  * fix loop counter: separate REAUTH and RATE_LIMITED counters
>  * fix racy -lt 2 timing bounds in tests

Thanks, this round looks good to me. The main things that I noted from
the review on v5 was to drop the old 3/4, and a handful of suggestions
on the final patch, all of which look to have been addressed.

The first two patches being unchanged, this round looks good to me.
Thanks for working on this, Vaidas!

Thanks,
Taylor
