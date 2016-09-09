Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EE181F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 20:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754569AbcIIUjc (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 16:39:32 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38482 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbcIIUjb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 16:39:31 -0400
Received: by mail-wm0-f47.google.com with SMTP id 1so52482750wmz.1
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 13:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=JtkIzJYvyOmVPJIu2+wH2+ScJ/PFd472SrJ8RqgLZIE=;
        b=YwL0t+7WyUBOkVs2Zwd0y1BVMJY6ljUh0HsTk5cSuH3gZhMstKHPPrSE04vn7cCgHL
         jzjJGXILuyXD5hhzJblqiG7Po5RXTPstfQvjp3hxzQsv9VA53GuYnd6jYn7028ykr2z4
         G9GZOUkh32hpFIMjQ6qCVZWDFl6GGcMa7UMzsxY8kdkJEeyrDXdPP1JJKPcjZAjIXBQz
         IMOOXLCo76rSEmtUwU2oLYU55JVVHZW5U92G1KSbUXz9s13z2N6tsjWoozHId9NyXQdx
         mUjFhGCgWIb0+vcXt019w+dj1XMzZvR/dlC0oU3p4fHRB/tY+Um4m/tNLqrdXTQ98hMv
         Qkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=JtkIzJYvyOmVPJIu2+wH2+ScJ/PFd472SrJ8RqgLZIE=;
        b=EsRl/c4/tJeQwKtet3JEI4cePrERFx25pDlsL/RlFOGaSbsYC8Q8UWrYkMa2+yMNwY
         RXG03G93Smr5o4TN3yCTK2ASk1VvnsVfE60jO7720AVk5P/pcaQDNv3vKQLNDx3zXOGU
         4xWy5cZGY+4x1oTstqdZ2jHq88mtoqThMmUCa6uDX+5qw95e9+vVN7PSWTZWIgV6DKad
         CK6CRZeuw5Znx9zG1A4BsJ39ON+cXP3LePoa8kWbP1niqMPoExOTtYFBQQHFtpM6EcEo
         mr11Dr6Bq0EsBsOXsfYdrxYL/FtKeczLq5czRoTN4CXvyu3DYp0KrJidyFLCQHhOsWve
         UFBA==
X-Gm-Message-State: AE9vXwPdMYe+1xLlHg+gFq2mFI1xVJIwm4wkH9DVqg+M+mRkmnIS0ojgVr8ixfUq2vCB6A==
X-Received: by 10.28.154.83 with SMTP id c80mr93930wme.102.1473453569477;
        Fri, 09 Sep 2016 13:39:29 -0700 (PDT)
Received: from [192.168.1.26] (adby20.neoplus.adsl.tpnet.pl. [79.184.24.20])
        by smtp.googlemail.com with ESMTPSA id l186sm5003176wmg.20.2016.09.09.13.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Sep 2016 13:39:28 -0700 (PDT)
Subject: Re: git commit -p with file arguments
To:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <87zinmhx68.fsf@juno.home.vuxu.org>
 <CA+P7+xoN+q_Kst=qXG_HRznxbN7cbyi5uZe15zq1c16EifeK1Q@mail.gmail.com>
 <xmqq8tv1c5nb.fsf@gitster.mtv.corp.google.com>
Cc:     Christian Neukirchen <chneukirchen@gmail.com>,
        Git mailing list <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <23de5ffe-eaf8-2d62-2202-f1bf6087d44b@gmail.com>
Date:   Fri, 9 Sep 2016 22:39:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tv1c5nb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 09.09.2016 o 20:03, Junio C Hamano pisze:
> Jacob Keller <jacob.keller@gmail.com> writes:
> 
>> It wants to commit bar too because you already added bar before. It works like:
>>
>> "git add bar && git add -p foo && git commit" does it not?
>>
>> I fail to see why "git commit -p <path>" would unstage the bar you
>> already added? Or am I missing some assumption here?
> 
> Yes.
> 
> "git commit -p <pathspec>" were added originally for lazy people who
> do not want to type "git add -p <pathspec> && git commit", which
> matches your expectation.  If you already added "bar" that is
> outside of the <pathspec> given to "add -p", the final "git commit"
> step would record the latest contents of "bar" in it.
> 
> For obvious reasons, "git commit -p <pathspec>" cannot be a
> short-hand to "git add -p <pathspec> && git commit <pathspec>", so
> the current behaviour was the best they could do for those who aded
> "commit -p", I guess.

The 'obvious reasons' are that 

  $ git add -p <pathspec> && git commit <pathspec>

would not work as intended, that is it wouldn't create commit out of
HEAD and changes to <pathspec> created interactively in the index.
"git commit <pathspec>" is a shortcut to "git commit --only <pathspec>";
the git-commit(1) manpage explains (emphasis mine):

 -o
 --only
    Make a commit by taking the updated *working tree contents* of
    the paths specified on the command line, disregarding any contents
    that have been staged for other paths. [...]

Which means that with "git add -p <pathspec> && git commit <pathspec>",
the "git add -p <pathspec>" would carefully craft the <pathspec> state
in the index... and "git commit <pathspec>" would take worktree version
of <pathspec> for commit, ignoring what was in the index :-(

Currently there is no way to create commit out of subset of the index,
e.g. with "git commit :0:<path>"

Best,
-- 
Jakub Narębski
