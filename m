Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690721352
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfbTEMkM"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE16AB0
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 10:52:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7b9e83b70so34737427b3.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 10:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698083540; x=1698688340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tn7HRI5SI3Hbj9fQC4oSVyPtEoCbGEsIBhNW8OhXZ5g=;
        b=XfbTEMkMMv68PADkrToWolfsI7HAQR2thOi6G5mXOVGzn0gcRDgHs9SV8/09JdRMDr
         BRUkSCNaGWGG0TnO8Z9HaXRsk6XX8Ilb6CYqx9ixvUWaNGXkTMV4IqSS5ck/kqUGayEE
         B+PfeKVx2acGEWSN8klvq5G860BA0xJ2r+XCFtjk2fxa+cbf3OGj/HSaiXaJRtPBVV/Z
         Uf5S5UHX+ix95DgN9nxwKJR6NpQYsCIDfYomAyXznjqLld/h9l4cAxoex3yqgAMNteC1
         Rzlp6gkOxk+ybXgV+TILsIanPlfm8obPFCNXFYe5teJ0/WUJvcKWVIN9ng1h4Lm1oyFF
         3oMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698083540; x=1698688340;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tn7HRI5SI3Hbj9fQC4oSVyPtEoCbGEsIBhNW8OhXZ5g=;
        b=vD7RC855P2xBoKyqRrKhcQeIZLvQqJmVQH6I58gmY9W7fRmmhAZcoNYJ3S9Q5ducex
         mcH/ObaLBUWnowx9QhMkjYIIZrNZjsHdmvEN0vDDx+0HrX65Ge92gVrSx8t99vCbxvTF
         L0eDCrjBtDyvBdAwjDTVUmwTbHsqPr0t24mEsTiNe0meGMNg+jzB9jG4pzOgvAL32fMl
         1oZ0JDYjHeoYsBsLaSEqMdTlVt8Zew5aLg0vDLwigsMFk5j7XVdAgEpVyzFM4HX2SEVf
         jfMv96SHyRQlxC6mbNysF8Pcamw6fti8GvD/n8dIWsTy9u2yB1cjHbfG1uenSoh3rihh
         mjEw==
X-Gm-Message-State: AOJu0YxkL0M2jvs73dNyMpC4XJAylxva1wom3udHLX3JmLaApH15h317
	8guZeauogOt1AjkteKxTLhfI8mKoTwnH7dM9/vC4
X-Google-Smtp-Source: AGHT+IEISmLdmIGKWo2xNFs/vqhKl6dRYGgroR2jmsEI32lVKcyC0Q46hUARFpjuhXFAfDxcRtXz2pYKrkKm0rQkck8Q
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:29f6:5cb7:f652:5c5e])
 (user=jonathantanmy job=sendgmr) by 2002:a81:5295:0:b0:58c:e8da:4d1a with
 SMTP id g143-20020a815295000000b0058ce8da4d1amr264359ywb.2.1698083539888;
 Mon, 23 Oct 2023 10:52:19 -0700 (PDT)
Date: Mon, 23 Oct 2023 10:52:17 -0700
In-Reply-To: <fa55b7836f112cb7c7ab9b80e745b9969421c768.1695330852.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231023175217.984090-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 1/5] config: split out config_parse_options
From: Jonathan Tan <jonathantanmy@google.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, calvinwan@google.com, 
	glencbz@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Josh Steadmon <steadmon@google.com> writes:
> From: Glen Choo <chooglen@google.com>
> 
> "struct config_options" is a disjoint set of options used by the config
> parser (e.g. event listeners) and options used by config_with_options()
> (e.g. to handle includes, choose which config files to parse).

Can this sentence be reworded? In particular, "disjoint" is a word
normally applied to two or more sets (meaning that they have no elements
in common), but here it is used for only one.

Everything else looks good, and the reasoning (some functions only use
a subset of the fields, and this subset is easily explained conceptually
as those related to parsing) makes sense.
 
