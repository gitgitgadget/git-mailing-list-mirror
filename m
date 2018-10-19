Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E520A1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbeJTBE3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 21:04:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33360 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeJTBE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 21:04:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id l14-v6so23092964edq.0
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7Ya+4D3+BIG81geiHDhNXocDEZyfXha97ouPzNoVGU=;
        b=gIZ/uwtbbqxBvTmrubyQ+3Lvu1zWDEdJuA7m5fE45KMzwyOrzCexXLA8TMFlB65YUT
         NtcSbvSN9Pb7tfcUDXjyHzAKJP8lArWQFD6dEhZ9fHKkmfWaSdSo1RqNkr4G00OVaqfn
         EgfvxWSo8k2HM/gxYKU6q5wuxrAXgyh5PA+EJnsFbQF/x/lDiFEauMtLZYvJQwAruVvV
         jqKKxuiGqC4JC34KcHMEYixH+dXNZkuWuVVMMeNK2c82z7eXECvOoMtBlIWBL6fdd8KB
         Ml2Yr3nJ3Xq59zzWTuMtO+VHjEmA6t9UWXWEZ2lwXZUaNf2M1WEdyvBytTU9I/fLAws/
         keiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7Ya+4D3+BIG81geiHDhNXocDEZyfXha97ouPzNoVGU=;
        b=hoB9YMzoraOw5tUf2vvs2pPHSfGyeBPORB6AZS/KusVhvyOdMwX2QRQqX09CJoOG9t
         8srG6u+vEh9OEyDV+H0AkKsg7x1lppqVtu0UVhm7sp6FhERAhZgyipjDSLkfsjY2PGQt
         9Og12uwwTB+ndE7IInG9sKOnXYi46qstRRJdyHIXsqfF8K3EPaQTqyWD2R/iAeb3ygrF
         e/hN3ZUt4LfPHS9XTRTZ0eIsTHXk5l5tSqUhwaPY6RGMTo47w+I0GJ4aq7Iq3pAd2g/x
         ASEE04NMZg/Qgzjl5auQOhBmVUi6kSVV7Jz5P/cPAH2SA/RWjkCzexiK0qB/3nK5dVCA
         BklA==
X-Gm-Message-State: ABuFfogxivZEOApc4/8BXLwexOOSh4MQQt9ZTlNWgs1NHG5hJez5rXYt
        91nSw4TXngGWFO8MO0QJrb+fbTqg6mEUJoeMUtlmm5n5xINZUg==
X-Google-Smtp-Source: ACcGV60UtjGqE/cl0CaHjmYbhXcx4SySg8vis5hdulZoUxI2DYro6i8NJt01CK7ZO44JtfrB/JQJQCE/m9/kDXSUFtE=
X-Received: by 2002:aa7:d70a:: with SMTP id t10-v6mr2251214edq.231.1539968251910;
 Fri, 19 Oct 2018 09:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <20180903180932.32260-1-pclouds@gmail.com>
 <20180903180932.32260-20-pclouds@gmail.com> <20181019162021.GA14778@sigill.intra.peff.net>
 <CACsJy8CGLRi64WzNUM-6NUm3i0JW7+ptfh7+NhiSb7J9Qb0u0w@mail.gmail.com> <20181019164237.GA24740@sigill.intra.peff.net>
In-Reply-To: <20181019164237.GA24740@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 19 Oct 2018 09:57:18 -0700
Message-ID: <CAGZ79kb4ZabdxUKmzkK_rJn4wbT-hT2N9gGRvoPQwZmBq8isGg@mail.gmail.com>
Subject: Re: [PATCH v2 19/24] submodule.c: remove implicit dependency on the_index
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >
> > Yeah. Killing the_index is just the first small step (didn't look that
> > small when I started). Now it's all about the_repository ;-) and we
> > have like 400 references of it just in library code.
>
> I suspect it is much worse than that, even. There are many spots that
> likely are relying on global data that _should_ be in the repository
> struct but aren't yet. I don't think there's even an easy way to count
> those. ;)

This is a very interesting part of the discussion,
please note the series "RFC Bring the_repository into cmd_foo"[1]
as that proposes one way how to deal with this, exposing the
repository/index changes into the existing test suite.

[1] https://public-inbox.org/git/20181018183758.81186-1-sbeller@google.com/

I'll read on.
