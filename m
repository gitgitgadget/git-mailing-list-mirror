Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A06941F731
	for <e@80x24.org>; Sat,  3 Aug 2019 07:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfHCHkZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 03:40:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44344 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfHCHkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 03:40:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so79390029wrf.11
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 00:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xhaCo/SIImNHGWM/XX4R5LKuR/YH6K8VeEw66f/RDgM=;
        b=NtkJOiaqMtGo7vKw8zNOVmAddxQzTsiyZEt/6h/VoIjHZ0QKwG/46canYyVGaRX4X/
         phUo2eXk6jHUcqtRcRRWOMQP9cJM/6bbjsb4TVR3sHCCaQQMhLJEaTGm1r+Ts6lTohzj
         GifJRoKTk3o5wCB1ep6Yzq+4deODvssGiEHFmu1mO7LFcLp7cDqiDksVLOVKcPOQ/uYW
         v/6NtSvXANC09I3L2VZKka2rhOsOdThzW/Di6+sEx8jE3FlhKn8CvQUDbpVilpahK4H8
         7sbL2krSuEGzV9b9YjMHymj3NeBD/sCJr0a9cO897FvMGDwLIgkf84P1ZvIIE9fhqZBU
         mF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xhaCo/SIImNHGWM/XX4R5LKuR/YH6K8VeEw66f/RDgM=;
        b=FQLctLEB+OFYlo3v7P5xS+0f/MhVDPocKh56wmKo6BAjU4dWODDbPVHt3L0rKSvg8e
         3uQj1oLYOG3XzY45swNUIDLe7gDIwxvr8folZS8Lq7WFZZnkziuBPdHw/rWgs9z8yVDo
         uuxKj1g4fzSjjOjvCWL62DYyk3r8yP45H9RSZQH7+nkn5LdO7KPZ7t80zU2PTT0ZJc+w
         4W413UWvafoj4/EvkRzA5m30iRV05aVath4fmTd5DwGubFAaUmQtqjZ0aT1bnr4/R49+
         5SUDhfX0aIrdKouSUAv3la+44hbjLmOaAzJcilUnidptApCioYsOfB8f7cLYOC06Nbx+
         xxVA==
X-Gm-Message-State: APjAAAUzonfm+UmkE8mbrL6JeGjx6lPdusagXYQT2ucus2BRae1GC7A6
        Co94XujRIrp3rOArbp7PYQQ=
X-Google-Smtp-Source: APXvYqxEYPHb2vGF6FFlxpa4d+B1U7gc/yTRhJPkGws0zC3OS/63e9rWCyDWR2pRkYgydUZ5Zk+9Dg==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr3977197wrq.340.1564818023176;
        Sat, 03 Aug 2019 00:40:23 -0700 (PDT)
Received: from szeder.dev (x4db55264.dyn.telefonica.de. [77.181.82.100])
        by smtp.gmail.com with ESMTPSA id a8sm63425167wma.31.2019.08.03.00.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 00:40:22 -0700 (PDT)
Date:   Sat, 3 Aug 2019 09:40:20 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
Message-ID: <20190803074020.GZ20404@szeder.dev>
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1564009259.git.steadmon@google.com>
 <20190725234229.GM20404@szeder.dev>
 <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet>
 <20190726220348.GF43313@google.com>
 <20190801180829.GP43313@google.com>
 <20190802015247.GA54514@google.com>
 <20190802191607.GW20404@szeder.dev>
 <20190802230650.GB109863@google.com>
 <20190803073549.GY20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190803073549.GY20404@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 03, 2019 at 09:35:49AM +0200, SZEDER Gábor wrote:
>   - Limit it to 'git/git's 'pu' branch, so others can have their own
>     'pu' branch without suffering from the consequences.
>     It seems easy to do so, on Travis CI these are available in the
>     TRAVIS_BRANCH and TRAVIS_REPO_SLUG environment variables.
>     I'm not sure what are the equivalent variables on Azure Pipelines,
>     though.

Ah, I forgot that we are kind of CI-system-agnostic these days, and
our 'ci/lib.sh' sets the common CI_BRANCH and CI_REPO_SLUG environment
variables both on Travis CI and Azure Pipelines.

