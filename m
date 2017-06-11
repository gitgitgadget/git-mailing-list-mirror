Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E8211FAED
	for <e@80x24.org>; Sun, 11 Jun 2017 00:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdFKAfF (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 20:35:05 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36302 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbdFKAfE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 20:35:04 -0400
Received: by mail-pf0-f175.google.com with SMTP id x63so39829479pff.3
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 17:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m+gb3R0HoHt4m3j2iBvZL8Sw30WNXbgEpRHp09o4J0A=;
        b=l1tzDKl1576OWG44LCds5pIwvA79cGPy3rDBpMmEuWwnudAQAIqkiohhNM3ISLn/dP
         Rv+mEh6aUR6Hze4ik5H4Q4NjNaLA0RRGai0QuXZYWvPrNx7QfwQIWIM3B9K24DL8vWbg
         n20bnsMVkkATPE0NkxVCmonBzkJfTaPy3SnWhZlKvPNydlKDVa7cXfSpg84Kp1ByNlOu
         aNkSe9iSei6CY81UKROszohhGTktn7ALmyZl//Qd8dBzcwsPJ2/HJj0DYdKRMtocgjNu
         pDVtbNda80ndk3Qn1ORWzg+vU4iSZyZ6H0qIvq9CmFnB3BPo3B32b2x0y7JMPIe1hSMv
         60jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m+gb3R0HoHt4m3j2iBvZL8Sw30WNXbgEpRHp09o4J0A=;
        b=THvFgqwnHFf3h/5TKzul9W7CIWsxlTn9jzVrIqPJ/TPhZa73PER+YSUV81q2wn4s0k
         og0KF+Jtbh1pkeNZTI5Ma/5C6/hLA0IbacyE+0ARyU+Pl255hgTSbqD1zatZV8XVQNfG
         qnODhTdLSz5MaoCgL/tH/0QydAQGT8VNu95oUGHlX9RsnTtKX68rw5w34r9S+e9npiRA
         ZKCFdkbPD7f7x/Z8oLC0TnnBQs00E0T4TC6nmL6A6kcxpTcTX1K5egrCQdYoKI7QJNke
         JJqK30Iwhe6afnKbj9fUif+c+WjaJlx+ugr5QIWG7RFUZmHaxm0fw4mOTHWRXXXECbjB
         NPQA==
X-Gm-Message-State: AODbwcB7qfZ/W9j+b5hka5W7R0O3A4LU6WyrW5YXrUnKnC56IT4k1X7w
        4LKvb9oASTVkAqIm
X-Received: by 10.84.217.11 with SMTP id o11mr48326916pli.299.1497141303512;
        Sat, 10 Jun 2017 17:35:03 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b5f4:f53d:2985:c426])
        by smtp.gmail.com with ESMTPSA id m25sm9892206pfk.15.2017.06.10.17.35.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 17:35:02 -0700 (PDT)
Date:   Sat, 10 Jun 2017 17:35:00 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v2 00/32] repository object
Message-ID: <20170611003500.GD81269@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
 <20170609174034.61889ae8@twelve2.svl.corp.google.com>
 <20170610060712.foqre5fscaxu3tnx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170610060712.foqre5fscaxu3tnx@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/10, Jeff King wrote:
> On Fri, Jun 09, 2017 at 05:40:34PM -0700, Jonathan Tan wrote:
> 
> > Before I get into the details, I have some questions:
> > 
> > 1. I am concerned that "struct repository" will end up growing without
> > bounds as we store more and more repo-specific concerns in it. Could it
> > be restricted to just the fields populated by repo_init()?
> > repo_read_index() will then return the index itself, instead of using
> > "struct repository" as a cache. This means that code using
> > repo_read_index() will need to maintain its own variable holding the
> > returned index, but that is likely a positive - it's better for code to
> > just pass around the specific thing needed between functions anyway, as
> > opposed to passing a giant "struct repository" (which partially defeats
> > the purpose of eliminating the usage of globals).
> 
> I think the repository object has to become a kitchen sink of sorts,
> because we have tons of global variables representing repo-wide config.
> ls-files doesn't respect a lot of config, but what should, e.g.:
> 
>   git config core.quotepath true
>   git -C submodule config core.quotepath false
>   git ls-files --recurse-submodules
> 
> do?  Right now, with a separate process, we respect the submodule
> version of the config. But in a single process[1] we'd need one copy of
> the quote_path_fully variable for each repo object. It's tempting for
> this case to say that core.quotepath from the super-project should just
> take precedence, as that's where the command is issued from (and why the
> heck would anybody have per-repo settings for this anyway?). But I
> suspect as we get into more complicated commands that there are likely
> to be config variables that are important to match to each repo.
> 
> I do agree that "pass just what the sub-function needs" is a good rule
> of thumb. But the reason that these are globals in the first place is
> that there are a ton of them, and they are used at the lowest levels of
> call chains. So I have a feeling that we're always going to need some
> big object to hold all that context when doing multi-repo operations in
> a single process.
> 
> For config, in theory that could be a big "config_set" object, but
> that's not quite how we treat our config. We usually parse it once into
> actual variables. So really you end up with a big parsed-config object
> that gets passed around, I'd think.
> 
> -Peff
> 
> [1] I wanted to see how Brandon's series behaved for this quotepath
>     case, but unfortunately I couldn't get it to work in even a simple
>     case.  :(
> 
>       $ git ls-files --recurse-submodules
>       fatal: index file corrupt

Yeah sorry about that...I commented on patch 32 indicating that I made a
small mistake and forgot a '> 0' when checking the index.  I made a last
minute change before sending v2 out and forgot to run tests again (I'm
terrible i know!).

-- 
Brandon Williams
