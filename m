Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4B21F731
	for <e@80x24.org>; Fri,  2 Aug 2019 23:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389119AbfHBXGz (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 19:06:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40935 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbfHBXGy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 19:06:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so36728100pfp.7
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=l8YgZWj3cO3gvonnHomAfTmmjHjyI/NhTQS9UScO0Bs=;
        b=Q6EmLV9nXrI8KGzYcX4nXYNnSnNCO7Z6aUDVUOoow2gzg1VOmovp+QMAYbpVnMz8yE
         T8JaO1rcy3WhL5uFzLNywncmsmvUdnQViwrGCRkDXFEbmkFu8HbYgcZhJW85T4xpAHW0
         nnjXx2wbGf6HQ5LbdF+tG7KS6FD49wQucFr8D/G7hFset8xHgtBbUK5cYmHxcguUFYmi
         YB1xd6mdYChIXLUfPtp1T4u+CGKbHMI6YzdGI+hIu4SGbRhf8fwzwDeli9Fx0zHNsdcz
         F3O+3KV5hBDCVXPTakVjLH9imAqV1iOuO3Qi9GH2ioTidlgwOl4/f4+jjjvYjSERJPJb
         CkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l8YgZWj3cO3gvonnHomAfTmmjHjyI/NhTQS9UScO0Bs=;
        b=V/jFGM/Yf4FsTALZdXTqJKytLVdQ3GyT6zxGwQeEJhWe1+lN0XYxVhKwIAKk8Y3YYK
         upxGekaHCnTP6n9+Ib+gssPjGFlhZrIqdXf6nsDWjXe92rBzJPi/iqkUN9eOTCqidPXy
         SuXLaCPnpJxSSZWANr8K8kmvBxdn8LxtxbXMDmZeIKVgmjyRxZF4gDVCegW+7qMLoKnk
         2YZV+1Ah/PRIrWphCx+5fObSKLkrezemdLgxHOeNvWtgA+IPsyhHfiPuXJg6lpe6BTl4
         r2kzFRZlYe9dUghhgCwvEv3K+7NIFmL3QVHFdvjxQ1NmV88DPj+TRwquHOql1fZ5eTJi
         imHQ==
X-Gm-Message-State: APjAAAUNsAfQ+yyIu4epVAVNZUp9Ywt7ikEdYKFNGEEGD/0rbIggdt37
        34q2pD6y0UcWl15Qh+549As=
X-Google-Smtp-Source: APXvYqzYkCOfBgKtfH8+XO3a07XaOukV09tf9DppoprJ2bQHVD2brWUb0ZOmnXj8N3+eXenTiGzJSQ==
X-Received: by 2002:a17:90a:8b98:: with SMTP id z24mr6572881pjn.77.1564787213723;
        Fri, 02 Aug 2019 16:06:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id w18sm97320377pfj.37.2019.08.02.16.06.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 16:06:52 -0700 (PDT)
Date:   Fri, 2 Aug 2019 16:06:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
Message-ID: <20190802230650.GB109863@google.com>
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1564009259.git.steadmon@google.com>
 <20190725234229.GM20404@szeder.dev>
 <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet>
 <20190726220348.GF43313@google.com>
 <20190801180829.GP43313@google.com>
 <20190802015247.GA54514@google.com>
 <20190802191607.GW20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190802191607.GW20404@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor wrote:
> On Thu, Aug 01, 2019 at 06:52:47PM -0700, Jonathan Nieder wrote:

>> Gábor, if we introduce such a parameter, do you think it would make
>> sense for us to set up a worker that passes it?
>
> That would be even worse than the current approach of the third patch,
> because the additional worker would have to install dependencies,
> build Git and run the test suite, in addition to the enormous overhead
> of redundantly validating the trace output of every git command
> executed during 'make test'.  So instead of adding "only" 10 minutes
> to every build, it would add over 20.

Thanks, that's helpful to know.

It sounds like if we want to run this kind of expensive test in CI, we
would want to set it up differently: e.g. daily runs against "pu"
instead of running on every push.

Jonathan
