Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676E620281
	for <e@80x24.org>; Wed, 27 Sep 2017 00:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936342AbdI0Azf (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 20:55:35 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:52838 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935589AbdI0Azd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 20:55:33 -0400
Received: by mail-pf0-f181.google.com with SMTP id p87so6385898pfj.9
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 17:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:references:date:in-reply-to:message-id:user-agent
         :mime-version;
        bh=Tw6bfm3suAhm8FBRoFiF7lF1paRN6W1y/D3mSmapxGk=;
        b=adCz6HQyufMuooJIvXNgkdLkZfCnIP+7k2focQc3A/jeNlYwSTApyhBr3centn1o5p
         AYMVXy8zfkFnZz/ljrsyJCw1kLX/S74YW7JYqVM7/TSzRwgbKsv3hewwJxjRqfhavBUw
         9lXQa6BJ56WPucHCIjlX9+muDzVO9jFpRGOU1pAXFIl06/j1tphLTBw7Iu84PEVm/Vrj
         nZHbYhiKMPhNuW2QKGHgTmSewhxfgafJxr+vYRvVYhN3e7OwTSgYhiM0rrBEDaNAgdIb
         B5hQ/ahX2f31IDqEgTBlTBEaT/8+jqL/R0ZGLCYX1+YHdkMgsk/MtNx9kLTf1W4f4g46
         gRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Tw6bfm3suAhm8FBRoFiF7lF1paRN6W1y/D3mSmapxGk=;
        b=YxcAvnIwwznhT5mDj6H4WGK5uY7f7t/GjvmnQKdHbc77hGu06fyZFEBdkoTTxx/ZYq
         CxNfwE5wBJJ+PUUo+DBqQlpehSr7XaAtdE5IL35ibmWR+4ndjDWCxV1HuaKfDq8sJx6Q
         gqePALMaQjYocqvmXK/eL692RLpiXbdbn/Zj7ygTiPqGG731xQaFDdINcMjVmhrDFwNx
         5zAy7dltALtKvZJZwW3036xIu2gu7lsBSADEY9lyRNVj/hJkCRVf17JZE/3kp+HSbtWK
         tHKjzcPctk/KNQlHBBskDSQnB5GBSPTFWfJSuka1CqgVUZ/18OVFUS6tnQWbFrR4nyRN
         D6WQ==
X-Gm-Message-State: AHPjjUj2T/+kcudxEGNa73Rqng4Laqp8fYnowTwTAUdzjgsFLDjdHVyH
        v7Kj6554fwzDK/HgQLl7YWi7fp+x
X-Google-Smtp-Source: AOwi7QCOtAHm6o4o7n7Og+6gjxJefVAiU6DzpR2v0PjkGEruwLUPZ75vO4TzkXPTKzPTNNo4madoww==
X-Received: by 10.101.93.136 with SMTP id f8mr12641998pgt.60.1506473732276;
        Tue, 26 Sep 2017 17:55:32 -0700 (PDT)
Received: from debian-x1 (adsl-99-178-242-129.dsl.pltn13.sbcglobal.net. [99.178.242.129])
        by smtp.gmail.com with ESMTPSA id t17sm19955761pfi.31.2017.09.26.17.55.30
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2017 17:55:31 -0700 (PDT)
From:   Ernesto Alfonso <erjoalgo@gmail.com>
To:     git@vger.kernel.org
Subject: Re: git apply fails silently when on the wrong directory
References: <87k20lt10c.fsf@gmail.com>
Date:   Tue, 26 Sep 2017 17:55:29 -0700
In-Reply-To: <87k20lt10c.fsf@gmail.com> (Ernesto Alfonso's message of "Tue, 26
        Sep 2017 17:53:55 -0700")
Message-ID: <87d16dt0xq.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also, has there been a feature request for a '-w' option to 'git add',
analogous to the same option in 'git diff'?

Ernesto Alfonso <erjoalgo@gmail.com> writes:

> I recently ran into a similar issue as described here:
>
> https://stackoverflow.com/questions/24821431/git-apply-patch-fails-silently-no-errors-but-nothing-happens
>
> I was using the alias:
>
> alias ganw='git diff -U0 -w --no-color "$@" | git apply --cached --ignore-whitespace --unidiff-zero -'
>
> to stage non-whitespace changes, but I was not in the root directory and
> the changes were not being applied. I broke down the command to discover
> the 'git apply' part of the pipe was silently failing to apply anything,
> exiting 0 without even a warning.
>
> The exit status and lack of warning is terribly misleading, I imagine
> this would be the cause of subtle bugs in automated scripts. 
>
> Is this expected behaviour?
>
> Thanks,
>
> Ernesto
