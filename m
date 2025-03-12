Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80651E9B3E
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814506; cv=none; b=qJlUOXOSWvfJ2F1VGMY+C4SzszIc+wqpnIvi6NCVULLWerUiqHEjNmhB5aRr38J/RTsJnH1QLemszYns8UCnJR+9XSPUax0TTVMbqKRQR6TIIZQg0wL+u97S69FKRNOf6XcfPgES4x709lwQo54KMqsjVjKHCM8G7XWNWDxSnco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814506; c=relaxed/simple;
	bh=KXG+An7UVLc5fNSXA8PiHJ3zk78TYTvmPxrDJSRbGqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxldz7VQhYWIl7Gtd2F599CKyRkiW18hMbFCreVT1hLJVVQAukFcaogKhq9/JfDRnaCmdtJKPw7S40MH6gneC+YEV5GxdRVLXVI+RS2y3GFZ8l2ZEliFYIx7WsZ3l+GqQRvzBOji0dn3c7d++Hcg2OENcuSmBLgadqITSW9a+WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Rk9NWOiq; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Rk9NWOiq"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fee50bfea5so3150347b3.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741814503; x=1742419303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYKRZxXhTyzklZyzO9XzF3pZgP+7CN5dVeX0iKqtanc=;
        b=Rk9NWOiqdc3jRCaQtU489IO56xVHOCpbNP77hWo7UeqyQ8pay3Ac2JzPR9AahdJBR4
         JWw6hNLxFMvPxmfYor8iey22+kcQVn3Z116axZalUlRsx32CanTl8EcANF4grYy/bZKD
         uxSwQZxYFTrOJ8DNTzL0B2PhvZRfkrKBqQDO/k4mStrJAs9MQ3DJED2RmFv3HyMhNrBb
         G42s3IiG2kW9blFndtvumsZpGaV73+J1PZjApjR/REsylu1z9ACss4CU8GrWNb1laY8q
         sNfIn8hrwefG7q94n0zY7VDHMYMDFd98F+jy5Dv3EMskcdOOtG3bAda1LrE1IjpWuWtq
         ODmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814503; x=1742419303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYKRZxXhTyzklZyzO9XzF3pZgP+7CN5dVeX0iKqtanc=;
        b=hpyRw3CXEBQl/nrv5sn2tY+EP/nR58fzL58YjOCmUGe8jo7f3aUXgJq6Mhq0rsIg5i
         ++RRQQ46HR/XSYxhmbJZirLYgomYtIeAeLPc/IF7GNCJxf5LSKKFKpMEQdU53/cS2w1T
         KRy9BsSh2vrVBoynp9pr461lftFpshD3xvaeGGqfeH5QjjqBXKXH6qYDGSLdAlHacxe4
         zove3f0YXr9JsgPQ6z/VtH+8wImg2LfedmGxWN09n8ZgEjbMg/yFOYCCo+iZK6sa0d7G
         judLYPbbcBf7jxwLtGf1OPX1wssDPTn6NDAbDd3e22fl9jIc4Dt4F9E35LZF27JxwCRl
         EQMQ==
X-Gm-Message-State: AOJu0YySNpRDoTfKFBK6QeXSMavZioS7pVpPjkM6U+B2BamgWaa37u9E
	hpvKOvttrDRPdl6JBHpttk/RnkE0qrR7uXKkd21DqK5A8U4lZ5ASv6eFxjZjVwY=
X-Gm-Gg: ASbGncuYYLm6qNKiVqJGXI0peUdAfiOTRz5Pa/gM24PEXte3x8hFyPEskDMSF8UHOuV
	75Cx3xLJeuBTcj6m3uQDyEmQhNKSelgjUqNrpRqNLRQlWrTTHAf0CaDZ92wWZDZ1T5JR7WYsMTF
	6pkpc1rxsGDx8T1n5SHeodIXlXTsYqO9ENZG22hTpU/Wi0IMzvKhYLXDtdOax9EDyZPJEDZNV36
	pdOfk0t+duHYYoxQqnCy9NJvL+ehXCxcM+OJ7JOHOde6iOIDb8vOYtFAH4vo9KnzGsvnQiAl96N
	INKalgWpaB/PAornsDlvtunjDgm9+hd8QQPsmd98ZXA0d127OJFjPcW27k/2DNBB72qJKu4rhuh
	n65nAieid60sWbu1p
X-Google-Smtp-Source: AGHT+IHYO/Thpsyda4nZQv9NT+O+Z3OqqmZ+yzDzDTiszU7X69uMTRqs+gIOvdgcsrG4JFo7H3g/eA==
X-Received: by 2002:a05:690c:6813:b0:6f9:af1f:53a4 with SMTP id 00721157ae682-6febf3ae047mr340947347b3.32.1741814503564;
        Wed, 12 Mar 2025 14:21:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2c46f49sm33478567b3.116.2025.03.12.14.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:21:43 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:21:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 10/13] pack-objects: refactor path-walk delta phase
Message-ID: <Z9H65fCcv/cybKRa@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <c047fbd7f275ef79695b5e1356075705e6fd7bc8.1741571455.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c047fbd7f275ef79695b5e1356075705e6fd7bc8.1741571455.git.gitgitgadget@gmail.com>

On Mon, Mar 10, 2025 at 01:50:52AM +0000, Derrick Stolee via GitGitGadget wrote:
> ---
>  builtin/pack-objects.c       | 82 +++++++++++++++++++++++++-----------
>  pack-objects.h               | 12 ++++++
>  t/t5300-pack-object.sh       |  8 +++-
>  t/t5530-upload-pack-error.sh |  6 ---
>  4 files changed, 75 insertions(+), 33 deletions(-)

Ah, nice :-). This is where you implement the idea that you were
mentioning back in

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index c756ce50dd7..c5a3129c88e 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3233,6 +3233,51 @@ static int should_attempt_deltas(struct object_entry *entry)
>  	return 1;
>  }
>
> +static void find_deltas_for_region(struct object_entry *list UNUSED,

Interesting, it looks like "list" here is UNUSED in this patch. On first
read I figured that you were going to make use of it in later patches,
but it looks like it remains UNUSED at the tip of my local copy of this
series.

Is this a stray change from when you were writing this? Something else?

> +				   struct packing_region *region,
> +				   unsigned int *processed)
> +{
> +	struct object_entry **delta_list;
> +	uint32_t delta_list_nr = 0;

I know that we have a lot of "_nr" and "_alloc" variables in the
pack-objects code that use uint32_t as their type, but we should prefer
size_t for these in the future, even if it breaks the existing pattern.

As much as I can grok of the implementation through the rest of the
patch makes sense to me and looks good.

Thanks,
Taylor
