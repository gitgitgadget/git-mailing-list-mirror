Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 074042036D
	for <e@80x24.org>; Fri, 24 Nov 2017 20:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbdKXUEH (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 15:04:07 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39944 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbdKXUEG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 15:04:06 -0500
Received: by mail-qk0-f194.google.com with SMTP id c123so15375782qkf.7
        for <git@vger.kernel.org>; Fri, 24 Nov 2017 12:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uBKq85eTuRI0SujZFVIRo6rRd1hIGy4NQJGmtZSJbUk=;
        b=CqhTpLe1fRSMgnGdCBLajN7bgG1Xn+jAd+AHdNxGPyuAKHqLU3YJY1RiTeqrVbBHmz
         Vzb7uCGvwv2m3NLazmP+qL8vhcKi5YeUgPQnMwVrZADCO5zbPU1xHOKkOpytm/2G04pD
         4GdNND2iwJO6Eixq5eHcV9eKNVbgvLmZj+vCeon5Obfro6KiBsCdssG3WH39Sa5kAKkI
         mceyAsrUumeVwfaRBez3hVgXF2lgQQujPZc6ZXOdxdz5Nu91Q5zpTn+hg96Q9YDRybO5
         heajX9g7oB/vGqIc0RrjpXWdXNtu0a71OzbVFOMo1Wlkinzj1J4ZH7ZBqaVCUl168zeJ
         SmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uBKq85eTuRI0SujZFVIRo6rRd1hIGy4NQJGmtZSJbUk=;
        b=AnysMntS6uh9SJb0ZtC2o8kuzsbw3aaxq4yoFScBKYWmQbuCT2GfWF0eX8+OIZ/yHS
         9K1yGNm9kH660R1txx2F3hTgmFbYl08b6BS9YrBrc8zMjIBQvsob8sbwwDB2Ily8yyNS
         mtjrfcDHeayJL8EQLe+99gRl7zEeJ8Zcr4DQzYvf/FsenAfJAV8O8UotDDVTjbURoVYg
         jp2AWhCm+we0lSTDwQY8a7CizRRZki3KtmmXOf1IoIk37USP3t0QofvufFJz6+Abl018
         k5ukTMR4d2NTSqt3zZtAgHGIhzNJC+nksN1gimB41TLO0gZrhamtFVsItAXxXCuYjVLJ
         31aQ==
X-Gm-Message-State: AJaThX7ut73watKW0yZ7Ggt92dKq9SZP/lQm8eHHeafg0gbamBq58Ivq
        epycrImSW1ZPMxHBSE7WpkTBmF4B/HolGRglJ6o=
X-Google-Smtp-Source: AGs4zMaSj8F4S4nQ2z1BbcKDltV4Asxx8OVqu0ParavPSoHLqeks0iC48EziY1BMkANhIDBv+4tL9rYg5xKn+3uA84Y=
X-Received: by 10.55.93.198 with SMTP id r189mr11965126qkb.210.1511553845855;
 Fri, 24 Nov 2017 12:04:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Fri, 24 Nov 2017 12:04:05 -0800 (PST)
In-Reply-To: <20171124195901.2581-1-newren@gmail.com>
References: <20171124195901.2581-1-newren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 24 Nov 2017 15:04:05 -0500
X-Google-Sender-Auth: Lh83pPuLt70NwjolSreNcXeb8go
Message-ID: <CAPig+cTtT2xLHy6gE9fW9G_KdzGTNEfgwz7NUOUwHxGKOkiKtA@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: ignore_case shouldn't reject intentional removals
To:     Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        David Turner <dturner@twitter.com>,
        David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 24, 2017 at 2:59 PM, Elijah Newren <newren@gmail.com> wrote:
> In commit ae352c7f3 (merge-recursive.c: fix case-changing merge bug,
> 2014-05-01), it was observed that removing files could be problematic on
> case insensitive file systems, because we could end up removing files
> that differed in case only rather than deleting the intended file --
> something that happened when files were renamed on one branch in a way
> that differed only in case.  To avoid that problem, that commit added
> logic to avoid removing files other than the one intended, rejecting the
> removal if the files differed only in case.
>
> Unfortunately, the logic it used didn't fully implement that condition as
> stated above; instead it merely checked that a case-insensitive lookup of
> the file that was requested resulted in finding a file in the index at
> stage 0, not that the file found in the index actually differed in case.
> Alternatively, one could view the implementation as making an implicit
> assumption that the file we actually wanted to remove would never appear
> in the index with a stage of 0, and thus that if we found a file with our
> lookup, that it had to be a different file (but different in case only).
>
> The net result of this implementation is that it can ignore more requests
> than it should, leaving a file around in the working copy that should
> have been removed.  Make sure that the file found in the index actually
> differs in case before silently ignoring the request to remove the file.
>
> ---

Missing sign-off.

> diff --git a/merge-recursive.c b/merge-recursive.c
> index b48b15a6f..100fb913f 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -646,7 +646,7 @@ static int remove_file(struct merge_options *o, int clean,
>                 if (ignore_case) {
>                         struct cache_entry *ce;
>                         ce = cache_file_exists(path, strlen(path), ignore_case);
> -                       if (ce && ce_stage(ce) == 0)
> +                       if (ce && ce_stage(ce) == 0 && strcmp(path, ce->name))
>                                 return 0;
>                 }
>                 if (remove_path(path))
> --
> 2.11.0
