Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B2C1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 20:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbfITUug (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 16:50:36 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44517 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387479AbfITUug (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 16:50:36 -0400
Received: by mail-pf1-f202.google.com with SMTP id b204so5511027pfb.11
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 13:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=smELTEdiQMzSJJm1iReJ5QhqXiGem5B1XKB+B9YRP4U=;
        b=I3Gqza3NQHsyQxSF/3nJdNkniAHV3MUqa15/q5SheXv901/nbeARvCW61r1hPw76fF
         iiWKhGhk3mYNhTYpru0DB6gx7WoJ2660vuH5TMjHb48XglpCTpi9U+3XkYI0iueWO6JO
         zjNLCxBoF3cGhWKyCMxWXn37gM79mixFKFrcIz23fqixgPbgg/rPfiPyn4Zy8vLsnOC0
         NPwolseBLyWtjbHKKnZpm4hVGbtfTztL4Nxxwnt3YkkhNWPR6Q27yMSWeg77yLY0w32J
         BkgGIh1oyWczOES8hX/7e6aTMjNGSeJVFnod/Bkv4Q20VZ/sIaQpxCTtLlJX8sfNNMZ/
         9tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=smELTEdiQMzSJJm1iReJ5QhqXiGem5B1XKB+B9YRP4U=;
        b=n+I23TzyIL3XeRqw1ABWvMIXEsbeQOmf1khkMKI8YfWfESMnqFaiRqJ8k56IsMRmy5
         +e9ayMg63F07RzmLZ5UCFVJHKs+z4mgj+p8YLMoGPDUuPl15A1XyljawliSYpLWjCZH3
         6PTtkcOrPq/w6l7cg3ONhr+pi6cFs5WoTLr7+qNiMQayYxxe4LH7F6N6ZqZ0illsJbWP
         1bIk4ie0yMcCDN4yJ3RmHgfK238pRsH6jhCwCUMckgLX1WuuKIpeDqO0iAGnEZdaas18
         /nGf6XA93NsbwWWTi4MLHBmP+7kU17aXnFgeUexVycak6ws2+4k7gganP58pYLNyQyS8
         eSWw==
X-Gm-Message-State: APjAAAWpqddsXv7kxiG4LWdke9kG/oMrwJqzTuIy0a6VBMbPMOzVzMwm
        uu2189KhWTZDlllA129QbeAzobWP00VYmFgHc5S7
X-Google-Smtp-Source: APXvYqwnyVmH+SbfXL85kB+6+uZoKbVqbIZyP3xFhSOuN3cc2gGUAfaD1S8kKRAY8z9Z+TXcwq7VPWZ7hTsyjk4tMb5G
X-Received: by 2002:a63:8942:: with SMTP id v63mr17156494pgd.58.1569012635545;
 Fri, 20 Sep 2019 13:50:35 -0700 (PDT)
Date:   Fri, 20 Sep 2019 13:50:32 -0700
In-Reply-To: <xmqq8sqiu2in.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190920205032.84796-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq8sqiu2in.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: Re: [PATCH v2] merge-recursive: symlink's descendants not in way
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, newren@gmail.com,
        szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> OK.  We notice that we need to newly create foo/bar but we
> >> incorrectly find that there is "foo/bar" already because of the
> >> careless use of bare lstat(2) makes "bar" visible as if it were also
> >> "foo/bar".  I wonder if the current code would be confused the same
> >> way if the side branch added "foo/bar/file", or the confusion would
> >> be even worse---it is not dir_in_way() and a different codepath
> >> would be affected, no?
> >
> > I don't think there is a different codepath to be affected - as far as I
> > can tell, dir_in_way() is the only cause (at least of this particular
> > error).
> 
> OK, so existing code already realizes that "foo/bar/file" added in
> the side branch is the one that must survive, and the "bar/file" in
> the current branch does not fool it into thinking that "foo/bar/file"
> is also on our end, and needs to be merged as an add-add conflict.
> It was only the dir-in-the-way logic that was not careful enough?

Yes, that's correct. (I wrote foo/bar/baz in my other email but replaced
"baz" with "file", and it still works before and after my patch.)

> In that case, thanks for a very good news and for a careful analysis.

You're welcome! The careful analysis should be credited to Elijah Newren
[1].

[1] https://public-inbox.org/git/CABPp-BHpXWF+1hKUTfn8s-y4MJZXz+jUVS_K10eKyD6PGwo=gg@mail.gmail.com/
