Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E9B1F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 17:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938556AbcIFRZq (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 13:25:46 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:34731 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936286AbcIFRZp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 13:25:45 -0400
Received: by mail-yb0-f175.google.com with SMTP id x93so91366131ybh.1
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/M0mpGAP5uZapDJkrlYoJHJYYK9+L8zKZADPBGzJlYw=;
        b=nfCkNgnDcVxbbfTyJRK7qtW2/oR+/9KggMJTH337Np2tNQNNolBcYax6WJ4LHorWWt
         SZtWa7RxwujJEFVlTi4CoE2X5hsbach69YfHBUbnJde5dS7Uvo9yrkWrSmGWAyYPXkYH
         xX22AALZl1dG8i4s0nRO01UlkxEMlm/cmn2/s18GWO71olO3rYH4PXZqLAfF9DAYAATB
         esLK/JziXZCtf0m34X1sL9ypIto1M2HjYywzVM1xR4VQaEAYg91a50xPrkkn67ixNFTd
         wF/lxDn7ipwEN2TZB7xkqlqTO4p+xKaFSenh/fmNLwrU0iQUOET5LKdMeG2N+OVF43hk
         hfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/M0mpGAP5uZapDJkrlYoJHJYYK9+L8zKZADPBGzJlYw=;
        b=mgArHqVabZlsgO2NE0Gu0em0DKf05GZiaOiSFaiciisrBiskFrVSUoLu+O9NbottHh
         Snqj1qC9A52o3ITBhQUbF2D5Cbi7PeESPOoA2E3YZJ4HCqyO7omGyHdnoTK2gPuvxH2n
         +y++Wde1FPPMmhgARwpzCUWUvnzjEqYnb5wfsC0ZfnZ3pKw4b5rJHZo6M34AcpqA24iw
         ks9cBnNxDwtCJ7B14FRvQlobljO/R65UJYaFmJhRF7IrnSDq7cvOhGi50xCfFQyzIRG/
         Vgoug0X5Msq9ScgWfU+rpcZl8cEe0mlbf6LkUpBeDFPCBu8FEIDLVEcY89Bl14vdmA6q
         qO5Q==
X-Gm-Message-State: AE9vXwOqp0cWAjhp9cQzPnNfqDhqrcdUanpcXVDkb56bqzJkE1dc9wZ8c1iwttpDM16xnOM5HnctOg5vO9HsNv8Z
X-Received: by 10.36.69.92 with SMTP id y89mr21902338ita.49.1473181393921;
 Tue, 06 Sep 2016 10:03:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 6 Sep 2016 10:03:13 -0700 (PDT)
In-Reply-To: <15618224-a9f3-bbe7-3556-8fd8aab2a2a4@gmail.com>
References: <20160906070151.15163-1-stefanbeller@gmail.com> <15618224-a9f3-bbe7-3556-8fd8aab2a2a4@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Sep 2016 10:03:13 -0700
Message-ID: <CAGZ79kZPzEYV=gdhzXQetXoe4+1zdh67eyL-gGh9EOCSbRwzWw@mail.gmail.com>
Subject: Re: [PATCHv4] diff.c: emit moved lines with a different color
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 6, 2016 at 7:05 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> wrot=
e:
> W dniu 06.09.2016 o 09:01, Stefan Beller pisze:
>
>> ---
>>
>>  * moved new data structures into struct diff_options
>>  * color.moved=3Dbool as well as --[no-]color-moved to {dis,en}able the =
new feature
>>  * color.diff.movedfrom and color.diff.movedto to control the colors
>>  * added a test
> [...]
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 0bcb679..5daf77a 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -974,14 +974,22 @@ This does not affect linkgit:git-format-patch[1] o=
r the
>>  'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
>>  command line with the `--color[=3D<when>]` option.
>>
>> +color.moved::
>> +     A boolean value, whether a diff should color moved lines
>> +     differently. The moved lines are searched for in the diff only.
>> +     Duplicated lines from somewhere in the project that are not
>> +     part of the diff are not colored as moved.
>> +     Defaults to true.
>
> [...]
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options=
.txt
>> index 705a873..13b6a2a 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -234,6 +234,13 @@ ifdef::git-diff[]
>>  endif::git-diff[]
>>       It is the same as `--color=3Dnever`.
>>
>> +--[no-]color-moved::
>> +     Show moved blocks in a different color.
>> +ifdef::git-diff[]
>> +     It can be changed by the `diff.ui` and `color.diff`
>> +     configuration settings.
>> +endif::git-diff[]
>
> If not for `color.moved`, I would have thought that instead of adding
> new command line option `--color-moved` (and the fact that it is on
> by default), we could simply reuse duplication of code movement
> detection as a signal of stronger detection, namely "-M -M" (and also
> "-C -C" to handle copy detection) that git-blame uses...

Can you please elaborate on how you'd use that as a user?

The -M and -C options only operate on the file level, e.g.
these options are very good at things introduced via:

    git mv A B
    $EDIT B # only a little.

So these options make no sense when operating only on one
file or on many files that stay the same and only change very little.

The goal of my patch here is to improve cases like 11979b98
(2005-11-18, http.c: reorder to avoid compilation failure.)

In that case we just move code around, not necessarily across file
boundaries.

So that seems orthogonal to the -M/-C option as it operates on another
level. (file vs line)

In another email you asked whether this new approach works in the
word-by-word diff, which it unfortunately doesn't yet, but I would think
that it is the same problem (line vs word granularity)

So what I am asking here is, how would you imagine a better user interface
for what I am trying to do, or do you think I should adapt my goal?

Thanks,
Stefan

>
> --
> Jakub Nar=C4=99bski
>
