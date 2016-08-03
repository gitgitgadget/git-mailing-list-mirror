Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 898A81F855
	for <e@80x24.org>; Wed,  3 Aug 2016 07:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027AbcHCHg6 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 03:36:58 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33063 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbcHCHgy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 03:36:54 -0400
Received: by mail-io0-f194.google.com with SMTP id y195so17697790iod.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 00:36:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9mOVW8fct5ETAAzkIpaiscWeKklM+/xReXL0+hXsEKw=;
        b=ttU2EQrMgJD9SswQwkzjrtkkS8H9PvRjoZbcCrT2Aa0gtjvi9cWh7GJSw7BkZkKYIu
         lgY5wUEIhFpM9asvA6P0nkCV1g8R4rA84d/47E1VVscvNR7whmt97s42rZiuuvggcdHw
         t+Q7kpu93/dAD7IXfMlypWIpiman9EaPaPkRhypdh4Im2Q5tOJti0SmaLUQBehoxSnh/
         0Yehupwr5JWFiDslQqqUvfTnYkuFj3eEG8t7bf2ienVgzvFlYz/FVan0BhEzYxnNwwPj
         u0wLopb4kalxVdfs1gLjwVMgzysFaBxCMWSgnaaOf3qg2AouASoOGVLbNuOm3vSNqKBL
         aRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9mOVW8fct5ETAAzkIpaiscWeKklM+/xReXL0+hXsEKw=;
        b=JLKdyGdbHCXRAMtpcHo6wBfrwg2aYU5uYisQ3+mSi6TtH/Vdbqve8UckdEtc+hwVx9
         OQWy0W2qdQf+urVtqU0j/y+GoEbebvsZ6hQVCtXX1XKMiTiPREGldTg40b0X37OvEmph
         Xx2VnLNP80lat+3oBwAE22UlfraNJFKoUYNEB0GYxq1dwEvHblmIJDKjrA5W0UjcQX4T
         HeytmU/B9YneRVLdLsYJgzXcWGVmnkuXyCO1ANSTGWFJA6aHy8UXfWJV7KyYOI/HbHkr
         14lzgc4j6b3u03zsMRHXKCqHunwNGmE3tg/5POq32w2QHfXDleG3kFGfgxL3QMSlYheT
         uXHg==
X-Gm-Message-State: AEkoout0zAICo0h+9YN3kSjjkoWMzK197Tc0L019UgotLA9C3/3FEGktSSGYSPYI+PMBF24JrPZ697gzYg97gw==
X-Received: by 10.107.5.10 with SMTP id 10mr67350306iof.104.1470209796365;
 Wed, 03 Aug 2016 00:36:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.7 with HTTP; Wed, 3 Aug 2016 00:36:35 -0700 (PDT)
In-Reply-To: <20160802105252.jyl5x7eanttw2swj@sigill.intra.peff.net>
References: <20160613053203.GB3950@sigill.intra.peff.net> <20160613053928.GC23880@sigill.intra.peff.net>
 <CAPig+cQudTwT6H35YgEvxdK9AAn0BwvUC8bi8-DxGYNh9rb_Lw@mail.gmail.com>
 <20160614050541.GA9909@sigill.intra.peff.net> <20160802105252.jyl5x7eanttw2swj@sigill.intra.peff.net>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Wed, 3 Aug 2016 03:36:35 -0400
X-Google-Sender-Auth: 7bWWXlQnqsgBytoGPbGYesq4HW0
Message-ID: <CAPig+cT4x2ndMde8RMsseHcuSZpOoPgfXLRFUOyBK_iAz-xKyg@mail.gmail.com>
Subject: Re: [PATCH] blame: drop strdup of string literal
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 2, 2016 at 6:52 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 14, 2016 at 01:05:41AM -0400, Jeff King wrote:>
>> On Tue, Jun 14, 2016 at 12:32:15AM -0400, Eric Sunshine wrote:
>> > > +       struct string_list range_list = STRING_LIST_INIT_NODUP;
>> >
>> > Related to this series, there's an additional "fix" which ought to be
>> > made, probably as a separate patch. In particular, in cmd_blame():
>> >
>> >     if (lno && !range_list.nr)
>> >         string_list_append(&range_list, xstrdup("1"));
>> >
>> > which supplies a default range ("line 1 through end of file") if -L
>> > was not specified. I used xstrdup() on the literal "1" in 58dbfa2
>> > (blame: accept multiple -L ranges, 2013-08-06) to be consistent with
>> > parse_opt_string_list() which was unconditionally xstrdup'ing the
>> > argument (but no longer does as of patch 1/3 of this series).
>>
>> Yeah, I'd agree that this is a minor bug both before and after the
>> series due to the leak. Want to roll a patch on top?
>
> Here it is, just to tie up a loose end. I marked you as the author since
> the hard part was noticing the issue and explaining the history, which
> you already did above.

Thanks for picking up the slack, and my apologies for not being able
to find time to submit the patch myself (my computer time is severely
limited these days).

> -- >8 --
> From: Eric Sunshine <sunshine@sunshineco.com>
> Subject: [PATCH] blame: drop strdup of string literal
>
> This strdup was added as part of 58dbfa2 (blame: accept
> multiple -L ranges, 2013-08-06) to be consistent with
> parse_opt_string_list(), which appends to the same list.
>
> But as of 7a7a517 (parse_opt_string_list: stop allocating
> new strings, 2016-06-13), we should stop using strdup (to
> match parse_opt_string_list, and for all the reasons
> described in that commit; namely that it does nothing useful
> and causes us to leak the memory).

A nice explanation, and the patch itself looks "obviously correct".

> Signed-off-by: Jeff King <peff@peff.net>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

> ---
>  builtin/blame.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index ab66cde..29bd479 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2805,7 +2805,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>         lno = prepare_lines(&sb);
>
>         if (lno && !range_list.nr)
> -               string_list_append(&range_list, xstrdup("1"));
> +               string_list_append(&range_list, "1");
>
>         anchor = 1;
>         range_set_init(&ranges, range_list.nr);
> --
> 2.9.2.670.g42e63de
