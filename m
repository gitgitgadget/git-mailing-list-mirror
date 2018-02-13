Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FB6B1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 12:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935099AbeBMMNs (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 07:13:48 -0500
Received: from mail-ot0-f177.google.com ([74.125.82.177]:43233 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935103AbeBMMNq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 07:13:46 -0500
Received: by mail-ot0-f177.google.com with SMTP id q12so17087514otg.10
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 04:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=09UoHKTZkwQzV1AwfgUiZBfOWoeQm8jF+jSTriJtUrI=;
        b=FfHMpjQWJJizzHB1v6TFj4OHPTnCGTSEdDeZiqpQzAG2f49xY/WQkdTrbcenljXdlv
         c10ZyDPi1kj8EsP/+Jq3VRgVF1OB5J+u7nhWwasl2t+SOgMU1KQIdYleZjJo6TvI0prs
         Krc/f9+oHjhJl+e/ulALrHup3BdRqkQQ4lSi3UtjnvOHYqbiSsT8nEVCvy1sybqN3vLa
         qs9dIR8LTj2BsUg+6wR9RV16XUNUwV9QCiAo55/Fkfa+NumDutWWSIMuzO2vZgyTv51U
         7BqAh2jVRaqNBg+fZlyUil0IZAy/kIaEaG6kRlAJKHed1LEUtKZG6oq49zQz4/X/cFEj
         UTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=09UoHKTZkwQzV1AwfgUiZBfOWoeQm8jF+jSTriJtUrI=;
        b=RuDVCsWSuws8Dn8TXlGXozrbMzSLT19Ti+N6eIgnyPsHsshpzA6oOIri7wf6uaoiFE
         mRBZRsejtdt+TTlAFf4pB7ikuCvCwFqLUj2ZZuZ1A9ehZ+lOhxvnSRVm08O4rqQRoG21
         f7ir6eW1T1ICpqvgJGFA82pm0N5yWy/TyvrOJrxVEuiRSawKq0eRySnMjfcEUXStqrF6
         v+eb62vzPZ5uLkyw/AKet77eu0my7WPGKtfNBmQ+w2FtQzYGRjws297f/P2/nyZ2OFXk
         HF1DAaSagH8CrLG5if2LpJ+d/yNo3CObSxFYuJCnZ8vIDLln2/B2c0eT14fytdzUOHjU
         Lr/g==
X-Gm-Message-State: APf1xPBVwHxVuxqZbaH2pv8GteMOEe09DgHHJ8PHvaEPgWEjESFaHqUs
        y6IsqsQDRNHbYUqFlBtYyUJL47uxu+eW9SgwP30=
X-Google-Smtp-Source: AH8x224tBSuolndBw1sTMkveoJkhCCgyOvrffAucN6yLIfUbn13EsiE8CdSV5yhJ5ESTufECguOCQNbE/I5L9PLpyCs=
X-Received: by 10.157.73.162 with SMTP id g34mr726048otf.301.1518524025679;
 Tue, 13 Feb 2018 04:13:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Tue, 13 Feb 2018 04:13:15 -0800 (PST)
In-Reply-To: <20180213114903.GA21015@ash>
References: <20180213012241.187007-1-sbeller@google.com> <20180213114903.GA21015@ash>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 13 Feb 2018 19:13:15 +0700
Message-ID: <CACsJy8C8+VnjrhEh3o36GUttZXmfiKxqjzS=2LzmfZKQjogojQ@mail.gmail.com>
Subject: Re: [PATCH 00/26] Moving global state into the repository object
 (part 1)
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 6:49 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Feb 12, 2018 at 05:22:15PM -0800, Stefan Beller wrote:
>> This is a real take on the first part of the recent RFC[1].
>>
>> ...
>>
>> Duy suggested that we shall not use the repository blindly, but
>> should carefully examine whether to pass on an object store or the
>> refstore or such[4], which I agree with if it makes sense. This
>> series unfortunately has an issue with that as I would not want to
>> pass down the `ignore_env` flag separately from the object store, so
>> I made all functions that only take the object store to have the raw
>> object store as the first parameter, and others using the full
>> repository.
>
> Second proposal :) How about you store ignore_env in raw_object_store?
> This would not be the first time an object has some configuration
> passed in at construction time. And it has a "constructor" now,
> raw_object_store_init() (I probably should merge _setup in it too)

A bit more on this configuration parameters. Down the road I think we
need something like this anyway to delete global config vars like
packed_git_window_size, delta_base_cache_limit...  Either all these
end up in raw_object_store, or raw_object_store holds a link to
"struct config_set".

The ignore_env specifically though looks to me like a stop gap
solution until everything goes through repo_init() first. At that
point we don't have to delay getenv() anymore. We can getenv() all at
repo_init() then pass them in raw_object_store and ignore_env should
be gone. So sticking it inside raw_object_store _temporarily_ does not
sound so bad.
-- 
Duy
