Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41461F453
	for <e@80x24.org>; Mon, 29 Oct 2018 12:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbeJ2VFD (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 17:05:03 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:45475 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeJ2VFC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 17:05:02 -0400
Received: by mail-wr1-f53.google.com with SMTP id n5-v6so8394374wrw.12
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XV5HBABI3yT8DraWa9kIsqbdcxoEUnKbkstOM05QHiI=;
        b=fO/ot8ouQyET4rqIDf30nZbVyJxEQVculQLetRijjzOfqNtQajnvCp6OXoYZ/jW9Rd
         P770/MM6PrjiGL8edVDhqYH4meQFIkBbNBWdvqZE2BBVWCpMmH68kqvqiFQ42cl9+ico
         IokRsL5SPmMkuuFzdOgi2lkv59TqaLBhzg59QskGW2cwqMzUabN7BrJWAljeBBHpffyN
         6CJkc16L+Of3Utxq+XlVZx6UOVZkO9QttsKyHOXtfEXN6FGQm+z/YJW4TFdBjNU+MnaA
         zP9OMCUYFIPgDZCkDMCzged/uiPZRPK907z59J/PSCUSd6xvjJPtobNRVqjXvOjjnnnI
         vHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XV5HBABI3yT8DraWa9kIsqbdcxoEUnKbkstOM05QHiI=;
        b=PdR53WqX9wJmFOcqW8wZHqiqEnluVBzO8PYH/CftMWZSzCNjUff0jexP7mxIXUxVMm
         x98dlFv0h6/Qbzzcp3skpe98/SfAlpyD/tDLh2bp6GeET/Vi2YZSA+L3Wu5/t5rGhydj
         03tcNK3LCs2HhI4uInxEj75dNrquP2sj1eGAq78zYG5aJ5G5ZqKgPlw1AFx+mM2iTc42
         4Qo1DhlhCfe95o72aXex3tRiqXi+mg8svdtM0iD3YawbhdMmvMSLvBTn1HCS/+KTny82
         FcsnXybYHp2N23ZaO+euP5G764kbc8uBuatCd3avFcJadH1qwtl+sEyb17FfubOxXt/c
         t7wg==
X-Gm-Message-State: AGRZ1gJGC/EjbunTv4joMzO+A5ZvsZqTaZN7tShz3YRXlPOfKzqlCQiW
        jh58baocylciuEVDIBJLcQYUpfQE
X-Google-Smtp-Source: AJdET5cakIp+LAMsRDYQOk8G1QJubfMrSPFZx7v5WQyx+FzlxVkyjvYK3mtBh3UV+93Zs1WLUpJSkw==
X-Received: by 2002:adf:ba06:: with SMTP id o6-v6mr13597067wrg.249.1540815395458;
        Mon, 29 Oct 2018 05:16:35 -0700 (PDT)
Received: from szeder.dev (x4d0c66d6.dyn.telefonica.de. [77.12.102.214])
        by smtp.gmail.com with ESMTPSA id c21-v6sm12543827wmh.26.2018.10.29.05.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 05:16:34 -0700 (PDT)
Date:   Mon, 29 Oct 2018 12:16:32 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: 'ds/test-multi-pack-index' vs. 'ab/commit-graph-progress'
Message-ID: <20181029111632.GR30222@szeder.dev>
References: <20181025111557.GL30222@szeder.dev>
 <87va5plois.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87va5plois.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 11:11:55PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > Anyway, this test seems to be too fragile, because that
> >
> >   test_line_count = 1 stderr
> 
> Yeah maybe it's too fragile, on the other hand it caught what seems to
> be a bug under GIT_TEST_MULTI_PACK_INDEX=true, and the rest of the test
> suite passes, so there's that.

I can image more prudent approaches that would have done the same,
e.g. '! grep ^error stderr'.

> > line will trigger, when anything else during 'git gc' prints
> > something.  And I find it quite strange that an option called
> > '--no-quiet' only shows the commit-graph progress, but not the regular
> > output of 'git gc'.
> 
> It's confusing, but the reason for this seeming discrepancy is that
> writing the commit-graph happens in-process, whereas the rest of the
> work done by git-gc (and its output) comes from subprocesses. Most of
> that output is from "git-repack" / "git-pack-objects" which doesn't pay
> the same attention to --quiet and --no-quiet, instead it checks
> isatty(). See cmd_pack_objects().

This explains what implementation details led to the current
behaviour, but does not justify the actual inconsistency.

