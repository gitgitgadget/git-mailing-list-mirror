Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28B36202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 21:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753286AbdJSVvA (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 17:51:00 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:55532 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752693AbdJSVu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 17:50:59 -0400
Received: by mail-qt0-f194.google.com with SMTP id v41so16265344qtv.12
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 14:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HyHuhy7XORU0wBQ/dI9E4VWwLlK2p3o72ipuEUdCR0o=;
        b=DXMcB+oc2duE9G9vvFh8rwPJ6O4KBu99oyGx0lFqP3a0c2HiDFSS8E6xR5qhHI7so1
         1SaTfaj/LokjB7ojBUN63tcM7N/PIZfp9G6hV0juHPBzYJbHEYAkZlfhbOGLrma5u5Pu
         P8k8VN8OvEnNJ8/Nk+0OcWfZ0BMPMVKp2hWPLiRtvmzd+8oORcZ7fKBoRX8Cl+y7gtRc
         w5EQp72Qx0jOiEhF1ZpgbEXhBhihIHo3t6D327K6OU3MMfub5eDB5N1AcCpDxym1Uu8d
         WUA2VD3gdDUrOR1jJKkSmroRMu++MvW3KXmKkDKFWzVxkDvCf9ftVNKn/4WTBmI9hH3R
         YgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HyHuhy7XORU0wBQ/dI9E4VWwLlK2p3o72ipuEUdCR0o=;
        b=BzbEE+p1qSVDLBVkekhjQVK2OEPrfl79qNF2XUjhQYPZJT4NR5fjCChxgim9eQ1qux
         EL3S3gZ+gCcQdPzg6BWhUrk+X/mMtPUV5DaSO45yXpImPBFODm5OiskGPiazvbYcB8yH
         bjEIueEVXm97bbhnyvwGbHKryE/2ETjOMpPQmEouGre02xetIdUBpWhDVbp1SUHQTS1u
         HBdjkWyhqqavAAl0KRjIylGuBXnRUlTcWPrzkr4eRgtyqAJjhsyGbkGvP7ibhvuYKorJ
         5/nI9xLJSzKwOy1TxB7juxs4QNOjKcwoE8jkh/euB9zT/g2ipmQAfhNYibquDlCsLmwu
         /jJQ==
X-Gm-Message-State: AMCzsaXPtqWCbPLMMVNZUoap49+b2V5ts4BOxTi16NVnAD2+aJpVS69v
        UnrgPLOGbjmcWkbOSjDgSJZyfGoQr/4UXZjO45OuYQ==
X-Google-Smtp-Source: ABhQp+SGn9i7M8TpeGVI2zGvMD99yF9qJ/A6EeKRlKjIv2tciXmmJc3r6rbNs8yLBDFbu/SGW2DOQ+4BzE6XucgyYA8=
X-Received: by 10.200.40.146 with SMTP id i18mr4291320qti.79.1508449858584;
 Thu, 19 Oct 2017 14:50:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 14:50:58 -0700 (PDT)
In-Reply-To: <20171019213958.d6rp2upiga5tsvys@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
 <20171019203119.d2xbryov2y5t2aig@sigill.intra.peff.net> <CAGZ79kY3jVgBRCKkswHV7xbjiiNgvsbVsgq_9PpVwa-zTt4q0Q@mail.gmail.com>
 <20171019213958.d6rp2upiga5tsvys@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 14:50:58 -0700
Message-ID: <CAGZ79kahvE=S_SwZqzC_VrAPURVCkqjaa9sVN-bCecYLoA4yRw@mail.gmail.com>
Subject: Re: [PATCH 5/5] diff: handle NULs in get_string_hash()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Orgad Shaneh <orgads@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 2:39 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 19, 2017 at 02:31:20PM -0700, Stefan Beller wrote:
>
>> > This is unlikely to ever come up in practice since our line
>> > boundaries generally come from calling strlen() in the first
>> > place.
>>
>> get_string_hash is called from
>>  prepare_entry, which in turn is called from
>>   add_lines_to_move_detection or mark_color_as_moved
>>    diff_flush_patch_all_file_pairs
>>
>> that constructs the arguments in
>> diff_flush_patch
>>  run_diff
>>   run_diff_cmd
>>    builtin_diff (part "/* Crazy xdl interfaces.. */")
>>     xdi_diff_outf( fn_out_consume as arg!)
>>      xdi_diff
>>       xdl_diff
>>        xdl_call_hunk_func
>>         -> fn_out_consume(cb, line, len)
>>
>> xdl_call_hunk_func however uses pointer arithmetic instead
>> of strlen. So I think this sentence is not a good idea to put in
>> the commit message.
>>
>> It may not occur in practice, due to binary files detection using
>> NUL as a signal, but conceptually our move-colored(!) diffs
>> should be compatible with NULs with this patch now.
>
> Good catch. I just skimmed over all the diff_emit_* functions, which use
> strlen(). But at the bottom is emit_add_line(), which has a real length
> marker from xdiff.

Doh!
There is diff_emit_submodule_* but I presume you meant
emit_diff_* actually as there the strlen is legit, as we generate
known non-NUL data to print.

The submodule output may get mangled in diff_emit_submodule_{add,del}
as the input is coming from user data.

> I agree we wouldn't see NULs in general, but this is maybe fixing "diff
> --color-moved -a". I dunno. It's probably not worth digging too much,
> since it seems like the right thing to do regardless.

I agree, that this digging seems not worth it; I was just agitated at
the seemingly incorrect commit message.

Thanks,
Stefan

>
> -Peff
