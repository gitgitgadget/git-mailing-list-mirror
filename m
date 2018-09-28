Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785E01F453
	for <e@80x24.org>; Fri, 28 Sep 2018 10:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbeI1QkJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 12:40:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39174 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbeI1QkI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 12:40:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id s14-v6so5776715wrw.6
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 03:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zEv3cF3OcVvPSwIl6LkEa4srb7SpUScaw/k5Eb5YICM=;
        b=DWD9Mk6XZ8UA/tqQGbFAXE31EMTl/NHOwmc57q+ZImfQJt2IVJQkNsf486b/POSgys
         HzMHznJDaPTahoo7g5gObqfFjp/NqIsZiRg2uQWLzYnOIpNcyiiS+NL8uAJKkothqoW/
         3XKpqNAIYVqh/7CSxeAfOc9MPq/XFeIrZAOBaGfwdQD4Bpc1wwwHAK6ln5lQsIYvo/7S
         XOvotbAeBNhVag8Z1/GmNw9Hcikx9ZFzei+XQIC9cqhcfsnIJBBjZ1TT9ftA9yUbFQQy
         uHUkR1LYY/HBZl94fpL7vgJl4morghqi+uSuaKZYo53WrEe+P4D7an69eaLdYMRxKb59
         YXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zEv3cF3OcVvPSwIl6LkEa4srb7SpUScaw/k5Eb5YICM=;
        b=rsyt13sQ/wVQCstCBHvLYYDQmn3BMG6bXvZVLFtprFbNxqBMWt8Wa6gtN3YHsOfQxK
         u0e2xnuyOC/JYdq3bA3ZFBdCnNX8rQI64f+pgkyxZrCA07776fzGJtqK0PWUjIT98BCG
         hDr2SPdqMIqU8q8WPg2b1R74NTw69SzSn7rIxMmjfuJpOwlFKXlLuSO3g447o5if+482
         AdF5xsy5YAFoAtxllh1K0vFy/p8vA4szkFNRLrFS/BcYYfPMCRXdmZvw6XXdBFj2xIay
         bGs+swWNBgrKUXXE0TcDju8/AODkulpfHnArQBx58JQhjQPjCh97iLRZjeNpnPFCKMjy
         TYOQ==
X-Gm-Message-State: ABuFfog0eSAsGv5sDAP2SxcMhqdLUjpOvgrEOouyCFUyy4nH1AMHg9AE
        DPI4piIRgabBHmaVNyajc98=
X-Google-Smtp-Source: ACcGV637cHozm72F9xplfH66SgtuNyOXorw75JYKGTaHXPN8e6t34f05Z2QeiizcTHRDCExV9F5i1g==
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr3753605wrx.310.1538129824058;
        Fri, 28 Sep 2018 03:17:04 -0700 (PDT)
Received: from localhost (x4db1ef73.dyn.telefonica.de. [77.177.239.115])
        by smtp.gmail.com with ESMTPSA id u23-v6sm5997222wrc.42.2018.09.28.03.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 03:17:02 -0700 (PDT)
Date:   Fri, 28 Sep 2018 12:17:00 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Fix the racy split index problem
Message-ID: <20180928101700.GB23446@localhost>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <871s9fjbcb.fsf@evledraar.gmail.com>
 <20180927142336.GJ27036@localhost>
 <87zhw3hsiv.fsf@evledraar.gmail.com>
 <87k1n6hzwu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1n6hzwu.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 08:57:53AM +0200, Ævar Arnfjörð Bjarmason wrote:
> > Thanks. I had ~400 runs of the tests I ran before and they were all
> > OK. Now trying also with t1701 (which I hadn't noticed was a new
> > test...).
> 
> Ran that overnight with the same conditions as before. 2683 OK runs and
> 0 failures (and counting). So it seems like the combination of the two
> fixed the split index bugs.

Yeah, I thought they would.  If you look at the first loop of
prepare_to_write_split_index() classifying which cache entries should
be included in the new split index, you'll see only two code paths
that could leave out an entry from the split index, i.e. where an
entry could be left with a non-zero 'ce->index' and without its
CE_UPDATE_IN_BASE flag set.  Now, with the fix in patch 5/5 both of
those code paths have the is_race_timestamp() check.

