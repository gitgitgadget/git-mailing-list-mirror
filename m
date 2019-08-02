Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98ECC1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 19:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392189AbfHBTQN (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 15:16:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51251 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392182AbfHBTQN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 15:16:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so68963578wma.1
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 12:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=i1dHPdOvpgJTQhDilN8ZU4jxmuoH/bPUI/CCNb0wdZI=;
        b=ljRxuamx7eBSH4Jpwh4G2SZMZgG9ScdgR7OS42LiNEBKiahUBUwahkQY8fEFLXLwUT
         zq6XIQmeKxAkaIp1F7/anrf+Ovofv926StcIyU+DNDek2w1C+KgtT1MjPw15AEzxMHXN
         u/sIr969gDIHVrO+GGzZsmv362jSBGFLyPze09fh+le7Bdru5Q31t5lowa5J1cNtFWld
         j7/it5jpOtjm4V7oXRL0GbyGEx0rK8nKEdKksmpBFitaP44UKiv2OIFKOhGNOoEEU39A
         yHxonGGg6EwbjlTkk7x5Wuuld81KsYzOjfXO9Eyf4eIPCYDMylyFtt6Ch9z9PuFJIOO/
         mzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=i1dHPdOvpgJTQhDilN8ZU4jxmuoH/bPUI/CCNb0wdZI=;
        b=BMAvKkvWqGywks5EVHAyCD0iLNOjQ39nmf3frToSIVLPGdPvQOiTN8QwqKBkJ2SrD8
         NLgc0Z6199ttOmS5vPcbPKJu6Y6DN0hcpEJ05378r7n/RSMmnaTnpsJlb6Q9DGyTJuf9
         foMLpz6GHia9MIAmNx/XfpmtfkDWFRG9Tt+zvLdApjtfWh5WENQR2tSbmqMB4ByrUiaU
         YiN4MljVtZM98RygPYxrcTWUFx3XtvunWkvy84dSZINe0IZf2s5TblmM3gwQk1puxrlZ
         I+j0Zc4ne9GHg26XntuYZ1qbu+xbKi9KUDEoZ7+gihlHXd1Y6StaIY582rWydF0oa+s1
         vzjg==
X-Gm-Message-State: APjAAAWcOUWOfdrPTYXBwMpJXg89WVVAIx0tBYABhHBOpgsxAyBmLa8i
        q4WtDiRTrsV5Aj3SpPHCDjg=
X-Google-Smtp-Source: APXvYqwYJ/9eN+ZYoj2FQt2v3lJpN4fJRZYt5ImPX8JJGeyARKjIUgy9tok0g9LU+t/PQi4J5WhzTQ==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr5750489wma.41.1564773371083;
        Fri, 02 Aug 2019 12:16:11 -0700 (PDT)
Received: from szeder.dev (x4d0c4277.dyn.telefonica.de. [77.12.66.119])
        by smtp.gmail.com with ESMTPSA id 5sm63394632wmg.42.2019.08.02.12.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 12:16:10 -0700 (PDT)
Date:   Fri, 2 Aug 2019 21:16:07 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
Message-ID: <20190802191607.GW20404@szeder.dev>
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1564009259.git.steadmon@google.com>
 <20190725234229.GM20404@szeder.dev>
 <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet>
 <20190726220348.GF43313@google.com>
 <20190801180829.GP43313@google.com>
 <20190802015247.GA54514@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190802015247.GA54514@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 01, 2019 at 06:52:47PM -0700, Jonathan Nieder wrote:
> What do you think of making the validation disabled by default and
> using a parameter (see "Running tests with special setups" in
> t/README) to turn it on?  That way, it should be okay for it to take
> 10 minutes because this would only affect such specialized workers as
> choose to set that parameter, instead of all of them.

That's kind of what the third patch in this series already does, as it
performs this schema validation only in the 'linux-gcc' build job.

> Gábor, if we introduce such a parameter, do you think it would make
> sense for us to set up a worker that passes it?

That would be even worse than the current approach of the third patch,
because the additional worker would have to install dependencies,
build Git and run the test suite, in addition to the enormous overhead
of redundantly validating the trace output of every git command
executed during 'make test'.  So instead of adding "only" 10 minutes
to every build, it would add over 20.

