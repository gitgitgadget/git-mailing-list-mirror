Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5130D1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 15:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbeFTPVi (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 11:21:38 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45829 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753885AbeFTPVh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 11:21:37 -0400
Received: by mail-wr0-f195.google.com with SMTP id o12-v6so3699573wrm.12
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gamFOG48gPxYA2IIVn1hQRI7LOUWJB+54O9bNCDxm7U=;
        b=JxH8dUIXMnBQeDRIIe8b8rat5lrZKSideUn6RnE1DS5bweyDAQSqzSx8cahQSQTJkR
         CLq/Fb6fdiIP3mmsOkyEU2KdimZThvTes8JTMLPyx28D6bINrH4qVIrtslEFElEn0RJ/
         6ow/LkBpbsxHWPftw8DUkEbtAIAsMBLdDvSnsGeCNQRQMJZ1xA9wfg4ePyFlf26218FS
         ctUbg/wSPdiQNwirxwTW+TGPSUHlvFNF7+49/YOoYGuW4xCwmlh7c6R8nToThNHfGgS6
         7DZzF7pXw65ClDHP4XJKMKuq6kFIAt/sc24xdzOq4mHUqCJgRPKjplwj2yb2ROKFT1wE
         xNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gamFOG48gPxYA2IIVn1hQRI7LOUWJB+54O9bNCDxm7U=;
        b=lvG79pS16x31WYGRsxTcx4dK/dKZJ/kuZANS/t6n+zyjnGnnc70kLSO/O9W3j28M+E
         uqbWb5TQgeGTyWOSG/yoFN71P7eH8KhSyQ/vwHzyWbxEz/8mS7SC/pPTm/0XkBg0I9KT
         QP6m5/VcBp9qgNtcERTe0OxMpf9waeTs8/tMvf2kjtUv0LwTyewxNMv5emW+IqdoxzMS
         +ht6OBFMdX7M99fb+oYf5jM8fyFQl8ib2Usc2An0GfgVjD4Kcbce6OYa+QHbvEBcnvaI
         v8XAJqoh/fNl0UUCnkdDB0s5Zk+gY6FelXJhRXlIMue2JAx/jHgkEyc7SpYT8g/db+wx
         7Bew==
X-Gm-Message-State: APt69E3ocDbHHgfQ9FKe3+jEjS8H0AMGCvohx2VokDCv4ptlShsFfO/M
        LopGai5UfHlG5ELz/AbH9uQ=
X-Google-Smtp-Source: ADUXVKLU/a0mDo0ygAyD6wUCY0etlSJX392sT3+xIydhfRjkA6AIvT5mxc4wK2nWfNfnXhLm2/p2MA==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr18629166wrc.40.1529508095943;
        Wed, 20 Jun 2018 08:21:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i6-v6sm2201966wrr.2.2018.06.20.08.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 08:21:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2018, #05; Mon, 18)
References: <xmqqsh5jwzp3.fsf@gitster-ct.c.googlers.com>
        <20180619222749.124671-1-jonathantanmy@google.com>
Date:   Wed, 20 Jun 2018 08:21:34 -0700
In-Reply-To: <20180619222749.124671-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 19 Jun 2018 15:27:49 -0700")
Message-ID: <xmqq36xhv5z5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.  The ones marked with '.' do not appear in any of
>> the integration branches, but I am still holding onto them.
>
> Would it be possible to have my patches that make bitmap_git not global
> [1] in this list? Peff seems OK with it. Let me know if you'd like to
> see anything else.

That one did fall through the cracks.  I'm (unfotunately) offline
this morning but hopefully can tag the 2.18 final by the end of the
day, and then I'll go into the usual "pick up the patches and
discussions missed during the pre-release freeze" mode for a few
days, during which time a reminder like this is greatly appreciated.

Thanks.

> The original patch should contain an extra paragraph that I've provided
> here [2] in the commit message - let me know if you want a reroll with
> that extra paragraph included.
>
> [1] https://public-inbox.org/git/cover.1528397984.git.jonathantanmy@google.com/
>
> [2] https://public-inbox.org/git/20180611115046.d03f8093347dc6c0e9b116fc@google.com/
