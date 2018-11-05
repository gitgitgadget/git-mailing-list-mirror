Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E8D51F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbeKFFFo (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 00:05:44 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36550 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeKFFFn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 00:05:43 -0500
Received: by mail-it1-f195.google.com with SMTP id w7-v6so14420287itd.1
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KLJz9Rv+BbkhDJH2hDHn9g4Ge37rJML+JDNMmDyDqk=;
        b=Oi2Y+RGIXrDUE5QYYqgiOKuZ2Lfd+zaneNq6UToj/Pu+EvQwbQbrolsMc7Or9g9t3z
         zsdCUHnzp+S3Ukl5W5CpyG1Tx0IBefmjjfCS+8nMxMJb2BNZYMYOcCpzzit0KVXLmtyT
         pmfGIAYZfmgiD7jwskaMPDgfJrRDJic0GTJy0yQeim9siryFfS09OU/gBQJig70H/mMI
         QLLJvey4Rk+3uId566elZe7IBHV9fy+i+yBOvxhJ6gmTxaAuoHXmbkd3swuZ37GOIs1l
         2AnzzM3dZnrzY6ZpgEKy7Drohckbs05AuCxXRw5bOBk1G2zE3eeOEmj6W+HOHPLgxsXL
         rzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KLJz9Rv+BbkhDJH2hDHn9g4Ge37rJML+JDNMmDyDqk=;
        b=oj5pcezcxVR3aoWLUijDX0xm6RjSyfGrLdDNVqySKhmkzg36ee/y5IZCKt63PujWzP
         0bFYB1n8nJSWEV2uel+0cV5gqxgLRwqF1l7o7r/DV3QzebDvGxhS/adS1rO/yXlLh9JH
         2hfz21NrxNrfBluMV3ZjZRxgyZq4GpYp+tkZKRaxCIsxaQJrvC0O50vWCjFojlW4GTmd
         o324AQ5zGY4lIGZAUAv83ar6MMmfZy714v+z9ofNaZIpDXX8WOf60/Vn4uJp/wmn43EZ
         abBIb2xB9jzhOlzMrGP7fDYTPCXYpS9LI+hpvjTYoFcKqcJS23qes/NsPF9+0oNfxmqN
         s2Eg==
X-Gm-Message-State: AGRZ1gIGM2Fmq/CKZzAsuMP4g+DDzeXMXeT/HVDJN3TcWdjtMY55jcTJ
        9laH0M1qu3IKyO2TLkBn7bpuf13CfBgZuac3ttY=
X-Google-Smtp-Source: AJdET5dydju7V04nC/jVHIFOMtb+x109Ypg/BpSoePiSqE1gSPhbHHZKlEzgSHfddWdj/Zq1iv+q4haRJtKpcic6lVw=
X-Received: by 2002:a24:fec3:: with SMTP id w186-v6mr6721509ith.10.1541447069033;
 Mon, 05 Nov 2018 11:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20181105192751.11948-1-peartben@gmail.com>
In-Reply-To: <20181105192751.11948-1-peartben@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Nov 2018 20:44:02 +0100
Message-ID: <CACsJy8DTNASgBMaoHJM2dXS5KZ7e-t+k5w-1z7Zb_B8UMpSeVw@mail.gmail.com>
Subject: Re: [PATCH v1] refresh_index: remove unnecessary calls to preload_index()
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 5, 2018 at 8:30 PM Ben Peart <peartben@gmail.com> wrote:
>
> From: Ben Peart <benpeart@microsoft.com>
>
> With refresh_index() learning to utilize preload_index() to speed up its
> operation there is no longer any benefit to having the caller preload the
> index first. Remove those unneeded calls by calling read_index() instead of
> the preload variant.
>
> There is no measurable performance impact of this patch - the 2nd call to
> preload_index() bails out quickly but there is no reason to call it twice.

Obviously correct. It's not shown in the context lines, but there's
also a refresh_index() after read_index() in sequencer.c too.
-- 
Duy
