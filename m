Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DC7D1F42D
	for <e@80x24.org>; Wed, 30 May 2018 21:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932263AbeE3VDi (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 17:03:38 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:46134 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeE3VDh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 17:03:37 -0400
Received: by mail-yw0-f195.google.com with SMTP id v197-v6so5174700ywc.13
        for <git@vger.kernel.org>; Wed, 30 May 2018 14:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7HNwDOj98qntrJFCU1+u6BKxPAsLRTJXjto2nWvQRew=;
        b=RLboXxBlFRwJD/DrN4AZXONLTLn5ccOYfqIpd/i/Owh5EbaovNbxaR3sV0LyLpQh6N
         j2tP1+UWPeo991DKr/5zKdpzV18zwI6HfwtR3XF62/XZW9t11lt/zerRjsaWfhi7L+5Q
         HnZc5+xrcZ42rg1Eoe+fiJjDjN7PdYKEjHZ7BmvLlbVP1uBx615wFODDMBA+4ma/ZNOF
         2GbaIh8kCqGd5/vq4tB3i8q941vxDE6Mwx9TEBVm6OyWaVWr3PRbGEoibQQx30VlziK3
         HPI8QW5DCYKjRUsGJzMTxo1Trr7Lyqo9UJ6R+Y9sTOktjKvn0pSHtjqLEzhTaNDcsz21
         J8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7HNwDOj98qntrJFCU1+u6BKxPAsLRTJXjto2nWvQRew=;
        b=QowCCNoo8CYhU81O3EHq/u5EJG3VzJGaE3JOkvRa4UZcw94kODcUnJLaMPJppXncxe
         l7gVb7yevpHBLx6RG4IoYdQfOZ1mzfphwALPwB/gC99MLKeBWALdBun0qKNSKWTHnZu6
         r7iDTIpejCw67oa9fOdUQUJnfwpkxHnYCTt30Uyx7MlRxIJfp0gXi3vN6RTc7UBfVrtQ
         58z7LKWQauoccgL5XPaffJOblOhOLL8cc8weMOt9o0yVQuhzH8vDjRzGwNvH3pmtDAMl
         NnJ9gSa8IMLUhXkH0iip/bs1NTmSTS6wadGYeinJtM0+ENgDciI0Jp4G2zRgfvsj85Kn
         HlYA==
X-Gm-Message-State: APt69E2ij1lIoi9diPtdZTyL22w29H+JMD18cB4KXW4kvuIL9kz7N8JU
        xDnbm40o7YypTzyEg5n9Xce+aI7FCjG1SSm6jASVJQ==
X-Google-Smtp-Source: ADUXVKIYz4nExVRD/t11GyBoqTMznted8A957UxfT76qf+NcsXXbzQdxsgzdx6oUCEKz7oiAScfuuQe3HEN5lZlg0G4=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr2372854ywf.238.1527714216933;
 Wed, 30 May 2018 14:03:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Wed, 30 May 2018 14:03:36 -0700 (PDT)
In-Reply-To: <CAPig+cRh02976beGp5c5Sw5=h86VgNZgVreCHh38QKP5udJeGg@mail.gmail.com>
References: <20180530080325.37520-1-sunshine@sunshineco.com>
 <20180530080325.37520-5-sunshine@sunshineco.com> <CAGZ79kZ2MKpjwwx0+ZsPZ9bFu_ersPJ=kKPYWRmWYjJ8yoVhuA@mail.gmail.com>
 <CAPig+cRh02976beGp5c5Sw5=h86VgNZgVreCHh38QKP5udJeGg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 May 2018 14:03:36 -0700
Message-ID: <CAGZ79ka1-emwYsEh1EQdh=pgFUV_bi2xoDu1Ajq=Z1XkkhyuDw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] format-patch: teach --range-diff to respect -v/--reroll-count
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 1:44 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:

>> Unrelated to this patch: how does this series cope with range diffs
>> that are not in commit-ish but patches on the file system?
>
> I'm not following. Can you provide a concrete example to get me up to speed?

I was just wondering if things like

    git format-patch --range-diff=v3-00*.patch --reroll-count=4 -3

would be supported, but that doesn't seem to be the case, now that I read
the whole series. I don't think it is crucial to support right now.

This whole series is reviewed by me and I think it is good for inclusion
once we have a reroll of the range-diff series and aligned the command
name to call.

Thanks,
Stefan
