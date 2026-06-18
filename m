Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE2C2D0C98
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798015; cv=none; b=Y30ufR/rHtIz33QHNf4bpwwxKlrGrcmwLvfrTI+k0tNMZDER6cauDuWNhxG7dYnh2MZiV0Nlb3ZUV4vZHjRL9MD78/8I3qnFqn3PxNyXppCt5Z/P+12ZzulRvuSL62U85SnQ/wWWJ/I7ZeXFaFGgvHLIHmks2FkLgm0WYRu02HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798015; c=relaxed/simple;
	bh=0K9xbxwRn7n1WsjCCCtY18PzycJp9FEC6+SnPqsAZJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxf8JZckhttSOmzS46/hN/AxgwG9J1vOzvIpzRs5E4qMhLEacepib6iftYKmxezgk6+y4qfj3FB4ewqxejNLyfn4wYJZjV5AT2+wZIG/YGMXcepScUL7UulZFWqEk0zUydhhKlmgKe2DVh5VugKm4yQXnPnGoYQGXAYOvlRVGIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMNnbs4h; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMNnbs4h"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7fedf0e99bbso14437867b3.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781798014; x=1782402814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAv1ZZUzS5+60cbI+LbGKd5FZ2VNZxytq2oFLJrU5/E=;
        b=OMNnbs4hReGQAl/J3uiVxO3QDH7ZBvC7GG1L0FZC8H0JC0LrNmngyprIY5ShB0ku+U
         89jqkMT/7ji7Vx3mPEKTc2b0O9HpUwxPl3Kdz3TVfx1suKBR7SHaVScNYI7PbVrrXgq6
         35KSz4rIX86Tx87cdiqmtfUwLnveo97QT56o6w5XjMLhJSi2Ksh3A5n4l7JW3oWxF3vr
         hxYTdz653zDX/X3fekM5WDQsz1wwC6hf6aYf/J7PhPhF9rPjFOMsz3lcwhoEtDTdg3Gr
         FVwLo4HDASpBk7Vlj0OzZqY93Gw5j6cccmEQs/tvGP6tNM9dqA22TWxUBBWKcMaPpYmk
         +/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781798014; x=1782402814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAv1ZZUzS5+60cbI+LbGKd5FZ2VNZxytq2oFLJrU5/E=;
        b=noExD3Tz4kCLqafGqeCAvQxWtpDomsDSQK2afh7xAhyj7MuTUAwPW5y0BxJVtBwzBl
         8lvdR9C4xk24jK34wGOsdQ4/DNNyFltHdfALiHEdDNFkSI41FxwzKhUiCldIPHoi+rdS
         iaj1bFqcvCBNM2A1pAxdDAn56fFV4X6sg9V6EmYKln4NpoQe6Iou9iTLOit59hFjRf2H
         ud8fywkMZxiAZuUtzyhAw+sN+OCQJnKNo6rp6HjKfKzbhTGplBSFD12BJHTn6ntmUwcV
         fvw699hME0IZhfc3FD6UxR00tjRCk6CbKt5y7nzXoBcMydiu04yGt6V9VmysGquL9nAQ
         5W3A==
X-Gm-Message-State: AOJu0Yw4SNEPzp4ysGCSLzZ1myYOUSHkPfPvvOTkgSKp4EBxC80f89RZ
	4yiIn1WY36nQdx1pqpsULwPf93v4jwD9dn48UnUx9m6MStIruaRVhpfZ
X-Gm-Gg: AfdE7clWaYSY5xbDUZ+ls71lBgboYHO9bYhBDtEN6KnJnkTG7/PCvjBm4+lMq4kIik4
	snnMdU4DdQHyY60PjL7K+S37rk++TNGEmmvjghmiQh3FN9pFNLKb/rbyxx83tN2h9R3jJ6IOy0d
	cvNBJLfO9RBazvpxEBLaFLpsk6VeRh6Vj5rd5EEDAm1wly2gqUYUNTfEvNcZZJKzzdGzPr8uv7e
	qNb8HsnmHFN27uE3quKzG01r9ct5j1VSydqcZ8hZnk5CETXPmENUt7g9VFyLK9J1JXjUlyQgSWc
	uafOKvIBbj71UujxXE5VN+AQx6QMV6lpSQu+67SHUrnZdFqU5VDXqGfjTwJq+SmPdMm1v1Wwhux
	Pa08qp+0pC2fDg/Q++gEqK414DAAlFeJygEwAuuRTrek/bRZcBsAOSEYIXs94uDYqEMy3qZysDe
	5rvOGntu91CccDdoa8
X-Received: by 2002:a05:690c:4d43:b0:7ff:1e70:d2c9 with SMTP id 00721157ae682-7ff1e70d381mr81356157b3.27.1781798013633;
        Thu, 18 Jun 2026 08:53:33 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7fcd00dbc0bsm71679917b3.8.2026.06.18.08.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:53:33 -0700 (PDT)
Date: Thu, 18 Jun 2026 10:53:30 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 7/8] refs: fix recursing `get_main_ref_store()` with
 "onbranch" config
Message-ID: <ajQK4vrkc1HVujFh@denethor>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-7-f4854aa99859@pks.im>
 <ajLoiCS2mXP49eAJ@denethor>
 <ajOJM8EvGWWkYNuL@pks.im>
 <ajP7W7KsXz4Wk262@denethor>
 <ajQF1yyCUOdzC4Jq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajQF1yyCUOdzC4Jq@pks.im>

On 26/06/18 04:51PM, Patrick Steinhardt wrote:
> On Thu, Jun 18, 2026 at 09:15:00AM -0500, Justin Tobler wrote:
> > Could we embed an `initialized` boolean in `struct ref_store` that gets
> > set when the ref store is properly initialized and use that as a signal
> > instead? I'm not sure how complex introducing this would be though.
> 
> We could, but I'm not sure what that would really buy us. It would
> basically be one more bit of state that we have to track going forward,
> and thus one more source of inconsistencies.

My naive thought here is that if the ref store knows when it is
initialized, this could be used as a more reliable signal by
`include_by_branch()`. I guess the problem though would be that, at that
point in time, we are still inside `ref_store_init()` and thus the ref
store is not fully initialized anyways. 

I was hoping we could avoid the hack of temporarily setting the ref
format here, but introducing state specific to tracking whether its ok
to parse onbranch conditions in the config is probably not worth it I
guess.

-Justin
