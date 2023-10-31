Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B8D2ED
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="S416pHAj"
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2AEF4
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:06:33 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ce2cf67be2so3786297a34.2
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698779192; x=1699383992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q2bOXh+B6hG0lnIFEcgizrrfwd3U3WpmJ9FsDoFq6ZY=;
        b=S416pHAj1F8EzvZrzyD310uVNctpYQ8WILbAAjyOYnK5+uR21s9saB4YG8ALDtx476
         fXjDgnvMpi+60fV+cG9JwzWhj8yqFa9eh1TswML1OCWq3yZ16Gz/MKIMLasqVM/66Bzr
         y7L5afGrFtqfYNC0yMh2fxDoJuj4V2zf4Br8VErgAjrPih1GFEvqyrcUhZihMkigy25m
         wE/t4aGgQdGZl/HAdtqQfTVasfUZI6DkWTP8UAuE+KVdf29Ucybkip3F5li8/tX5ZuWg
         HbTT6HbSlo5/k48nmvFXJeYE5MI8XLUzRn6nA6VA1li/BxZVdhzTOWPt+pjJ7r/m5B1k
         11CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698779192; x=1699383992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2bOXh+B6hG0lnIFEcgizrrfwd3U3WpmJ9FsDoFq6ZY=;
        b=eST1peJ9D0mJb5VZxTD794yOxLX4D9bSsOi2ucUdKCqraIx0hqBYgHxKY6s8BCa3xt
         rNx6HWZNxQdAvwoJs7ECsFJAobFpBsY5V87cJW+mtDeqs/bEtWFeBZvF9nne/k+dhF4S
         Xio73wxItzx6MNa3GKCgwtK8xvf8erRXjNtmeF0iCTEqCOUzHlxgpz0v44+UGtkf0pUz
         WV7gsY09p/2PKn/Xr+ZUI7PIGFBlKnX4ndRv4DXYxxmCSyj4tm+2IlBoZ/DtMQxjt4Sl
         j9Q7oDTgsF0iWBczNQI2anV5u6Z8EIJI4qfqbhyxF29+T+08JKFtj5WqTPQ49wY0WeqT
         WgzQ==
X-Gm-Message-State: AOJu0Yx8qm2je6skKsOc3mV1JPDtUYFy4D8kcmzQzOtpBNepqHxCuMde
	IRn57Z5O9TzlS6QHZgkcyL4DBg==
X-Google-Smtp-Source: AGHT+IFwrA+9nT1S6J4lbu4MrY1nXbG4neIF0gx8z13mzYfvX9RH535HJrY78uICXa21c8VIWtwX9Q==
X-Received: by 2002:a9d:6b8d:0:b0:6c6:50d0:1104 with SMTP id b13-20020a9d6b8d000000b006c650d01104mr15150900otq.27.1698779192412;
        Tue, 31 Oct 2023 12:06:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h4-20020ac85144000000b004108d49f391sm740994qtn.48.2023.10.31.12.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 12:06:32 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:06:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 00/12] builtin/show-ref: introduce mode to check for
 ref existence
Message-ID: <ZUFQN8wbMEDyyfF2@nand.local>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698739941.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1698739941.git.ps@pks.im>

On Tue, Oct 31, 2023 at 09:16:08AM +0100, Patrick Steinhardt wrote:
> Hi,
>
> this is the third version of my patch series that introduces a new `git
> show-ref --exists` mode to check for reference existence.
>
> Changes compared to v2:
>
>     - Patch 5: Document why we need `exclude_existing_options.enabled`,
>       which isn't exactly obvious.
>
>     - Patch 6: Fix a grammar issue in the commit message.
>
>     - Patch 9: Switch to `test_cmp` instead of grep(1).
>
> Thanks!

Thanks for the updated round. I took a look at the range-diff and didn't
see anything surprising. This version looks great to me, thanks for
working on this!

Thanks,
Taylor
