Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6251F461
	for <e@80x24.org>; Thu, 16 May 2019 01:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfEPBqZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:46:25 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46718 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfEPBZv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 21:25:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id a132so1224285qkb.13
        for <git@vger.kernel.org>; Wed, 15 May 2019 18:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6SeWOnRZSmHWJUO6NKEpEkDGnjj8GhH7NroY4Ui//F8=;
        b=j4fs37CRuFnp4yWhwZv4nCyYdQ/P0ToRxmxTJA3JrwZjWbsHyyusvy2Dg4GtBI9Ho/
         9AgB0P8GE/EG+qRLm1lptXCjDk/ZD2YAIYSS0z+ls8oHc53EqmmiRnxUb9B17dmNByuY
         NI/ty69983M5FR5Urebqm9euMn3mhzS1YMbFmj/eslrEcTeIDZezQ3+/TedXBBKsIbUM
         YdyJ9BX57WjxmOt8VdR1usUtBA49kg/oRydWCk/XFLpvcybLYVTou1UMOb/Brk08bbpV
         tOSoguuztdWbRkpL0ZkyBDUOLfKPigBT5SOtQN0dAwxiDSzYmArAh3UcEwLmcser/LZ+
         wQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6SeWOnRZSmHWJUO6NKEpEkDGnjj8GhH7NroY4Ui//F8=;
        b=kGPp6yDxOIL/9t2w5Z99d/0uJRX2jgRLNkRBIOgPboUtUfNbSyWePkblinqpCCvDCw
         Uffsv6f7I9PKebae/jtnKip84k48oVuxosDj3vm1eZ44/OFD0IM2S8uEMZ2Hj0zVdRKP
         RGxGXloBuVCwV1PeLnWgHomuR/f+Ai8+Y5L2VZM7c67bXehSy8SMspMJeYdIA0ePpaRe
         MP8zSTfoD1dbL+cD5sJqbAfRmiI/ulP8weKTAFSwFcBDqmcWs1wpS477xXx2cVqVGQou
         UwoAR17YQgYHVlD3J1YkVYP2Zi86v0T9N6aZqxOhzUO7yFkBIyDSJYdfHlhK8nvF0rhQ
         3Pyg==
X-Gm-Message-State: APjAAAUoaSLwb/56hVSmwLsH8j75fPjbAFYx5Eah+kWuKhPy316w4u9M
        qX5Nn/xSn6yqW5Gn9MNM9e8Tz8oIUaA=
X-Google-Smtp-Source: APXvYqzJOG2DJDyhlyxNwx9J7xMtfVnYr2RYmxpQMCW8NIJT4csbS8oLM98lQDftFpmpIUpaTyD0zA==
X-Received: by 2002:a37:6043:: with SMTP id u64mr24283066qkb.9.1557969949296;
        Wed, 15 May 2019 18:25:49 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id q66sm1955550qke.66.2019.05.15.18.25.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 18:25:48 -0700 (PDT)
Subject: Re: Finer timestamps and serialization in git
To:     esr@thyrsus.com
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <023b01d50b5c$cbd3cd90$637b68b0$@pdinc.us>
 <998895a9-cfbb-c458-cc88-fa1aabed4389@gmail.com>
 <20190516002831.GC124956@thyrsus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3b8d6a78-bd88-770c-e79b-d732f7e277fd@gmail.com>
Date:   Wed, 15 May 2019 21:25:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190516002831.GC124956@thyrsus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/15/2019 8:28 PM, Eric S. Raymond wrote:
> Derrick Stolee <stolee@gmail.com>:
>> What problem are you trying to solve where commit date is important?
> 
> I don't know what Jason's are.  I know what mine are.
> 
> A. Portable commit identifiers
> 
> 1. When I in-migrate a repository from (say) Subversion with
> reposurgeon, I want to be able to patch change comments so that (say)
> r2367 becomes a unique reference to its corresponding commit. I do
> not want the kludge of appending a relic SVN-ID header to be *required*,
> though some customers may choose that. Requirung that is an orthogonality
> violation.

Instead of using the free-form nature of a commit message to include links
to an external VCS, you want a first-class data type in Git to provide this
data? Not only is that backwards, it makes the link between the Git repo and
the SVN repo weaker. How would you distinguish between a commit generated from
the old SVN repo and a commit that was created directly in the Git repo without
performing a lookup to the SVN repo based on (committer, timestamp)?

> 2. Because I think in decadal timescales about infrastructure, I want
> my commit references to be in a format that won't break when the history
> is forward-migrated to the *next* VCS. That pretty much eliminates any
> from of opaque hash. (Git itself will have a weaker version of this problem
> when you change hash formats.)
> 
> 3. Accordingly, I invented action stamps. This is an action stamp:
> <esr@thyrsus.com!2019-05-15T20:01:15Z>. One reason I want timestamp
> uniqueness is for action-stamp uniqueness.

Looks like you have an excellent format for a backwards-facing link.

Gerrit uses a commit-msg hook [1] to insert "Change-Id" tags into
commit messages. You could probably do something similar. If you have
control over _every_ client interacting with the repo, you could even
have this interact with a central authority to give a unique stamp.

> B. Unique canonical form of import-stream representation.
> 
> Reposurgeon is a very complex piece of software with subtle failure
> modes.  I have a strong need to be able to regression-test its
> operation.  Right now there are important cases in which I can't do
> that because (a) the order in which it writes commits and (b) how it
> colors branches, are both phase-of-moon dependent.  That is, the
> algorithms may be deterministic but they're not documented and seem to
> be dependent on variables that are hidden from me.
> 
> Before import streams can have a canonical output order without hidden
> variables (e.g. depending only on visible metadata) in practice, that
> needs to be possible in principle. I've thought about this a lot and
> not only are unique commit timestamps the most natural way to make
> it possible, they're the only way conistent with the reality that
> commit comments may be altered for various good reasons during
> repository translation.

If you are trying to debug or test something, why don't you serialize
the input you are using for your test?

>> P.S. All of my (overly strong) opinions on using commit date are made
>> more valid when you realize anyone can set GIT_COMMITTER_DATE to get
>> an arbitrary commit date.
> 
> In the way I would write things, you can *request* that date, but in
> case of a collision you might actually get one a few microseconds off
> that preserves its order relationship with your other commits.

As mentioned above, you need to make this request at the time the commit
is created, and you'll need to communicate with a central authority. That
goes against the distributed nature of Git.

In my opinion, Git already gives you the flexibility to achieve the goals
you are looking for. But changing a core data type to make your goals
slightly more convenient is not a valuable exercise.

-Stolee

[1] https://gerrit-review.googlesource.com/Documentation/cmd-hook-commit-msg.html
 

