Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EA6D1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 22:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeI2Evo (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 00:51:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55895 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeI2Evo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 00:51:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id 206-v6so3596708wmb.5
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fW3SuHXYj2/rpU7Sj9UOGK9rRI0znk23QCGKAXHH4mE=;
        b=SoO0GqwOg2VtCMBEoLzvzzpvoP1W7GNpNrc8g9POxfDILCkiGo9TMlFZJ990FlUJKI
         9s/bbRi9Sr1hwaSMwVP3eMwYSQ0wHRGEiCLFiu8GokdEgO9inlUaIe+4WuZIGGnFqJ7X
         IXiXuPp6CIosDLjFi81a+6FnrSR/ehYoFHccwleoBI+wL/NFtBPCxXG2mURpsnu3elRl
         LBWersavYs6rDr/ri2MAsW6QrtI/thhE+QT7nnaZ1leucfZ8AUjuv/Qmu0ZbwwBUdxCj
         SuzWFg5//miXOsG2gNqdA44oGfB1a/S0kv685sFpOTOehFfpti1SXY1w2tlWEzg1cpOF
         1mrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=fW3SuHXYj2/rpU7Sj9UOGK9rRI0znk23QCGKAXHH4mE=;
        b=S6er68c3RwMirl2DKZ7pKfMUo1as6Hy833del/rZyvVoUO5tDj+DrdgT3GzhVk+pnb
         gwPQnqUueKN5TQzgS+SYEPgnQ4p1uCpf/Qol/DzmXByeXMwfpmNMXuNTMsmOg3CIkK65
         OuMfQ7MTWgQRWyexthdrjl0jeR/W9wbrSJrHuBFubv60Hd40pUTQiM5cxC1acVQnwXg9
         tlFDi0q1nDtldA6qi4b3eUXL7F2MTa0GBfXxN0SOEGLKjGTWRNdUwgVjJniqhRGqhr7A
         PdSUvujBCZ8jShvLNtD5re7reJw/2SUMLhEZ5eP4wSyWBrYlhBOmlbYcR4xFYDKVdqoS
         z2GQ==
X-Gm-Message-State: ABuFfoip65EJs0KOq9Dq1QnzCRSxUEkABdEtsXxBrlUg6Q6GzwhL5ILT
        cWuwXMwlwUa+TjkQgvPYsTI=
X-Google-Smtp-Source: ACcGV62DqB8Mlpq2lZIfXNk/7dWOpKjuA4M4RJyY3QBNcUx/UC3uN/w8pxLv9ZmoQzjRRn/qPeRWMg==
X-Received: by 2002:a1c:603:: with SMTP id 3-v6mr2970682wmg.64.1538173552452;
        Fri, 28 Sep 2018 15:25:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d2-v6sm4788707wrn.20.2018.09.28.15.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 15:25:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sam McKelvie <sammck@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule: Alllow staged changes for get_superproject_working_tree
References: <20180927181054.25802-1-sammck@gmail.com>
        <xmqqbm8ifvka.fsf@gitster-ct.c.googlers.com>
        <D09E2583-BD1D-4C56-9C19-6B1E97CEEDAA@gmail.com>
        <xmqqmus2e6rp.fsf@gitster-ct.c.googlers.com>
        <37DC7525-209F-49CC-90AA-D55463456D20@gmail.com>
        <xmqqftxtcxjb.fsf@gitster-ct.c.googlers.com>
        <2A26D56C-59E6-4F69-B0CA-4849EBE7EBC9@gmail.com>
Date:   Fri, 28 Sep 2018 15:25:51 -0700
In-Reply-To: <2A26D56C-59E6-4F69-B0CA-4849EBE7EBC9@gmail.com> (Sam McKelvie's
        message of "Fri, 28 Sep 2018 14:59:15 -0700")
Message-ID: <xmqqh8i99s40.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sam McKelvie <sammck@gmail.com> writes:

>> Or perhaps
>> 
>> rev-parse: --show-superproject-working-tree should work during a merge
>> 
>> may be more to the point.  It does not hint the root cause of the
>> bug like the other one, but is more direct how the breakage would
>> have been observed by the end users.
>> 
> Haha, that is closer to my original title that Stefan wanted to change:
>
> submodule.c: Make get_superproject_working_tree() work when superproject has unmerged changes of the submodule reference
>
> Though I could see why mine was too long.
>
> I’m really happy with both your suggestions

I've pushed out with the "rev-parse: ..." as the title.

Thanks for the fix.

