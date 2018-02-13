Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70DB41F404
	for <e@80x24.org>; Tue, 13 Feb 2018 17:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965258AbeBMRrl (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 12:47:41 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34269 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965057AbeBMRrk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 12:47:40 -0500
Received: by mail-yw0-f182.google.com with SMTP id z77so1194731ywa.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 09:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J4kOGmVGhDs0J7QKrgNy0HmUA21ohsAs3VG5L7xax74=;
        b=f7O+vGPNMT/fCxfnsjie0CYGbLqfSH5oz35+hTsTA9DLG1WRMh6yQUEpRLafy05Lfb
         ZIWvnHXrZCm/0HmSBaqNXzCrm9yzxlsoE2qHmmUbRLmUlOX81UXg66fS00j1en4cJpsh
         Y49pZOOR2Xu+3BNsmfn+9rRr5Zv+yX8TzszGCb5DwzedkY0qyizOQXWeW5K/0SHsD8CE
         gSeVp0qSzwgLY2IPmJl9R/IkXe8/7XEK+1/iErLYOyLxw0iUPxwZfTDZBQLbfqBooXVJ
         RXrjSuF0B7Yujkm84+Pjm7lbhEan5gQcW8/84Fkbi4EsMRlek5SiXNSHG3MiSQmNvjuh
         MSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J4kOGmVGhDs0J7QKrgNy0HmUA21ohsAs3VG5L7xax74=;
        b=gtPRjW3O8v3moGw1xgPtmJDlWVKfa6+t8tu+2wauzH2mRKT0xYQVtKj6RG+ODbAsJO
         rG8cO4l5G2gqXlDe69tR7C0bWogMOsPmk+at39rbbNrwEJm/FGceGScov0YD69ZD5cyG
         zSkvFUyPPIpEhmU2hIeVQGkemkT1CMH6kCjCe1R7OFGyv4v4QUUM7FePKiHZG3LbqjrF
         k8xq4ZcQ0fLOorE8nEf4u581aF0331k+2seR5BFZ7+/ngRWQnuGqvw+UcVQOCCSuAkVC
         oSBpOZ8a4sJNas9MIkEhJbrvNqe7+wJ75beiO/j2VZjhcxf8gr/6UeRIcjum309kadMK
         ZAcA==
X-Gm-Message-State: APf1xPAWelAJhb4BMQdk3PcKwJ9Yz27Ok3Fq32/nZqOf1z7n3eAbcDd0
        yNwJHs6QhMPNLbgtX1XVJTu5C0UjW6JAA6bJZ2nRhQ==
X-Google-Smtp-Source: AH8x225I7lz8UsHGCC9/JgNA+l8YQp/7KRg0u4LY//Bz+vUMKE4p3Shk/jTFyPUiekgHd75StzMikvEBE1JbiS+l3yg=
X-Received: by 10.129.86.139 with SMTP id k133mr1266632ywb.253.1518544059224;
 Tue, 13 Feb 2018 09:47:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.203 with HTTP; Tue, 13 Feb 2018 09:47:38 -0800 (PST)
In-Reply-To: <CACsJy8C8+VnjrhEh3o36GUttZXmfiKxqjzS=2LzmfZKQjogojQ@mail.gmail.com>
References: <20180213012241.187007-1-sbeller@google.com> <20180213114903.GA21015@ash>
 <CACsJy8C8+VnjrhEh3o36GUttZXmfiKxqjzS=2LzmfZKQjogojQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Feb 2018 09:47:38 -0800
Message-ID: <CAGZ79kbmAkN5EpW1hzW-FFdR74c-qXJc5aKZX0ff9bU0gxMRqQ@mail.gmail.com>
Subject: Re: [PATCH 00/26] Moving global state into the repository object
 (part 1)
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 4:13 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Feb 13, 2018 at 6:49 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Mon, Feb 12, 2018 at 05:22:15PM -0800, Stefan Beller wrote:
>>> This is a real take on the first part of the recent RFC[1].
>>>
>>> ...
>>>
>>> Duy suggested that we shall not use the repository blindly, but
>>> should carefully examine whether to pass on an object store or the
>>> refstore or such[4], which I agree with if it makes sense. This
>>> series unfortunately has an issue with that as I would not want to
>>> pass down the `ignore_env` flag separately from the object store, so
>>> I made all functions that only take the object store to have the raw
>>> object store as the first parameter, and others using the full
>>> repository.
>>
>> Second proposal :) How about you store ignore_env in raw_object_store?
>> This would not be the first time an object has some configuration
>> passed in at construction time. And it has a "constructor" now,
>> raw_object_store_init() (I probably should merge _setup in it too)
>
> A bit more on this configuration parameters. Down the road I think we
> need something like this anyway to delete global config vars like
> packed_git_window_size, delta_base_cache_limit...  Either all these
> end up in raw_object_store, or raw_object_store holds a link to
> "struct config_set".

That makes sense long term.

> The ignore_env specifically though looks to me like a stop gap
> solution until everything goes through repo_init() first. At that
> point we don't have to delay getenv() anymore. We can getenv() all at
> repo_init() then pass them in raw_object_store and ignore_env should
> be gone. So sticking it inside raw_object_store _temporarily_ does not
> sound so bad.

Oh, that is an interesting perspective. Here is how I arrived at the opposite
conclusion initially: Searching for 'ignore_env' shows that we care about it
as well for the index and graft paths, which are not the object store, hence
it would be better kept in the repository. (The alternative would be to
duplicate it into the raw object store, but I do not like data duplication)

But maybe it is better to duplicate this one bit instead of passing through
a larger scoped object.

I'll rework the patches.

Thanks!
Stefan
