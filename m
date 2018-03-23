Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D7FF1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 21:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeCWVba (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:31:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38451 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeCWVb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:31:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id l16so5917746wmh.3
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9LT2Gj1Tq109CPJ4ZhqktoGEdOfzABTTh9S8cbjOI+Q=;
        b=OIiSpxT84pVxCBS1Qf0W52uDQpu6TSD10Gl0aNRkbNEXl/VWggOCNHQ1/n75uCOoa1
         EIU88W00eLHpWcFthMBEXiVJEOQjYGEuHBAn+/7QevJY4XKVV7q9RopmegKKS8WX8PUe
         8WfdWkpSVn/at+7FChL6jAljPc78mAuhel+Gwpmh/9m/sRc8GKLzI1OAtfDRKa1m+NPc
         Bbi3RIAJScyqM8UO+4aTy2FiPwtQNc8fF5zbEEgQWxL46inzoX3bOXnvIeuHKYdtHZQ0
         tRYjCrQbGu9fGX58gDRSBzRX5vHO7WppMS/inDiWPQeh0KcTjE7FMZdAFeSx01zIvB86
         7OAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9LT2Gj1Tq109CPJ4ZhqktoGEdOfzABTTh9S8cbjOI+Q=;
        b=MrtbbJ/1xJRU2laltIkcRAEJill2drsbgMl73oQeYYRSm0KTwBRDaBoMT+9lofVD0L
         /weOzWdqjtZ1unrvdVf02kxhWEMpJ0HV+AjBrtyxPZEfv4c3ABxCUBjbxgZuKf4Z/ug0
         TE691OyhwWCHyNIj5p19Ctx2Wqd5ecIHs8H3Po7ptBYQ6f7BNhDSLnEcMvVGJFBE+N7V
         obMnP+WkeB2Ccp1JxpW8zCE0c7SiO5NBa7taItrLdDypXRXAHbxOi0bC4A8Iio26TWEZ
         WSUDxzs2+4kjXtr4MkgjoaYVqyzjaWa3TfFLHKZ9d4DnIk3fPiRosFSQiCgeT4eoiMH2
         KLpg==
X-Gm-Message-State: AElRT7HgmP4qeAaMD3tjjWHNtknyKQKEWdH+g5jUrud5p7MXvRgwYXTF
        Ae/G6vZ1KONMqYXPe3Tzqco=
X-Google-Smtp-Source: AIpwx4/0fpW8EnbDiTJW3wfwv8Qfq/415Vcs49pD32P+pOgbPTzmwRgTx3AStjMnDUV60HZx4v26rA==
X-Received: by 10.28.148.206 with SMTP id w197mr376118wmd.60.1521840688478;
        Fri, 23 Mar 2018 14:31:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p19sm14801401wrb.75.2018.03.23.14.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 14:31:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, sbeller@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/27] sb/object-store updates
References: <20180303113637.26518-1-pclouds@gmail.com>
        <20180323172121.17725-1-pclouds@gmail.com>
        <20180323183550.GB243756@google.com>
        <20180323185055.GD243756@google.com>
Date:   Fri, 23 Mar 2018 14:31:27 -0700
In-Reply-To: <20180323185055.GD243756@google.com> (Brandon Williams's message
        of "Fri, 23 Mar 2018 11:50:55 -0700")
Message-ID: <xmqq370qiimo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> > Interdiff is big due to the "objects." to "objects->" conversion
>> > (blame Brandon for his suggestion, don't blame me :D)
>> 
>> Haha, I'm guessing you prefer having a pointer too then? :P 
>> 
>> The interdiff looks good, though I'll set some time aside today to go
>> through the series as a whole again.
>
> Had some more time than I thought; this series looks good!  Thanks for
> take the time to keep this rolling.  Hopefully we can see this merged
> soon :)

Yeah, I definitely hope that this one is already 'next'-worthy; the
micro-update to ignore-env we saw recently looked good, too.

Thanks.



