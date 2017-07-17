Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87E3B20357
	for <e@80x24.org>; Mon, 17 Jul 2017 21:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbdGQV7V (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 17:59:21 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34975 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdGQV7U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 17:59:20 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so278174pgc.2
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dgaRpWt1OqhAx3mg+n2VyOd/bbouf47IcQ/78LzIXoU=;
        b=BKIsB1PvYHqzMTdNpgg4BrCAEAidYGNMiUhpTcim1JxYGlPkuAAQjouqBUOhjKXpjy
         9EG1MDOFzTSoJfC2E8T6egI+g+oXetkR1XktR3QUKjjzRngLSZ+J048OX7AZ1z0DK2/J
         N6nM6Nv1vSY8cHRvc/r4pwQdh6dfosADCcI338Rd5VmcYROkHuZGkGXARY3lmqwOa2X0
         q+1ft6P25FwNNgeRLuyOmH1jfyzx+iSOiHin4xBQd9o0WSkae24NUvNxzuGsuQiG/69u
         q90oRh4pN47tXGHF17j8f+DQ732+Td3NNhf9cLaITiUtLHkNOgzFl/ed+kQOFwZibTW/
         Nnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dgaRpWt1OqhAx3mg+n2VyOd/bbouf47IcQ/78LzIXoU=;
        b=JmUuOQfOY7IrPOleFMO97NXg7JiV/RUAePhKYEE7KoFA9BsJ4Xf9j89yKcis+g0JpT
         4Rau3gEnXAIugISiQuL1k8qQe/7iC4X3TmKvddAfkWwJnEKvj5Yy8nQDSDu9VuBliTN5
         83YUD4vvxAgatwwfAkEnQAXiI82ipNcEhMCkIJMkuIX+0M7cgXaGOonZ3OmkQJPqI7Pb
         z34FpE9hwjMU5TpktqWTAzo0dSELjI7i4gss+d8ZL/wuUj72dOt41ZzR6NqO+WdzhhPl
         aQUpQlu2ZzBmGAJjk6oGcgFedh4I773jAKrq6qin9TlFkO/hWVDV5eMn64Yl/bMy80hT
         RfUw==
X-Gm-Message-State: AIVw110hkCIynm7BlbLD+3dcLSyl2avvU0CeNUn+qt3ezy3JlIbv0DHc
        z7kJW7CKEawOLg==
X-Received: by 10.84.224.207 with SMTP id k15mr1232120pln.108.1500328759937;
        Mon, 17 Jul 2017 14:59:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:480d:579b:4a3b:27f3])
        by smtp.gmail.com with ESMTPSA id s9sm401233pfe.67.2017.07.17.14.59.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 14:59:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Duclot <william.duclot@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rebase: make resolve message clearer for inexperienced users
References: <20170716194220.1304-1-william.duclot@gmail.com>
Date:   Mon, 17 Jul 2017 14:59:18 -0700
In-Reply-To: <20170716194220.1304-1-william.duclot@gmail.com> (William
        Duclot's message of "Sun, 16 Jul 2017 21:42:20 +0200")
Message-ID: <xmqqr2xeg1xl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Duclot <william.duclot@gmail.com> writes:

> -$(gettext 'When you have resolved this problem, run "git rebase --continue".
> -If you prefer to skip this patch, run "git rebase --skip" instead.
> -To check out the original branch and stop rebasing, run "git rebase --abort".')
> +$(gettext 'Resolve all conflicts manually, mark them as resolved with
> +"git add/rm <conflicted_files>", then run "git rebase --continue".
> +You can instead skip this commit: run "git rebase --skip".
> +To abort and get back to the state before "git rebase -i", run "git rebase --abort".')

This may be my fault, but we do not need to limit this to "reabse
-i"; I'll drop " -i" from this line while queuing.

Thanks.
