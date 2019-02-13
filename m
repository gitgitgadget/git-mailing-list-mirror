Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE6311F453
	for <e@80x24.org>; Wed, 13 Feb 2019 09:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbfBMJtr (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 04:49:47 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43291 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfBMJtr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 04:49:47 -0500
Received: by mail-wr1-f43.google.com with SMTP id r2so1685842wrv.10
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 01:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:user-agent:date:message-id
         :mime-version;
        bh=lXBFgkIWomBr8vyJjDkl6CLyGlHXd1W1+lENKaxs5X4=;
        b=otN5JNgg51xx3gLTCYHIFxISWQeL/BAOjSV8L5w8RhJx7mIby+OfFzL9ItQWdLa39F
         XVaFBmtHj6w1zl8TM+GTHWpGGB0+ZBO6v4fz1ItW6uQnmg4T/54WAScRGLtGybYaNNnL
         QfkC1U5YCpNTLY+3p0MrkTAvwjickg5pEGXo71yl3ELEytclHKgoW4bbn8Ar0iPWp19v
         r6GFrR7HMO233UA/EIxX+1DZdg7AbaRM0ExrO7zixoo66NxWUxlNkirRoQWM1uNDGrwB
         IK7SdySCr8+4368FKt/vsKQMV+3uBYO5UZstnhaM6fsNqZiEueU9k9++9/1rAX1gr49F
         D8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:user-agent:date
         :message-id:mime-version;
        bh=lXBFgkIWomBr8vyJjDkl6CLyGlHXd1W1+lENKaxs5X4=;
        b=tvz9HMb0Y/1FtquyJ0BUYUi4dMbrAeR3+402UKdvxFME116hs2+0D2Qi4TcdFfQZQE
         +Ra4NFgh2ZaRLGbrkVIzCupVGuzwONykok1PW6CcJu42i9065IvMRfvrfYqBk2bg9rEU
         Fbg7LuTlepbrD+lTNYfRmSMTd4ChEo11pGTWROm29kIzjnJs3TezHnzlezKd8kTBdqIQ
         QkxjFGAF0I8UUkdaEREI9JC8S8bn+TIQimYwaPJyzWTBJwYPzPGQJedrg6/xZug3HwJk
         uK8hjPFotsmFUoQaQqtkxNvgXMEZ+CVsjPkn+SA/+/YLwQ7H0NBWwlJA6DAOyqw35anF
         SZCA==
X-Gm-Message-State: AHQUAuaRYrqDtFbqAMBNp77V8mGNVw5VH09eoDAag53bhAXeASVSodfz
        vZdqQ+mh6c5hgrhzesl375gYH1ul
X-Google-Smtp-Source: AHgI3IbMZqlQdR15+EdbJ0LM3ai06vtjiToUcfDDbdS6VYSCX7zZTqVUMPOY3RxNrUyaVyFV8FzGTw==
X-Received: by 2002:adf:ba84:: with SMTP id p4mr6351161wrg.156.1550051385042;
        Wed, 13 Feb 2019 01:49:45 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id x21sm6138627wmi.28.2019.02.13.01.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 01:49:44 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Cc:     git@vger.kernel.org
Subject: Re: How to get next commit that just after a specified commit
In-Reply-To: <383c14cc.9289.168e61d39e8.Coremail.wuzhouhui14@mails.ucas.ac.cn>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
Date:   Wed, 13 Feb 2019 10:49:40 +0100
Message-ID: <87mun0j9vv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Replying to
https://public-inbox.org/git/383c14cc.9289.168e61d39e8.Coremail.wuzhouhui14@mails.ucas.ac.cn/
which curiously I can see there, but not in my inbox (or spam))

Git's data format doesn't make it easy to find "C" given "B" in a commit
chain like A->B->C (also there could be any number of "C"
successors). We need to walk the graph. This shows how to do it:

https://sqlite.org/whynotgit.html#git_makes_it_difficult_to_find_successors_descendents_of_a_check_in
