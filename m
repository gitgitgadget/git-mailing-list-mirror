Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F721FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 22:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbdBNWKP (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 17:10:15 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:36800 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbdBNWKO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 17:10:14 -0500
Received: by mail-it0-f44.google.com with SMTP id c7so53051544itd.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 14:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vwOm6YL4Pzb1ixKcnLSQgnLhpTtTqCVXMgNg17bCtag=;
        b=vuoYyJTFgDjcZjiL1dyUmB7a9ptyETezkpbcnxZKTw1SnB+PV7a4J1PG8lIX2TI1jD
         WZNxBqkeKWsALrH06PxbVPbViuswnJOggjcO+SKOlAxvMykyItKAFT0DRMMbul4CrNsX
         2do2SMw0h+mRn6U256eaQwsI3Kj+fHn9gVFI/FMUdU4N5ax25tnrlj4zD+O2whKgLNfD
         rzF/+DPdZevKUJ6dVF0drpGmAoGtPDCF2/pwtXdK8WEDY3Ti7eYf7svpqjoSxmJt7JiU
         QqrQcGCnfcDveKh+k1OwU2AMvnmI8EhRQQeJSCXBl0epWvxY5JrtNlNfD3g7tuLw90h2
         uClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vwOm6YL4Pzb1ixKcnLSQgnLhpTtTqCVXMgNg17bCtag=;
        b=ItrbpekuoEMkn9durO8mnK01ekhlwJbW+LKmXILImNZRjetk0QP8KMb09LtL9VvTIm
         ElZkaCSSt8HaRqlFuMcjn1hD3q/xGXTufXlRF+ofeBQIVyhww323EQy7ZFJrZrTSNNCh
         fZLwbTI5tXji2Pa87w7HfHpQA3ykPaYYXnZrd2oprr2eHSBbDKfb1QUcu8vl/jO02N+8
         b3g2pcVnW5xb94ciiexE7WzSEaKrtFYznqkZ2swHm56gDLT8FqNTWzDpDss1yiIJAIJu
         jVySREnVbFtJmoomu7DBStxlQXeUdiEQAfMCiWXys3ZWRj2MJswWQRZpOMcJtfZH136J
         OTMg==
X-Gm-Message-State: AMke39liLVfl0Hvzv109ah+rKtd0heg7CF2ynwZWdi4oTtHCD4Slcg3bC1AcZj3OM4vpdL/Sqha7e+22pRVsSnNi
X-Received: by 10.107.37.148 with SMTP id l142mr27414005iol.159.1487110212726;
 Tue, 14 Feb 2017 14:10:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Tue, 14 Feb 2017 14:10:12 -0800 (PST)
In-Reply-To: <xmqq4lzw8mim.fsf@gitster.mtv.corp.google.com>
References: <20170209020855.23486-1-sbeller@google.com> <xmqqo9yblz33.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kb2jZ9fgct6gncDqmWFsbY4MRiboFXPvw7AMcU2KanyfQ@mail.gmail.com> <xmqq4lzw8mim.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Feb 2017 14:10:12 -0800
Message-ID: <CAGZ79kbjSLaUsJH_KuT6EiC+Kt-87+GjONt08hCytXULecMijA@mail.gmail.com>
Subject: Re: [RFC-PATCHv2] submodules: add a background story
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 1:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> If we were to redesign the .gitmodules file, we might have it as
>>
>>     [submodule "path"]
>>         url = git://example.org
>>         branch = .
>>         ...
>>
>> and the "path -> name/UID" mapping would be inside $GIT_DIR.
>
> I am not sure how you are going to keep track of that mapping,
> though.  If .gitmodules file does not have a way to tell that what
> used to be at "path" in its v1.0 is now at "htap" (instead the above
> seems to assume there will just be an entry for [submodule "htap"]
> in the newer version, without anything that links the old one with
> the new one), how would the mapping inside $GIT_DIR know?

It depends. Maybe git-mv could have rewritten the internal mapping
as well.

Maybe it would work similar to a rename detection
utilizing a bloomfilter that includes all recorded sha1s at a given path
and then we can take the sha1 from the a given path and check for each
absorbed submodule git dir if that commit belongs to this repo.

I did not quite think it through, but I was pointing out this is brittle.
I guess a quick way would be to follow the .git file inside the submodule
if that exists and if not build up an internal cache that can map
"path -> potential git dirs".

Of course we can argue that the same problem applies to e.g. remotes:
If I have
    remote.origin.url = git://kernel.org and
    remote.mirror.url = kernel.googlesource.com
then swapping the urls will of course yield different behavior
for 'origin' and 'mirror'. But in this case it is obvious because
"origin" is not the same string as "kernel.org".

So long term, maybe we should come up with a better default name
for submodules, e.g. just a hash of say the URL being used when
adding the submodule.

>  Don't
> forget that name was introduced as the identity because we cannot
> assume that URL for a single project will never change.

Yes, URL and path can both change over time, which is why it is
a good idea to have them versioned as well as having a way to
overwrite the URL in the config later on.

> I fully agree that our documentation and user education should
> stress that names must be unique and immultable throughout the
> history of a superproject, though.

This would be a good paragraph in this "background story" that this
patch tries to write. I'll add that.

Thanks,
Stefan
