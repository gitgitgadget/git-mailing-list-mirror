Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA4547ACD4
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276647; cv=none; b=OPOUvKnF1JRo9/S/4UzysJXEzHqrpKlTEk7hc/wKKeqardVuzCe48j2L/0aELXt6rDuOCYrTN3RzONMsJl6XPgoRyx995n1ywPVPJRZXkqbhwq/do8dgnkgBkUwkwNoGpwi1CbgHnxoXwCJLLu2Uz+dQYFTc7xQZBLx973LFsUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276647; c=relaxed/simple;
	bh=+Wzrf4Gtt+eNrBivUk/sJvV2igrn1rqhNC9vLPhwiAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxDx7rOSmiqPUqqgK/85egWHP/aldfkBtR9Cd1j5UgRB/9Oau5uZGsE7M71R6FabIDv0slwqu1LcHT+KJYnDMP5XTykUom8ZP13X2M9oY0wJ8AzA2WMRDAxmzSKP5voQ/PPT06URxt6XmvgyDdcc6T6XAByJ0/dwINj9YUvgfl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s8GwQ4y8; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8GwQ4y8"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7ec1e9d3359so321439a34.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 15:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785276642; x=1785881442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Wzrf4Gtt+eNrBivUk/sJvV2igrn1rqhNC9vLPhwiAk=;
        b=s8GwQ4y80Op4cdy2pYssw93QPDXcFVBhpYYStS0EnqG6Ux/PNY31xmX+7jPVkRij1U
         7jhEl/vuP6OOb4bZPfLGhqCJBXLJsaIINfLViftm8tPs0ojXNxtikPdCsDDgY3ss/3JP
         F1FVULfUhLgPj/NqDvB+GEGmcFc4ETHGwsY+2fNUhPVhKaUy8LGrDrnfmv+jh0+wHqju
         nRDmvCccQLCUsmVwiv/W9H7SvxLU60LrRMzBCOb2FxglrN8NobeQeasR7BGwtJphKXfE
         alrEdphRkhZMAwbvmDrL0KUXP/u+2tYGsramu77Qa4N49FyMUv5Hbos2va3vs6fktb81
         +ZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276642; x=1785881442;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Wzrf4Gtt+eNrBivUk/sJvV2igrn1rqhNC9vLPhwiAk=;
        b=TFOOk7vO6v1b46SqFaCklbRfv9yxywmsx8t/a1Xq6PElz0gQXrqu+MOUpZZWInsGu2
         xhvmuBi6p/6BkJi4DBaXAv/fRqqRyJHpdeQrfaGw4MSdg2ZBGJ1YRTCN4jAXUfFBvkty
         9VCcXCCZSNR5AyR8T7nEKZvMN1vDmGi6VyqO1/AsWUQRN/6CcvySqBPAygK7/h6sgy1k
         0zrptRv5P+lE7yPz0AOCjVFjl0mAUduSQnq5u8afs0XR5o0u9hiwY8IMTeBLlSeC0FUp
         C1CzHFc3WiUUBSVUasxKhuA8Z9SJdOOwe7BRkMCf+/Y9Ynm7AjrEMVGwA+l2iyU5tijm
         hmXg==
X-Gm-Message-State: AOJu0Yy0qt7OeAAtUrL1fTfZDhaHdH1O0x64apqXalD/1NInbZ30PRU7
	RY+nsbxcsfX/3HOD0NeZe/ZHV5FfrE3P06NtL8LJGCHNK9DgLgbiJ6y8hwhNhw==
X-Gm-Gg: AR+sD13cym8rkP0EzTSVOFvktVU73XWb1lcxWhhM/vCR8BAo//vyUR7xsCeJ7h+rNQU
	uiMGmR+Gv5IlMNYfFJ7Z8ouXZiqWgQi99N8J9A4yaTrMTnfM9xDTH7el/pw4EKmpqgwTPLxnxkc
	CqcybGpNhaugBb7ybmLovQaI5ntn1tVCR6KS/gG7ZMB83ZknTpRzgCiJsm4CgN0peiZojGXWd7J
	ZO2ugk0ngmLH4J+f+IteEsAGW5wQZakEi2iYsO9br71m6MeWtJfkFefNBhLH4yqvdkQchTEcMD7
	TUsNknVsN2OgmRt/zrOHKLA9iifFYFK3wSv51kW5pft9EyZA/Nshafuh2A3uugeHqqksQNr6IeF
	MpNf1El9rK/sLk75ToZ+zm0JjXAuyWMBsdN82Y9J8zGSkjhK6fEXdjpEwpAmzFKAucuN1wjKnAo
	0pkglFs+vUBqOs7yDGQGgf1IrFyIOfhKZRGUDurBUmNH5E0w/wGynhpQ==
X-Received: by 2002:a05:6830:2116:b0:7e9:b537:102d with SMTP id 46e09a7af769-7efff296d3fmr2248107a34.26.1785276641911;
        Tue, 28 Jul 2026 15:10:41 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d9a9396sm761730a34.26.2026.07.28.15.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 15:10:41 -0700 (PDT)
Date: Tue, 28 Jul 2026 17:10:40 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/9] t/u-odb-inmemory: implement wrapper for writing
 objects
Message-ID: <amkoeX3HeUWqwqeu@denethor>
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
 <20260717-pks-odb-move-loose-object-writing-v1-2-46446a3cb5b7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717-pks-odb-move-loose-object-writing-v1-2-46446a3cb5b7@pks.im>

On 26/07/17 11:32AM, Patrick Steinhardt wrote:
> In the next commit we're about to change how objects are being written
> into the object database source. Prepare for this refactoring by
> introducing a wrapper function into our unit tests so that we don't have
> to adjust all callsites.

Ok, I assume future patches will extend the `cl_assert_write_object()`
wrapper function logic which would make sense. The patch itself looks
trivially correct.

-Justin
