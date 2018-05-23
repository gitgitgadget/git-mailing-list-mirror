Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C7F200B9
	for <e@80x24.org>; Wed, 23 May 2018 07:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbeEWHBh (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 03:01:37 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42514 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754316AbeEWHBg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 03:01:36 -0400
Received: by mail-qk0-f195.google.com with SMTP id 196-v6so3272414qke.9
        for <git@vger.kernel.org>; Wed, 23 May 2018 00:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=4z6fXp1QNn70B6T9IpeqHndniGY7Ex/nQkssQaG4SJo=;
        b=ukiVXBktE4uhKGjgd7LszujoJhXGPehEObT0L2dYpHd7vCS/ct0LYrk2RQqqIFP2Jr
         vOCU5Z95hyaNPb43EJfm5G8JEK6iNlCfXojp34nijc0KBQ9f/kXYtSRqK/ob3z6Ql0ul
         +AXWLOZ7RFtQtYyxsU3DvUzehOiwMt1Y3yxB67IauULZEY5o90uKpEOSt24RQQXzl5ug
         sfIgYI3DbBnKghUpaUsnIlbvFyChj5nT9Yfq4ANSs9NMH5lshhbIrc/zeDU6ys8mrbXD
         usROobScDPkyFRUhW1CiA3HaBBgyd263fNYFPdj/QFci+4bQbY9au2ljx4B2Uea+fZxB
         Ckrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=4z6fXp1QNn70B6T9IpeqHndniGY7Ex/nQkssQaG4SJo=;
        b=tkmiwb5sGeD9HHi8Ifkm3TNehGYCSFvQQ7b9bPPNEW3b7gJrtPYi3O9JQE+MsPJOkl
         bSCMxA08unOc12GQLrd6j2sHX7bNcoPjpJ/NGFe/i6nU7+8Y/TZNT45nHwNaDiEGx0Bo
         vaxLydi0TB2GnnNRIYpONPoXRL1XvXYzrh+3hq662BKD9oyHOToBXyGG004ki6jCDUl+
         xNdI0LIpcoI8QLbagtWsANOo47r0SZmDj/QBlf/Ff4Dzl3TEiI3rIyIEpzm9XbKx+ImA
         g2tDaoLZtJ5iGSDZPnVux9Z9rh+nwFyx43NxHHDu4zpdUMuO8CrwP6+b1ORPD+GFDgUy
         qyXA==
X-Gm-Message-State: ALKqPwepg/Rnbsr5ucH6CYD8i/IrUtTZtdvdQYD7w5VbfU1EphuTRqK5
        /42QnXnCvh6jIC8YjI1L56zX5JtukKmJlx6n+oQ=
X-Google-Smtp-Source: ADUXVKKyven1DJhjC7rpjETVZFqShY6S2TUjih+f9uf71xW5jBK+F2ra85gKiJ/WMVcuYoaz3T8y7LLnw8XZWrxF52I=
X-Received: by 2002:a37:71c7:: with SMTP id m190-v6mr1305209qkc.91.1527058896064;
 Wed, 23 May 2018 00:01:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Wed, 23 May 2018 00:01:35
 -0700 (PDT)
In-Reply-To: <cover.1526812503.git.martin.agren@gmail.com>
References: <CAPig+cT1eejizU26mPE+tN+eZR4Wg0jw1DbmShgqRu69EYQutQ@mail.gmail.com>
 <cover.1526812503.git.martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 23 May 2018 03:01:35 -0400
X-Google-Sender-Auth: g9vnQ5n4yzXPyDkTR9tmWlQ5PHc
Message-ID: <CAPig+cSR=GnXvOcsxZmskmdQTM+59SpUis28y7RfhfA_-MGi3w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] config: free resources of `struct config_store_data`
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 20, 2018 at 6:42 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> On 14 May 2018 at 05:03, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, May 13, 2018 at 5:58 AM, Martin =C3=85gren <martin.agren@gmail.c=
om> wrote:
>>> How about the following two patches as patches 2/3 and 3/3? I would als=
o
>>> need to mention in the commit message of this patch (1/3) that the
>>> function will soon learn to clean up more members.
>>
>> Yep, making this a multi-part patch series and updating the commit
>> message of the patch which introduces config_store_data_clear(), as
>> you suggest, makes sense. The patch series could be organized
>> differently -- such as first moving freeing of 'value_regex' into new
>> config_store_data_clear(), then freeing additional fields in later
>> patches -- but I don't think it matters much in practice, so the
>> current organization is likely good enough.
>
> I tried such a re-ordering but wasn't entirely happy about the result
> (maybe I didn't try hard enough), so here are these patches again, as a
> proper series and with improved commit messages.

The re-roll looks good; it address my concern about v1. Thanks.
