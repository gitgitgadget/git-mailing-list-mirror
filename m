Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4D31F404
	for <e@80x24.org>; Tue, 13 Mar 2018 18:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeCMSVo (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 14:21:44 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:41694 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752555AbeCMSVj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 14:21:39 -0400
Received: by mail-vk0-f43.google.com with SMTP id l123so367971vke.8
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b/u7nYdvnShxQA0CMbuKOWbgVj6J7HK1BF4wu9z0uT8=;
        b=dEaUN4lsvNEWH/6nbzBq3m8B978b4gn4fYPZPVTNORVJ8Dc2xEDEIoEFgc+QB2Z4w1
         kGi3gHu0IV56csVetYVC9saHXc5CoA6Fe9UFtBgHw8jLMr548VhEfsQWOxTqVL+/mH6S
         JU93bnMB3N0xDJqHevKEJ7sfnCUSbG9IB5a2guF5Y67CoCem2htqi2i287ttp0vBpwkI
         XP0TMGokS4mqtxtsoYQDbzI2s8XO/Gsg3ejQQksvFvh0ZAC0yKyO8ota4xQpqS9a4NNh
         tF0LiHv178KoNSGqRhGQuAhHJYjqTzC+17PWDMYW49QtRFmx3iuxr9knFa2xyUI8xHam
         dbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b/u7nYdvnShxQA0CMbuKOWbgVj6J7HK1BF4wu9z0uT8=;
        b=EBWC5G2azjrIukM6EZrhMKFx6CW7aZTgUfUrjCQyF3sJZ9LhPeWh4AptT/uuqbSuqK
         dhOxig2xVATMspfckBPQdWk+umrB7XLM3r047BR2IXs3rj3l1IgCEbxh6conDHQHKsq9
         Ro5F0TrL2LfHsilVqVL3ptrlwC8V4m0NhW3innVayRajQx8eOg5DJnFu4SkW8Y7KnNg5
         7+n62wqic5UegoIZZd5otfYGAfkYelYvq+xxjmnUIz1yoDBPOdekGUTiLwQHXF3+g3Bc
         pO7gjmIOzurC4fnWGINC3dTUtkdYSuj0moPsXStbQdh3lFbPG2gy4UNTYluVdrzI+h78
         RDkg==
X-Gm-Message-State: AElRT7FiAK2DhiuXBSoL2xIU3tw3COm+vMb9rWeDSu554bOXilv5RmGO
        vY9SiIOK9DgZupZXbkcTKRKymg0CWwVxhyPokMI=
X-Google-Smtp-Source: AG47ELs85itLEfPLGCMI0kUXYywm9HIRHpWwMHNeZ5739JWvcho1RzZwks3GI1sDkvdnM3Rf/iYhlnj2Vvz4zXy3lko=
X-Received: by 10.31.182.210 with SMTP id g201mr1041552vkf.187.1520965298779;
 Tue, 13 Mar 2018 11:21:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.3.241 with HTTP; Tue, 13 Mar 2018 11:21:37 -0700 (PDT)
In-Reply-To: <CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
 <20180312184734.GA58506@aiede.svl.corp.google.com> <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
 <CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Mar 2018 11:21:37 -0700
Message-ID: <CABPp-BF-LnGPx6vKzCNaFNi_fkxK-CpenatOVa2fvJRZHd0hZw@mail.gmail.com>
Subject: Re: Opinions on changing add/add conflict resolution?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 12, 2018 at 10:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> While I do not think it is a bad idea to add an optional way to write the
> contents of conflicted stages out to separate files, I do not think it is a
> good idea to change what happens to add/add conflict by default.

<snip some other good arguments>

> If anything, if rename/rename behaves differently by always writing
> the result out to separate files, it is that codepath whose behaviour
> should be fixed to match how add/add conflicts are dealt with.

Cool, thanks for the context.  I'm happy to go down this path, but
there is one question I'd like your opinion on: what if the
intermediate content merges have conflicts themselves?  If that
question isn't clear, let me be more precise...

Let's say A is renamed to C in HEAD, and both sides modified.  We thus
need to do a 3-way content merge of C from HEAD with the two A's.
Let's call the result C1.  Further, let's say that B is renamed to C
in $MERGE_BRANCH, and both sides modified.  Again we need a 3-way
content merge for that other C; let's call the result C2.  If neither
C1 nor C2 have content conflicts, then making rename/rename(2to1) act
like add/add is easy: just do a two-way merge of C1 and C2.  But what
if C1 or C2 have conflicts?  Doing a two-way merge in that case could
result in nested conflict markers.  Is that okay, or would we want to
continue the old behavior of writing C1 and C2 out to separate files
for that special case only?

I'm inclined to special case content conflicts in the intermediate
merges and handle them by writing out to separate files, but I was the
one who suggested sometimes using separate files for add/add
conflicts; I'm curious if perhaps my strong aversion to nested
conflicts is also off base.
