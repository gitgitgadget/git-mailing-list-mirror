Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B51207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 21:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753942AbdFWVnq (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 17:43:46 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35249 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbdFWVnp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 17:43:45 -0400
Received: by mail-wr0-f193.google.com with SMTP id z45so15563388wrb.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+YB2oDM3tPZ6vVYMOmqnLOI7tiy/aH87L+8Hl5W8/C8=;
        b=pd2NnYGUSOnvoySxvYYTwjC8lrymTGhmYH/TGYdAW/gyrDBfXXRZm34eq3tO8fC7wX
         nWCayB7PpN766U6pBb4NPkTbDL4MMBz40QlzFXEu59Juz94aDvNDN+w/v0pYhBTctxUF
         Y/o6rCobZJo3pXuzDe4KaRF6tdczv6IHZHiVZCMdS1CA0cdTXTpHMKGWgHie0w2jf0Yh
         UqkrFHOAeVtJsE0oGIz9dkp7Lpkv7Pes6iLYeJKiVTNyYUbdLceZ7rVJiYKl+oaUTIFN
         FOWsupgEWSJbs3um1nlHDuvrvYnvpkLz1CiX4S7aSHWPqj00BFcuhzBXVZbdAxL7hIgH
         Je1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+YB2oDM3tPZ6vVYMOmqnLOI7tiy/aH87L+8Hl5W8/C8=;
        b=TbAtY0ImIQMgOLCCO7UMYzc1t8DRjMs8YFtJXh9Ddg01HJOnfH29lxr5B83EnkFo8M
         ZBF3TLOsLXwr9T4GIcnewWHRpq79wl9sGninFXMjgTXfPEgnRMjSdjqh1sg4ZxguYUeT
         4DiUh4AE+KbooJuu6NWv972+6AUxCRe4UI5CP/xSve33GumNSKPq+shiy2hxpap1ACaA
         Wa+o2qvOkn1V8FynbB+mr5uXOs5ERGQ872DTOFhacbbzFv2N7I6XQ/UFevBcPnLQxlNq
         QV6z/Kb4uCt8w9OwNLuEDhyAnnefyMIRBNyFVtfZfHHigU0p6skqiBIZF+Tj3OMREPgm
         Z9+w==
X-Gm-Message-State: AKS2vOzIJH/cd0ezS6wUnbzBooL1LWn9JKBWtY8Y07MJpFv9qeTGDSt4
        9b/iKJKwf/kP8nJT0j0=
X-Received: by 10.80.131.133 with SMTP id 5mr7296000edi.14.1498254223833;
        Fri, 23 Jun 2017 14:43:43 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id d56sm3073289ede.42.2017.06.23.14.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 14:43:42 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dOWMf-0004nt-J8; Fri, 23 Jun 2017 23:43:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Subject: Re: [showing-off RFC/PATCH 26/26] diff.c: have a "machine parseable" move coloring
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com> <20170620024816.20021-1-sbeller@google.com> <20170620024816.20021-27-sbeller@google.com> <CAGZ79kYLdpaXzn0T5547fRr=EPR691n2bPfS+mzaZuS-k39ayw@mail.gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAGZ79kYLdpaXzn0T5547fRr=EPR691n2bPfS+mzaZuS-k39ayw@mail.gmail.com>
Date:   Fri, 23 Jun 2017 23:43:41 +0200
Message-ID: <8737aqjs6q.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 20 2017, Stefan Beller jotted:

> + Ævar, who was not part of the email where I copied all recipients
> from for this series.

I played around with this a bit, it would be great to have something
like this on top of --color-moved eventually. It's a lot easier to /^_
in a pager than looking for color codes.

Of course it's diff-incompatible output, but it's fair enough to have
that hidden behind some option IMO.

> On Mon, Jun 19, 2017 at 7:48 PM, Stefan Beller <sbeller@google.com> wrote:
>> Ævar asked for it, this is how you would do it.
>> (plus documentation, tests, CLI knobs, options)
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  diff.c | 15 +++++++++++----
>>  diff.h |  2 ++
>>  2 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/diff.c b/diff.c
>> index 7756f7610c..61caa057ff 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -997,6 +997,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>>         static const char *nneof = " No newline at end of file\n";
>>         const char *context, *reset, *set, *meta, *fraginfo;
>>         struct strbuf sb = STRBUF_INIT;
>> +       int sign;
>>
>>         enum diff_symbol s = eds->s;
>>         const char *line = eds->line;
>> @@ -1058,8 +1059,11 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>>                 default:
>>                         set = diff_get_color_opt(o, DIFF_FILE_NEW);
>>                 }
>> +               sign = '+';
>> +               if (flags & DIFF_SYMBOL_MOVED_LINE && o->machine_readable_moves)
>> +                       sign = '*';
>>                 reset = diff_get_color_opt(o, DIFF_RESET);
>> -               emit_line_ws_markup(o, set, reset, line, len, '+',
>> +               emit_line_ws_markup(o, set, reset, line, len, sign,
>>                                     flags & DIFF_SYMBOL_CONTENT_WS_MASK,
>>                                     flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
>>                 break;
>> @@ -1086,8 +1090,11 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>>                 default:
>>                         set = diff_get_color_opt(o, DIFF_FILE_OLD);
>>                 }
>> +               sign = '-';
>> +               if (flags & DIFF_SYMBOL_MOVED_LINE && o->machine_readable_moves)
>> +                       sign = '_';
>>                 reset = diff_get_color_opt(o, DIFF_RESET);
>> -               emit_line_ws_markup(o, set, reset, line, len, '-',
>> +               emit_line_ws_markup(o, set, reset, line, len, sign,
>>                                     flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
>>                 break;
>>         case DIFF_SYMBOL_WORDS_PORCELAIN:
>> @@ -5475,7 +5482,7 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>>         static struct emitted_diff_symbols esm = EMITTED_DIFF_SYMBOLS_INIT;
>>         struct diff_queue_struct *q = &diff_queued_diff;
>>
>> -       if (o->color_moved)
>> +       if (o->color_moved || o->machine_readable_moves)
>>                 o->emitted_symbols = &esm;
>>
>>         for (i = 0; i < q->nr; i++) {
>> @@ -5485,7 +5492,7 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>>         }
>>
>>         if (o->emitted_symbols) {
>> -               if (o->color_moved) {
>> +               if (o->color_moved || o->machine_readable_moves) {
>>                         struct hashmap add_lines, del_lines;
>>                         unsigned ignore_ws = DIFF_XDL_TST(o, IGNORE_WHITESPACE);
>>
>> diff --git a/diff.h b/diff.h
>> index 98abd75521..b6c4d7ab0f 100644
>> --- a/diff.h
>> +++ b/diff.h
>> @@ -194,6 +194,8 @@ struct diff_options {
>>                 COLOR_MOVED_ZEBRA = 2,
>>                 COLOR_MOVED_ZEBRA_DIM = 3,
>>         } color_moved;
>> +
>> +       int machine_readable_moves;
>>  };
>>
>>  void diff_emit_submodule_del(struct diff_options *o, const char *line);
>> --
>> 2.12.2.575.gb14f27f917
>>
