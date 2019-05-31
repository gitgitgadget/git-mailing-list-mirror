Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39431F462
	for <e@80x24.org>; Fri, 31 May 2019 15:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfEaPF2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 11:05:28 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:41527 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaPF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 11:05:28 -0400
Received: by mail-wr1-f49.google.com with SMTP id c2so6749998wrm.8
        for <git@vger.kernel.org>; Fri, 31 May 2019 08:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=e1ORrax1v3mE5mJvHqnGhgVqI+2yQaxdDYWgABmBpZE=;
        b=LS6aoiCxLa92ps+BHmYkSpkR/KYH7Vju/sPeuff9RUHLX6g4eKgJ/Yj2IPMjgnZEIC
         j1ZlZ4sSerdCZ8fSsT470yEK5PYrsdVMZr6eGGWA9AI15SPEEnuLZBEB4bM+wnLi0QSp
         kvmc8vFN58dhZ3SWeVvBYkw2GrvJ8leYFq24swvUn1TTUeyO0aUwPFG5K6i3kUteMVsl
         al0c/hujMQXxRYYShSwInj6371X8m2BsRfnuIlOfrp2BM/0T64CtkfqPpRdTMgnUzMN7
         /E39ta5URv7uHxTT3T3llyUbS0s7s7gy/tpk+PtkQx7M0OB0Z0DPHz2J/gYKa0jL0MtX
         2EmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e1ORrax1v3mE5mJvHqnGhgVqI+2yQaxdDYWgABmBpZE=;
        b=nc51gN4QgY8xQ/M81l29jusgMB6tYSXq6rgs42EIaiUW+cf8diUgwB/9VZdRAciUiy
         1gmDWs4/vTb6Niddj2bYl3g+yvvMnOKppvmvIxhh9MkD+Qfk7Sw2M7VfZwtKtsS4RtJm
         jGmF5qdOW69+yx1wAqDl8Oi4inUIlGFk16Eh3LHs9slJSLGWkQn9USzPdckRp8ReefEO
         hyU5/ZKmLp5C+Egquh+ArLiEjqnfjG7yrsLbAAkB1N9hFHlshv9QPMaTk3F2mMfWcBTt
         id9xToXOQ8sSQ/G0GFyUGYTCGgt5NYmP2nmb3CnfwQTRKYwjXo5gEfBP7o1VUdXQnZ4Z
         pfDA==
X-Gm-Message-State: APjAAAWRnvf8bfsm655e1l0UsKRGRmv9VpjP70QQemDLWeCKGBjUY89Y
        krlu+KJtx1XBol3hQuID9PqGKMk8fKE=
X-Google-Smtp-Source: APXvYqzccC/2BEDyGSA6pkF4dZooyg5L8xFr47nzY2rDylZKqivn0RwMxbvxd4hsGPVkykIAqznirw==
X-Received: by 2002:a5d:4310:: with SMTP id h16mr7293858wrq.331.1559315126523;
        Fri, 31 May 2019 08:05:26 -0700 (PDT)
Received: from [192.168.1.13] (adqg48.neoplus.adsl.tpnet.pl. [79.185.140.48])
        by smtp.gmail.com with ESMTPSA id c2sm3284776wrf.75.2019.05.31.08.05.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 08:05:25 -0700 (PDT)
Subject: Re: Simple shortcut for "git push --set-upstream origin
 newBranchName"
To:     Cliff Schomburg <clisc@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BN8PR21MB1156ED141AE2662BC5328A22B7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156F593DAEBD7194DA7041EB7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156DA1893F64814F1BE8709B7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156F7F3E7EFF9C8A60F33D0B7190@BN8PR21MB1156.namprd21.prod.outlook.com>
 <ac62f96f-0ebc-2dff-3365-781e6b9142a3@gmail.com>
 <BN8PR21MB115693C381F65E97AB65FA18B7190@BN8PR21MB1156.namprd21.prod.outlook.com>
From:   Patryk Obara <dreamer.tan@gmail.com>
Message-ID: <ebc03b4e-daf8-d47f-94ca-a4a549589773@gmail.com>
Date:   Fri, 31 May 2019 17:05:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BN8PR21MB115693C381F65E97AB65FA18B7190@BN8PR21MB1156.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/05/2019 16:56, Cliff Schomburg wrote:
> Wow, I did not see that in the man pages... but I see it now.  Thanks!
> 
> So I guess I would change my ask to this:
> 
> "git push -u"
> 
> Should default to "origin branch" if no parameters are provided.

I think most people will agree, considering it already works this way :)

The default behaviour of git push changed in Git 2.0, perhaps you were 
reading some old tutorial. You can configure it to match your 
preferences by changing push.default value in your git config:

https://git-scm.com/docs/git-config#Documentation/git-config.txt-pushdefault

--
Patryk Obara
