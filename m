Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC02405E1
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546923; cv=none; b=fklCHw/Achs/s6MhxhxzV7osp7nAU8+Qmqh2f4fY9tBfNvLe+I6JrFHnRa0Bzely4IkkgBkTS7XY9uPKyxJ5ukqSn0++UAMgGBgVAhGIc2tEN6bXEiN/sgFxm+E7yYsJ7U+BYae9sBm+s4ycRRyiR6ofkR6+dvPTQog5mA7Qw1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546923; c=relaxed/simple;
	bh=Gv+KiB1PZWJFFTHA0bLln8yNvRoL7P3Fo+wDjljMcOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAwr1oK8t5iqzcXQvgYmdbAGjpb0MIhBr6xKkVKS0jEt+zvxeJrt8XrcAnBUAUr8M5W6cCekxNYhydGR5NBdcuqsYlhyBrsYN2yvyJTtJtMHRDQw2oKPDS3YIqxeIQCEigaag8Xc2Om316m4KgLF7zuENDsFn+07seflvu2cfOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=NDwCpYya; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="NDwCpYya"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bd6f65c781so44610857b3.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 17:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778546921; x=1779151721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qmoAh8QnMics7evUr3qjVlIOICzlEDT0Af6vSr8a9gs=;
        b=NDwCpYyalRQLTL44q8VjnXuEFtsIZEqu715YehBgV+JuEvyO2UT1NjmfvVxEV2Kg4w
         dunz0OkyTiDWczc4vjuom/tRtFnuyLU1dtD9fNhVELrUxOr4FxnmLqdkc8zPj3gxbuu5
         DMS1Zs2YYv5M1G2P4p03BEddOKF7gaJh6eMXwxM69rl2JQiwHx+b2Dz05B0Wb7cw02EG
         hNGwkKhRIKDWiNxn8bauLzeWvTcZmSR6Fk3rgzWDFmBpN3ASAEiPrMVJICdL5Gj5YlfT
         NrGWOczrlhGqhM2fFQYnsheoj4HMzTqvsBc8ka65QoPZmK/FlgXAYEiupp0gaRfc+9br
         HaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778546921; x=1779151721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmoAh8QnMics7evUr3qjVlIOICzlEDT0Af6vSr8a9gs=;
        b=h30+ulEmVF5ue0JQFlVIPvEGqAuKXhbJEVAo5UrL9B5FJIs0A5zjqoOUa1MqVXrNkz
         MWICSes2LCyfmVzI9L+zfsD/G6nwTVEXbRZS3ok0cinTukPpjputFf6rjClCdKBD042J
         aT/kHNfAZpcre9lukULdE8+B121VaqaCluBPfn8Z4pVWnUaRm9kPcOjDxgz/e837L3UT
         y/cYuWwc2VLj7JllC53RV1sRTjC+NZZv56boQV7huiPnHCrpwRC1uf/BmBmaNENp7SGU
         1eDdZRsNQnscAcNRUnvTCMIrL/X2ajSCTcIjsu26dfcFvfi57KzsCtXVm6G9doKQjvga
         N3jQ==
X-Forwarded-Encrypted: i=1; AFNElJ+m3AAYuvw/GelQKxdjLLkjSBlXO9yKMtiK03LsBICzw/00Abj9rKdEyaTUce3zQdNrp7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAS4GO3/F0zKwIs/4XNqMFj8m/V7qIT0Z78ySvZY1SjTcPIRGu
	jEga/QGWgMxfObcwolu2at0DVW8x4oTK4doMoNK9iy9haojDgUXdNA+vYRCy/2+ACXU=
X-Gm-Gg: Acq92OEeRCMc2WDdkHkF56cEZNvrw+NtysULawGfNFsoLOuI2gQmlxUvqpxYWHvHsJ6
	A/RGufu7HxuUzGtsIzjuCNxlNPdrzwfVm7jpgwkCZmcLMQdhP4s/2F+S+Ohu9eGbVW6ptIZdQlH
	Ya1muOsn5XUDfxth/f6lJcJv53LMTYw0Wo0Tw6dT/Q2y008njETHSBtEZ8gJabaiw15NdrcNp6Z
	WiO3GbWVdpeY/ESXilUtJduahKEkZOzqOILk1CuRS85Ma7+II/oCxuzvLzeX9G0jcMWFfgxfOPx
	auntUl5QhdKHcXkAUYiTs5PhT0VrjPlto6TWqk1yunuvTMYeojb+vyX9BPmCenIMxzNy6M7Yl1v
	5UbrUB1c/bn/1QU8E2bLipCu7JmHd7l6YZmS8wYvWuX9V/t21SNAw0uh93akxt+v/0kOu+6rbzM
	EXbnebJjz3tn6fQrYiOaWaYIUKP6qTkkiP1zpgU3LzfUdlRisQp3zfgfR2+fEQHOgSGivlPeS1r
	lqvZm4LuTLZGM3FBKIvND4Ps8mNpCxCb8rEu/Fj97nELDpKIecLQF6uNKp48pXGqWpYpNzl4aBj
	zLbZrDqBNJlO23sj
X-Received: by 2002:a05:690c:3:b0:7b6:783f:2122 with SMTP id 00721157ae682-7c50e70daa6mr17382727b3.9.1778546920958;
        Mon, 11 May 2026 17:48:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66528237sm155101357b3.5.2026.05.11.17.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:48:40 -0700 (PDT)
Date: Mon, 11 May 2026 20:48:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/9] pack-bitmap: fix various pseudo-merge bugs
Message-ID: <agJ458pXAXTsIpKi@nand.local>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1776801694.git.me@ttaylorr.com>
 <CABPp-BGkfavqezk2SV3+K6iF8MLm8j_=ijHiPDLmv_U_o_Ykgg@mail.gmail.com>
 <xmqqpl32u06q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpl32u06q.fsf@gitster.g>

On Mon, May 11, 2026 at 11:53:01AM +0900, Junio C Hamano wrote:
> The topic went dormant after this comment, and it seems that it is
> so close to the finish line otherwise?  I'll leave the topic marked
> as "Expecting (hopefully minor and final) reroll" in the draft
> "What's cooking" report I work from for now.

My apologies. I had put this aside while you were on vacation, and then
got busy with GitHub-specific topics in the interim. I just sent a new
version that addresses Elijah's comments, which should be ready for
merging down.

Thanks,
Taylor
