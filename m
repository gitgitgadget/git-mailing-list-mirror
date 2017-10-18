Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9722A202A3
	for <e@80x24.org>; Wed, 18 Oct 2017 19:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbdJRT4G (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 15:56:06 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:49147 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdJRT4F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 15:56:05 -0400
Received: by mail-io0-f171.google.com with SMTP id j17so7515627iod.5
        for <git@vger.kernel.org>; Wed, 18 Oct 2017 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KclUGp5szB+VW1C9oczEAdfNP2Y25ejP6BiW2I2DjEs=;
        b=mceTbYNeg1fgCH3gpo9MPATeA5mIjnD4H8A4+XoBL4GkbLgnVNskv8gKpdE+/jEc/r
         qvYLhJo3fL46WT4IRr8S/Jn9TiFgufo1ccyNysHjoa9E71f7yyUJ6dUsSEePk5QIsF8q
         r/+wcTT7bqSxM1Lk5L1Bd2x+YTPN8VlDYgOD79C+IKl6LoCDp3AfE/Y+Ml+34oruna4z
         Nye8XvBf7pf2ByTij2JNt8buPf5wJ251Rhj19e83brnRsKhzm9esxHT19THc/RsrwGpm
         6rtSlHhAWkjQNaxq/l5I+SdLSdVZgNLi4RekDExZKTfVz/krqNIjUkABAjtOaOY+XQso
         s/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KclUGp5szB+VW1C9oczEAdfNP2Y25ejP6BiW2I2DjEs=;
        b=LYPOegMbvcBIeK90IEK1RUEHuuvTRV9bj9Kv0MQnQtB7L2CtlOVrhOVIZAq4mG6HCT
         +wyEuQP3XPAY18nN8Me/msj2OEYXDKvWVEC1NOZiwl7Y+c1wVN8bwI386wjwilwMqdsW
         qrPCK2BNyLhxLpBISlVZO6g8LG4/p8b7OTYAMgaQMPBjmQD+x+dYoeAnhZNbciMjMoO6
         TaPqtun/VhfufpuwCZZ3SC2EAJeU6Znqs8j/zzxONVoqXVDKnh60jOkrduj2wwPA9nKG
         6yTv5WKFcu1mioawhClfNmxLaFlcrJ4D4wmYQe/IQQquiWDcO16pE1Nwafk025W7tm3U
         pTIw==
X-Gm-Message-State: AMCzsaVyacCmBfAcVoCwAKVRGQ+ke4uVsXXTkU9EdbNWKBzZHTy7nYEa
        Mh/Xsd+Bed7s0fQUhviNr2N/LxJIgGg=
X-Google-Smtp-Source: ABhQp+RkCspFcVegZa3Tdpxva7p+esCf4mLWpBctFbjhG1yqyEUH5VcJAdi2ePqnNj8eGq/iEhezPA==
X-Received: by 10.107.181.138 with SMTP id e132mr16905311iof.125.1508356564556;
        Wed, 18 Oct 2017 12:56:04 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:550:4cf:a88:68a])
        by smtp.gmail.com with ESMTPSA id o192sm6731138itc.27.2017.10.18.12.56.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Oct 2017 12:56:03 -0700 (PDT)
Date:   Wed, 18 Oct 2017 12:56:02 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How can I debug git source code interactively with debugger like
 gdb?
Message-ID: <20171018195602.GB155019@google.com>
References: <CAC2JkrLR=RUN01AeYGd1YpOPMv=kArm9LWGtMvJ7DS5sz7c3nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC2JkrLR=RUN01AeYGd1YpOPMv=kArm9LWGtMvJ7DS5sz7c3nw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/19, 小川恭史 wrote:
> I wanna learn how daily git command works when I run specific git command.
> 
> I wanna know which function is actually called then, how variables
> changes its value, and how some object is stored into database.
> 
> How can I debug git source code interactively with debugger like gdb?

I have had to do this in the past when trying to track down particularly
nasty bugs.  If you build git from source (you may need to turn on
debugging info) you'll be able to find a script '/bin-wrappers/git'
which you can use by making sure the environment variable 'GIT_TEST_GDB'
is set.  This will launch it under gdb.  For example:

  GIT_TEST_GDB=1 ./bin-wrappers/git status

-- 
Brandon Williams
