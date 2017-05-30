Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C157820D0A
	for <e@80x24.org>; Tue, 30 May 2017 00:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751025AbdE3Aff (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 20:35:35 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33770 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbdE3Afe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 20:35:34 -0400
Received: by mail-pf0-f175.google.com with SMTP id e193so56285080pfh.0
        for <git@vger.kernel.org>; Mon, 29 May 2017 17:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Us0/Vz0dqAQKVwD+MEsBbJpuZLHaYu/XTIJaEBeBqmI=;
        b=Q7DY+8IiunyIFRxpmgAT01L9fv5+iBalyYFaqVUJeH8ykwiGj4gKErsnDzo+pSyyPQ
         m+iejj+w1d10lQuU0SOqxIuu6pT7C7m8hDMkyKtmBcjdF1lsDIbGCH6QNsNMgfd5QLXE
         ddrcSL9IsJa5x1qDWmGsz1NAc2YN74x16xsnuzyktDBmKrK5m94u+yylFnKj+E/ZWQxw
         ljj4iVGPGwOEgSBaz7X8NvB9Q/9tvUzi7UgwBB1nOTPapGYcmKsv5qi8by2mQJlU5i8v
         OjOjnSCziBK1r8rbyXL79uwKf6ENqeU9bWjOMnZmfzZc53ujVFTObnsE4HGsda6W34vO
         y+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Us0/Vz0dqAQKVwD+MEsBbJpuZLHaYu/XTIJaEBeBqmI=;
        b=nwjKdMCBqK31UPsyGejgArEtjoFSTUxmGWQy9LOWdQcBnChSHHuq4atTmThkM3xWya
         izIbdkaES57jZfJzlOGB05BKupldOONxxPWRijaDZMHw2KvaYrZkROgJe8FJP80J7sI5
         gEbjcfRB3iqILxNcPNAnOD5V1d/5Rscxe7afnLzdizfHdirJohHDvk/1v8rRLJmMmjcU
         WV7mXseVX+RJDNVHdixPNFeXmDYywTjo29aluBokGEXjy5KGqKGIhwPsVyxBcdBQ1xvq
         5s7US+lkJxO1y+WvmgVDS9DGCzc1y0D3dAmJ5YgFC/D+9J/O8ocZPP0xfe29Ji1kt76H
         kPxw==
X-Gm-Message-State: AODbwcCdPpHclIte719yEjGpjRpB3OcCEpJXl9v5K5AePvq33glEtAj6
        PvgH8rDQzzfHmvOPAcw=
X-Received: by 10.99.111.140 with SMTP id k134mr21849166pgc.20.1496104534176;
        Mon, 29 May 2017 17:35:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id 15sm17743352pfk.115.2017.05.29.17.35.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 17:35:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2017, #08; Mon, 29)
References: <xmqq1sr889lb.fsf@gitster.mtv.corp.google.com>
        <CAJZjrdXwUiGt9fe=TF2MWq_kdCzWVijB6UqRig+Uf4tzxebV5g@mail.gmail.com>
Date:   Tue, 30 May 2017 09:35:32 +0900
In-Reply-To: <CAJZjrdXwUiGt9fe=TF2MWq_kdCzWVijB6UqRig+Uf4tzxebV5g@mail.gmail.com>
        (Samuel Lijin's message of "Mon, 29 May 2017 03:51:37 -0400")
Message-ID: <xmqq60gjfagb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

>     "git status --ignored" previously did not list ignored files in
> untracked directories without -uall, contrary to the documented
> behavior of the --ignored flag (that all ignored files would be
> listed). This has also been corrected.

It's a balancing act to decide what level of details when
summarizing what individual topics are about in the release notes.
I still think "clean -d" fix is the primary effect to the users, but
the change to "status -i" is also visible, so I do not mind spending
four more lines in the release notes to lengthen the description of
this topic.

Thanks.

