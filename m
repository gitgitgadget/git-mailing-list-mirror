Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DED201F403
	for <e@80x24.org>; Mon, 18 Jun 2018 16:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755170AbeFRQrD (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 12:47:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40048 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754743AbeFRQrC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 12:47:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id n5-v6so16827627wmc.5
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7qjx80kmfVEj1xMo3pxRtlUvdmcXlM8Bk8GIEC7rR8I=;
        b=qcVf7iOZ2VKMX7VzgWqlvzyPQ6Ol4MG7uW/Kn4quLGyO3W5ACIYpThFFXTojEeFG8U
         Aa3Zu1Czv55PjmOnWWc4e7+7SFm7xMjDUvwgqrGMGwrHdZM2MZrzdtK/SILxWQYBMokc
         sJT2t6P5bnS6/PthVYiOGJilnGsaSfCJPg6gafgIfDZgwrAxWMSDbkKP9dHODkHAOD6U
         +OYnYnHftby45msbrCJNSdbAn1Xt7WgKgO8Lg07lxGA5TVAMwhG+0ozUK2aV8jaJxImM
         a54Ek1264eYbqjgkxYTMI9ntGvp3a6Gn5+17cic+yyEhHGz09uteBwQ5Di1E9eDxLU63
         M/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7qjx80kmfVEj1xMo3pxRtlUvdmcXlM8Bk8GIEC7rR8I=;
        b=e/B9S9p8k8K/WTLGmdMH0UDQGgKhZdmuwZxiPSplvYci/Wfpl3lWPNRbDXRicnQAFp
         6JkeCKeBjKaUgRkpWP4nyjV1TMnrC93GrPvO/WRtrvRnCY/mpK43Ob6IUUKl/5+Rmlgm
         GODCXXC5TlsFA7TQ/FF8HmmGh94AM/MqihBAQYSkeOC6Qje2BZKdqPW9LPz5WxOOWTTQ
         dnyjOHG8bb4znet0/w7rFuzDmfCLVXidEbVuEI2Qx8pG6jjbHg53g2L7xSBMqsK33kZR
         XvLYGc0kaF8kjj/2kfvqFhHh0gRi9g81bhD+liCeH8oa5m6sSfvkayCJwSEewdZEe2ux
         22xA==
X-Gm-Message-State: APt69E2Ue9Hx0b0r5krdk6qoDWcDyDcs87WwyF3WFwTMlw4PtjPb02wT
        amSNFkFDqMqAS7q3age5MO0=
X-Google-Smtp-Source: ADUXVKJQxLpy36e6ilGCrpT0leHrKAa1KNUfD3HnjtUBx3EDCtozk6VdPkJALZ3TBVGNS/UH+AAD6w==
X-Received: by 2002:a1c:6fce:: with SMTP id c75-v6mr8928295wmi.83.1529340421479;
        Mon, 18 Jun 2018 09:47:01 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.gmail.com with ESMTPSA id b8-v6sm16272256wrp.50.2018.06.18.09.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 09:47:00 -0700 (PDT)
Subject: Re: [GSoC][PATCH 1/3] sequencer: add a new function to silence a
 command, except if it fails.
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com>
 <20180618131844.13408-2-alban.gruin@gmail.com>
 <b23a9e30-58bf-afde-4d77-563e0b288e70@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <deae16f0-8852-4b98-dc14-705d8456f219@gmail.com>
Date:   Mon, 18 Jun 2018 18:46:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b23a9e30-58bf-afde-4d77-563e0b288e70@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 18/06/2018 à 17:26, Phillip Wood a écrit :
> Hi Alban
> 
> On 18/06/18 14:18, Alban Gruin wrote:
>> This adds a new function, run_command_silent_if_successful(), to
>> redirect the stdout and stderr of a command to a strbuf, and then to run
>> that command. This strbuf is printed only if the command fails. It is
>> functionnaly similar to output() from git-rebase.sh.
> 
> s/functionnaly/functionally/
> 
> It's not quite the same though because the shell versions handles
> --verbose where as here the caller has to put that check in every call
> site. I wonder if it would simplify the callers if the C version did the
> --verbose handling it's self.
> 

That’s what I did first, but removed it because I thought it would be
less confusing.  I’m fine with this solution, though.  Do you want me to
do this instead?

Cheers,
Alban

