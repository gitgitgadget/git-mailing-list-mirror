Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1D281F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeAZSGi (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:06:38 -0500
Received: from mail-yb0-f174.google.com ([209.85.213.174]:41192 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbeAZSGh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:06:37 -0500
Received: by mail-yb0-f174.google.com with SMTP id t14so490664ybc.8
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 10:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=03Lu6ImMGDZ40bJ07ceAiQ7fB8zY19hbRxmWUIVyll8=;
        b=HL0ZcdRUWeb+nvlPSVIWYcOOv1LAWZJJkgeQb1//lQkdjLVLuxaAbgN0GCiCpR38/E
         BDk+KdlvCwT/9FbjJK7xOyw5/UxBHdPPAJNW8Fh1Nqio9iTLGHTw8ejZdvDzJ8kD2jgT
         MjcJLVs9M5iwT7mA38u80MUwo/56SQGsqt7YTHu4kkdEq6qnBd0fOgv85JKMC3kziJYn
         hJpXlQBBRJbX0WW2S3QJmUtZ3aCYRuW619Czs3sUa21obXk8SVwTFtJJApj9ME7N+K/S
         Hzu1Bx4X6MrLXlI6Xn6Pw/59kFp0KYp7HKmn1z3iiBjfuw3snE665nf9V2GZ9nA3dy2I
         GT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=03Lu6ImMGDZ40bJ07ceAiQ7fB8zY19hbRxmWUIVyll8=;
        b=neH5omihTx21W+miq7MiCKeuqB6PhwaEYxOVSKe37rWMEdprR+pjV0PzxsyZgkkzrF
         h8GcR72v418S1SeottXhSDQ2L/dfnd/jWYasDGPDFTLrs+JFOVpX2btqo/chDZIJh61W
         5hpVGLj0nCvBtJCX7GIxdzst4glTy9Y3zR4+UIZHpSv4vOoMN18nbXPiDMsO1x9qZEBb
         KGulvHqzLc5THKEytAgG6uIHAMjPjkpr+8X4LBbfe4cztqFbue8cVBOMtnZYZTELLwEX
         8aTaE7QKy3mnNTNJjWCOJac5QA6+AcZCJtByfzR1rDQvA5H6vjf4C1UvuZWK6WgI/+oz
         9VEw==
X-Gm-Message-State: AKwxytc5jcr2Wf95sreAqOxoe5tnkvzxmAtx9mxPfwZ4d+TuX6irKwkK
        oinxA3ZSpOLrz81HnoDPHQbMEAaxxPlLy57zun1GpQ==
X-Google-Smtp-Source: AH8x226W1+6eVkR7LhxoWMr2HcTuOct/KfgIynO30cQqB0vfE8BDZU7yxLVNCrPXyPbWXb43ck6nl5A4cZZa/28LpTk=
X-Received: by 10.37.60.7 with SMTP id j7mr10219211yba.39.1516989996432; Fri,
 26 Jan 2018 10:06:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 26 Jan 2018 10:06:35 -0800 (PST)
In-Reply-To: <CACsJy8BFsXAMAGYjKp8EBrepqZwgKrAtqRKyiKLOydWbpzZWWA@mail.gmail.com>
References: <66fb698096ed14ee58b2611f41f2e3e5dfa49059.1516798941.git.patryk.obara@gmail.com>
 <CACsJy8BFsXAMAGYjKp8EBrepqZwgKrAtqRKyiKLOydWbpzZWWA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Jan 2018 10:06:35 -0800
Message-ID: <CAGZ79kbV0-z46O5=E1Y7ZxzvNr+YJG+q-5AunXbEFF=7Od2U3Q@mail.gmail.com>
Subject: Re: [PATCH] setup: recognise extensions.objectFormat
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Patryk Obara <patryk.obara@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 2:08 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jan 24, 2018 at 8:09 PM, Patryk Obara <patryk.obara@gmail.com> wrote:
>> This extension selects which hashing algorithm from vtable should be
>> used for reading and writing objects in the object store.  At the moment
>> supports only single value (sha-1).
>>
>> In case value of objectFormat is an unknown hashing algorithm, Git
>> command will fail with following message:
>>
>>   fatal: unknown repository extensions found:
>>           objectformat = <value>
>>
>> To indicate, that this specific objectFormat value is not recognised.
>>
>> The objectFormat extension is not allowed in repository marked as
>> version 0 to prevent any possibility of accidentally writing a NewHash
>> object in the sha-1 object store. This extension behaviour is different
>> than preciousObjects extension (which is allowed in repo version 0).
>
> This config is so sensitive I wonder if we should forbid changing it
> via git-config. You can't simply change this and expect anything to
> work anyway.

You may have a local tool to do so, "git convert-repo-to <newhash>",
that would also adjust this setting.

I'd second Johannes to not add special error handling and forbidding
git-config to change this setting.

> "git init" can have an option to specify object format.

makes sense.

> "git clone"
> naturally inherits the format from the remote repository.

not necessarily. As the hash transition plan suggests, you'd start with
a local conversion, so it would make sense to have a
"clone --convert-locally-to <newhash>" flag.

> Maybe a
> future command allows to convert hash algorithm on an existing repo
> (*). But other than that nobody is allowed to change this.
>
> (*) it's probably git-clone that does this job, cloning and converting
> at the same time.

I think we also need on-the-fly conversion in fetch/push, so we can work
converted locally, but pretend to the outside we speak sha1 just fine.,

Stefan
