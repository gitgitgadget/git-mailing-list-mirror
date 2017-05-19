Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FAAC2027B
	for <e@80x24.org>; Fri, 19 May 2017 18:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756132AbdESSkh (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 14:40:37 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33283 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbdESSkf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 14:40:35 -0400
Received: by mail-pg0-f46.google.com with SMTP id u187so41831736pgb.0
        for <git@vger.kernel.org>; Fri, 19 May 2017 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7ZutLqEXJSs28+ly5/1iouO+lbipAGZGtgVbX6XmkBE=;
        b=kP7b0OkpTW4f5CgT8UCBAuFaXIhymedQC3z1rR806RcpF5L5y6f6wH4CRrmDlcf+Kg
         /DjhmH8wsNbuMInq0R6GGm+glM5ME59ojXDdBoKS2Iy7CR+NdW/O8DayBY6+hng3iHLJ
         rWz903OehpQraXF5Py4teqfhEtlN/2TLeoDZnNsnetAK/6EmDdqYI6WjA4BXfIHfbecr
         K48xDMewL4VPCcEZArdKK5tWlWCKki8HA86J70LDMHaJm7wSlXg6udp1KE6ORwk8VfNJ
         4qLP3VHdTVTIxg6kByqurd+BdIw46am4UcmFH0C8w/CkLXkYezBWbtYAH2xOzX210Nyd
         8HCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7ZutLqEXJSs28+ly5/1iouO+lbipAGZGtgVbX6XmkBE=;
        b=TQ/qzZj0UHgWezpgH144DR2K34XLj56I9ZLhAcATl3jMbACbfht0oj/W6QSVhZ1wME
         m4gsIIJKrQGRIxEqLiYBd4nzaclIY+6CX8B5rFwqPQG/jGr/HdDxsO5P3sEtgmg7OQUw
         akJUmIaqrn3+yk1SBOR33N37hNT8NTbQ6aesfhKY1p/KU/jY5JBLEZJW7d5o2jAGIAvj
         kagRxVTQXg/SuzNct/JMKLhDygD49+9+WCVyxFRnpVrRqLck2l1jbQtSaKKR/nLink9p
         cQfBMGq/PtzwwGFqZF4GfQ9fqJnpUxwMSmr1lfus5Kk1jBe99b7ZbtuBouYeSgY0/Nwp
         ND/g==
X-Gm-Message-State: AODbwcAgjgJZ6ikOtJQ9nuC/puy0UADb7c+IfMrTwQfiG+2btCgd6jP1
        Uvwy4D2q76sck+bgeI1AGUct8nNkMqSk
X-Received: by 10.98.205.65 with SMTP id o62mr11757487pfg.105.1495219234627;
 Fri, 19 May 2017 11:40:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Fri, 19 May 2017 11:40:34 -0700 (PDT)
In-Reply-To: <20170519112330.731ecc66@twelve2.svl.corp.google.com>
References: <20170517025857.32320-1-sbeller@google.com> <20170518193746.486-1-sbeller@google.com>
 <20170518193746.486-21-sbeller@google.com> <20170519112330.731ecc66@twelve2.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 19 May 2017 11:40:34 -0700
Message-ID: <CAGZ79kYzgZeAnYsEODEYAEavvABS89oSq9Zj80=eS2ObtnMmNg@mail.gmail.com>
Subject: Re: [PATCHv3 20/20] diff.c: color moved lines differently
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 19, 2017 at 11:23 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Thu, 18 May 2017 12:37:46 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
> [snip]
>
>> Instead this provides a dynamic programming greedy algorithm that
>
> Not sure if this is called "dynamic programming".

https://loveforprogramming.quora.com/Backtracking-Memoization-Dynamic-Programming
http://stackoverflow.com/questions/3592943/difference-between-back-tracking-and-dynamic-programming

Instead of doing backtracking (finding the lengthiest hunk for
each line), we keep a set of potential hunks around, this sounds
very much like the examples given in these links.


> The first part of the commit message could probably be written more
> concisely, like the following:
...
> Having said that, thanks - this version is much more like what I would
> expect.

Thanks for giving a more concise commit message, will fix in a reroll.


>
>> +static int buffered_patch_line_cmp_no_ws(const struct buffered_patch_line *a,
>
>> +static int buffered_patch_line_cmp(const struct buffered_patch_line *a,
>
> Instead of having 2 versions of all the comparison functions, could the
> ws-ness be passed as the keydata?

No, this is misuse use of the API, peff explains:

https://public-inbox.org/git/20170513085050.plmau5ffvzn6ibfp@sigill.intra.peff.net/



>
>> +static unsigned get_line_hash(struct buffered_patch_line *line, unsigned ignore_ws)
>> +{
>> +     static struct strbuf sb = STRBUF_INIT;
>> +
>> +     if (ignore_ws) {
>> +             strbuf_reset(&sb);
>> +             get_ws_cleaned_string(line, &sb);
>
> Memory leak here, I think.

It's static, so we don't care.
I can make it non-static and release the memory in a resend.

>
>> +             return memhash(sb.buf, sb.len);
>> +     } else {
>> +             return memhash(line->line, line->len);
>> +     }
>> +}
>
> [snip]
>
>> +static void add_lines_to_move_detection(struct diff_options *o)
>> +{
>> +     struct moved_entry *prev_line;
>
> gcc says (rightly) that this must be initialized.

This is one of the last refactorings I did on this patch, moving
the prev_line out of the diff_options struct (which is memset in its
init), forgot to init it here. will fix.

>> +     int alt_flag = 0;
>
> Probably call this "use_alt_color" or something similar.

Sounds better than alt_flag.

>> +                     struct moved_entry *p = pmb[i];
>> +                     struct moved_entry *pnext = (p && p->next_line) ?
>> +                                     p->next_line : NULL;
>> +                     if (pnext &&
>> +                         !buffered_patch_line_cmp(pnext->line, l, o)) {
>> +                             pmb[i] = p->next_line;
>> +                     } else {
>> +                             pmb[i] = NULL;
>> +                     }
>
> Memory leak of pmb[i] somewhere here?

pmb[] holds pointers into moved)entry elements that
are obtained via  hashmap_get_next(hm, match), such that
any pmb[] element is also part of a hashmap.

When freeing the hashmap, we'll free the memory. This
array doesn't own the underlying memory.

>> @@ -4874,6 +5114,11 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>>
>>       if (o->use_buffer) {
>> +             if (o->color_moved) {
>
> Can you just declare the two hashmaps here, so that we do not need to
> put them in o? They don't seem to be used outside this block anyway.

Obviously. Thanks for that pointer as well.


>> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
>> index 289806d0c7..232d9ad55e 100755
>> --- a/t/t4015-diff-whitespace.sh
>> +++ b/t/t4015-diff-whitespace.sh
>
> As for the tests, also add a test checking the interaction with
> whitespace highlighting, and a test showing that diff errors out if we
> ask for both move coloring and word-by-word diffing.

We do not error out, but ignore the move heuristic doesn't find any
blocks. I can make it error out, instead. (and add tests)

Thanks,
Stefan
