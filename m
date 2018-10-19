Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37931F453
	for <e@80x24.org>; Fri, 19 Oct 2018 07:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeJSP2Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 11:28:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44542 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeJSP2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 11:28:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id 63-v6so36214332wra.11
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 00:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=41REx81gYgk+JtcLuYIjRrmEf/ZGHyGBj11/8cOF8nY=;
        b=TrWPKHp1Busxj3iHwq7kMJn67RbuzV7SY0CME108N0cWOoaOW/2R/Ouy8/oipRiCUM
         cgUa0yuKPZHRKjr1zWgL5cWdiZuoSXa3p/KvhiotpPyhF/wLF11aPELTIgwwES3hFvGI
         fZPoRoSGb+2nP9M9C+SIw5IjruosxqgXhxpJ2NOrwpM0sgwRzoTTLxBvCuItESRSu6Ht
         MfjCRMSWTtKA8ps2LJbjU4lgsxfI5nlE3hW2adIjzNHmYpxcrzAfme4A6nzPivX/BsHG
         Ob5LVjdFgVlQsfNte04k0VekY67rGjBXzWmoTWDloxrq5odSdGNMS81kIb0v6feNPsnZ
         9UpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=41REx81gYgk+JtcLuYIjRrmEf/ZGHyGBj11/8cOF8nY=;
        b=JfJshA7NGkjKpeKHgtydltaWzH73/1Je7puFJRg2RkDmHNnkvwg44RQnXLL4UCmCMf
         wra9uFYlviLMbUlay/iK5Xt9zcQRUA9Nt++cpWEf/d/9MwvpE31sltUoEST0bPzs1CkD
         m5DauPvkSoHC/ahEFl4dXpG7BKuKcM60+oYqSnYKAUoK65gHeMMgmvvIHUN8jeWJm3aZ
         hoXETXPqQkGHs328NSNB0V99lO+jVt/KH+fAIcPQCv7y3xE2npYCJIxnNUvIl3zMXFYc
         pQtKXeMDc0qykvTJXqWfZzih3uYzYgml3RbJiF28BgKxL9WUgm2FsA3bkI8CG5F3aSej
         LxvA==
X-Gm-Message-State: ABuFfogWM6TNtnKYOexzU3gR75AzGVcRe3iFFj6JQ/EpJvN6s5WQdND/
        O8i91rrEDedNQbqxjEbG4cc=
X-Google-Smtp-Source: ACcGV63rrbwuiXQx/PEsh5VUJrv5Q5ajTI31s3V8KWmyGMDDsTXN9nxatXatoPWh4/XPkEKv+Qerag==
X-Received: by 2002:a5d:4949:: with SMTP id r9-v6mr31115476wrs.114.1539933804900;
        Fri, 19 Oct 2018 00:23:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y19-v6sm1971721wma.7.2018.10.19.00.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 00:23:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH 00/19] Bring more repository handles into our code base
References: <20181016233550.251311-1-sbeller@google.com>
Date:   Fri, 19 Oct 2018 16:23:21 +0900
In-Reply-To: <20181016233550.251311-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 16 Oct 2018 16:35:31 -0700")
Message-ID: <xmqq4ldi1jti.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This rerolls sb/more-repo-in-api.
> It applies on nd/the-index merged with ds/reachable and is available via
>     git fetch https://github.com/stefanbeller/git object-store-final-3

Thanks.  Luckily we have both of these prerequisites in 'master'
now, o hopefully this can be applied to 'master' directly and would
play well when merged to 'next' and to 'pu'.

Will queue and play with it a bit before sending comments.
