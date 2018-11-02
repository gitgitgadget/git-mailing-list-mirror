Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25941F453
	for <e@80x24.org>; Fri,  2 Nov 2018 20:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeKCFyx (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 01:54:53 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:44975 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeKCFyw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 01:54:52 -0400
Received: by mail-ed1-f51.google.com with SMTP id n19-v6so2791615edq.11
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sDxuxQIqnG4QmwAfumXiA50LPZDd+6sLOnVhofyTwus=;
        b=HWRtT9wQCHkLSfAlQ7x7nHwTnbLYnOprcEPPVHr8svxz191/IC/zJXd8k0TrIKVFQ5
         i7TSNwARm7p0Rnemg065r+tbK4zpFQ3cJ6cvVvAlxI2zsyI2PXNKpdwXDxIa5TmNwyxq
         uOGk6gNSu95/VTsIKnYlp9LlNhQk4Bzv1Or0h8vhykGHCEEmze/Tnzf22Y9I1ahYFWuo
         JIqFQei7BuI+Ekslb1xSF0N++P/DcMVtmvdjgvClOXTFfNn9nfFFpieXtReYMqC2lNrc
         Vs5VefmupC7Zp65Cj8l2kCnXvnKvevDZYML7FIgOVn4X335TLViYoAys7mjGI32fYsEp
         wTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sDxuxQIqnG4QmwAfumXiA50LPZDd+6sLOnVhofyTwus=;
        b=RLXt1vmzOkTD65PDVJByrfz8XJqKv5xI9IylppVx3A90NeQ6eDnWWvh73SPtLciS01
         bFvuHp6MPz4/FnmgRynzkcGkcSueizLOteMU5g4W8+yHyL+hmeVeTENTGM/PZEs03gEj
         4t6V4fyvnFdedvE2iYqQ1peSECU1cxmeAAY3zwfVJf7uFrzSMCQl5I0LAT+mm51q1Gct
         SnCgK6M4BXKf8u9oLEXmqKUt8qatYk7DQ+uYh0zgzunfGCcpRyuNwqBxspHqAF9yrhy9
         KAa4yU6wTAbhS2yE6PICvg6mOrCCi6DmMgvCnWtlnWieyesqY2vOmbfUl/henzm+1fhy
         uH9A==
X-Gm-Message-State: AGRZ1gIM6E8Stny3U0KZkCPeR3eRiub4GaJ15j/shSDDWK1vaunPTIns
        SXVpROZ+c/vv9Hd3KK36EYjgY1JPxT3jO9lfhGAuUQ==
X-Google-Smtp-Source: AJdET5dgqfp9itxsS6D1F+esfh4UnHSyyNYv9ULPbLclpiLJh2lQJbXT1ZO17Uyq8o43wyKll/5TxhK1dd0u4wAs0vU=
X-Received: by 2002:a17:906:3712:: with SMTP id d18-v6mr7377147ejc.126.1541191573925;
 Fri, 02 Nov 2018 13:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn76N34oBhRZvXKOwP0L_pF=LYbT6ugTgtPYSvnHg=MZVw@mail.gmail.com>
 <CAGZ79kZ6LxRevLy2mZd1Ag=oO_NtDdmRSuadswR_n=RGpO=rGQ@mail.gmail.com> <CA+X5Wn6nP5sZh8Z2dcTZKpPBWG43nSUATcWx0fzp2dNTJ3UzQQ@mail.gmail.com>
In-Reply-To: <CA+X5Wn6nP5sZh8Z2dcTZKpPBWG43nSUATcWx0fzp2dNTJ3UzQQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Nov 2018 13:46:02 -0700
Message-ID: <CAGZ79kasAsUNbNKXtexZDiZtQtFXP5EODLaquwvf7BN_JSiEPA@mail.gmail.com>
Subject: Re: Using --word-diff breaks --color-moved
To:     james harvey <jamespharvey20@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 1, 2018 at 6:19 PM james harvey <jamespharvey20@gmail.com> wrote:

> > This sounds like you are asking for two things:
> > (1) make color-moved work with words (somehow)
> > (2) allow the user to fine tune the heuristics for a block,
> >     such that default=zebra would still work.
>
> I was asking for #1.

I currently have no time to look into that,
but you're welcome to do so. :-)
I'd be happy to review the patches!

Thanks,
Stefan
