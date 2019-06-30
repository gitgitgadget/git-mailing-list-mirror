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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C38E1F461
	for <e@80x24.org>; Sun, 30 Jun 2019 13:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfF3NFc (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 09:05:32 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44533 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3NFc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 09:05:32 -0400
Received: by mail-pg1-f172.google.com with SMTP id i18so22272pgl.11
        for <git@vger.kernel.org>; Sun, 30 Jun 2019 06:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kG3uuiidRSebeIXBeijQWR5pwWzfP0mJFT9YQvDAt7U=;
        b=gbyfe7zE0/ay+I0CFj93nZ4Vcv4hAK0nrPWXAkSNz1z+4JfSb6vTv331PhVbM29zOB
         lWM57leRsstaZc8EsVzVqEyX9wnDqz7yDmOwoWSVEP6F7BdmxRLOMcVSM2TzN+27qp28
         708k4GwEPwhakXTCCD6vCI9nm77gtrNcRVcDtMuR8VyykSg8C7zeJ5YfHtGk22cErcyW
         /duZ17x36iZdynA8X/WiTNL46SQ1wXHXCFXJ0pr3m1fS//aeEsJIfY2NohqWGuiZZXBh
         AlHC4KvLNaEXYqJlbxG6i/w4DROl+i+zPgAAXtAA7tAgj3ibLF2bgT/OsYyyNXuEf4cm
         Pfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kG3uuiidRSebeIXBeijQWR5pwWzfP0mJFT9YQvDAt7U=;
        b=UGRDSEEyT3MdT2SVw7e2kYptvOy3zC7Z4uuz3QZtbtZ5fVT12pbsnT1cORUGVnIOa2
         XUPuIIFrkOrnfzhMu/ujIWQnCfzUjI8lViOc5v8AQ4L0G3E3KNk2+0NuhwaeU+AEpNfv
         UdYODKMduSq/nn7d3xvcW5eAMlKrdbFNrh/GAlLlU04FvFaOuaJwx4SmdBqOJ3MNMWTY
         Q1NJNfdc8T3s2/6ysCg0B+1FaoIpNoiPEdJkTbSajbylpEV+ECH3T/TJyijyf93mfk/w
         +UugT8ILTwJHtmU3jmKsbwtLNutmR/ntyT+xW6ZEDYlJ4hIe0ypr/jbhy+a9cnJ+MKK3
         wyWg==
X-Gm-Message-State: APjAAAUmcFK1WrMZxGKdJTmiL6hhM8DGNCbjeK6KyyCSDRVXR0MJK0tp
        ZZC83UYrNOx+rh7bUJhRxrU=
X-Google-Smtp-Source: APXvYqzeW4RuPeV2PnB5gzJ++09u48E5o+/yf7LQ7uJ8yj17Q0l+hFj62fe4MgTZWO+YiXoVYUttbw==
X-Received: by 2002:a17:90a:246f:: with SMTP id h102mr24673750pje.126.1561899931644;
        Sun, 30 Jun 2019 06:05:31 -0700 (PDT)
Received: from ?IPv6:2601:647:cb00:ba40:f99a:b411:32b7:17a? ([2601:647:cb00:ba40:f99a:b411:32b7:17a])
        by smtp.gmail.com with ESMTPSA id 201sm9354210pfz.24.2019.06.30.06.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 06:05:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [BUG] Symbolic links break "git fast-export"?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20190624185835.GA11720@sigill.intra.peff.net>
Date:   Sun, 30 Jun 2019 06:05:29 -0700
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <25624E1D-55F1-466D-92E0-F06C1909F920@gmail.com>
References: <95EF0665-9882-4707-BB6A-94182C01BE91@gmail.com>
 <CABPp-BE8um5g98jqWawsuG2dAvO6AZcR54vrRzAkJbq+L3K6Zw@mail.gmail.com>
 <20190624185835.GA11720@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jun 24, 2019, at 11:58 AM, Jeff King <peff@peff.net> wrote:
> 
> On Mon, Jun 24, 2019 at 06:33:38AM -0600, Elijah Newren wrote:
> 
>> We should probably also make a corresponding improvement to
>> fast-import; it also makes some attempts to be smart about handling
>> order of modifies and deletes, but misses this case.  See commit
>> 253fb5f8897d ("fast-import: Improve robustness when D->F changes
>> provided in wrong order", 2010-07-09).  It'd be nice if fast-import
>> could go through the list of changes, apply the deletes first, then
>> the modifies -- although I'm not sure where renames go in the order
>> off the top of my head.
> 
> You'd have to split the renames into separate delete/adds, since they
> can have a circular dependency. E.g. renaming "foo" to "bar" and "bar"
> to "foo", you must remove "foo" and "bar" both, and then add them back
> in.

@peff: Can you give me a hint how one would perform this circular
dependency in a single commit? I try to write a test case for this.

Thank you,
Lars

