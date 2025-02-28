Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3917E0
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740701933; cv=none; b=rYA5U9S5JTeG8NRhQzyN6T1TlLDZkNxLg+K9DUHUZdi9bJmfumuBExVm1wrF3dMuX4yX0lgrmuFIrtWD9qUPnOYZExDRleEg2eSvejpiHRBd3aJ8OkSiN9kKw51yDKscShq3weJnWR/utP83JPe7Qf3IrvVz5FVch1M3gEbMPhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740701933; c=relaxed/simple;
	bh=Anwo5+uJEwX+ypQygZW6JGvhbD6+YyOIyFLTuDqOes0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BD9Um3Sase07aAKfiR/zz3TS1WRSr2WrE/7mcZ/ATZugYKNf/k0H3pO7tzCGyUhKFDP1dzAS+U6MV54KSAVLIAd48S9XoDpvXyDrZRGgK9s8g1ycZyWiSoAekyl8l46Ddg176/Zv+m/kpSNxQI3nAxXKuhSiLp4PjZ0O2RMiINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oZ5a8CCN; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oZ5a8CCN"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e545c1e8a15so1920792276.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740701931; x=1741306731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nT16hUyvqvn691hFYDWsVlK6ztj521ayTcy0CYeWjR8=;
        b=oZ5a8CCNkIZtDIAsclibByKwnGRhfaXF3VQSaI/4IBJA2UAtXvkkqsGdH9oUZw+T9H
         0xTeKU+a51xcy//EFPT4ra6cyvdwlxc+as+r8dyFhekIFEZebLRn1ovmFSxfu7UNO3NK
         JMp1fMSgrDeN/Es6kkTFzZAeQJMc7DHv/GiExE/bcw0c/FgXyno6SqGGybiBb0TFtZ/o
         CF6Hf8dXw04iPfSnlSXki57xAi8BkE6qgNZEXqsWPSJDr+SsG8zz1DE0gAC4tIqgMNSh
         4y/PAfPkKJdWV0I6iEZIRSO+catsdMuzxTyZSqHT9JVzlztEw60PF5Z4JfFfLbC4ew99
         fRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740701931; x=1741306731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nT16hUyvqvn691hFYDWsVlK6ztj521ayTcy0CYeWjR8=;
        b=oPZrU+TrIi5GQDd8q8VfZnMyefqx0ERpFXP6ZRxXws2DGIgZjPeEsyGXeJQMTLsP+A
         H5FcQwana9XYt1WYDLFA24ZesXwcPAeAT6sjap2dLSDNd3zntS7nJRK1eSIRJAaZmRxx
         9C3IH4JuNtvJpnhABhev4lAYqi64OlBxWwlkFPBRpZ7QwRyk0H/MAtHWdIE7C6scpIof
         xmgqH7NeVxMv/sB+D0Gd/RKei2Zhi81lvnkO2KfXH5em+EELRxNcWnxeMPzCw5iayO0q
         6XQ7rUmJ8gWbxhM+Ii7IgLQAGTfNqIPSXqH8VJB3tdHodQDq21lm+6P0396yEq47Cl37
         ty9w==
X-Gm-Message-State: AOJu0YycYp4AdL2RdQ46eSbFz+LVhbuPiul5Y5orIb4ZkrVh7CbDjtDo
	LjPbhXvhaE6/AmMs12YyyKBcOZNAgT8F2RFNvUHfoYIJw81W32Q02v//mkfKk8uAGXI9x01+wfC
	j
X-Gm-Gg: ASbGncu3ggSqQLKE9dx96hQFtUPJAOFegBcAPf0NelO+dKQ4qtKdvoeJCLrBUHxvyzd
	7f5SF+b4pbo1v+9Ur7vyKT7yoNGux/x0GMtUnTjnq8Ze526p5BRE/PSETSdAZpzrEnrt6L8NhJw
	AWFa5ZXPJFjMeyr8PlFQVeWRlI+xLZwBaANNFTjX5OlkF9tboIz6PjW8jY1p+X9Tbog/GF51TQI
	SXyh25h9RQTpRTh0DgfSA9/M/nBg8PjNH6tj2NpA+0JVY+ibxzBjxZU54WXHvFDawGf63pypIGN
	qgoxPA1KE7ibHRS7Gggx6SGnRN4z10ryp9Z5/N0lVrTJJWWSTL6CeYMyN8Lu7xccRLNPkNyOEg=
	=
X-Google-Smtp-Source: AGHT+IHACjUhitnrAzPg9SUVfM8g4O41eP6kNwM8H+thKc1zZmd5cvScq9X1HaKAoc7svFBAgNrhNg==
X-Received: by 2002:a05:6902:230b:b0:e60:b004:3427 with SMTP id 3f1490d57ef6-e60b2f157e5mr1235757276.31.1740701931172;
        Thu, 27 Feb 2025 16:18:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e60a3ab082dsm754626276.47.2025.02.27.16.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:18:50 -0800 (PST)
Date: Thu, 27 Feb 2025 19:18:49 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/10] unpack_loose_header(): simplify next_out assignment
Message-ID: <Z8EA6SGpwiV5pv7J@nand.local>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225062900.GB1293961@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225062900.GB1293961@coredump.intra.peff.net>

On Tue, Feb 25, 2025 at 01:29:00AM -0500, Jeff King wrote:
> When using OBJECT_INFO_ALLOW_UNKNOWN_TYPE to unpack a header that
> doesn't fit into our initial 32-byte buffer, we loop over calls
> git_inflate(), feeding it our buffer to the "next_out" pointer each
> time. As the code is written, we reset next_out after each inflate call
> (and after reading the output), ready for the next loop.
>
> This isn't wrong, but there are a few advantages to setting up
> "next_out" right before each inflate call, rather than after:
>
>   1. It drops a few duplicated lines of code.
>
>   2. It makes it obvious that we always feed a fresh buffer on each call
>      (and thus can never see Z_BUF_ERROR due to due to a lack of output
>      space).
>
>   3. After we exit the loop, we'll leave stream->next_out pointing to
>      the end of the fetched data (this is how zlib callers find out how
>      much data is in the buffer). This doesn't matter in practice, since
>      nobody looks at it again. But it's probably the least-surprising
>      thing to do, as it matches how next_out is left when the whole
>      thing fits in the initial 32-byte buffer (and we don't enter the
>      loop at all).

Thanks for calling (3) out. There is definitely a subtle behavior change
there, but having the context that it doesn't matter in practice is
useful in judging whether or not the refactoring is OK.

In any event, I agree that this is a much cleaner read, and recall
thinking something along the same lines as (1) when we were working on
this together.

Thanks,
Taylor
