Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721451FD99
	for <e@80x24.org>; Sat,  6 Aug 2016 21:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbcHFVtj (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 17:49:39 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36322 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbcHFVti (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 17:49:38 -0400
Received: by mail-io0-f177.google.com with SMTP id b62so328770311iod.3
        for <git@vger.kernel.org>; Sat, 06 Aug 2016 14:49:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ObTtzmrRAV+KrQkLlk7OX7tHfOovih9oeePHOGGb7MA=;
        b=pu9NLhOku9NpGxmckTjgICmUognxCwnSGHy/QTbjV/fef6xQn7WndsLqXy//u+nal/
         M/5zJguynLUqoXryJf9nvHKVPISWsr/eqVGO6fVUKGsS8mpSpTbrRXQPvn2Dfo9jGIkn
         GV/98jvP1yZr2DOn6aY3zxY5+p7ui1FEKtkZYszRZR+PbRxVmNBgNtW7D/Dqyl481nmM
         4kS+bMSpTXKiepAME53GVEt1utxBKUfinKEHCFKX7DTsmeqfO66CEL+hWEa+UC1Gyfgc
         np6XGqUPpgZ0e3f4MkQcCxJEEuKg9OzTAatFU/gdaDIXgvJnGYN7Jiu19GWzDzwPHXKY
         HUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ObTtzmrRAV+KrQkLlk7OX7tHfOovih9oeePHOGGb7MA=;
        b=jD230EIrIr5J6HGYTN+TOvaIeBPOwheNU0F4GFph7RRbsDWeUHq9EkCGjK5AdxlkIz
         NuMknPZxa9yVrlLAGdUkU2s2sDfGI6xQujETHiIGeZOvTcbyIcCFdfC2IxLeG7z1n4eb
         LGRUlMcgNz0j5D35ZAFTLwTSPLVFTy7hQMxeWiQwtaTUzQ5wF0j/JrGRtdTCqefHsvf7
         JPfMFNGnhna18yuh/m+gQfWWOcGVuYOT5axtMOjIOXK3Yz0Jq/DWSTQyBZJo03vFgIsR
         a5QdPeVTloBg29XY14S9eQlKhfl/O3G0Jv4ky6uWfo3rO0csJFwIy3crSLaGQ8KGgDGc
         uH6g==
X-Gm-Message-State: AEkoout4uBDelKFI9G9uEPhK5CKwgFG2QBOV8Q4hw8oPOBMcKIR9eC4MSxsYiK2SEt0WTGiI7icY3US6NuPA4GVR
X-Received: by 10.107.131.38 with SMTP id f38mr86745259iod.173.1470442921958;
 Fri, 05 Aug 2016 17:22:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 5 Aug 2016 17:22:01 -0700 (PDT)
In-Reply-To: <xmqq1t22x6fj.fsf@gitster.mtv.corp.google.com>
References: <20160804195159.7788-1-sbeller@google.com> <20160804195159.7788-6-sbeller@google.com>
 <xmqq1t22x6fj.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 5 Aug 2016 17:22:01 -0700
Message-ID: <CAGZ79kYsdqffWykzcEQcd2HigYqVNt0Y1H0Biw3QA2RdQaMOOw@mail.gmail.com>
Subject: Re: [PATCH 5/6] submodule update: add super-reference flag
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>, mst@redhat.com,
	Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 5, 2016 at 2:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> That's a bit sketchy description.  From the title, I expected that
> we would see one additional 'unsigned super_reference : 1;' field in
> some structure, but that is not what is happening.  The log message
> needs to describe what these string list are and why they are needed
> a bit better.

A "--super-reference" allows giving a reference to a superproject instead
of a direct reference.

With --reference you had to point to the direct repository, e.g.

    git clone --reference /usr/share/foo git://xyxxz.example/foo

assumed that /usr/share/foo is either the working dir or the git dir
of said project.

When giving references in the submodule context (this part of the helper
is called from "git submodule update", which itself is called from
"git clone --recursive"  we do not know the place where the submodule
reference is living. As we do know where the superproject reference is
living (i.e. "git clone --recursive --reference <superproject>"),
we can construct one possible path where the submodules are located
at <superproject>/<submodule-path>. To differentiate the reference flag
from a direct reference this will be called "--super-reference" as it
references a super project.

The next patch makes use of it by just passing on the --reference
given to "git clone" as --super-reference to the "submodule update"
procedure, which then uses the code in this patch.

>
> At least, please don't name a multiple_word field "multipleword" ;-)

uh :( OK.

>
>> @@ -715,6 +716,15 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>>               for_each_string_list_item(item, &suc->references)
>>                       argv_array_pushl(&child->args, "--reference", item->string, NULL);
>>       }
>> +     if (suc->superreferences.nr) {
>> +             struct string_list_item *item;
>> +             for_each_string_list_item(item, &suc->superreferences) {
>> +                     strbuf_reset(&sb);
>> +                     argv_array_pushf(&child->args, "--reference=%s/%s",
>> +                                      relative_path(item->string, suc->prefix, &sb),
>> +                                      sub->path);
>
> The phrase "super reference" made me imagine it is some kind of
> "reference" that is applicable to the superproject,

Oh I see. Except that from the superprojects point of view, it is not a
superproject; it is just a project with submodules. From a submodules point
of view you have a superproject however, so a super-reference is a reference
that points to another superproject, so we can find a sibling reference.

> but this code
> smells like it is a "prefix to create reference suited for use in
> submodule".

Yeah that's it.

> Whatever it is, it should be explained better (than "no
> desciption" which is what we have here ;-), and given a name that
> match the explanation.
>
> Thanks.

OK.

Thanks,
Stefan
