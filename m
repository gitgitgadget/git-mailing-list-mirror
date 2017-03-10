Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B14091FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 19:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbdCJTz3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 14:55:29 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33752 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933269AbdCJTz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 14:55:27 -0500
Received: by mail-pf0-f195.google.com with SMTP id v190so11840726pfb.0
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 11:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VMn5FlDZhBCuJrnLDYuK1OQsrwCJzz1FOCI5JoUpqlU=;
        b=HTc7GHda8CR/3ExIJsYsi9hM/GojLV74pfnUsDZH7v/NYIYly9oiaBkPxWAho00pOS
         SeEE5TSKESWxuKLaIEb/3hDMBSMCpiMBsPcS3TjDw+0U8LgmNQE6JTyPRxCDqUQhEFJQ
         mYfw3iRMg7ALA0cdFFjTlU4Uj3DExniuCRBEfuDbdcJ2tqwfSugB8hym1oUs2B1PMBEK
         aHqmT3YXWuQ7XOpWkIdMGo22xlydfMCqSPhrtL8Co4/Tp6BFb/VSMnjChN5cRMreTLHS
         14dfvyuUy+KVXPTqxnZeBvXMyQC5WBqYQFLASkWdjQi85RkZcb5sVehsCyzXIfUtnG5y
         1VXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VMn5FlDZhBCuJrnLDYuK1OQsrwCJzz1FOCI5JoUpqlU=;
        b=O9VitzJNU2TS9xoWkuqaWOIwlkKLHYl196HMZoEwLEJIThaJbRi6KuZxVe5MhT7dk0
         DQKp9A0OuDQ0WmOsiKLmUHszwcJ4mB5ENML2l5aEQl1y+KJFynvJ4cgVLCsGzyzXz7q9
         c1xyOrvJRUN0/qTHQdt9Ob7sK9LF260WpLdaHFeSBYSsdiVyYSI9Xb6FaOCiFIAcdLrU
         4OsxIWXCPj8dcC9xq4LGMuSLshVJcJ6RX7ppex+RQ7UDfM0b8gT50katIbIN9bOMI/q1
         UViP5k4gjGRyT1nbNMQm0XJvrKXeoJ2j8hGt+huyOW32WVgVJbARt8z9UJDlALgIzAQG
         RsOg==
X-Gm-Message-State: AMke39mxbxgCeJwG1vXMFuUwQD/sJEUtnOMBx1ex9jGznz9pN2I67qv5hMu2SmBphfVXsQ==
X-Received: by 10.98.153.11 with SMTP id d11mr23428843pfe.15.1489175726499;
        Fri, 10 Mar 2017 11:55:26 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:9cce:1925:a4e:f6c5])
        by smtp.gmail.com with ESMTPSA id k76sm20178684pfg.42.2017.03.10.11.55.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Mar 2017 11:55:25 -0800 (PST)
Date:   Fri, 10 Mar 2017 11:55:24 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20170310195523.GF26789@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com>
 <20170309202408.GA17847@aiede.mtv.corp.google.com>
 <20170310193835.t7syswueuu7nmkjz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170310193835.t7syswueuu7nmkjz@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, Mar 09, 2017 at 12:24:08PM -0800, Jonathan Nieder wrote:

>>> SHA-1 to SHA-3: lookup SHA-1 in .msha1, reverse .idx, find offset to
>>> read the SHA-3.
>>> SHA-3 to SHA-1: lookup SHA-3 in .idx, and reverse the .msha1 file to
>>> translate offset to SHA-1.
>>
>> Thanks for this suggestion.  I was initially vaguely nervous about
>> lookup times in an idx-style file, but as you say, object reads from a
>> packfile already have to deal with this kind of lookup and work fine.
>
> Not exactly. The "reverse .idx" step has to build the reverse mapping on
> the fly, and it's non-trivial.

Sure.  To be clear, I was handwaving over that since adding an on-disk
reverse .idx is a relatively small change.

[...]
> So I think it's solvable, but I suspect we would want an extension to
> the .idx format to store the mapping array, in order to keep it log-n.

i.e., this.

The loose object side is the more worrying bit, since we currently don't
have any practical bound on the number of loose objects.

One way to deal with that is to disallow loose objects completely.
Use packfiles for new objects, batching the objects produced by a
single process into a single packfile.  Teach "git gc --auto" a
behavior similar to Martin Fick's "git exproll" to combine packfiles
between full gcs to maintain reasonable performance.  For unreachable
objects, instead of using loose objects, use "unreachable garbage"
packs explicitly labeled as such, with similar semantics to what
JGit's DfsRepository backend uses (described in the discussion at
https://git.eclipse.org/r/89455).

That's a direction that I want in the long term anyway.  I was hoping
not to couple such changes with the hash transition but it might be
one of the simpler ways to go.

Jonathan
