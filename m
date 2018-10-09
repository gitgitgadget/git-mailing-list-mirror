Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490AD1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 05:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbeJINGZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 09:06:25 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:46445 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeJINGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 09:06:25 -0400
Received: by mail-wr1-f51.google.com with SMTP id n11-v6so237099wru.13
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 22:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X0XbjZ8UyjcouxGp0VkknZYnK9Zl06VHaaNGNzu4w9c=;
        b=ITwTDOF4Hk6D+08+3wvdWm29A4fNH9Or2hM5LPeWOJ+TqsPNQ0esrG1t0NjhQH9p3I
         z+5acJhNW/8XlDPnyvYuJ3tIdjOsHm7xu/8WNJt4Gczboux6mGexPkOoQZRQACJM1lv5
         dWYomjrp4nJvBCeC9GqexX5EdFmZ1BO+270Wcv7dEOOZX+D96tliFGB4aXsgkPbiVvFI
         Tr5tKwso5e+zlIGrjeqtj438BLPoN+/okJ9cv5V+YYMdqYs1urWGw2+qtpvVCqCmfzK3
         ODn9XzMqF3MllwSrvp3G9TRKMS1D7iNNPTmO91Mq6m0e4V0srZo7SMTrjekO8jv2Wgmo
         ZOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X0XbjZ8UyjcouxGp0VkknZYnK9Zl06VHaaNGNzu4w9c=;
        b=bFhPJhPQcD9iSBema55WFK8+KhZeBAGlGaQ7ptXTeQkbdDqkt1NkCPRSvU1dY96ugC
         35UfNMWxfRubXiMaTrf0br66TGAiETJLNOKRhOFe2Nfiwcl4Ns9lL5hCYpswsMOQQBe7
         ZpuvdkHT3f7B5LaWC4p7PLT2dZh7z+WnXkegrLGPDTKCkVmIhSRc30hd3w587idq3WuF
         MrmtETcblubbwjdznIJ/bQDFApWqH1HdcSs2hv+zWMbd8lxgDla5YSiuuvS4i3p0s6qQ
         VeVp9cZL98d9V9hqyt14TG8vO5rNJlzikQPo+3tWBax6JBqeki58tYeEn+wDoQW+lFqG
         29Xw==
X-Gm-Message-State: ABuFfoi/TKiSeOGL2iBMyOg+AjhnjQ/mu5F7aGQ2i2YXlXB48dhh8bD/
        tmSTYNPoWV19V6UrkQRtcy0=
X-Google-Smtp-Source: ACcGV62toEiuB47+qb6g/lRogzlntAZOVVnVC9+UIoibKZ05eYiOyGtlXFzeDEM4t/lATIivr9K4dg==
X-Received: by 2002:adf:ee88:: with SMTP id b8-v6mr173455wro.48.1539064270861;
        Mon, 08 Oct 2018 22:51:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b139-v6sm28152386wmd.36.2018.10.08.22.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 22:51:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen & Linda Smith <ischis2@cox.net>
Cc:     git@vger.kernel.org
Subject: Re: How to handle patch series conflicts
References: <CACsJy8B1UDN26tWPvOtixSBiFF6bYP2BtK2n1u4W-tWdVeKK1A@mail.gmail.com>
        <32028230.38oFsPliiV@thunderbird>
        <xmqq1sa74pd5.fsf@gitster-ct.c.googlers.com>
        <2206767.tHxkKBSiVS@thunderbird>
Date:   Tue, 09 Oct 2018 14:51:09 +0900
In-Reply-To: <2206767.tHxkKBSiVS@thunderbird> (Stephen & Linda Smith's message
        of "Sun, 07 Oct 2018 18:28:38 -0700")
Message-ID: <xmqqh8hvr7le.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen & Linda Smith <ischis2@cox.net> writes:

> Junio - I've been working this but would like your opinion on 7500, 7501 and 
> now 7510.     
>
> I note that the the commit tests have intermixed functionality.  An example is 
> signoff tests that are in the three tests I mentioned. 
>
> I've been tempted multiple times over the last week to just merge the tests 
> into a single script, but that doesn't seem right either.
>
> So would you prefer a single script?   Would you prefer me to move tests 
> around?

The scripts themselves having the same name that is no more specific
tha just "commit" does not bother _me_ personally too much.  If I
were doing it, unless you are an obsessive type that wants to see
spanking cleanness everywhere, I'd limit the changes to the minimum.

If something tested in script X is tested in another script Y and it
is trivial to see they are testing exactly the same thing, removing
one copy from script Y would be good, and if the remaining changes
in script Y becomes more focused with only such removals, that would
even be better, as at that point we can rename "tY-commit.sh" to
something more specific like "tY-commit-signature.sh".
