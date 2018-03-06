Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01CD51F404
	for <e@80x24.org>; Tue,  6 Mar 2018 21:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753747AbeCFVU2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 16:20:28 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:42373 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeCFVU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 16:20:27 -0500
Received: by mail-wr0-f177.google.com with SMTP id k9so59702wre.9
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 13:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HnhQAByJZ21QPiXJ9VnnAUwC0DJOZudIGgOT8Aa8UBo=;
        b=OLvlBHPCydwXKIZgtTGh84vuXdEIOpq1qCV/XtjwG3R9YV/S1njcs3FVEdrIeGpI1H
         SELKn08L6GDlkUI1Hw+cAfZ61T9uVSdYh6yvJevAVAlqGEPMHqi/MCM23p19fIhfrevT
         cNE+WQI++fwd0YIfSi6kjf/nsuMePv/2e3IkXvAnRKPUF9qXgqE/okVuGMcknYMmgRGt
         bxMy2jCpor2L5KCXa9Z/pPvD6HBhjjza7N1dwgsLIlSfXGQVDWwtrrdJJxg15VdGkZON
         SoeaEEKRR5+XU+0Ff12+SrCM8yCq9EIF7UE9ztw+jilJF3GO2WZr27+4nVUNVOA3TUMH
         /JNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HnhQAByJZ21QPiXJ9VnnAUwC0DJOZudIGgOT8Aa8UBo=;
        b=okAeQcbBDXkkdhKO+dttCZEoy1sfrDYX7i7iInA+RNAVZqc92qFhO7nlb7NUacFzaD
         kysldg9biVHOWTW6DNrY8T46Gp/wW4YDQ2A7dYWUizCr6DH6zPusDPFmEqfWl7mp+itH
         NAck3Ts0DdkP7NYhU3Nh1zg5mMgmpby1nlRwozjldCKWaZepsIAANLWugm/d3gdoJxC/
         QTLbrR4EPZ8Wn7pur2xNvAiz3PxqVPrrtPsldsOwZPdfzFciHEewvgxfhzkkdkSbDwfM
         2+I4Rt4ukHBmrxcfHJPaKxCf13PcQ6AKSVqtz02aPXXYSlUJZj/t5lDtjApRnguhVe0q
         JfNQ==
X-Gm-Message-State: APf1xPBj3dy+LnHhyl3aRkwJfMv+VWHuHWxDNp5zZva+wfXwHxfO1V0V
        RpW7lnurgHypEdFzaCHXFAgxIAUTyjY=
X-Google-Smtp-Source: AG47ELtJYomtBxboij9cARFI5JmqomGRPuisjyB0Svju9ECneeN71QSWgNslwTnx2JjBf4H1UEIN+g==
X-Received: by 10.223.178.206 with SMTP id g72mr16198904wrd.135.1520371226324;
        Tue, 06 Mar 2018 13:20:26 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id q77sm11555031wme.41.2018.03.06.13.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 13:20:25 -0800 (PST)
Subject: Re: [PATCH v2 0/3] add -p: select individual hunk lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Gustavo Leite <gustavoleite.ti@gmail.com>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180306101750.18794-1-phillip.wood@talktalk.net>
 <64005dad-ec23-892c-4270-b01cae74f663@gmail.com>
 <xmqqr2ow3ojb.fsf@gitster-ct.c.googlers.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <9e46f6c7-952f-c4d3-6a12-40c59baaa702@gmail.com>
Date:   Tue, 6 Mar 2018 22:20:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqr2ow3ojb.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 06/03/2018 22:03, Junio C Hamano wrote:
> 
> > A small nitpick - I see you use phrasing like "select lines", where 
> > the other commands usually talk about "staging", instead, so "stage 
> > lines" might be more aligned with the existing text.
> 
> Isn't this machinery shared across "add -p" and "reset -p"?  What is
> done to the selected lines when you are using this UI while running
> "reset -p"?  I hope it is not "staging".  If the interface only
> "selects lines" and what is done to the selected lines depends on
> what operation is using this backend, then the current phrasing is
> perfectly fine and saying "staging" makes it actively worse.

Hmm, if that is the case, I agree, but I was merely trying to review 
the files being changed - for example, inside "Documentation/git-add.txt":

       y - stage this hunk
       n - do not stage this hunk
       q - quit; do not stage this hunk or any of the remaining ones
       a - stage this hunk and all later hunks in the file
       d - do not stage this hunk or any of the later hunks in the file
       g - select a hunk to go to
       / - search for a hunk matching the given regex
       j - leave this hunk undecided, see next undecided hunk
       J - leave this hunk undecided, see next hunk
       k - leave this hunk undecided, see previous undecided hunk
       K - leave this hunk undecided, see previous hunk
       s - split the current hunk into smaller hunks
       e - manually edit the current hunk
       ? - print help


In there, adding "l" should follow "stage" phrasing, I would think.

But you are right for "git-add--interactive.perl", for example - in 
there, I didn`t notice the line (seems to be?) added inside the shared 
"help_patch_cmd".

But if so, I guess it should then be moved to more context-related 
"help_patch_modes", being phrased accordingly in there.

Thanks for pointing this out, let me recheck my comments.

Regards, Buga
