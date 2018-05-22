Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE521F51C
	for <e@80x24.org>; Tue, 22 May 2018 19:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeEVTPa (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 15:15:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50210 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeEVTP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 15:15:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id t11-v6so2669201wmt.0
        for <git@vger.kernel.org>; Tue, 22 May 2018 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=etseYvJTcq/dPHFSB9G7QjbxmoUVJImKZ4b6IWfuJ/c=;
        b=AaMvwilw2mLhPUEE99h19ZwRw2tI1fxM590kItsWgJxZ61Mn35pjV9/ttQa0J6m/f9
         uhPWRJvpvRr80+tvUpCciJTeiTmMY3s5HIPs1GVzkOJQZogxtMQHDHI40uNGeIvnTHK2
         DrnBaN4vB1X8OUDXJlwsUyjW6M4H12czzd4NSzgac3LbdBRw3XwIJ34eparQp6HeCL2H
         3CDAVNKf8Rl6QFexZjPBkhaV3PFgA6yntxZIH6HnDfKoW1FkaVoCa9FUHdUA4sF8xN1Q
         XabwMQpW1nmFJRICocyGTFX9lG5of0Wmv8YKdzI+LtpzS9ImP+rrPoeQRWvyhxjQZ3RV
         LB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=etseYvJTcq/dPHFSB9G7QjbxmoUVJImKZ4b6IWfuJ/c=;
        b=k16IBw2IsbT6OLc9+qPFNel60EpqNvNbUiQPN8hncozDzVa/Xz1+MoeE2w8u5viKd9
         fcZSldEHqo3kFehVAxThE/XKgGExWDp0LZwpNC9q3jgs6hpSqnZQOsqHeyN5zcJ8FyKj
         WQx1Ndcuzk7NRWzIllth7RpwDJNP+Xw1O+1dBGTDsqJXtby4tnINeFIm67TpvEX9CLMc
         xm+7gNE2A9ad6mOORgtbsOuMPKQG25WWII6GVP7hVthFf45vihkD05mKzgTjniO7ilNi
         MnNRdA30MZ10l50k47B9OZ3USH/epWYYbeVaSc71lFhsCy3dDnp9ZytTpIrStoOBhTYw
         M1Jw==
X-Gm-Message-State: ALKqPweSkEUZEP2bRKj/GLcmGM+lWmdyS4eTf1rFVUkHHSNIK2m/xdsr
        H11tXZSYOl59gExukFfyAx0=
X-Google-Smtp-Source: AB8JxZot8vHKjqP4HYQmiecaSdBKtgnkkel/c0Lx+k3+qHWDF1k/hBqRgPJCs+eYKS+nCcOz879V+w==
X-Received: by 2002:a1c:c1c9:: with SMTP id r192-v6mr2030046wmf.120.1527016528698;
        Tue, 22 May 2018 12:15:28 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-38-64.w86-221.abo.wanadoo.fr. [86.221.117.64])
        by smtp.gmail.com with ESMTPSA id v12-v6sm588642wmc.35.2018.05.22.12.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 May 2018 12:15:27 -0700 (PDT)
Subject: Re: [GSoC][PATCH 1/4] rebase: duplicate git-rebase--interactive.sh to
 git-rebase--preserve-merges.sh
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Wink Saville <wink@saville.com>
References: <20180522133110.32723-1-alban.gruin@gmail.com>
 <20180522133110.32723-2-alban.gruin@gmail.com>
 <CAGZ79kaTPu=z_6oJk__meuyhUt-pU_LtOJ90rPTQcC=YvhnOnw@mail.gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <a3d0d6f6-c6c8-ad70-4e1a-7804dbfa1b35@gmail.com>
Date:   Tue, 22 May 2018 21:15:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaTPu=z_6oJk__meuyhUt-pU_LtOJ90rPTQcC=YvhnOnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

Le 22/05/2018 à 20:26, Stefan Beller a écrit :
> On Tue, May 22, 2018 at 6:31 AM, Alban Gruin <alban.gruin@gmail.com> wrote:
>> This duplicates git-rebase--interactive.sh to
>> git-rebase--preserve-merges.sh. This is done to split -p from -i. No
>> modifications are made to this file here, but any code that is not used by -p
>> will be stripped in the next commit.
>>
>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> 
> So how would I best review this?
> 
> I applied the patches locally[1], and ran git-ls-tree on this commit
> hoping to find the same blob id for git-rebase--interactive.sh as for
> git-rebase--preserve-merges.sh; however I did not.
> 
> So I diffed them and had the diff below[2], which looks like that has parts
> of Johannes recent series?
> 

Thanks for the heads-up.

I started to work on that patch set on the master branch of git.git, and
I forgot to update git-rebase--preserve-merges.sh after rebasing on
Johannes’ branch.

So I’ll reroll the patch as soon as possible.

> Thanks,
> Stefan
> 


