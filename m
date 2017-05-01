Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01B591F829
	for <e@80x24.org>; Mon,  1 May 2017 01:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1951521AbdEABlu (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 21:41:50 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34614 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1951508AbdEABls (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 21:41:48 -0400
Received: by mail-pg0-f42.google.com with SMTP id v1so39659968pgv.1
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 18:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=c4etjvJUZGM72kX6IV7Y53D6cxKhEH3jcr8e9EqCeO4=;
        b=Db7R+IB0ji8a/pgi1DtfieBUg2dT2BINu91JfQyVt2hjfaOgDCIPshDOYDH9uE+8gJ
         ZyLCe2lVw4UdG7BpxhFwEJDvxdFPyz1NxrMuKbJ38QMmhlppO8d6HZ94evq6ZUArUWc9
         LZwAqcbo2wrGFsVZuYPRJyHbVUzCU6nnLd40qzP6Ht8AwZcCM1D2FWjqljtEMy+lrRF3
         32dm9XRbccpsoZkXBG914zv9V9Cfyedz6IanCwUfEZHzFOmK7ywG8Z8icVB+BxcHxkZK
         ytDgjQz0Y2BL+gq16NQgt7OEtNNuFd/o3o6w5Cm7KLqgHmapSNxix1ML8p513Ez2U/6O
         3MbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=c4etjvJUZGM72kX6IV7Y53D6cxKhEH3jcr8e9EqCeO4=;
        b=cwtk9u343+mTdrkZvaVZoiQdgnEYLU4HV8Kbp6dbUhzH+A5qaC1ZNVFV0/zY/VoiiQ
         XqsPqBKOE7u5CR67/QIn8lsigsOu7DEhIx/ugJRzJA2BWanLNR5qaNEx9rIyQ+zEWFDT
         IWn86iSTHixAhD+md4zzkoZOEyJBzuw+0VBU+PQA/75G/qPzGclEdI7qPd2irzyNu/+Q
         BaVaozQMgsdM16t7yE7dlOJ/dZ5mLzNeYLPyPFTkcxTYoxvIlVmrHqZ/nPFEpZi27e0c
         AwpILuGHuKx6iJxQFL8bNqAi3YH2chxvSpFpq/gYSoHvXcS695Dj/RnTgLP3728iUN7H
         KfSw==
X-Gm-Message-State: AN3rC/6CmKlQZ9wpnoSsC9VicQdkSGp2IX9RLF0BrqmK5nK5zEuQzGDF
        1gS+CCandylQ9A==
X-Received: by 10.98.200.136 with SMTP id i8mr24035285pfk.154.1493602907679;
        Sun, 30 Apr 2017 18:41:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id s7sm20183167pgs.52.2017.04.30.18.41.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 18:41:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Johnson <chrisjohnson0@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug Report: .gitignore behavior is not matching in git clean and git status
References: <CABfTTAchc61aB02sCD=Oa9gRMGr94h7mC53B9q6Qy2k2hDqzAQ@mail.gmail.com>
Date:   Sun, 30 Apr 2017 18:41:46 -0700
In-Reply-To: <CABfTTAchc61aB02sCD=Oa9gRMGr94h7mC53B9q6Qy2k2hDqzAQ@mail.gmail.com>
        (Chris Johnson's message of "Fri, 28 Apr 2017 18:56:02 -0400")
Message-ID: <xmqq60hljqud.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Johnson <chrisjohnson0@gmail.com> writes:

> I am a mailing list noob so I’m sorry if this is the wrong format or
> the wrong please.
>
> Here’s the setup for the bug (I will call it a bug but I half expect
> somebody to tell me I’m an idiot):
>
> git init
> echo "/A/B/" > .gitignore

You tell Git that anything in A/B/ are uninteresting.

> git add .gitignore && git commit -m 'Add ignore'
> mkdir -p A/B
> touch A/B/C

And create an uninteresting cruft.

> git status

And Git does not bug you about it.

> git clean -dn

This incorrectly reports "Would remove A/" and if you gave 'f'
instead of 'n', it does remove A/, A/B, and A/B/C.

Despite that "git clean --help" says 'only files unknown to Git are
removed' (with an undefined term 'unknown to Git').  What it wants
the term mean can be guessed by seeing 'if the -x option is
specified, ignored files are also removed'---so 'unknown to Git'
does not include what you told .gitignore that they are
uninteresting.  IOW, Git knows they are not interesting.

It looks like a bug in "git clean -d" to me.  Do you see the same
issue if you use "git clean" without "-d"?  IOW, does it offer to
remove A/B/C?
