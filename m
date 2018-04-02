Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368541F404
	for <e@80x24.org>; Mon,  2 Apr 2018 18:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeDBSCw (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 14:02:52 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:42954 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbeDBSCv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 14:02:51 -0400
Received: by mail-yb0-f170.google.com with SMTP id d7-v6so5052429ybn.9
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 11:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TOkx8QSE6O4s6nZro0FwMTTGn3g5v0oaBOkLsj+PHOw=;
        b=PWWniDWiqOxDLqWcnqw8fvUeMsptAppgjAAe7+eI9d1MdWro239sexN25qvFpPOnWl
         DAcg1zKJ2kbp/o5SuLo1ivpwkjH+5Rh4WmE+Bh4+THbDKQCUmbnNyknx57TW8ApqPrgE
         I+QXFaFGjq7aAnWcg+w9IW1DgKVpnPi4A/sXWrXXFgVKLAo6rBGDsOGa2NfrBcqS7cV3
         xUFI+DA9D1scUYbDrVzjb18C4YrtIxO6U/OQPCqfylZlH7zj4UotWD5XooqtaBm+zCmd
         n90/VoND+k2KUq7wNb/XN4LO7XX755Teki8ACz5DKsz+3xwf/HN0Dbn7QjhJcuExiqxm
         UveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TOkx8QSE6O4s6nZro0FwMTTGn3g5v0oaBOkLsj+PHOw=;
        b=oDfOz0G54Zw9Yn2eJRMNVF4+S1wf8voL6gdLLP1uHfl9BMa4ZIykRt15am0L435N3z
         Ul4gxbnjN6/Olhh8vVzUkblFGDJPxsEi5tHQsp0QS1zuUcm1TsQ6TF1/UspfGNJENGDn
         vXdMgW7WL826WrKC5gQN9ZV9s8SnNADstnYlKmwuYcH9rFxNA4nBj3Hw5dW7yGwSNC3U
         fx9OYLojISzKOvhIo1qFyOT0Hgp1uosvWTNFgFIQos9pGpzj3k5ZXqQEngEzqODPPvRV
         Zm691dSxrODeWmTurL3nLfCIri7D6Ii8Fr1AxTupXrMHNA+69N9OhQ4fkfFq5R+eUe5Q
         /epQ==
X-Gm-Message-State: AElRT7F7PfsuQ74DGyUbuLLkR69XVF6Pxe+NugeF79VbTLeCCZjqIgKP
        MWhoX2TeXm8bBNgYsXOj7q8iZ3R050sXJpApDTrRpQ==
X-Google-Smtp-Source: AIpwx4/WBPocfCDF9MY71P1UhrB1MW1qt5fGoc8Xv++bz4stQkGqIX8uTu6N+j0qP5BNc/BsX2kI9hSEPMbX6mMd07Q=
X-Received: by 2002:a25:c713:: with SMTP id w19-v6mr5618892ybe.515.1522692170246;
 Mon, 02 Apr 2018 11:02:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 2 Apr 2018 11:02:49 -0700 (PDT)
In-Reply-To: <17430580-aae6-8693-c4c9-0935104bc535@gmail.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com> <867eptkeeq.fsf@gmail.com>
 <f5d8934e-afc2-39d4-b7d5-e5ba5e5021a1@gmail.com> <861sfxekeo.fsf@gmail.com>
 <d3060103-7fab-3b6c-e968-cb49f3f23acb@gmail.com> <CAGZ79kaoDNNcu8zqaTnoXWfJ0FnLwqvZfOHUniG-izndAjvDVw@mail.gmail.com>
 <17430580-aae6-8693-c4c9-0935104bc535@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Apr 2018 11:02:49 -0700
Message-ID: <CAGZ79kZZCFTm-+=E-HOMNt-3wKS=ZSyCz-rrPsY+mPQXq3VXAg@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Serialized Git Commit Graph
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jakub Narebski <jnareb@gmail.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Currently, the format includes 8 bytes to share between the generation
> number and commit date. Due to alignment concerns, we will want to keep this
> as 8 bytes or truncate it to 4-bytes. Either we would be wasting at least 3
> bytes or truncating dates too much (presenting the 2038 problem [1] since
> dates are signed).

Good point. I forgot about them while writing the previous email.
That is reason enough to keep the generation numbers, sorry
for the noise.

>
>> I only glanced at the paper, but it looks like a "more advanced 2d
>> generation number" that seems to be able to answer questions
>> that gen numbers can answer, but that paper also refers
>> to SCARAB as well as GRAIL as the state of the art, so maybe
>> there are even more papers to explore?
>
>
> The biggest reason I can say to advance this series (and the small follow-up
> series that computes and consumes generation numbers) is that generation
> numbers are _extremely simple_. You only need to know your parents and their
> generation numbers to compute your own. These other reachability indexes
> require examining the entire graph to create "good" index values.

Yes, that is a good point, too. Generation numbers can be computed
"commit locally" and do not need expensive setups, which the others
presumably need.

> The hard part about using generation numbers (or any other reachability
> index) in Git is refactoring the revision-walk machinery to take advantage
> of them; current code requires O(reachable commits) to topo-order instead of
> O(commits that will be output). I think we should table any discussion of
> these advanced indexes until that work is done and a valuable comparison can
> be done. "Premature optimization is the root of all evil" and all that.

agreed,

Stefan
