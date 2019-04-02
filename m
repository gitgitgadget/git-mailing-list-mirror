Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88A8C20248
	for <e@80x24.org>; Tue,  2 Apr 2019 00:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfDBAw7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 20:52:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42278 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfDBAw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 20:52:59 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so13042697qtc.9
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 17:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RVFvgKS2SbC5sEVOpkaU58C1uhMmJlVpRjaie2pIchs=;
        b=gLGtF+E+/X+oxGSliUtetICyiscBh5+PAnmdtZnpkWNQocj+1GUuUv3TwexQibgaNb
         ejwQufALjlEDowM0ZTl2lZcNJEtctZExtu+yTGKeB17zmG5hxqzbVrWrZiVxRI1DuQH4
         dWxy/WbyXi9+6mpYE93KgxFcArYq18WzoYCrCQilRcajCBiEVdIaQfM8x/+Rq1XNQ7cH
         apm/4L7NdVaWM6JADW5WOocT48sKuhResS2v92KYi8V0PFhzwePw4mUH79ZHEuYaq4HS
         HptSde2qTwRatabhqkr+lpDhaIsffTxIFD0eG1gNtwzpnoSkpqtQMx3DY8Xt+J/Y60GA
         JkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RVFvgKS2SbC5sEVOpkaU58C1uhMmJlVpRjaie2pIchs=;
        b=pUCnOqxXagpflyVneRsGTD8bTt5fVdzhODRoeNv/wFZpxy4vjJbPl1srKYhlOCfreR
         dX/bKuFd8Jj6IKXA3mhyiNLPQ9OClcu5lk1boNGZBe6ueN0uStJyKX6/sZPeX8vR88st
         t1N83a0lY6GPmdjBNTdgtQh6A+751pvXjx+kJdqS52mhfC7Slllk5Y/JJhOq4sRoRCbT
         ZZG+gQH2i7Wlk9dX8ihVkbKCdHB2mjlQJdbvhSeFH+3PHJ+wA7hM5HrRgVWWtEV17ZAZ
         XgBWnRZd9DBNQ/gncYNerdGm3uypBIEny6NpbJ8n6tJ8uFaxM6E7QdGqRXPLRmrY8kDu
         naYw==
X-Gm-Message-State: APjAAAX8uoGdR7OEfRqlv72jMHLceCYgC86ahcVcLds282tar9LYd0XN
        14L0t6T5pkJQKtR5ye1TwiHIMxy2UjE=
X-Google-Smtp-Source: APXvYqxV2d1XVTYVlouJsLrWRRZx/R4rgtcpXFnnwESDK9LotbHC6EETB+nr8gMMBZ0Q5sFL6WHp9g==
X-Received: by 2002:aed:3769:: with SMTP id i96mr11861732qtb.296.1554166377664;
        Mon, 01 Apr 2019 17:52:57 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id n188sm6380922qkb.40.2019.04.01.17.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 17:52:56 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Stefan Zager <szager@chromium.org>,
        Stefan Zager <szager@google.com>,
        Zachary Turner <zturner@chromium.org>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        David Kastrup <dak@gnu.org>, Duy Nguyen <pclouds@gmail.com>,
        Alfredo Goldman <gold@ime.usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=D0=9E=D0=BB=D1=8F=20=D0=A2=D0=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Make the git codebase thread-safe  
Date:   Mon,  1 Apr 2019 21:52:45 -0300
Message-Id: <20190402005245.4983-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am planning to work on making pack access thread-safe as my GSoC
project, and after that, parallelize git blame or checkout. Or even use
the thread-safe pack access to improve the already parallel grep or
pack-objects.

With this in mind, I would like to know if the problem discussed in this
thread[1] is still an issue on the repos you folks work with (gentoo,
chromium, etc.). And also, could you please let me know which git
commands did you find to me more problematic in them, nowadays?

I downloaded chromium to give it a try and got (on a machine with i7 and
SSD, running Manjaro Linux):

- 17s on blame for a file with long history[2]
- 2m on blame for a huge file[3]
- 15s on log for both [2] and [3]
- 1s for git status

It seems quite a lot, especially with SSD, IMO.

[1] https://public-inbox.org/git/CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com/
[2] ./chrome/browser/about_flags.cc (same with ./DEPS)
[3] third_party/sqlite/amalgamation/sqlite3.c (7.5M)

Best,
Matheus Tavares
