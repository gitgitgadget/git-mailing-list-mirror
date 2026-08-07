Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC74ECA6B
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118470; cv=pass; b=KZ0F2YVf/zJGlCEBIsAVE01V7IBGYFtIZVYKAR9v4wjCGFOuhTrx2PVQg3lhetXtsyVam1ZbZeCLbWk51vo1JcpX2LE6sXU918w+XnV44X2Ur3iWLrYg2i7zLKh2XNJrElXJPLZCaphGxLK78zJL3a46++yBdFcndrv1+A4U3Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118470; c=relaxed/simple;
	bh=AQzmlhbVNrGtxN70biObl8CcTWRf4GKNALAHqlJk35Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfrdEz7aYRdvyzTk24vHt7W4GPKpdRIZF/go+HTdflnzrNNSQLx+FdCJUmenaN1fsk/fuk0V05EgWVzGArOHBi01jebxBY94I2BRtG1qwnlMPxQ7C51BzTYkrg8jv4Jz7k0n1Y3KnmkMAlfmQAvbfuLFt6zF+6e31Dl8gwBKhPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=PkEz3/jQ; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="PkEz3/jQ"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8114a4542b2so51430957b3.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 09:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786118468; cv=none;
        d=google.com; s=arc-20260327;
        b=fxguyMW7R7aLx77rR2P5HIVpkNjBghyMxvdhTC7/cNqFnhSE/PhjssviyHksLgOoM4
         XRMdudRRoBeuLvRQahLy77U/yLL+Jx3/NW/mjogpGYF9mu0kQ1WSgUlG5ijuOGxEzND9
         1JOyrI2xLmPdiBWIRLIIMhgMQk5uY8DgiWUzdFVNZ8Jsr59aq972eEPc/OmVvfV2NsmQ
         9AqTHVZlvO5GUSfie1j3RQbPLQsvgSJN+70UnfImpmxziHJ6DxPZYKNOBCDYKTcTCtOT
         JVN50VRXf6Sh0xfPe7RClrB4P3HFE4kn/fC4ApS3oTattHxpPDnmIgCLQtqPEvAUu8cx
         WtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KK9TIfkCw2AathRBtaZ87a6ixjaO8eLGkUuP4a5yqTo=;
        fh=DGIa/P8azKuq0h6oxXLh48i9S2AuJ4FwT0fjQOFPTJU=;
        b=d8yzbHNBtX0XN0Aqx9orFvQsMl/fjCEgqcLor9s2mQlCn7RO73dhCO6c4/gCpBrGC+
         yjLbUMmZZRptEFWqLeLSjQjcCDQGotTbZxddJVjCznth5KkSHykcUifL5TPBp1DcpDLb
         OE3FQFumIG130nP0EJx3xMacKxlFwdsQ3az2EvbDseTTwT8Is8/NrqddCeayR6YojNF8
         efy+ngwXJe7KgC3qTrJeAM9jvcGkbQiLXjsU5n02/6K3moca8JVCVJdRD4XWPP9Lqgn/
         wmuPiYMFec/azqBYPmTW90Iqm9I8MsbjDZFJ/0YCEJKp7voGI3uLxjiNowVhA75IlzXo
         DZpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1786118468; x=1786723268; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KK9TIfkCw2AathRBtaZ87a6ixjaO8eLGkUuP4a5yqTo=;
        b=PkEz3/jQCjutY1HdR1om3kWmvKV53zO7/uzgR9qam0tktAS9lfBJ9OpZ+7htg49M3h
         /eSyZBUtTQ7iGf0yugXH7/l/l0BEpoqpsFnUQQFypWt21ko5MzgQnvZMOvC06Kj8Zx/J
         WGXuF4jyPayRFpalfzw6fJ7ucefxLhdbm9GNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786118468; x=1786723268;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KK9TIfkCw2AathRBtaZ87a6ixjaO8eLGkUuP4a5yqTo=;
        b=CpnmjEhQebO70qliJypD4YQs+/LSgWJf5atdz6i4D5VKtZ3EX216QadJORLi8tZqzX
         wBRsNOVoKGXbvXDV4v8q2qeu+hMwVyDjrL61bM7wxe6OR5jZbyca2GJS+KhM56zJFarB
         ejxQTV0C9s5IzfwcQ8+tUGaVzWvJl5jn/Q7wTa1IKlgC5EMXK+pSM17taozJbJOWXMWD
         L3bIKaNG+LTP1+67QSwL9jj+USxplu6nI6DJq8N76vmctZl8HaT+KlhlQ3a/3yI849bb
         xMu07weul2xSOpjOdwRmdWShOO86i9V4g34NXHk8Q2gPIoJTrX2nz0Nz6cDNI4LH1yQ4
         q9nQ==
X-Forwarded-Encrypted: i=1; AHgh+RpECffDTLzlLKOS/ZqbPE94JIU2AqYbo+rOOFl30S9/PUr38AdANiZAIH3zRm8UTcgxKmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5b1hpyxbQ/26WnPiguzeopNBYS/BguU4RGmo4bSb9P+SfKUza
	kqJk0LeFCJNywXt0VuvRvHJdfHjaIYl53THWXugeDP6hKW/h4brv2oGDJ9+ScRkdpen2fPGZl50
	xgU+HPcEsDmTOtykIsP1XE0YnjI7cmMprVyOf5JOl/w==
X-Gm-Gg: AR+sD11tI0BdzoiCOlcT9cYfaZmdtbh9NEz9MMQ7wg/0swX8sNZiutUUyQ6EqUPD+wk
	Dvls8cOz93Ws7esDOzbpwy2bQHvJ18SvZhOUE7y4n22FXkdmBebMUicInxZvAG1G6i1Ac7lLJw6
	s9L9ZlUK8PyISI2/TxjD2/dAqsj/CqWaXTfLim2ev7qkcfrTsE9Z3Uv2Vod+tMLc5X8R5l3FZPS
	axMH9xHYO36I3qPqL6PI608Uz5wH+V6WPNNDYlBveTKXN7xO6X5o9/k3TnUbYprk8jct76JEJxr
	fbd4vLJ+ldNHATebIhh9iZJPgtSKNSy1mzFGaxxEA9Ij1h/8ygRG9SE=
X-Received: by 2002:a05:690c:4b0a:b0:81f:c2dc:6870 with SMTP id
 00721157ae682-82573d3ac01mr10509247b3.15.1786118467667; Fri, 07 Aug 2026
 09:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <a1c8e89ef9f1d0fb5cb10ec9687633df8792ec7b.1786013982.git.gitgitgadget@gmail.com>
 <CABPp-BFqghtx4p_Nqx+AWpU7SVn3mXOZGDQ0yoN-ZYQgXmZC=g@mail.gmail.com>
 <CAL71e4MULMmbMyrE2iKgNXD36vpjnxCYXTcNw75ibu_nwxqAPQ@mail.gmail.com> <CABPp-BE+QBBYj=oaRDcQj8bFrDX6Z_JVK39ciAk4TwMPb0zHOQ@mail.gmail.com>
In-Reply-To: <CABPp-BE+QBBYj=oaRDcQj8bFrDX6Z_JVK39ciAk4TwMPb0zHOQ@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 7 Aug 2026 18:00:56 +0200
X-Gm-Features: AUfX_mxVy8XMXvkz-Dqsn5VFSQQpZGkQa8VMkTr2-pu-XSn9ix0dlya3svzUFg8
Message-ID: <CAL71e4P1hRcDk0TiR_Gjapf=EScGNbeHqSQ6BqeiAkEvczNu4g@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] commit-reach: introduce struct paint_state with
 per-side counters
To: Elijah Newren <newren@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026 at 17:44, Elijah Newren <newren@gmail.com> wrote:
>
>
> My comment was meant more as a "review out loud; show how I'm thinking
> about the patch as I read it" kind of comment rather than as a note of
> something worth changing in the patch.  The order _is_ important here,
> so the idea of adding a comment to reinforce it seems quite reasonable
> to consider (I thought about changing my comment to ask for one when
> reviewing), but I'm on the fence about whether it's important enough
> or overkill.  I'm okay with the patch either way.

True, but your thinking out loud fortunately reminded me that I had
the same thought process, and that the ordering may not be
immediately obvious -- and thus we should document it.

I will add a comment for it...

> Although, if you do add one, as per the CodingGuidelines:
>
> /*
>  * Multi-line comments include their delimiters
>  * on separate lines from the text.
>  */
>
> :-)

... and I will be stricter about the formatting in the patches
than I was in the email :)

Thanks,
Kristofer
