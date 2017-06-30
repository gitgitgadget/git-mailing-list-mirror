Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC64201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 18:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbdF3SNr (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 14:13:47 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34754 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbdF3SNq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 14:13:46 -0400
Received: by mail-pg0-f43.google.com with SMTP id t186so67487939pgb.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Faw+LBQh4HLEAsoGUbKOgLyNko/Oaw5eoVF6NKqUqfc=;
        b=W9XzAymCKer8ZjHgbmhfgc0KpsiIKFVs5BHL4UmNICrh+bMnb6zOeiJfZY2B86GG75
         GNq3DpcS8dNFEYQohIV75hTXn9zLd/+erVFJsj2j+E34bp+qbUMSNlHjFktcSdFW0ieZ
         RiZA6foQicW3GATVm96CY27LDpSpFR7BlG5ah/lujFM9UDxJyZOlydWF5zdikOS/06XE
         AzzRvjKE0y4tNULXoceY3qG/4ZKwHtHty/+sid6EYlz52FnkqvEcpy0bEqQXgj6v3u9e
         sJA4OGoh5XJmyBNjceseXNuvk+JolR3kPHwffjUW/MgXi/S7fzucXdvlxKgCJ5iKXEQR
         Omsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Faw+LBQh4HLEAsoGUbKOgLyNko/Oaw5eoVF6NKqUqfc=;
        b=lRNByo/hjyQRrEky+4muto6EYm7ja0qsqqNb2Gogk6ZRSb39/ZRleAM4DfoOPGYaIU
         /1iXELeP0zWZLCyzc3XRYlC2nY42012mpOio/csLbvHRzzl5lM8IP0DGWBuqL4QKHCjl
         yV1rlrJ7ufbDiAlbLBpvtJPYcS1bX/VXHEy3MTsvcClQAGAm4KBn3YCnF38Ju4T2I0BJ
         3Dd3jo15b6tn3zf41kZ1OYfKBByvP+spTEomtOjonu/E4E1uZmKpRFp3apg/tCoIgmSu
         ObWcp16xNyYW5WaqCItEXRvx7yzCBwKFtteL7dfTImt99YUQdT7f5dnOQVYv0bj+jrvs
         HAdg==
X-Gm-Message-State: AKS2vOx/termW1/4EgHzHeU4p1JK2g9aoqWwxzA+y1SfYoF4Xg4TYdLa
        U1SkAuIuPek5dODvFnwNZCVXwBc3rImo
X-Received: by 10.99.53.129 with SMTP id c123mr22313858pga.87.1498846420929;
 Fri, 30 Jun 2017 11:13:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Fri, 30 Jun 2017 11:13:40 -0700 (PDT)
In-Reply-To: <xmqqd19ls6no.fsf@gitster.mtv.corp.google.com>
References: <20170630000710.10601-1-sbeller@google.com> <20170630000710.10601-23-sbeller@google.com>
 <xmqqd19ls6no.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 30 Jun 2017 11:13:40 -0700
Message-ID: <CAGZ79kaK00CpXOtXnx_u7_KHbZq4Mz8vWHKy2a8p1gQ8ogE-OA@mail.gmail.com>
Subject: Re: [PATCH 22/25] diff.c: color moved lines differently
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2017 at 10:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +static int next_byte(const char **cp, const char **endp,
>> +                  const struct diff_options *diffopt)
>> +{
>> +     int retval;
>> +
>> +     if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_AT_EOL)) {
>> +             while (*endp > *cp && isspace(**endp))
>> +                     (*endp)--;
>> +     }
>
> This should be done by the callers (both moved_entry_cmp() and
> get_string_hash()) before starting to iterate over the bytes from
> the beginning, no?

Good point.

>> +
>> +     retval = **cp;
>
> The char could be signed, and byte 0xff may become indistinguishable
> from the EOF (i.e. -1) you returned earlier.

Ah, I messed up there. I think EOF is wrong, too.
So maybe we'll just return 256 to indicate the end of memory chunk
to not have to deal with signedness

>> +             if (ca != cb)
>> +                     return 1; /* differs */
>> +             if (!ca)
>
> Shouldn't this check for "ca == -1", as we are not dealing with NUL
> terminated string but a <ptr, len> thing?

Yes, we'd check for the ending symbol instead of 0.
