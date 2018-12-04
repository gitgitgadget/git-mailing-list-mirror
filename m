Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FDF0211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 10:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbeLDKnM (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 05:43:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45055 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDKnM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 05:43:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so15378446wrt.11
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 02:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CWcqtgutn11vWBCAuSQcstalhTGDQ/EF0Cf7uB/m8ec=;
        b=Vh9Kd02kEIMKZfTwPHL73zmMV97CNOCh+kcMhGeevz8U8XVwznk9bfOTBSmxvOSoqe
         vOYzPbpys81omAtF874++/WnU5OErEljI7jbGSz3ki+sG6CZGKF4bnnACRwD5dHLR8uw
         Nb21SbTXataixmkkmM/NFsD5aazys/Ur+P3YiwbZAe06TWkxCMrcYSjnuDbZfrqLyQOM
         9FPDIY3/hcm6xykng8Xo0xJdy7D5QScddHB1m5DzVgyc/sjBfYmuwlEV6xol+mEOkL1d
         UzRgmjMVzITSZ8U8vI0yOs7YakxZg489reRVOKXn/KQ/f4hyjqc4MjzM+CCGBI5Voiyg
         T60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=CWcqtgutn11vWBCAuSQcstalhTGDQ/EF0Cf7uB/m8ec=;
        b=fqp2K3gSmfVbW9j72dFKGSkaIu2u88d1ilUgx3jLkq/17DVWzMJ/hy/eNurKBTtuLJ
         rtu68hig+BMMdWVfCYVXN+w8yy++M/ZEDaPLT9kGo0SJQj0nGEb/oIEJDqIKY8+EdfNM
         jKVDl8eEbXy0vx2LuxesI/9aPEESteTiaNEf7Gq+ZJvuD7bBxt6addMvF0QIb6O4kmbl
         st8sEjPvdT0yAPUm5uhFIDVDYDPqsf3t9BY0YzB2ZrhoviUOfWf2P4rEUZQvYjjlxKOL
         SfdYVjUCaLNRiElf6bHFkQQa8F87YylUeuKV555/fnyuaI93TtmiDdJ7bx6RPl9ITC9F
         p12A==
X-Gm-Message-State: AA+aEWZdDiK+sjcrJ9EeBy5Z08T+cU7PGBD8L4OCJUFA2VUCoSYrdYdE
        i/wPd2/y5hnA/mym2dXmwAY=
X-Google-Smtp-Source: AFSGD/WPY95m+TTyuz49AhXvRHQj4gTHJgeH/IsdrRMHm1D5rrXTQPFdTjp9XtE5OzG0JRgM+GFefg==
X-Received: by 2002:adf:e08c:: with SMTP id c12mr16516541wri.199.1543920189144;
        Tue, 04 Dec 2018 02:43:09 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id 129sm9417033wmd.18.2018.12.04.02.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 02:43:08 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Git for human beings <git-users@googlegroups.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: How de-duplicate similar repositories with alternates
References: <87zhtsx73l.fsf@evledraar.gmail.com> <20181204065930.GA11010@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181204065930.GA11010@sigill.intra.peff.net>
Date:   Tue, 04 Dec 2018 11:43:07 +0100
Message-ID: <87tvjtvah0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 04 2018, Jeff King wrote:

> On Thu, Nov 29, 2018 at 03:59:26PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> This is the thing I was wrong about, in retrospect probably because I'd
>> been putting PATH_TO_REPO in objects/info/alternates, but we actually
>> need PATH_TO_REPO/objects, and "git gc" won't warn about this (or "git
>> fsck"). Probably a good idea to patch that at some point, i.e. whine
>> about paths in alternates that don't have objects, or at the very least
>> those that don't exist. #leftoverbits
>
> We do complain about missing directories; see alt_odb_usable().
> Pointing to a real directory that doesn't happen to contain any objects
> is harder. If there are no loose objects, there might not be any hashed
> object directories. For a "real" object database, there should always be
> a "pack/" directory. But technically the object storage directory does
> not even need to have that; it can just be a directory full of loose
> objects that happens not to have any at this moment.
>
> That said, I suspect if we issued a warning for "woah, it looks like
> this doesn't have any objects in it, nor does it even have a pack
> directory" that nobody would complain.

Yeah, although see my <87sgzjyif2.fsf@evledraar.gmail.com>, I also ran
into a different issue.

I think a warning (or even error) like this would be more useful:

    test ! -d $objdir && error... # current behavior
    test -d $objdir/objects && error "Did you mean $objdir/objects, silly?" # new error

I.e. I suspect I'm not the only one who's not read the documentation
carefully enough and thought it was a path to the root of the repo and
wondered why it silently didn't work.
