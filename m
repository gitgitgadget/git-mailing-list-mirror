Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1DE11F404
	for <e@80x24.org>; Thu, 19 Apr 2018 03:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeDSDWu (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 23:22:50 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35968 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbeDSDWp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 23:22:45 -0400
Received: by mail-wr0-f178.google.com with SMTP id q13-v6so9938123wre.3
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 20:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZO3rEG07vqrs0WWOVSwDw9dMTvHXSEIyxhZhjKJxpuM=;
        b=jxUDN+UFILjR7IfsNl9puScrs6ZlzGDk4MBf+eSw29JkBOSewJJBJ7EGk8NVOKdPPH
         5Ew4PQt57nunI5ue5HEVwjIBUfa9cTwOTf1aOP7Lb4k6sOX7zwyuaXOddNmuCm1FwM6z
         2w82aP2rUOiOU0NQyoRbwQUHn5+kDtJaXGiGmFXaaUwVJzREmxj4MxRkTqfJboqATNUx
         ZgtqlA/ixmvrurGYlmaxF5bOthGsGZP5a3+aVYSha/8am/3M3JWKglMRytFPbOvc6gz+
         k2Va8Zw1ibQNtYfDHap+kYMEgKIXsoGPFxK9l2CSkdk313h1c9Yri1ftS5TVeFGFJSoA
         xdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZO3rEG07vqrs0WWOVSwDw9dMTvHXSEIyxhZhjKJxpuM=;
        b=iTP4xVI7qFnt6aueGi492pxOADl1NFw5rYS16aA3moE/+81ukKphIUpKQ1cClr+5EI
         ECZL8odWgr6SFBpIxAX//Rx/VuY4/7D/NIKVFtccQNOSFXOdg5q6TdGVzgQdM3fi4JXm
         ws1xOthIQZUS7/5cI8lodbB3QTdJ3gDD+9C1EoEN+0YJep5bhcofAWxmZ0eTICefQzPF
         xiMZVjhbu7wAvqf39XADMvTMkrUc63PTDVica+0oI3bZpSXGjrK1RxbB7wJSHD6fe6Ji
         sIacInZIuHbwPhAoRlup5BzxFWWsetxVkjxcAOk3PmEiOH/tDz+v6RvLLGcAH1x0xuiC
         VQhQ==
X-Gm-Message-State: ALQs6tDRCmEpmKTEKcabg19ti+BRIOATv+dp4Vct/BJnWbXElpY6Qlzg
        dliVnJ+6I0yZDPvt1AAWcyM=
X-Google-Smtp-Source: AIpwx4+01qzKHY9tQG2oG7xQBe+dt5bjnZ7iSbeu8Cw94N3NYLBKKGTxllLcqkadfenuMWOFpLoIOg==
X-Received: by 10.28.139.143 with SMTP id n137mr3063786wmd.55.1524108164380;
        Wed, 18 Apr 2018 20:22:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k89sm3226093wmc.15.2018.04.18.20.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 20:22:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: Silly "git gc" UI issue.
References: <CA+55aFxSZLuk++Dz6SonD+JhbbSDt9G9VcBx5f1CV=6nJC9hvg@mail.gmail.com>
        <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com>
        <xmqqmuy0ez8b.fsf@gitster-ct.c.googlers.com>
        <xmqqfu3seyad.fsf@gitster-ct.c.googlers.com>
        <CA+55aFztDdB9tVHREhQ7T0COs7p9ng81XfAHZCL3rx9WT2ecEQ@mail.gmail.com>
Date:   Thu, 19 Apr 2018 12:22:41 +0900
In-Reply-To: <CA+55aFztDdB9tVHREhQ7T0COs7p9ng81XfAHZCL3rx9WT2ecEQ@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 18 Apr 2018 19:29:47 -0700")
Message-ID: <xmqq4lk7g9ry.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Yes, I get that nice "malformed expiration date 'npw'" error, but I
> get it after 64 seconds has passed.

Ah, that timing aspect of the issue didn't occur to me.  The patch
indeed is a reasonable workaround.

Thanks.



