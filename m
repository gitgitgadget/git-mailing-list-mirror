Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D7C1FD4F
	for <e@80x24.org>; Tue, 29 May 2018 19:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966061AbeE2TR3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 15:17:29 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:35594 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965541AbeE2TR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 15:17:28 -0400
Received: by mail-pl0-f52.google.com with SMTP id i5-v6so9515523plt.2
        for <git@vger.kernel.org>; Tue, 29 May 2018 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=K2DUr6HMNUkuOQC25xBjUOCfCsXbSlVgsyGePxYHKsg=;
        b=rzcgBN65sGSw8LlifqSkZDzOgETHRxHJEPVUDsAMmwdbqNYnyF4JNyo7R28PmsHIM9
         zGNu2hSSzYM5csVT7KgTsuYHEv4s12Hxce0x1A3ObjNf93zE51QBmGy+mOGAfI6SNIoF
         co80AJlsHOkdQT9ZkqLuQQp7uW1vU/tS418QFafuX4EX4e35l16NNe0lED0zqPImp3Of
         8Rzl190bzt/84/F251B5hdDWf8+MPl0XGqDSU5af/ajhel9ebdT2tqD7fu6zM9Y6iFrS
         J9vl1lE3EfW6Mbub4EA4xA5VoWcjwpPKnqcEv9QQCxxNGmQ4k1MTZYYYlCydjqT6p7Yc
         etFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K2DUr6HMNUkuOQC25xBjUOCfCsXbSlVgsyGePxYHKsg=;
        b=T2UMXzOyvmlqlpeo2JRDxE28sXCCLOb5poh6nrz41hfd7KUDzwReqiH/jH74OIDpua
         DLG8qn6c6Ec5L2/OCWwWqLWhw+8VToxrcWU7t12Nb044dOnLuJFpfvFOEkuwYr69RRGD
         UT2RPD6pQ03vsjMmqo1P4s79AkEJnWuQBhKUjAp0XKoGDnGoYsN63iJBOhhqZ78DMX5s
         3N2DQeGb0YqQzLs90A42nGyRqWBLxTNdF5TFXs170l2x/MwMTuVxpugRwVbpq/pTR3tN
         XUfTV1sHmolkdssbdtsuUfOsWjQLsKIVywteSBTdfJg2b+BA9LyUqting9wOlNQUB7nN
         MF+w==
X-Gm-Message-State: ALKqPwc4DUa9Rj+ikkfeamYhSFphdZj6lJEvQQAK3z5NtGimfk5TBDEi
        uqSN6aRjXnmUJPvt5Dv3ge/VdA==
X-Google-Smtp-Source: AB8JxZoHhXczeP1ZPVku7fNb2kJCeT5Fdyae9bCtubRtWm86cO7EXp4WtPEWIXSUryspjYOU6T3imQ==
X-Received: by 2002:a17:902:6503:: with SMTP id b3-v6mr18770611plk.147.1527621447775;
        Tue, 29 May 2018 12:17:27 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 73-v6sm75952922pfo.153.2018.05.29.12.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 12:17:26 -0700 (PDT)
Date:   Tue, 29 May 2018 12:17:25 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Is origin/HEAD only being created on clone a bug? #leftoverbits
Message-ID: <20180529191725.GA259827@google.com>
References: <87bmcyfh67.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bmcyfh67.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/29, Ævar Arnfjörð Bjarmason wrote:
> Here's some more #leftoverbits where we have a clone/fetch feature
> discrepancy and where clone is magical in ways that "fetch" isn't.
> 
> If you make an initial commit and push to a remote repo "origin", you
> don't get a remote origin/HEAD reference, and a "fetch" won't create it
> either.
> 
> You will get it if you subseuqently "clone" the repo, but not if you use
> "git init / remote add / fetch / git checkout -t" which should otherwise
> be equivalent.
> 
> If you push to "master" (or whatever HEAD is) from the clone the
> origin/HEAD will be updated accordingly, but from the repo you pushed
> from & the one you did init+fetch instead of clone you'll never see it.
> 
> Some code spelunking reveals remote_head_points_at, guess_remote_head()
> etc. in builtin/clone.c. I.e. this is special-cased as part of the
> "clone".
> 
> Can anyone thing of a reason for why this shouldn't be fixed as a bug?
> I've tried searching the archives but "origin/HEAD" comes up with too
> many
> results. https://public-inbox.org/git/alpine.LSU.1.00.0803020556380.22527@racer.site/#t
> seems to be the patch that initially added it, but it is not discussed
> why this should be a clone-only special case that doesn't apply to
> "fetch".

I believe the issue has to deal with how symrefs are handled.  I don't
think any of the fetch code path does anything special with symrefs.
Symref info does get sent over the wire for the HEAD symref but i think
its just ignored.  You'll see updates for origin/HEAD when you
subsequently fetch most likely because its recorded as a symref locally
which points at origin/master. This means that when you fetch
origin/master, origin/HEAD will also but updated just because its
locally a pointer to origin/master.

With that said, yes we should probably fix this issue with fetch because
I added symref support to protocol v2 so now symref information for refs
other than HEAD can be sent across the wire but the client just throws
that info away at the moment.

-- 
Brandon Williams
