Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED46C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 17:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbiC2R0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 13:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbiC2R0N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 13:26:13 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6AA17F3CC
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 10:24:28 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id a11so15850070qtb.12
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aAUtmQVysCrqRfqRwRNxIn4NS102Eq4xKWmATFW4kmE=;
        b=Su9jWGlLdmyN6oPtQwbsbVjuKAIHAwTsXHSLAixjc2l41wRB2shxpCM6h2yvpor+A9
         9gDSNdqnsnrAFxlLzuWnBs4hSM+VsFbJcLWE/9ZBBeVaMFYdPtfgovB1PmjcQJbV/3OX
         GUj2pxJR8+YTEXiwt6erjt6DbFv6/IhdFiJTiuYYzRW0j0qnAGQ71EcK0GSil8LCb3vN
         LBxN32i/QpC+LJJ0EAp9xVC69ScOwHsH3nlunM2Hs4a5b5R3fxO3VCRq+EBe0md/DyW2
         INISS/10m+tCM1uR2r2dmWDlR0l9KODjY81Jp6kCaXCJN01WQbEtSzDF8BkBREGDIl2T
         dvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aAUtmQVysCrqRfqRwRNxIn4NS102Eq4xKWmATFW4kmE=;
        b=p/EZInJY3EvcdPt3fIZD7F9YkkiDR5qAON3s/BuXgRwp4ZzzzI+bV1BMXwL17is9Jw
         CVcQOix0KVfkWxsUTwunrfIANGeS5qNCV6zTRNfj7M/tWGs5qt04k7sFqQCJ8qrZUclf
         tbsZluCXZMfSjHbcquhcLgu6yXGcWMiW41lrVUWBZ/R350sGlEm4OoPxOQc3tpXbEWUt
         71W5/aCZdbCwlvoDSuwrJ8lUOS8sTfSlj/AgbJXZrKN23swq40IUETBD00wvMPk/RfWL
         tw3EuYczXWnHc9PDwbRi+figZthPs7JgtsTzqwkDF2buw73lv0HpmwbgqKoArsO9ezyV
         ZUKQ==
X-Gm-Message-State: AOAM5304V/Kgc5TY2eZ3axdfS27GcOkABRrtoOn4oidVJLT9ry8IBEJG
        R6taTUzBnDAsK07OdUmtmyg=
X-Google-Smtp-Source: ABdhPJy0iGFzinTMTaBumFAXq9ehP+raBd7pJKUPRZcECmYgPc632BXeBPPhb2FOmVBiJPvgrVgRRA==
X-Received: by 2002:a05:622a:60c:b0:2e2:7b3:3231 with SMTP id z12-20020a05622a060c00b002e207b33231mr29304318qta.678.1648574667714;
        Tue, 29 Mar 2022 10:24:27 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id s15-20020a05620a29cf00b00680ca4b3755sm5406886qkp.119.2022.03.29.10.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 10:24:27 -0700 (PDT)
Subject: Re: [PATCH v7 4/4] vimdiff: add description to already existing
 diff/merge tools
To:     Junio C Hamano <gitster@pobox.com>,
        Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, rogi@skylittlesystem.org, bagasdotme@gmail.com
References: <20220328223019.271270-1-greenfoo@u92.eu>
 <20220328223019.271270-5-greenfoo@u92.eu> <xmqqh77gww6c.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <f56a7a0b-8525-c4cc-7bc7-5ac4bba59206@gmail.com>
Date:   Tue, 29 Mar 2022 13:24:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqh77gww6c.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio, Fernando,

Le 2022-03-29 à 12:38, Junio C Hamano a écrit :
> Fernando Ramos <greenfoo@u92.eu> writes:
> 
>> ---
> 
> Missing log message and sign off.  "add description" tells us what
> it did, which is easily visible in the patch text already.  The log
> message should say why we are adding them, and the rationale has to
> be better than "adding is better than not adding".  E.g. "in output
> of X and Y, we only show the names without explanation on what they
> are, which is not helpful enough" would be a helpful log message.

I might add that the prefix of the commit message title should be changed
to 'mergetools: ' 

> 
> Doesn't the change in [3/4] to include these strings in generated
> mergetools-*.txt file depend on this in place?
> 
> Thanks.
> 

The list of available values are already generated in the  mergetools-diff.txt and
mergetools-merge.txt files before this series. After 3/4 we also
include the description of the values. In 3/4 descriptions are only added for
vimdiff and friends, so the rest of the tools would simply be listed without 
descriptions. After 4/4 all tools have a description.
