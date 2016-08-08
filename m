Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D8A2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 23:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbcHHXCX (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 19:02:23 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36986 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbcHHXCV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 19:02:21 -0400
Received: by mail-it0-f47.google.com with SMTP id f6so96308308ith.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 16:02:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ta2pdETCA4V78AHAgC1fg/YuSQgrXosSdhSzsXnusQQ=;
        b=RhSbyX2cEb397sribkBRiALcGHr8nygPyTU2wPemo60CNK6fKxHMQX64XhMOasxjBx
         zWoSRecQoT+zyMsTcQ8hEDeWg0ylMJw4WZKFLWufex2acNZlFJsV7R03SOSeuvxifYaT
         huKvyDfjDY+bvzIpiT37amnLd4zsZUqi7LKwr4DrpkJA+9VkRNVHGRZ3FVPurTpO4K4r
         yQBQpSOzJ8VsSTclxi4BCY3nu7XNdlz27mx+T4hKhBBOZIuXla3QWiyJ6BUgWUcvDou3
         56J0BRMytJ3KW5odzX5pe5Cm1v07kajppbSwuSI+rC1N2Ud2nJ805AndQJqZEf46jPe0
         518Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ta2pdETCA4V78AHAgC1fg/YuSQgrXosSdhSzsXnusQQ=;
        b=MVeetEqryHB0caqv629aR1hc74/GkBP/djl6wYXUUCodNgVipao+1itBtTSTAYivHl
         etd6d8VmsYsI0ddunC08V61cc1o7jyjU4fn4iz/ukqbiZ0GoexSKXvCr9S5TmwcoFHGH
         aQUSFgYwznG923UyMtLh39mfW0BCAL5eApmlqDxEw3AKmYkrMswrvQ2kZLeuECclwSFO
         eTW08JlUENjv4+NCXSTEIEoMvURumEE0GAHqJH5CfEH7+d3WeR6lo1jIJ4To5VwGTCyv
         zEnWI5K2aqmDmN246/vhwMpoo9+TohZddf9aN4CX4KbyGzetJ7VgMh0XWwNd5AXmsorh
         cWBg==
X-Gm-Message-State: AEkooutUItnyTDcnYOLfanAXztg4pJC/bGp+qxa6v08+mgkeUVly9SPjtpexu2KZikZKayXWUEebyLPAa1w/i66D
X-Received: by 10.36.227.13 with SMTP id d13mr1153348ith.97.1470697340283;
 Mon, 08 Aug 2016 16:02:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 8 Aug 2016 16:02:19 -0700 (PDT)
In-Reply-To: <xmqqwpjqdh7w.fsf@gitster.mtv.corp.google.com>
References: <xmqqwpjqdh7w.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 8 Aug 2016 16:02:19 -0700
Message-ID: <CAGZ79kbf-VA3rg7U2JFgvoB84E=ZC4eUPYGEsCLFqY7QBSM3Mw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #03; Mon, 8)
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 8, 2016 at 3:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> * sb/submodule-clone-rr (2016-08-06) 6 commits
>  - clone: reference flag is used for submodules as well
>  - submodule update: add super-reference flag
>  - submodule--helper update-clone: allow multiple references
>  - submodule--helper module-clone: allow multiple references
>  - t7408: merge short tests, factor out testing method
>  - t7408: modernize style
>
>  Waiting for review discussion to settle.
>  cf. <20160806012318.17968-1-sbeller@google.com>

I will reroll today with a totally different approach.
No need to further discuss the last 2 patches.

Thanks,
Stefan
