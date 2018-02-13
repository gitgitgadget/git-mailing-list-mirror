Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3DC1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 19:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965608AbeBMTnH (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 14:43:07 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34008 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965593AbeBMTnG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 14:43:06 -0500
Received: by mail-yw0-f176.google.com with SMTP id z77so1440234ywa.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 11:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XlIQdzEcHaL8GVeckLnxtwP+cLilfRx8nBiN8ogpmWE=;
        b=aFE8XgWtukRirCI/M9pnU30odOVLvjWgNKkKOAhfIsv4SQqbvI0vHUvEyy8z1fnXjx
         TrYPyIlSJRE1GdY83d+OfWUA+oG8Jd7tQO5BCJrPbE5HfxLduzatY1Fr6mZD3BGJJUVc
         kpiTG8FTjtITghsp2ACLnL5GAGTisqBDU1zS99PItAn1GnmGRTjsMye7e+3c42FqA/lD
         wsNG/T0VASo5Phmkw30/3Q54yKj4y97H4W1NWakr9jbEdqV9H8h6+Ac+ReDzley5s8cH
         mOM1i0greP6cWYCjmxjG11pbjjEOMXxLp4L2XPTTbLj1kt223y483dAzOsl6DexbqwcH
         MBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XlIQdzEcHaL8GVeckLnxtwP+cLilfRx8nBiN8ogpmWE=;
        b=d5jFQd90+9EQaEJM6a2ZRy5QdBYvSUNaTu9HSrDvA6S8Gy/anl1LeGWl1dRmdjgFHN
         iqeHQME8bakD6cd0L0ro9B1duFOjcscKjjAIF5OrIVe/9CqbZlPa8lb89DybN/9so/8m
         3cUWB2M2tDP6LQQB3nyxrXHS8/yFmM2KHPi9xWKvbEEUODkgBDwYmvjWVfRgX90+7Xvu
         0REI3fvz2GGlg/blmvzcM9prQhGaeSQt5s7w7lG+9ZzeNzbn/aSHylM3rsrleUo5+dCw
         qi44Cexv5sMjh3qFCN9rooK3LNBDMW+faSAzuj/OsxglYguPGHwQfiiKiinxPgxB+wE4
         ig+A==
X-Gm-Message-State: APf1xPDDBDdKxWvovdqc+Jg9jkNTfRSiTGRR6oXKgtu4ivVyiI0ehavz
        ENjm0CIa9G9rTvrh7nVsveZlA9qeXD/qpzA3bhT6WgTLU+E=
X-Google-Smtp-Source: AH8x224NFMg4l1FW0HqlZGY6HZPL4AEzkXoTuXSpn3tbe2XDA7+gk+sriOXIyw7YWj+2OIxS9jMXprDYKagurTZOVgA=
X-Received: by 10.37.12.130 with SMTP id 124mr1543662ybm.39.1518550985069;
 Tue, 13 Feb 2018 11:43:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.203 with HTTP; Tue, 13 Feb 2018 11:43:04 -0800 (PST)
In-Reply-To: <xmqqzi4cptsa.fsf@gitster-ct.c.googlers.com>
References: <20180213012241.187007-1-sbeller@google.com> <20180213114903.GA21015@ash>
 <CACsJy8C8+VnjrhEh3o36GUttZXmfiKxqjzS=2LzmfZKQjogojQ@mail.gmail.com>
 <CAGZ79kbmAkN5EpW1hzW-FFdR74c-qXJc5aKZX0ff9bU0gxMRqQ@mail.gmail.com>
 <xmqq7ergra2y.fsf@gitster-ct.c.googlers.com> <CAGZ79kZOq+_NOOabBUtPJ_zKNb_vdais70F6VzVFoSn5B5A4fQ@mail.gmail.com>
 <xmqqzi4cptsa.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Feb 2018 11:43:04 -0800
Message-ID: <CAGZ79kY4bFHAYeVn_8jBKp+kNzCs+juaa0Lp=Tx=SZK_HtDQHg@mail.gmail.com>
Subject: Re: [PATCH 00/26] Moving global state into the repository object
 (part 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 11:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> For now the ignore_env bit lives in the repository, as that helps
>> when working with submodules, when reading its comments.
>> Unfortunately 359efeffc1 (repository: introduce the repository
>> object, 2017-06-22) did not reason about the existence of the ignore_env
>> flag in its commit message.
>>
>>> So from that point of view, it may not matter where the "bit" lives,
>>> among repository, object-store, or ref-store.
>>
>> It matters on the scale of confusing the developer?
>
> What I meant is that from the point of view, having the bit in the
> data (not on the invocation) is confusing no matter which data
> structure holds it--they are equally bad.

Right.

Which is why I'd strongly consider having it only in the repository
object as that is the largest-scoped thing we'd want. e.g. submodules
should care about environment variables differently:

    GIT_WORK_TREE=~/mysuperproject git checkout \
            --recurse-submodules master

 So with such a command in mind, the environment variable would
only apply to the superproject and the nested submodules should
ignore the env, but compute their paths off the superproject, i.e.
the superproject repository, not its object store?
