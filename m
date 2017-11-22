Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060ED20954
	for <e@80x24.org>; Wed, 22 Nov 2017 17:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbdKVRNy (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 12:13:54 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33440 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdKVRNv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 12:13:51 -0500
Received: by mail-pg0-f44.google.com with SMTP id s75so12856251pgs.0
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 09:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bBM3fEtMN9lBOUE/NRopBTAauh7T4HUiKpvm1LFkwQo=;
        b=C74IQOrC248Z3o0z+3xY7TNZxnnx7ldKKEtXNIKVgHjc33Fi2Sm+fTCg8LWA72Jonk
         eSSALH03D8SfCT1G8N5MQ+1GLBxCBTKycYIg9Ea8H0aT6jWCy7DKqrryylV5T2KukUnD
         FgDS8FXJwUrtVch51s4CsON8BOUPCaQqqJAvNGGRgJx01WN3Q6PLxAwCVzuyrr6QY8fu
         idulTaT7z799Ke3a/LLdctUIe1g1Lh8AXsyj0sYI3o1hR95tm+BrfYKr652EOKb17qUQ
         D0AlFWOicZVXkMR0z/DiJ64EkHhtl8Y4rn3QT8QtY57hAzbBN7mKzmhckxrTJVX5YaNZ
         pvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bBM3fEtMN9lBOUE/NRopBTAauh7T4HUiKpvm1LFkwQo=;
        b=TV3bxWIFoVvidqyS8t8Zfn0KD3YSqJwUSDLTbGuLEzJ7cCZPLpcdPcUDtDB7XWOYaJ
         tNhYTOKrGQHT8/cM6EPumYzlUykjN7YG7K4qjYmmTPPe0MHDeIEPZEH8nu2fAl9vj6tM
         0IGh+8RTCOpaqhQjy3FRfpl00cOSU23uf1LwF0JMlq2XLkunkFIqTsPRj09l0t/xjmjX
         0iiI1eqPVjdQ2NKltZepOvcKnJkhDGd3OJvI9S2RG751OCoGRPaoqtQmJJyhzfAV305u
         vrkZak1MsFDoj78uv9ryW+ns/AXWMxdRayHxvmF9fSIZk9ioPWLjojrWsn+t9CTin3g/
         oxLA==
X-Gm-Message-State: AJaThX7n9IOfc+/KyjXX+GplFfoLAEVbgEeGmoDOmijWLdXl4WerjUMA
        goJ0F4nUl2zJuUCJMUR+uCc+5sjt
X-Google-Smtp-Source: AGs4zMbFDWH0RPTcXxNs2+T9XZrSgyK1i82UG2u0zqgWobyx6dehlzZ6GYjdkDlyL51tZYQmalVD+Q==
X-Received: by 10.98.9.209 with SMTP id 78mr20027082pfj.59.1511370831043;
        Wed, 22 Nov 2017 09:13:51 -0800 (PST)
Received: from ?IPv6:2405:204:73cd:cf11:6767:b6f6:4b9c:e3f? ([2405:204:73cd:cf11:6767:b6f6:4b9c:e3f])
        by smtp.gmail.com with ESMTPSA id z17sm28639641pfd.124.2017.11.22.09.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 09:13:49 -0800 (PST)
Subject: Re: [RFC PATCH] builtin/worktree: enhance worktree removal
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>
References: <20171121150954.3227-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQrC1MiPrwwPqtdX2tzj1ntFHxO28uqnMBcmVpPPrc_Rg@mail.gmail.com>
 <xmqqa7zfxdru.fsf@gitster.mtv.corp.google.com>
 <CAPig+cTux4dfBsX3DD=5TbM-p4-t66WX3+sufi39-W5Dw+ZvOw@mail.gmail.com>
 <CAPig+cStgFaeWoNVcwaJVtNnYeLQ2LfS9xXF7uM3Py17HUaFFw@mail.gmail.com>
 <xmqqvai3ufu9.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <bc4ef82c-083d-c36b-c406-122819248501@gmail.com>
Date:   Wed, 22 Nov 2017 22:43:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqvai3ufu9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 22 November 2017 09:25 AM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> So, Kaatic's patch is intended to address that oversight (though I
>>> haven't examined the implementation closely; I was just trying to
>>> understand the reason for the patch).
> 
> OK, so the proposed log message was a bit confusing for those who
> are *not* the person who wrote it (who knew why existing behaviour
> was inadequate and did not describe how "worktree remove" would fail
> under such a scenario to illustrate it, incorrectly assuming that
> everybody who reads the proposed log message already *knows* how it
> would fail).

I shouldn't have made the log message as 'ad hoc' as I made the patch, 
sorry :-(

> 
> 	"git worktree remove" removes both the named worktree
> 	directory and the administrative information for it after
> 	checking that there is no local modifications that would be
> 	lost (which is a handy safety measure).  It however refuses
> 	to work if the worktree directory is _already_ removed.
> 
> 	The user could use "git worktree prune" after seeing the
> 	error and realizing the situation, but at that point, there
> 	is nothing gained by leaving only the administrative data
> 	behind.  Teach "git worktree remove" to go ahead and remove
> 	the trace of the worktree in such a case.
> 
> or soemthing like that?
> 

Much better!
