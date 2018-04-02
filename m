Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D15C1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 17:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbeDBRcg (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 13:32:36 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:56063 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753095AbeDBRcf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 13:32:35 -0400
Received: by mail-wm0-f51.google.com with SMTP id b127so26336734wmf.5
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ESVflRvm1OdSO1XTOP3CFFQMUMZbhPoxucxyyBdwK1E=;
        b=brletpqwGLbLDg06RhO/WemTBaNM4I12SSMkyAQnh1hqO/7A13gcusKCokGikWjVF0
         Grl7zB7ujzIcd2NiY1ZB6cp1nVE9CGGuZj+nfxk2bYvCUlF7JYX+AwO2aNtSK5mV/mLu
         yhM4ACPaDS4p6ileIKmPT4HSUGQBpR2jv3mulacNiYg5PbpVDa4tzTpRFEcmhJq5skfH
         HPKmlkLLihidfHEf72lCNs7I3MRTuUhcapcSoYHsDR4wINPcpXeweI0w8RRAlNzS27Yd
         aHzoJHkHTzKPdfg5n0WP467x4bf198ryez523U+Vc5kwJ6QfBnWAlz4dt42p19pvDQBk
         aRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ESVflRvm1OdSO1XTOP3CFFQMUMZbhPoxucxyyBdwK1E=;
        b=S/AaxkkpkRT7HlHkuuLCf3CdPP58miTZCnEyu4GZa9aCPU3BxeAwXlNU6l3OfOb14Y
         EM3Upv9Du92cKaci2i4Swobsb7IUn4tlgEqTha3v25QZf9MQQGevN7CIXsNY7DpsXDv0
         1o9s6PGhVgJyYMxytIn2BDCJQLmj8ZlQ8BYCQBPQxq0TXj6ipxMFPaatV1C8/XXWY+5d
         PXxl97ligFe7u3XSaw74CFUKRfN+uYU22nixrsQjb8aG50YToL5LF+L/fAktzL4ucIop
         zTfePs1I3NLnltEFkMV8+iem2kqa9M5zAP95ISUsyC/tmHOfEwWOpBU/FMq5Cf30V8zZ
         3+tA==
X-Gm-Message-State: AElRT7FjQBjt8YnlEIpSlETq8kUrHLAsNOxtxscIOK2EfOAWfznRU8wZ
        a9hNbVxIYrD095ckOHN+JEMg2m7m
X-Google-Smtp-Source: AIpwx4/rrKHF7tiRIDmhvdAsMkduNsqTmBRrzABboAWwaSVxLTltUOrZ0Vnwt1vuyAaDbCiUtCrwNA==
X-Received: by 10.80.231.13 with SMTP id a13mr13601028edn.212.1522690353877;
        Mon, 02 Apr 2018 10:32:33 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id b47sm589817ede.13.2018.04.02.10.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 10:32:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ls-remote: create option to sort by versions
References: <20180402005248.52418-1-haraldnordgren@gmail.com> <87605aw1ue.fsf@evledraar.gmail.com> <CAHwyqnV1BwsaHVsh0xSx3MroNoJRT7UYrqF_WFKhkZMf-X9Evg@mail.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CAHwyqnV1BwsaHVsh0xSx3MroNoJRT7UYrqF_WFKhkZMf-X9Evg@mail.gmail.com>
Date:   Mon, 02 Apr 2018 19:32:31 +0200
Message-ID: <87zi2lv7io.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 02 2018, Harald Nordgren wrote:

> In regards the the print statement, it was only moved down according
> to the diff because I added more logic above. Basically there is 1)
> the unrolling of the linked list to an array and 2) the printing
> logic. I could move it and make the diff smaller, but that probably
> makes the code a tiny bit more complicated.

I was just wondering since it wasn't explained in the commit message,
makes sense to copy this explanation into v2, or lead with a purely code
re-arrangement patch.

> It would be nice to have a uniform option like
> '--sort=version:refname'. But spending a few hours to look over the
> code, it seems that ls-remote.c would require a lot of rewrites if we
> wanted to start using `ref_array` and `ref_array_item` for storing the
> refs.
>
> Which seems necessary in order to hook in to the sorting flow used in
> other subcommands. That, or reimplement `cmp_ref_sorting`. But maybe
> I'm missing something?

I'm thinking just in terms of UI. If it's the case that porting this to
whatever guts git-tag uses for sorting would be hard, then we could
still use the same command-line option convention (and perhaps just die
if anything except --sort=version:refname is supplied). Changing the
underlying implementation is easier than cleaning up UI-differences that
(seemingly) only arose due to underlying implementation details at the
time.

> On Mon, Apr 2, 2018 at 8:37 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Mon, Apr 02 2018, Harald Nordgren wrote:
>>
>>> Create the options '-V ' and '--version-sort' to sort
>>> 'git ls-remote' output by version semantics. This is useful e.g. for
>>> the Go repository after the release of version 1.10, where otherwise
>>> v1.10 is sorted before v1.2. See:
>>>
>>>       $ git ls-remote -t https://go.googlesource.com/go
>>>       ...
>>>       205f850ceacfc39d1e9d76a9569416284594ce8c        refs/tags/go1.1
>>>       d260448f6b6ac10efe4ae7f6dfe944e72bc2a676        refs/tags/go1.1.1
>>>       1d6d8fca241bb611af51e265c1b5a2e9ae904702        refs/tags/go1.1.2
>>>       bf86aec25972f3a100c3aa58a6abcbcc35bdea49        refs/tags/go1.10
>>>       ac7c0ee26dda18076d5f6c151d8f920b43340ae3        refs/tags/go1.10.1
>>>       9ce6b5c2ed5d3d5251b9a6a0c548d5fb2c8567e8        refs/tags/go1.10beta1
>>>       594668a5a96267a46282ce3007a584ec07adf705        refs/tags/go1.10beta2
>>>       5348aed83e39bd1d450d92d7f627e994c2db6ebf        refs/tags/go1.10rc1
>>>       20e228f2fdb44350c858de941dff4aea9f3127b8        refs/tags/go1.10rc2
>>>       1c5438aae896edcd1e9f9618f4776517f08053b3        refs/tags/go1.1rc2
>>>       46a6097aa7943a490e9bd2e04274845d0e5e200f        refs/tags/go1.1rc3
>>>       402d3590b54e4a0df9fb51ed14b2999e85ce0b76        refs/tags/go1.2
>>>       9c9802fad57c1bcb72ea98c5c55ea2652efc5772        refs/tags/go1.2.1
>>>       ...
>>
>> This is a sensible thing to want, but why not follow the UI we have for
>> this with git-tag? I.e. --sort=<key> & -i (or --ignore-case)? Of course
>> ls-remote doesn't just show tags, so maybe we'd want --tag-sort=<key>
>> and --ignore-tag-case or something, but the rest should be equivalent,
>> no?
>>
>>> [...]
>>> @@ -101,13 +115,22 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>>>       if (transport_disconnect(transport))
>>>               return 1;
>>>
>>> -     if (!dest && !quiet)
>>> -             fprintf(stderr, "From %s\n", *remote->url);
>>>       for ( ; ref; ref = ref->next) {
>>>               if (!check_ref_type(ref, flags))
>>>                       continue;
>>>               if (!tail_match(pattern, ref->name))
>>>                       continue;
>>> +             REALLOC_ARRAY(refs, nr + 1);
>>> +             refs[nr++] = ref;
>>> +     }
>>> +
>>> +     if (version_sort)
>>> +             QSORT(refs, nr, cmp_ref_versions);
>>> +
>>> +     if (!dest && !quiet)
>>> +             fprintf(stderr, "From %s\n", *remote->url);
>>
>> Is there some subtlety here I'm missing which means that when sorting
>> we'd now need to print this "From" line later (i.e. after sorting?
