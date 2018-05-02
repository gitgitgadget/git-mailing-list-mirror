Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED,WEIRD_PORT shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1C221841
	for <e@80x24.org>; Wed,  2 May 2018 11:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751073AbeEBLrw (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 07:47:52 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45049 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeEBLrv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 07:47:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id q22so11578226pff.11
        for <git@vger.kernel.org>; Wed, 02 May 2018 04:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kojima-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U7Ta6nks+gM+vgGpG5bj0KnIBBOSmgS9h+KFKZCzd9M=;
        b=yCDBc9a6jDId+6JlLLREKPpYVkGvT82u1ZNxCJABSqRPkY2v1GRVmYSGxWbi7Hb0dV
         YOOHMaLO7+kFTeUtn2Qe56xpQdl/+FJkXJImBFYCA67KU7kazoOIsxIwYeQiOBwOm6HI
         f0J9WyxfGICagC4WmU1CfGX5xtl3dltq8vL2HGrFQ4Gvfl+ottvbalRRF6i5FvrBKJ2z
         ucxvRZfAYrEjt8fWG9xB0Iih2CAMfBBHvwEOv3Zo1Zo+GLL0YAZ7gF4DH0aAuJ7qSdml
         5fdI2uASRM7cXp/EyQzGZEWt+LxOEXOuCzSzqUDpNRkJnTo+gxJ904AfCli8rNGGRmNC
         xypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U7Ta6nks+gM+vgGpG5bj0KnIBBOSmgS9h+KFKZCzd9M=;
        b=pYQf50CVEh2jSgnZW2oXyf6rSAhYh/4TL9xZD4QteSyreQc7yHt+lrwSJcJGS9fOOB
         aRTIedgTTlBNB5+seZdz7KCjGH14o61HlIaWv/JCNsIyQxhtblJ/E+mGZIL/YAf9744g
         sui/I1LzvM7AizYe4v9ubcHDN7ykSDw60HLYdQKFELWv8jh8irrtOvS+PH0HmvkFlqqN
         ToLsTEkKIvuKLidmbW3JisO4lr7+uhD2CkvmYTVX1eA4Kzdl0LnlXSwr/K9Oy0UAfoll
         20pVkbvcJKmtWu+W37CGJaLXGeACfSROUY1qhORlqFR+LFBEk6yRRm5QtnGQS5FZDNJQ
         stGw==
X-Gm-Message-State: ALQs6tD3c6ax2CF1V2dSA8TOXcs0eq3TroIxUQ1ellNMOB0htn81f7Kg
        N1fKmww9IeQUcT2a+44JrucPoQ==
X-Google-Smtp-Source: AB8JxZojaV782zyGPYhsqC2oQiZlKmQKcxgjKbY5bQ81EOFGoqNs2V3T37SXP5fbXsg+AyoMnaDkbA==
X-Received: by 2002:a63:7514:: with SMTP id q20-v6mr15699663pgc.88.1525261670775;
        Wed, 02 May 2018 04:47:50 -0700 (PDT)
Received: from skmbp (pl40313.ag1212.nttpc.ne.jp. [203.138.175.121])
        by smtp.gmail.com with ESMTPSA id j74sm23914071pfk.25.2018.05.02.04.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 May 2018 04:47:49 -0700 (PDT)
Date:   Wed, 2 May 2018 20:47:45 +0900
From:   Shin Kojima <shin@kojima.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shin Kojima <shin@kojima.org>, git@vger.kernel.org,
        jnareb@gmail.com
Subject: Re: [PATCH] gitweb: Measure offsets against UTF-8 flagged string
Message-ID: <20180502114743.cmetkapax2y5mipj@skmbp>
Reply-To: shin@kojima.org
References: <20180501064015.59977-1-shin@kojima.org>
 <xmqqtvrqv632.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline
In-Reply-To: <xmqqtvrqv632.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20180323
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> ideally we should be able to say "function X takes non-UTF8 and
> works on it", "function Y takes UTF8 and works on it", and "function
> Z takes non-UTF8 and gives UTF8 data back" for each functions
> clearly, not "function W can take either UTF8 or any other garbage
> and tries to return UTF8".

Yes, I totally agree with that.


> Some codepaths in the resulting codeflow look even harder than they
> already are.  For example, format_rem_add_lines_pair() calls
> untabify() and then feeds its result to esc_html().

Honestly, I discovered this problem exactly from
format_rem_add_lines_pair().  In my environment($fallback_encoding
= 'cp932'), some commitdiff shows garbled text only inside color-words
portions.

I added a reproduce process at the end of this message.

After my investigation, I thought format_rem_add_lines_pair() tries to
use split()/index()/substr()/etc against raw blob contents and that
produces funny characters.  These builtin functions should be used to
decoded string.

untabify() looks proper place for me to decode blob contents
beforehand, as it definitely is not to be used for binary contests
like images and compressed snapshot files.

I'm sure using to_utf8() in untabify() fixes this problem.  In fact,
there is also another similar problem in blame function that assumes
blob contents as if utf8 encoded:

    binmode $fd, ':utf8';

I personally consider text blob contents should be decoded as soon as
possible and esc_html() should not contain to_utf8(), but the
codeflow is slightly vast and I couldn't eliminate the possibility of
calls from somewhere else that does not care character encodings.

So yes, I would appreciate hearing your thoughts.


> Also, does it even "fix" the problem to use to_utf8() here in the
> first place?  Untabify is about aligning the character after a HT to
> multiple of 8 display position, so we'd want measure display width,
> which is not the same as either byte count or char count.

Following is a reproduce process:

    $ git --version
        git version 2.17.0

    $ mkdir test
    $ cd test
    $ git init
    $ echo 'モバイル' | iconv -f UTF-8 -t Shift_JIS > dummy
    $ git add .
    $ git commit -m 'init'
    $ echo 'インスタント' | iconv -f UTF-8 -t Shift_JIS > dummy
    $ git commit -am 'change'
    $ git instaweb
    $ echo 'our $fallback_encoding = "cp932";' >> .git/gitweb/gitweb_config.perl
    $ w3m -dump 'http://127.0.0.1:1234/?p=.git;a=commitdiff'

What I got:

    gitprojects / .git / commitdiff
    [commit   ] ? search: [                    ] [ ]re
    summary | shortlog | log | commit | commitdiff | tree
    raw | patch | inline | side by side (parent: 79e26fe)
    change master

    author    Shin Kojima <shin@kojima.org>
              Wed, 2 May 2018 10:55:01 +0000 (19:55 +0900)
    committer Shin Kojima <shin@kojima.org>
              Wed, 2 May 2018 10:55:01 +0000 (19:55 +0900)

    dummy  patch | blob | history


    diff --git a/dummy b/dummy
    index ac37f38..31fb96a 100644 (file)
    --- a/dummy
    +++ b/dummy
    @@ -1 +1 @@
    -ｃoイル
    +Cンスタント
    Unnamed repository; edit this file 'description' to name the repository.
    RSS Atom

What I expected:

    gitprojects / .git / commitdiff
    [commit   ] ? search: [                    ] [ ]re
    summary | shortlog | log | commit | commitdiff | tree
    raw | patch | inline | side by side (parent: 79e26fe)
    change master

    author    Shin Kojima <shin@kojima.org>
              Wed, 2 May 2018 10:55:01 +0000 (19:55 +0900)
    committer Shin Kojima <shin@kojima.org>
              Wed, 2 May 2018 10:55:01 +0000 (19:55 +0900)

    dummy  patch | blob | history


    diff --git a/dummy b/dummy
    index ac37f38..31fb96a 100644 (file)
    --- a/dummy
    +++ b/dummy
    @@ -1 +1 @@
    -モバイル
    +インスタント
    Unnamed repository; edit this file 'description' to name the repository.
    RSS Atom


-- 
Shin Kojima
