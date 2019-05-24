Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29CD1F462
	for <e@80x24.org>; Fri, 24 May 2019 09:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389959AbfEXJ1q (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 05:27:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45945 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389724AbfEXJ1p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 05:27:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id g57so13409306edc.12
        for <git@vger.kernel.org>; Fri, 24 May 2019 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MxN2WU0k3KAbhvZF89xgevLzhda/0OK6bvxWMxLSfkw=;
        b=CC4j5kqWaBpMl+sCHIRYIYfPWSvITXfsxX3CYzqvmVUiINb/sAoaPdWxnstH7Afk3J
         EFq1qkqvhoaJpHstLtE+vWiXWhuZ4iha9ZvwJQcTbFuCGfTvgqSF1a9xnzaxnjgCYwgQ
         8uDDt1bfFNp1yxe6y8hvJmYooCrDphn0ZhV9Phn5zGwVcJC2+lOi7rBbl8LMH9b2KW2h
         OfyPNxhGKRhdxJ8O2Jr5q/ysTDrr+h7XRxp6q67Ag8wn6L7N16TYzBmxv7AHtT6mN7qh
         AZ58bIJr9QFjHgWpUTA0pvM3CMi+4LlEs6XhnQNBBywe5VGUUKXV8ONYQ0Hx1VDS4F39
         mpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MxN2WU0k3KAbhvZF89xgevLzhda/0OK6bvxWMxLSfkw=;
        b=SPFtIpskg1jFl4b1YLIN/ILOOysDhUX3/ET6dWGf5Nsi7mF4bDipPNoQ5+iDk0shWt
         t6yPMq2fpN9BK+qWuaxKPr3yCEsxd+rmOsBuklC2WKxC1rXeTKf3MaVmj7EDyMvKYzq6
         mda2nbYi8QH7cZ8OVo7DUbA0CMXnftzkiHPCGPTy6IHk9lQGYr86rnAoJE1Exb5B1KAa
         5mzp0zx/AiWKCFevzYLycBHnBYD2S6vyV66gJDiNaC+UzzHa5n/+Zo3Inf4nUn9vBdcS
         X0bFMTH/IMonuMU2o7d4kOvEvuYmMEun5xcONKpqNk/qQoAEoHEh3h8nNi1kEv8P/8sS
         CLdA==
X-Gm-Message-State: APjAAAULYZWsv7WExDYRdexX2OKpjUQnjJJflptle8gHYrMVTQkPxLv9
        nsVp8SOmDVJpZlWTzRq/umELZ5u3QQloO4bLaXc=
X-Google-Smtp-Source: APXvYqybBU4DHCANqO9VNxOIgarYaaDr3n+0NjcrjrgHnS2r/WaT9Zm2FJsQUj/bLC1c6C3J+FyHWuFyMfqC7XRHahw=
X-Received: by 2002:a50:86fb:: with SMTP id 56mr103910843edu.83.1558690064054;
 Fri, 24 May 2019 02:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181108050755.GA32158@sigill.intra.peff.net> <79b06312-75ca-5a50-c337-dc6715305edb@jeffhostetler.com>
 <20181122173931.GA22123@sigill.intra.peff.net> <CAP8UFD0XbOUj70pt4X=HDvGBoLaG9qBv9SWGnM6N8FG3t-57rg@mail.gmail.com>
 <20190524083142.GC9082@sigill.intra.peff.net>
In-Reply-To: <20190524083142.GC9082@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 24 May 2019 11:27:31 +0200
Message-ID: <CAP8UFD3bVH5w=DeMi8R=_O=oyatWj8coh_MxT4kTyJyp1+pOMw@mail.gmail.com>
Subject: Re: how does "clone --filter=sparse:path" work?
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 10:31 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, May 24, 2019 at 10:05:45AM +0200, Christian Couder wrote:

> > The way I see it could be restricted is by adding a config option on
> > the server, maybe called "uploadpack.sparsePathFilter", to tell which
> > filenames can be accessed using "--filter=sparse:path=".
> >
> > For example with uploadpack.sparsePathFilter set to
> > "/home/user/git/sparse/*" and "--filter=sparse:path=foo" then
> > "/home/user/git/sparse/foo" on the server would be used if it exists.
> > (Of course care should be taken that things like
> > "--filter=sparse:path=bar/../../foo" are rejected.)
> >
> > If uploadpack.sparsePathFilter is unset or set to "false", then
> > "--filter=sparse:path=<stuff>" would always error out.
> >
> > Is this what you had in mind?
>
> My plan had been to disallow it entirely, and allow some mechanism by
> which the client could specify the actual set of sparse paths itself
> (which it might get from a local file, or communicated in some
> out-of-band way to the user cloning, etc).

I think that indeed disallowing "sparse:path" is the simplest and
safest way to go. And I agree that a "mechanism by which the client
could specify the actual set of sparse paths itself" would be really
nice. I think it might be more complex and take a significant amount
of time to implement though.

> If we just want a mechanism for the server to provide a pre-made sparse
> list, then I think pointing people at sparse:oid=<blob> is simpler
> there. I.e., your "foo" becomes "refs/sparse/foo" or even "HEAD:.sparse"
> or similar, and the server admin just sticks the content into the repo
> instead of dealing with exposing filesystem paths to the client.

I agree that it is simpler to just use "sparse:oid" which already
works. I just thought that some servers might want to provide pre-made
sparse lists that aren't in the repo so that client cannot possibly
change them (by pushing into the repo), and that "sparse:path" could
be used for that purpose.

Now if no one is currently interested in providing pre-made sparse
lists that aren't in the repo, then I am ok to just disable
"sparse:path" for now, and I might send a patch to do it soon. It will
at least fix the security issue with "sparse:path" and thus enable
people interested in using "sparse:oid" to start doing so (without
opening a big security hole).
