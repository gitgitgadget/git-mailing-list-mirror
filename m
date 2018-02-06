Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D3321F404
	for <e@80x24.org>; Tue,  6 Feb 2018 17:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeBFRtB (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 12:49:01 -0500
Received: from mail-yw0-f174.google.com ([209.85.161.174]:34174 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeBFRs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 12:48:58 -0500
Received: by mail-yw0-f174.google.com with SMTP id t201so1934463ywf.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 09:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=RW8gon/SNBPo0kghkTLONY4OjWtE5lAd6a5zfdsoLQI=;
        b=Y8kj04klgUBRRdRrxGpm4p8NSnzi1WPMTuDqHewY+a1UfQPeGsBQZRKMnGwZwBU7Zs
         zXgU6mkEDr9xwJQyLDfieYWwQkt05ufiPh0r6LN/QbRJ97A+c7jiNJ+xSA+ak6VP69In
         x7xoLLpgIWjR3gfMxQx7QBESnyuQqZ7BXjXZe+rZDRXRjQWFL9OcmkNWrgbdjvcNa5hy
         LPHRrgqgeAvk1WxVyoTJCcvo4ctwX3Q2aOjDUXrLdTdP52PDFEryqKkK28oSAjjE9evr
         t/GermDjwUC4sk9qta9ZKS7m2sJ8FhuN7/GObLy/IW4EIUGBdpp7CgLiFSFQqSwpcMtS
         F4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=RW8gon/SNBPo0kghkTLONY4OjWtE5lAd6a5zfdsoLQI=;
        b=Ou02Ei0kI0IbtsECFPdsPUnRWhUL211qnXyqI1C6aAxSBn1oteeS54sg1ANr7nYAcT
         3Lwl6pawiOKPVkWKvexAGXdxENA9HnQo9JPi3T+t7jltf+JPO3tKeuZqP8mWdPuIAZUJ
         LDgB+Pb/6Hiv2gMlzShgyMOS8+c4hFJs/vclEEtWTBW8SJ3mFxcferBVU8IWWCYmjOQy
         1gQUBZBjfPtYFyU2apT+9bzMuVeeluHFq01Q378VZe6ysQhszZpRg/cr01Y69XwvA+/C
         7L45DTkLzh09SbXr+ZlM76pynWIXhY/fATjLZhMb4OpYlMlOcgQwGGMVupjUjT0WZl4r
         lgRA==
X-Gm-Message-State: APf1xPD+DEJtGX1MJWLXr4vEL4vu2llB3HjuHShHHJ2wS0a1uwUTirBB
        DzKyl9Pw3vXkHgyNbgHTX3PyLjEXG8r9t4StMl5yLQ==
X-Google-Smtp-Source: AH8x227LxijDXx6+o9v5uaRhyLf7zaP4EYKScutfSLtWYOf92IGKcVdQ5p1HVQ3zmQv05dbyXBtgyb/TUTo0b6tRfKg=
X-Received: by 10.37.34.138 with SMTP id i132mr1513308ybi.114.1517939337453;
 Tue, 06 Feb 2018 09:48:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 6 Feb 2018 09:48:56 -0800 (PST)
In-Reply-To: <20180206011940.GD7904@genre.crustytoothpaste.net>
References: <20180205235508.216277-1-sbeller@google.com> <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-5-sbeller@google.com> <20180206011940.GD7904@genre.crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Feb 2018 09:48:56 -0800
Message-ID: <CAGZ79kYAjs17RvRyo4rErR+ymkKfyORZ7xBSCDm_q0b-E6BqiA@mail.gmail.com>
Subject: Re: [PATCH 025/194] object-store: allow prepare_alt_odb to handle
 arbitrary repositories
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 5:19 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Feb 05, 2018 at 03:54:46PM -0800, Stefan Beller wrote:
>> @@ -434,12 +433,12 @@ static int link_alt_odb_entry_the_repository(const char *entry,
>>       ent = alloc_alt_odb(pathbuf.buf);
>>
>>       /* add the alternate entry */
>> -     *the_repository->objects.alt_odb_tail = ent;
>> -     the_repository->objects.alt_odb_tail = &(ent->next);
>> +     *r->objects.alt_odb_tail = ent;
>> +     r->objects.alt_odb_tail = &(ent->next);
>>       ent->next = NULL;
>
> I'm sure I'm missing something obvious, but it's not clear to me that
> this transformation is correct.  Could you perhaps say a few words about
> why it is?

This is a pretty open ended question, so I'll give it a try:

* ent is a local variable that is newly allocated using `alloc_alt_odb`.
  `alloc_alt_odb` has no hidden dependencies on a specific repository,
  it uses FLEX_ALLOC_STR, which is defined in cache.h as a wrapper
  around xcalloc/memcpy

* Before this patch we always used the_repository->objects.alt_odb_tail,
  but with this patch there is no reference "alt_odb.tail" of the_repository,
  but only of a given arbitrary repository.

  Usually we convert only one function at a time. (Chose that function,
  which calls only already converted functions, because then passing in
  r instead of the_repository still compiles correctly)

  The additional messiness comes from a cycle:
  read_info_alternates
    -> link_alt_odb_entries
      -> link_alt_odb_entry
        -> read_info_alternates

  That is why we cannot just convert one function, but we have to convert
  the whole strongly connected component in this graph of functions.
  This is why this patch is so messy and touches multiple functions at once.

* While I hope this helps, I assume you want me to repeat this or other
  hints in the commit message, too.

Thanks,
Stefan
