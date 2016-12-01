Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E280D1FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 00:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755118AbcLAAOn (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 19:14:43 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34760 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbcLAAOm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 19:14:42 -0500
Received: by mail-qt0-f169.google.com with SMTP id n6so205463958qtd.1
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 16:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6gyGA0mE8stJFmLq+s3PQwoe/+mK7cbDWd3tdO72wQk=;
        b=J9C6z6mWOgFlSfVC6ctw54Q9Hbm59IOym+KHLps8b7rlwmw/MJO5hNuEGy7hr1s4Qx
         HlCwUxxpL+heEHrpRbsSa+FlBmY3goZWGlnPHacANtV6o4UXGeKCopWI5HhQrdRdccFv
         gwxnz327LCR2wl7YSznihvQj1fGp1/npJlMRDhNoBG05sugx9gZjJCROfnFAAFSXI48G
         HoXs4T9vwwvqO8EuKrbLZq63EVP0dRUIhxmLCtGdhf0IUQUTmrQBMKpr1bLxDUvcLjMv
         GpZraLTfZTk6lRVexWivzvbqyc0m1JASJIIuTka1/oxHhLa/BdaoLAkYdVe5k6tk/oX4
         obTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6gyGA0mE8stJFmLq+s3PQwoe/+mK7cbDWd3tdO72wQk=;
        b=C11LZ3LdmgcMcqET5fuyl4IZE3b1QjDi/1y+5O5bxfXStqdgI7JMbU283MSicSL3nB
         mv0RxAY7nGKeQPQ2AZhEfdTd97Hyo71rvJudIvUACYD/MMTOvX65sTQ66/n/tArNGxtl
         1FxitSxmH8ZrjmaiBRGYMzGm+6hxJi36SXe2hT2+kW01u7d+I8fBSNtu+zH6Q7RZsU5I
         CtoinqiTmZJ0kkzB6UaYwysrv91yigbkQTGOtcmI3F/Yn/VO/Gk6dEXIMmAgBmPZiqLX
         XGEh5rsTl3jAeijEGujD//a9kFQdMVC+NKwbZm29vEc/qGivhnGS6BNPAZy1itnQHVDD
         q0Kw==
X-Gm-Message-State: AKaTC01Vb1cE/+zA0pLuAFtE420ZDU2mnb16NFUcDqOqAqIW+GpThPnGv9Ctq3HftdVSGNsGpi3Oea3z2eRi0nRt
X-Received: by 10.200.50.53 with SMTP id x50mr31348841qta.207.1480551281909;
 Wed, 30 Nov 2016 16:14:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 30 Nov 2016 16:14:41 -0800 (PST)
In-Reply-To: <20161201000824.GE192901@google.com>
References: <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
 <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net> <20161130195427.GA166433@google.com>
 <20161130232823.GA192901@google.com> <20161130233204.ihbrjwwu3yiv4ugq@sigill.intra.peff.net>
 <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net> <20161130234248.GB192901@google.com>
 <20161130234636.6az7xfywzprpn6ly@sigill.intra.peff.net> <20161130235952.4j63gkdlbobjitdb@sigill.intra.peff.net>
 <20161201000437.altjlcsn4u7rwe5c@sigill.intra.peff.net> <20161201000824.GE192901@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 Nov 2016 16:14:41 -0800
Message-ID: <CAGZ79kaaJgsa8SsvWiGkmKQU7Wv_PD6O50ybm=rxPySk=z9N7Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Oh interesting, I wonder if there is a way to not have to perform a
> chdir since taking a lock to lstat wouldn't be ideal.

I think we could rewrite is_submodule_populated to be

int is_submodule_populated_cheap_with_no_chdir(char *path)
{
    return stat(path + ".git")
}

i.e. just take the presence of the .git file/dir as a hint to run
the child process?
