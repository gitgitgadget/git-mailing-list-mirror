Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA47C1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 00:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeHUDpN (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 23:45:13 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:42868 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeHUDpN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 23:45:13 -0400
Received: by mail-pg1-f179.google.com with SMTP id y4-v6so7590478pgp.9
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 17:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ct9i8dx3HqnnvcYD9GwrrURUbF2fiyXxFiBI9Vo7GTs=;
        b=nfVoGK3BrxXptSCfnfgWG5ALSUhOCWNRKUaBXkxuBIhj+HiWaNKib0eD8kBt+57uOw
         iriKTrhNPt3dhKfWsdME7VlHkf2EOXyi2N9BDp4KIOwbt7uOnk2uMuigbcjN7DU94ASu
         CSBphIi49qbAaY+932eemN6+q6w3gXWZ1K6LhWiXfkTOINPoKuHcSrjt9VLWWIXznahw
         ssbmdnkudNVyPBpF98XxhV8AQ4CMitnbnji6Bo3XOSzoZTOJ/VVjVDpYjOKjBMyHEXQJ
         ZD0GCdlT2Y3vg0xQ2Hko6TYxnpQ/yF+bO6sqZCNgWTexxRYciuYog65s9t/tzZsCOoCN
         shtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ct9i8dx3HqnnvcYD9GwrrURUbF2fiyXxFiBI9Vo7GTs=;
        b=Oj/lVK9dCRwTX16uV2tUQnelxamdndRibrq9MOkg2Vs8im+KiLXVW6BfO4ION12ulg
         EJRZGecSObS8iFtaLW9yU8Ym2DmuBWrzDmL0AFbyLCFSFIt82nFf239eDI/Zj34Kqx6b
         sMBuzqR0bsLu3Tj22kj8mStb1NW5E8SCoQSFy7Z02XIeKKkgOPOTZ1P/33VXK58HsmFW
         PZVu2RBMOj+0zK2N8eFg/GQhQa9rJNw2ZBjNlkgaIO1zL3WELEN3pPlr4AyaX6FMSTgs
         WgD4I6chPpTYDnZVB5cKjE/W0HWf8yXmYCYJxpLJmp/io9TtsrpAayKcIDy21VCI5o6L
         UNng==
X-Gm-Message-State: AOUpUlGOXR2zA+r2dGfF4tojvnrER82Vx1W75a68jIwKBUCLpG+5FOEt
        IDiW4pOsTM7QfOsT3slQLUI=
X-Google-Smtp-Source: AA+uWPyKOnPTsVfbwZViz6lvouTChbwKHb5ujlAYi6JkwUSCXD1PRFo/xOeIUcqPWUVRak6wsZPxUA==
X-Received: by 2002:a62:95d1:: with SMTP id c78-v6mr50750815pfk.130.1534811244529;
        Mon, 20 Aug 2018 17:27:24 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d75-v6sm16597255pfd.49.2018.08.20.17.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 17:27:23 -0700 (PDT)
Date:   Mon, 20 Aug 2018 17:27:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180821002722.GA174626@aiede.svl.corp.google.com>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbrv62ttBYt7nwO7E4S7wTVWZGceqE6hPjAbhPPWfRkEQ@mail.gmail.com>
 <20180820233901.GC31020@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820233901.GC31020@aiede.svl.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Stefan Beller wrote:
>> Junio C Hamano wrote:

>>>  * "git submodule" did not correctly adjust core.worktree setting that
>>>    indicates whether/where a submodule repository has its associated
>>>    working tree across various state transitions, which has been
>>>    corrected.
>>>    (merge 984cd77ddb sb/submodule-core-worktree later to maint).
>>
>> Personally I do not view this as a bug fix but a feature
>> (but then again my thinking might be tainted of too much
>> submodule work) hence I would not merge it down.
>
> Can you elaborate?

... ah, I figured it out.  You are saying "would not merge it down to
maint".  In that case, I agree, since this this is not a recent bug
(it's existed since before v1.7.10-rc1~14^2~2, 2012-03-02).

Thanks,
Jonathan
