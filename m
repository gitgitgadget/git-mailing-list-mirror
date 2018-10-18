Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5889F1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 18:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeJSCDS (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 22:03:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32907 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbeJSCDS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 22:03:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id l14-v6so20117747edq.0
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 11:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/G9n7QqzWE6n7tmIwUlq6NRCLt6UFCki+cKHUytQeIk=;
        b=Pcx/gUgi//1VQt7fcFOClqI9Vv3vFZ2T903Y7ibQ+8xlRrKJ0Q4l5mxVHaQy6SPAq/
         EDqHMAXysD8Jbju2/ZSNY92OjGcZmDx36LKaHGFczsTLSzfIF7dj0m42i9RTSuOoAF4b
         M9tgfdYCltaod3X5u8uixjNw+Z4YOqZMEmUXtNFA6OGGcOE1i5gQtapV2lgvYEeIl1n9
         gT1pR7+w/4TK/005UIyYaAG4SdroVjkEOzr1cMFZcdqzmBdWXLySB42GJdGBi5ox/jFY
         +8uh39Mu/tD0UV6Du9Ql41zNLJxkZU9OyPR3hOaq5QRlORmp/h8b2N/MfifKK2yTYuiT
         7Saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/G9n7QqzWE6n7tmIwUlq6NRCLt6UFCki+cKHUytQeIk=;
        b=MOk3rMURTTqKKrPjlT0EHVeEfBYiBFDmqcs2TOt53nJVg+iK8yXbDHLk2R+zv4+38n
         7QQA8m6Ck215bRwPwB5R+/2Zi0AM3Jo+ExJIlxjiEQ7Mprv4iNq1VvJQuBH/8+GersMi
         WGYav31NjK7lRowqjmZzXx/0JwkFonsTvQhkFNrgY3MjV9cJtCI6KbpSOg+llGJJ3P0M
         LDH0hQTBP74zvpcNW5xFZEXNKUwpIb0PjUzAv3ZOl7UoZmoHuQTLSEb6e00FkqtHK04S
         e9/hFYWTRGImEx3x/vzFLLBZTgFy2Cv8VaGKB1iecO2TP2vB5gDyglYQnAxg4g3IITol
         0NLw==
X-Gm-Message-State: ABuFfojqu8hrlbIZvElRYb+DDCNEEJAPnYQzWg7jKbZiSbSQr0K4MhsG
        n3+q4EOTQgUeEktW6eQ4XbfKbbk5VIy+9SKUuKmTLXEUWlPjFg==
X-Google-Smtp-Source: ACcGV61R4+QHGfZx+ROhnFHo06mFluM8MFTYhXj2gRVUHEHnboebHejI56aRT9hPphs8NTNGH2l4hNsu1LuXWXbFJ3g=
X-Received: by 2002:a50:aca2:: with SMTP id x31-v6mr4072270edc.76.1539885670715;
 Thu, 18 Oct 2018 11:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181016181327.107186-1-sbeller@google.com> <xmqqa7nb67a2.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7nb67a2.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 Oct 2018 11:00:59 -0700
Message-ID: <CAGZ79kapFJh+4rubbD4oNtzfceFc6yMWEixDu48vN7wqJGWMRw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Resending sb/submodule-recursive-fetch-gets-the-tip
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 12:30 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > This is based on ao/submodule-wo-gitmodules-checked-out.
> >
> > This resends origin/sb/submodule-recursive-fetch-gets-the-tip, resolving
> > the issues pointed out via origin/xxx/sb-submodule-recursive-fetch-gets-the-tip-in-pu
> > by basing this series on origin/ao/submodule-wo-gitmodules-checked-out
>
> Applying this round to the result of merging ao/submodule-* to
> 'master' requires this to work, it seems, as you've introduced a
> call to repo-init thing in the meantime with another topic.

Unfortunately, yes, sb/submodule-update-in-c had one such call.

> > This is based on ao/submodule-wo-gitmodules-checked-out.
> Thanks.  I had an impression that we were not entirely happy with
> the topic and are expecting a reroll, but let's hope that the part
> we expect to be updated won't have much overlaps.

I slowly came to the realization that this topic might be ripped up
into 2 or more topics, as some of the cleanups seem to be orthogonal.
