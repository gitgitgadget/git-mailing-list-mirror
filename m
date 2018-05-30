Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49A7D1F42D
	for <e@80x24.org>; Wed, 30 May 2018 03:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754765AbeE3DSs (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 23:18:48 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:43314 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935984AbeE3DSr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 23:18:47 -0400
Received: by mail-yb0-f177.google.com with SMTP id w3-v6so3274714ybq.10
        for <git@vger.kernel.org>; Tue, 29 May 2018 20:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AAyn1CRTCcPmBNxGrnt5eixIk1sK7J+FKD+Ih5lyjxM=;
        b=YlM0HqAP9Se5r7n4PqfuudRPaYET0UwGXFfpi0kxZ521dN7Nx+rvqMm5C5qCk498ds
         3Apoqb8/oBkgGYsBLM+z8AAaCspmdfdj1aNzeas5MLUxPTpeHBOkzqZCxO1gB9mPHFWE
         /C7rnLL5duCeuaP284sQgSS09QEnLCYuk2FFFGqTjt9y0mERVQqBNLmqJzv3NW44GO8R
         TqeD3zm4+Jp8oe/bVqNRkyxPhlw6Rm/G5VlhsDBSKNYnFGO0k/CcbLYnuI1vs8ACmi5G
         wFB4EciEEod9bufZF9AtrzW6WJAH3EJ4mOuW2jxNHRPxI7X12YzUuJ4d9YR45LoBqEZH
         nboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AAyn1CRTCcPmBNxGrnt5eixIk1sK7J+FKD+Ih5lyjxM=;
        b=ETwy6JObLwYEbifhC0s8eVaoJ9WkUFeUeZkuT8Zi0Y3QZ6KbI0h1pV21DSM7DFfAUu
         Mpx9jmFrHt0ui46b8NlLZc4veOtm6iSPoxL8ysIGqi2YHRmtbXczp/ZXqn/DhqX3tbfj
         6mIK6N00nQoZTG9vyeEZadMldnaFdSaZDxLc7G2oIFUvIB1tfsxaYlrCSzVCiC3Hdkcl
         ZYSnJmmoheZd7F9/7q7ulY9rzl/hDRxH61rRtsy/d6h1i1FoGp0tfgryb7xqgHJ7suzV
         McW7L91fl1Wx9TZYs8Ogl4VuC1J8Alk6cMfgNx2SLzAZwKUjFVqI8/KmY50D2giqqOTh
         ZERQ==
X-Gm-Message-State: ALKqPwczok/4V3mBEjYLkx/gXoVzq8WvKmdkvIr3kWgt5leqMLUniyvC
        Ue8H5FWVBccU3bJYK6cPoIVWYlSH71BGg52NeWfFXg==
X-Google-Smtp-Source: ADUXVKJoNZdneG23w3w3+JYkUFPEB2Haun3Dbyoa5CXkARRQtTIQELJal/X1h8R9orO+fNkMbE1m87vGFOgHEONjjxA=
X-Received: by 2002:a25:dfca:: with SMTP id w193-v6mr534234ybg.334.1527650326371;
 Tue, 29 May 2018 20:18:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Tue, 29 May 2018 20:18:45 -0700 (PDT)
In-Reply-To: <627c65a9-d807-8912-b96d-ef7feecb9ea4@gmail.com>
References: <20180530004810.30076-1-sbeller@google.com> <627c65a9-d807-8912-b96d-ef7feecb9ea4@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 29 May 2018 20:18:45 -0700
Message-ID: <CAGZ79kaEHhE=suT2-Rzrbu2P7z8KPzRdCOFNCTqsOiV0+HjJ9A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/35] object-store: lookup_commit
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 29, 2018 at 6:05 PM, Derrick Stolee <stolee@gmail.com> wrote:
> On 5/29/2018 8:47 PM, Stefan Beller wrote:
>>
>> This applies on the merge of nd/commit-util-to-slab and
>> sb/object-store-grafts,
>> and is available at http://github.com/stefanbeller/ as branch
>> object-store-lookup-commit
>> as the merge has some merge conflicts as well as syntactical conflicts
>> (upload-pack.c
>> and fetch-pack.c introduce new calls of functions that would want to take
>> a repository struct
>> in the object-store-grafts series)
>>
>> As layed out in
>> https://public-inbox.org/git/20180517225154.9200-1-sbeller@google.com/
>> this is getting close to finishing the set of object store series though
>> the last
>> unfinished part of this RFC hints at new work on the plate:
>> * To give this series a nice polish, we'd want to convert parse_commit,
>> too.
>>    But that requires the conversion of the new commit graph. Maybe we need
>>    to split this series into 2.
>
>
> I'll take a look at this series tomorrow. I've been working in
> ds/commit-graph-fsck to make many of the methods take a 'struct commit_graph
> *' parameter, which could easily be 'r->commit_graph' for a 'struct
> the_repository *r' instead of the global 'commit_graph'. Those graph-local
> methods will make the transformation to be repo-local a lot easier. (There
> still may be some need to insert a repository, though.)
>
> Since you are working on the commit-slab stuff in this patch, I'll (continue
> to) delay my patch series on using the commit-slab for generation numbers to
> avoid collisions with your work.

This series touches the commit slabs in the last few commits only.
I don't think there will be huge conflicts, as all I had to do was
move the definition from a global to inside the parsed object store.
