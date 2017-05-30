Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783542027C
	for <e@80x24.org>; Tue, 30 May 2017 17:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751037AbdE3RmN (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:42:13 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33156 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdE3RmM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:42:12 -0400
Received: by mail-pf0-f177.google.com with SMTP id e193so78705557pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ddtc/iZqALwkxRTUk/UPb6KtD7tdiPnGnYspNtPCiFM=;
        b=Xvhg2OHCX9/jOJOA4LOAnrI8d8FYR1sTmik+MAsoGCV9FeeDs+WbTQJTbWUIDU4mlB
         kvWunIpQABJYp3/SpUnsJ1HA1045FdiQp12pz0wWd2tggOZbkSIwvbvl60DvVFz2WUhL
         RySHz5tRSKeSMlmAMk2ULnrevECSqhYUvCz+twlPXfI57XaYSWB9dfn2dKmDDnkYO8dH
         lCg1e7qBkvzzOztbVHoaz/9KzRhJBRX2Bvbuj4JA7hlhe0CxrlRzHdLVXSM7fNwJbcW5
         nykC9UpxWKl0hujC+LZLqQmFCP+qn+umr14vW7C4FXQqKlWYAGwNgKxzBWI258j0IibC
         P06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ddtc/iZqALwkxRTUk/UPb6KtD7tdiPnGnYspNtPCiFM=;
        b=U/SYakBdPL1xptjNKFgedQazVOuqCMmVNGYUMAFsMT8WRHCo+5zzTpb4hfABQfjFFA
         nf0JTby4N0luWAzSsJ6YobkMTGaUIUKjYU+nbR2bhdfKKU6KVgjVnTPM86gHsVkWCmof
         e/UEKUOW0uQTmMXxs3UIzbA/6Vyc/cMQEIyrUls5fz7zIKh8/iDW0XCBv1NkymJ+mJo3
         8sR45FydXS+hI09TmpXuZ2Em84vHsDigl9SH8lM7bmVYhXmRU6Ut+g8WokcBwx2sUoZ/
         lBhu4WKVv9lwZvUEt7raIbqPYuiltWqqZxDRTGWpRUSwbYxPv3oSQL547838ug6ZOwIu
         37Nw==
X-Gm-Message-State: AODbwcC869++QB8s84DpZpnbjFgd9+pqord306CIb9hgumPZR9u7msC9
        0Cs5HUNfp7pwVLdUsEIhWv+QUIs3FbC0
X-Received: by 10.99.116.7 with SMTP id p7mr26417421pgc.162.1496166131404;
 Tue, 30 May 2017 10:42:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 30 May 2017 10:42:10 -0700 (PDT)
In-Reply-To: <xmqq1sr889lb.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sr889lb.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 May 2017 10:42:10 -0700
Message-ID: <CAGZ79kZWmLnUr5hyKjy8bKFAksURW9a65035CHispAT0oH1rkA@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #08; Mon, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 28, 2017 at 11:23 PM, Junio C Hamano <gitster@pobox.com> wrote:

> A bit more topics are now in 'master'.  One unfortunate thing is
> that the SHA1 breakage in 2.13 for big-endian platforms were lost in
> the noise with excitement felt by some subset of contributors with
> the possible use of submodules.

I am sorry about being excited, without considering the immediate
pressing issues.

> The first step in the series is
> neutral to the excitement, and should be fast-tracked down to
> 'maint' soonish.

Yes I agree on that. Thanks for being calm and unexcited about that!

>
>
> * sb/diff-color-move (2017-05-25) 17 commits
>  - diff.c: color moved lines differently
...
>
>  "git diff" has been taught to optionally paint new lines that are
>  the same as deleted lines elsewhere differently from genuinely new
>  lines.

My current understanding is that we agree on having the first n-1 patches
in good shape[1] and are only discussing how the exact line coloring
algorithm should look like, so I resent that separately[2]. While
it has better documentation and tests (also a command line option)
Philip still found some issues in there, so I will revisit that patch once
more.

[1] https://public-inbox.org/git/xmqq7f15e8pu.fsf@gitster.mtv.corp.google.com/
[2] https://public-inbox.org/git/20170527001820.25214-2-sbeller@google.com/

>
> * sb/submodule-blanket-recursive (2017-05-23) 6 commits
...
>
>  Retracted for now.
>  cf. <CAGZ79kZexcwh=E6_ks83=pJh=ZvKnLvJ54eLsn+HURsTZOpvqg@mail.gmail.com>

And the retraction is retracted by sending a new series.
You remarked that it still misbehaves with other series in flight,
so I'll inspect it again.
