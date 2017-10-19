Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D62202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 19:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbdJSTxG (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 15:53:06 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:56309 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752477AbdJSTxE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 15:53:04 -0400
Received: by mail-qt0-f169.google.com with SMTP id v41so15892729qtv.12
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lD/mG0kZk4+piBFt7xEEAhAspCHOtEDgpZ8Hid5ulEo=;
        b=m1HcD52It59Fozsiq9Tu6jLVwC4cJfFMDJdRoimpA70cSZWsssni1Y0pDLM5S3BCRs
         mX+SzcGdAyGb2vsq4CSswc6uFJvjr8FRW1s4rJ29IDJ1yLZVmqMOsXxuH7K4iRb0XVaZ
         cvuPpg7+Cb4TAVxWo/pZ0zjVI2EhA6I8L8cjZQ9G8fSKhHZju2G5W0ylkfIgrbawFMrm
         9tTS559oFuziCd8HT8ByhL4BGt8TGTSA0VlUECk9Lfqs6QNpl3+YK5wh3EFDWj8hDEAW
         w6msf+LxtLzq411+Q2wlTSnidz4RxnMpJ2yCb0Amg45lfSqRbsS6uxnRqEmzvFKb0crC
         7jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lD/mG0kZk4+piBFt7xEEAhAspCHOtEDgpZ8Hid5ulEo=;
        b=cTRmDtq2bLhh2AH/BKwnAdzrxWz6TzH0yXLSeb3MuPxY1+zDRgJ07P8VDGNbpHiZaC
         vtB7HndLuGrw7tUcfS+dja3ZxOYIvmGmFEWAY3iDBrNIj9ofcwEUgzPHM/pn7IussvDi
         gFfrK28AYoXwbJXZm9J5CH/KVX6ioQHPmB57H2IJtfrgrn3x2uSSGFFycxrkPz5tJ5X7
         cZJ6SQeE8uL0ZwtYngTvv6Z3t2wajHxEQuekCjng1AKmJcWVNSL42TCC6ca927xMU2T5
         vbl1soN0oCMXBAaGJdnioDVob+EoH/2PXeAvu8wYsnsVX2mLOOLqKZtjFIIg/j2Ac0dw
         fzSg==
X-Gm-Message-State: AMCzsaXAbVjsORC/uITkXhBWJJ8iHPM+hXOogjzzjlaSy1EnLS0KtQfq
        9G1gDMX1Wj2Mc79/DGBjjjshOgzaOwhOze0j/NyS6g==
X-Google-Smtp-Source: ABhQp+SHqFDbBbttVEtY/S2KuVobah3Np9tKw5uY+8bwB2jsHxZ9Nn6XhG3oMCgx70Z7v1oUlmryI/a56RB3S74tzYI=
X-Received: by 10.237.37.132 with SMTP id x4mr3557781qtc.224.1508442783829;
 Thu, 19 Oct 2017 12:53:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 12:53:03 -0700 (PDT)
In-Reply-To: <20171019052457.gqenoshgyjcw53tb@sigill.intra.peff.net>
References: <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
 <20171012233322.31203-1-sbeller@google.com> <20171013001837.43nx5paeqisbrflq@sigill.intra.peff.net>
 <20171013002057.froqi54olmhmah6b@sigill.intra.peff.net> <20171019050459.p2cx63yrxfwq4ta3@sigill.intra.peff.net>
 <20171019052457.gqenoshgyjcw53tb@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 12:53:03 -0700
Message-ID: <CAGZ79kbRFVd=hbc4DCrdkOJ4aUE_g1_NhMbG-tfPGnOJikf1GA@mail.gmail.com>
Subject: Re: [PATCH] diff.c: increment buffer pointer in all code path
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Orgad Shaneh <orgads@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 18, 2017 at 10:24 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 19, 2017 at 01:04:59AM -0400, Jeff King wrote:
>
>> So. That leaves me with:
>>
>>   - I'm unclear on whether next_byte() is meant to return that trailing
>>     NUL or not. I don't think it causes any bugs, but it certainly
>>     confused me for a function to take a cp/endp pair of pointers, and
>>     then dereference endp. It might be worth either fixing or clarifying
>>     with a comment.
>>
>>   - Those loops to eat trailing whitespace are doing nothing. I'm not
>>     sure if that all works out because next_byte() eats whitespaces or
>>     not (I think not, because it doesn't eat whitespace for the
>>     IGNORE_WHITESPACE_AT_EOL case). But I'm not quite sure what a test
>>     would look like.
>
> I had trouble constructing a test at first, but I think my test lines
> just weren't long enough to trigger the movement heuristics. If I switch
> to something besides seq, I can do:
>
>   # any input that has reasonably sized lines
>   look e | head -50 >file
>   git add file
>
>   perl -i -ne '
>     # pick up lines 20-25 to move to line 40, and
>     # add some trailing whitespace to them
>     if ($. >= 20 && $. <= 25) {
>       s/$/     /;
>       $hold .= $_;
>     } else {
>       print $hold if ($. == 40);
>       print;
>     }
>   ' file
>
>   git diff --color-moved --ignore-space-at-eol
>
> I think that _should_ show the block as moved, but it doesn't. But if I
> apply this patch:
>
> diff --git a/diff.c b/diff.c
> index 93dccd1817..375d9cf447 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -743,8 +743,8 @@ static int moved_entry_cmp(const struct diff_options *diffopt,
>                            const struct moved_entry *b,
>                            const void *keydata)
>  {
> -       const char *ap = a->es->line, *ae = a->es->line + a->es->len;
> -       const char *bp = b->es->line, *be = b->es->line + b->es->len;
> +       const char *ap = a->es->line, *ae = a->es->line + a->es->len - 1;
> +       const char *bp = b->es->line, *be = b->es->line + b->es->len - 1;
>
>         if (!(diffopt->xdl_opts & XDF_WHITESPACE_FLAGS))
>                 return a->es->len != b->es->len  || memcmp(ap, bp, a->es->len);
> @@ -771,7 +771,7 @@ static unsigned get_string_hash(struct emitted_diff_symbol *es, struct diff_opti
>  {
>         if (o->xdl_opts & XDF_WHITESPACE_FLAGS) {
>                 static struct strbuf sb = STRBUF_INIT;
> -               const char *ap = es->line, *ae = es->line + es->len;
> +               const char *ap = es->line, *ae = es->line + es->len - 1;
>                 int c;
>
>                 strbuf_reset(&sb);
>
> it does. It just adjusts our "end pointer" to point to the last valid
> character in the string (rather than one past),

Thanks for spotting. I can send a proper patch with tests if you'd like.


> which seems to be the
> convention that those loops (and next_byte) expect.

I'll look at that again.

Thanks for poking!
Stefan

>
> -Peff
