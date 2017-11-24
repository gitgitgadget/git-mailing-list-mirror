Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63EF42036D
	for <e@80x24.org>; Fri, 24 Nov 2017 14:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753826AbdKXOmM (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 09:42:12 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:33331 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753810AbdKXOih (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 09:38:37 -0500
Received: from [192.168.2.201] ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id IF7ieUSvJbjdZIF7ieEpDS; Fri, 24 Nov 2017 14:38:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1511534315;
        bh=l6/+78ia5M3kLv2WfaqIj37Rh85Hf1e237U3xPeVZSY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GdwZ53+BT1OtxHw4Ogx8Aqi2s2HGq6wRQRphdh3b3j/fyFywMMWhzRHqW56N+VikF
         cIzm+bgI3OpVzPYHo6AP25bvwZVgCTlZhiREcigyn9EOORlKiCu3bvVD9Y9Bj/rFnj
         FvyxhzV6X3zGTxGgPbfYnkvmFxiovdQUtJTslEio=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=XaicNUNpfa4iGmdvC5AA:9 a=sZZOI_t8B3bbFZ7P:21
 a=UOWPE0ha30Zqyvlp:21 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 7/9] sequencer: load commit related config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171124110758.9406-1-phillip.wood@talktalk.net>
 <20171124110758.9406-8-phillip.wood@talktalk.net>
 <xmqqbmjrn5yb.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <33de5245-828b-dca3-0b2e-13e54299a6bb@talktalk.net>
Date:   Fri, 24 Nov 2017 14:38:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmjrn5yb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBYc9MyJVBupiLRN0Y/I3E0qpaQXYwAxHjXOvPkUB3R7UQKtKB3uuxJD0vn4Cafaq6LlTYZlHQnzjtVbgcBCvvhDUQRmvIcnFsnCmIMUloSBR8RgZn/l
 pCG2SuV2PyohGExKkigJe6HF6dt46SnPj7dFQh448Aoo6RtWvkEaEFGyKyOnhIrV7PgJSIZ30d9bCMW+d+vVKCQqG8EEcNeumG7ky7mz+Qs52pEjqDpYIKOx
 T9La+y8MvluXWKL+JyFPXEit75o72WCvCtZjLHPxJfiQVpFEOu9Jaftg2oSNMBdHvWdaPoHGnkkMWu7CPYLO1Chw+P/LqwvEOvBdvNF6m3n9C8tHMZ2kkjGa
 wRj9x0nTsxGqRmD6eOe9iZovGFoSiw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/11/17 13:48, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Load default values for message cleanup and gpg signing of commits in
>> preparation for committing without forking 'git commit'. Note that we
>> interpret commit.cleanup=scissors to mean COMMIT_MSG_CLEANUP_SPACE to
>> be consistent with 'git commit'
> 
> Hmph, is that because we never invoke the editor to edit the commit
> log message?  Over there, scissors is demoted to space when the
> editor is not in use, but otherwise this demotion does not occur.

Yes that's right. In fact I'm fairly we always specify an explicit
cleanup mode when calling try_to_commit() so the default is there in
case that changes in the future.

> Just being curious.
> 
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>
>> Notes:
>>     changes since v3:
>>      - interpret commit.cleanup=scissors to mean COMMIT_MSG_CLEANUP_SPACE
>>        to match 'git commit'

