Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E9C01F453
	for <e@80x24.org>; Wed, 13 Feb 2019 21:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436697AbfBMVMa (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 16:12:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40387 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436689AbfBMVM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 16:12:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so3950080wmc.5
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 13:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ENxT7i2qtlH/df8HXA16wJftCj7Ao8TCcRfcoOCd9ws=;
        b=j3S6zGf6v+mgo+K1AJUoVeUg43zhMNnBzV7Mx9r5QQ6nSVcuajov1ydsnaUN3QcQHO
         rUu8bcFzLKOju8Yi6bfpR2hzflYRmIVL7iBSTJJo8W2zGANxXT9SawIcLE2/VaDOhFuN
         hoVoKgEMqxdzOGvUD2hSJIGQh2yZH355jH2HUvUf2VMYVPOWqUalsFx3X97DHZMJmsz4
         mWgN5uCQouErKWUPfMVjj3aViBNLcNDx9He7yNO6xukj2FRHWqNgCv+NYQFfchAfWqAj
         pCdb1+/4uQjacgMBhbolaP7Ha69qRErJP3KzZqAygcOvC/pIPZgxAxHg6h+1itq6dCSx
         N4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ENxT7i2qtlH/df8HXA16wJftCj7Ao8TCcRfcoOCd9ws=;
        b=Kg/ZJHkBvnFTSSZiNDNJNv6QyZuXWcErB3jn7xA4i0tTGmOLaMXW/pGbh923VstDtU
         16x2lCML1/n6Sl2ZVv446UnLAlh8loToN1yWLA1CQ3PtOjLyx0OGHTRT5BXV+tS/e2K3
         1dRWroO69nhR59P+A9wl8hndAFtnsYEGA7HjBcHpHZkEFoOzGZ96VmBzoufzp9ONCELE
         gF9+1DSQKiTGmhPubmYyrXVh9bPyIO3Pv388oRaMqgDvmGK+pOj+KAJ6OYcvrzIZuFoz
         fpDUvPP9Y5hSUK3F2YYmgIB+u01kpx7QL+bMsRDUBbhD9vpJyBZ4U05RWeaalp7xv6vJ
         k/oQ==
X-Gm-Message-State: AHQUAuZh58QlI7o+2bU4nmAumCYCKG71b3j1hFTX6KQNG0BBB2XCEdft
        KU8Ak6tOFNisQI3ymFh61cw=
X-Google-Smtp-Source: AHgI3IY01Or2+uW2SaxNW3uEBtS0CTOGVnFotwsAfTt+ELUklBv7pdbbNHpDU4ZGL32of46Q/KjRDQ==
X-Received: by 2002:a1c:67c2:: with SMTP id b185mr96901wmc.96.1550092346878;
        Wed, 13 Feb 2019 13:12:26 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u184sm497506wmg.45.2019.02.13.13.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:12:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git@vger.kernel.org
Subject: Re: How to get next commit that just after a specified commit
References: <87mun0j9vv.fsf@evledraar.gmail.com>
Date:   Wed, 13 Feb 2019 13:12:25 -0800
In-Reply-To: <87mun0j9vv.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 13 Feb 2019 10:49:40 +0100")
Message-ID: <xmqqimxnbdfq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> (Replying to
> https://public-inbox.org/git/383c14cc.9289.168e61d39e8.Coremail.wuzhouhui14@mails.ucas.ac.cn/
> which curiously I can see there, but not in my inbox (or spam))
>
> Git's data format doesn't make it easy to find "C" given "B" in a commit
> chain like A->B->C (also there could be any number of "C"
> successors). We need to walk the graph. This shows how to do it:
>
> https://sqlite.org/whynotgit.html#git_makes_it_difficult_to_find_successors_descendents_of_a_check_in

Of course, the history is not necessarily linear.  Even though you
*MUST* know all your parents before having a commit (which means
that when you ask "what came before this commit", there is a
definitive answer that everybody in the world would agree on), you
by definition cannot know all the commits that are children of a
commit (simply because somebody else may be creating a new one), so
the question "what's the next commit" does not make any sense from
that point of view ;-)

