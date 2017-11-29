Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0BF20954
	for <e@80x24.org>; Wed, 29 Nov 2017 01:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbdK2B4O (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 20:56:14 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:32897 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbdK2B4N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 20:56:13 -0500
Received: by mail-io0-f169.google.com with SMTP id t196so2103502iof.0
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 17:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YOSOMUSyqKmKWQYawo+A46SfU/LTDj8Axxeuhy1yF8Q=;
        b=F0CE5BfcGcswsdiAccXurqRLK6GyNU+xHWHsEJQKtG9NB9DUaLmke5X3nxZfWJPlmB
         tRPBh71jw3YBLmTCvgHl7H4XaXyOxqOn6Dt8lAIP6S2+LM5CaA5W+zMCsCWfAXuPXirs
         Za4/1lEQwrsnLGUccQx0PJZd2LDXHR2Ejuk3Mgw1AZ4uqOskJNQI6u8bJXEnDSgw7lTE
         HIfEqjOjXufwJ/b7Iv58/NU1h2pr6uDomX/4/Tu9Xg1pkR8g6Du3ylv8DMNU/RUM/3Bi
         zlEgpfVPXmoC4QTyNSz2DwmeLBnMzOhMaApUetC1JQX48tiRDUWhDwdgnvKT2Qi9TRX4
         /QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YOSOMUSyqKmKWQYawo+A46SfU/LTDj8Axxeuhy1yF8Q=;
        b=H+S+HZurAfELM6OV6LmtejnOp1+6tNAFRS9JCN9ZDLbn0lvqHD2PfoqjNEtM/Cr128
         EuCVb83tvXgY6glc76bAxPUApvmL+R6LBBqnSk4gBiqBgFwGxN9xX1wYi99VV/AZwYH2
         Mo3s2Y/dR225tee5gSigguRrUVNaMtkgOoXdFhJLAU1bVE51mi0bjax8klE6/W2PrZ3P
         y3gN5vgcS4Ja5Unm+Kb5uKjvjF3b+DD0OND77haTuNeEJPSwLNFJXbcdBLyNihhUgwpi
         e0MHzth1kIQGmPb3jA08/dY87AjifrB413AyWQUqgnZIBeVrO2lWq6M3n+CFBB1vVzsA
         GU8Q==
X-Gm-Message-State: AJaThX57r5nFCTonj0O551R23V8WNJ9mkTH+0HhOl3JF3ea7LPkksLy7
        ifN73nLZtd/kYjJ23gXc6GU=
X-Google-Smtp-Source: AGs4zMa8EfP87j1RzZeTF7fgDrBbztAmxsliOTZCB7say6pIc0jJDLMCnAo9YM2hTUI51D8yZhximQ==
X-Received: by 10.107.30.81 with SMTP id e78mr1516616ioe.130.1511920573045;
        Tue, 28 Nov 2017 17:56:13 -0800 (PST)
Received: from [192.168.3.104] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id v126sm278124iod.45.2017.11.28.17.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 17:56:12 -0800 (PST)
From:   liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH 0/5] rebase -i: add config to abbreviate command names
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <xmqqwp2ccn2i.fsf@gitster.mtv.corp.google.com>
Message-ID: <02d5cf10-7c3d-c5f6-fa9a-6b440c6a60c6@gmail.com>
Date:   Tue, 28 Nov 2017 20:56:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqwp2ccn2i.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 27/11/17 12:23 AM, Junio C Hamano wrote:
> Liam Beguin <liambeguin@gmail.com> writes:
> 
>> Liam Beguin (5):
>>   Documentation: move rebase.* configs to new file
>>   Documentation: use preferred name for the 'todo list' script
>>   rebase -i: add exec commands via the rebase--helper
>>   rebase -i: learn to abbreviate command names
>>   t3404: add test case for abbreviated commands
> 
> I didn't send any comment on [1&2/5] but they both looked good.
> 

Thanks for reviewing this. I'll go through your comments and post a
v2 shortly.

Thanks,
Liam

PS: I'm very sorry if someone received a few copies of this, I'm
having issues with my MUA! Hopefully, I've got it right this time...
