Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FCB61F453
	for <e@80x24.org>; Wed, 24 Oct 2018 05:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbeJXN44 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 09:56:56 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37154 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeJXN44 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 09:56:56 -0400
Received: by mail-it1-f196.google.com with SMTP id e74-v6so5060465ita.2
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 22:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2z98TWu2IipyRDLvU9chSDf2/GWnkwU1SwFEKw/37Fo=;
        b=Qzc76ApxLFm1uDhWTnU5PqaOxVE2Amd0DyK11xlZouHSVRfD26/Zm/D6SyF1td13QG
         sySdam3dxKzT9azvz5zJSTedhjT7oYHPv2pf/3RMDdKK6tauCeKCbhEUp5tR4nBfDDxP
         YtJp4kGxsmNqCwZ5rXhtn1xgIKObPNlsWBhUDngHCyl0TJ8572+yVKxZgIRxcqo+5gFS
         9C77GjyRjkz45bHDSCDbz2wDGvomOls/OQstY0VSb22ezvZ+DIm8tC4AM/mIvK3aqCjc
         6cxPZXLruYsk3Z4PUWK/d6KU04MKpqiNQvgsn3WkK2ciLfLgBldpGhlgCSAo2hncbtsr
         8TGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2z98TWu2IipyRDLvU9chSDf2/GWnkwU1SwFEKw/37Fo=;
        b=MzY6pXLaaRVlAA8LmIPX/Deenu9DT1Gs26S5DlBjOefAVRYxkYrEwyOytI0b5LzdzY
         iS+/SaIfPATwLIAmRbYAKgqHQMi78uY12ySdCOAg/ud75qyTu8tbnWdJywF8ZmPXwnCx
         7iwk2NGPc8HZ0UQoaHWuum0TW84p9jeRbKzeM1tb+0VABrhl6C+HcvR9h77qZY4IryVX
         cSuO/2Q/SbhtEwvEf/GPTazLlMTMBGznXkiY1dYN5RrqtVAgvPoe/6uWtMgbqNr2LiVd
         33k/ClTNy7zLoqxuj4pbGBogyOa4GUeR5UX8p25vq1gVC5cXKG6zNvtXEmEIyP+rz3cQ
         BroA==
X-Gm-Message-State: AGRZ1gLoHH9s317yPjCHcR48j9TrC3uqCRCOLwHNRt63dLAbzH0hymdu
        gyIc+wykFqtYiN/ybwfOQzQ=
X-Google-Smtp-Source: AJdET5fEG3bg+aeAzizkwdeTSW6UxpKWrkR2GqeNCwGK3fladK7liioXGWgw+v+q1TL/MjqmtnBkUw==
X-Received: by 2002:a24:9f42:: with SMTP id c63-v6mr610740ite.165.1540359024065;
        Tue, 23 Oct 2018 22:30:24 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id n187-v6sm1663957itb.17.2018.10.23.22.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 22:30:23 -0700 (PDT)
Date:   Wed, 24 Oct 2018 01:30:21 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com, davvid@gmail.com
Subject: Re: [PATCH 1/2] mergetool: Accept -g/--[no-]gui as arguments
Message-ID: <20181024053021.GA14408@archbookpro.localdomain>
References: <20181024022500.GA29011@archbookpro.localdomain>
 <xmqqy3aond55.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3aond55.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 02:10:14PM +0900, Junio C Hamano wrote:
> In mode_ok shell function, we seem to be prepared to deal with a
> case where neither diff_mode nor merge_mode is true.  Should this
> codepath also be prepared to?  
> 

According to Documentation/git-mergetool--lib.txt,

>Before sourcing 'git-mergetool{litdd}lib', your script must set `TOOL_MODE`
>to define the operation mode for the functions listed below.
>'diff' and 'merge' are valid values.

so I think that we can assume that the one of diff_mode or merge_mode
will return true. In any case, it seems like the rest of the code was
written under this assumption so if this needs to be changed then the
whole library needs to be fixed as well.
