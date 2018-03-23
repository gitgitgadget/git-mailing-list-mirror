Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8356B1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 16:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbeCWQmz (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 12:42:55 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:41621 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbeCWQmy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 12:42:54 -0400
Received: by mail-wr0-f177.google.com with SMTP id f14so12755577wre.8
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 09:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fkX36n8rTh7tikaqfznRk1gK359tCKb020J/w1JfFr8=;
        b=Ryb1Bq9zdoqJlY/+ALnQgtuiigrqP4J4JnXmaMOw7C1Ri7jItaYY3NZAH8dlZ7x6Oc
         tqZJ6rfDG8bOc3kbqBHwpywWG6l0i2Xlr5/Lb+QFt1eNd+VWorYzcdfz/AZ+hoXQrrkC
         lZolc7+XDjQBJtlCFnXZCWZq9pm0k7eL2853dAHOxc7vRP/V9SHRcWxstTWn0nzPMZQB
         KEMtwHwQY6J5SI3WsObzTZkCXvryZA17SdgohMqkcLkhkpyKdP3QA3hjVG3HyzVMzRwz
         wYSj8KEK5MPvLmysm0MrTJzkCb9KQqqwswxucMke8W225lKtPFj/YMtC/qKqLb1CUWsS
         qAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fkX36n8rTh7tikaqfznRk1gK359tCKb020J/w1JfFr8=;
        b=ij7NQN+G5FYJ1RxnQkVDccPMWI0nKZFYA9gsb5udCCvTr/bKSBKgwPj7+aWW12iGuj
         9Zx4k8SUgVyxrh8EKeHjY84aSAg5Jvt/cOwB0Ao24l8IoM2/cjVXJ6cKssXSfXRAaMBz
         tfUfXJdhxo7iDwikehgiePvCmxZw+YTU5iaOPdhd9yAZUEL29PSqP+5iA4oLzfEsw7YM
         jlYvHBwU6zOUXuH3DubzY6+byImDb70TpwgYwKV3a5TEcMv/5tycPJIZGVp6LQ1mPvr9
         EjfHvfRBTJ24/qkZ4svzR0Pzub21KdOBWNO9axnfmphqIWOXGPPsH3EoFew3DnWRGLyQ
         irsQ==
X-Gm-Message-State: AElRT7E6JS2+mUTHV0RQov44m7TrdQOMfh5WdVom2/GWHyfZ1P6BG0Mi
        lN/B8T1Wp7KP2DKbJwJHI3Y=
X-Google-Smtp-Source: AG47ELvnxkeah/acjSpF+cyjuGA1+CyF4NAucektMihGlHvQlTru62mE+FJRcWym9ndjI1Q+zSJKrw==
X-Received: by 10.223.167.153 with SMTP id j25mr25043284wrc.118.1521823372835;
        Fri, 23 Mar 2018 09:42:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 33sm7835277wrs.74.2018.03.23.09.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 09:42:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 1/5] fast-import: rename mem_pool type to mp_block
References: <20180321164152.204869-1-jamill@microsoft.com>
        <20180323144408.213145-2-jamill@microsoft.com>
Date:   Fri, 23 Mar 2018 09:42:51 -0700
In-Reply-To: <20180323144408.213145-2-jamill@microsoft.com> (Jameson Miller's
        message of "Fri, 23 Mar 2018 10:44:04 -0400")
Message-ID: <xmqqvadmkak4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jamill@microsoft.com> writes:

> This is part of a patch series to extract the memory pool logic in
> fast-import into a more generalized version. The existing mem_pool type
> maps more closely to a "block of memory" (mp_block) in the more
> generalized memory pool.

Sounds good.

