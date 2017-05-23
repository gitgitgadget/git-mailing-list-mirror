Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48582023D
	for <e@80x24.org>; Tue, 23 May 2017 03:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756318AbdEWDkj (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 23:40:39 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35820 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbdEWDki (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 23:40:38 -0400
Received: by mail-pf0-f169.google.com with SMTP id n23so100764271pfb.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 20:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=p7VajJTqQ9/9U8Pk2FcyXJ4ypqX1GaymS15knDD1GIA=;
        b=Wgjnj9LhGhh3gl8Q2P+giNJTuyfaOVmAtx38Rnup+qWt9KrwmJ/13I4QmJTylfQ9tM
         sbHKy2tcc0Cwwobiaq1HiLXJz6fFaWVJltpzJJYlLq4v+p6RQtC9IpUyCN5zlauxfE++
         MNcNnztVOo5VvLDd7V7jFAdRYbUzsVA4+ms3UyMm0rOEPKaq1lUqVkLP7/TTwN3Nfe9X
         RCuZS+e8VT79ln2NOC/kbUlkcvQKtZ3okr1zWJ+Ks2IXwyRYhd8qwPpFZ82jFzrmI68w
         WGDEqBzlgApfJknWZN38ahA8zmoKdelb943DG5c5g7GXBRiHWZ+D3t2JVkR1DD4BT2m8
         bIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=p7VajJTqQ9/9U8Pk2FcyXJ4ypqX1GaymS15knDD1GIA=;
        b=qtq9RJDRje+pfsU7QBQa4HKL8P0dE74x9xwIhAUdm2xEgKI/Of7/T9W1TxHiVhi/PE
         /cO+jxtvZqqyye32ivBG6cyJpm1G0h/glSRpeLhav8TlRra6rRMIsCtR868uh5pZgcdX
         bb1SeSoqlgco5WB2ygkE5ZP2dWOXcvgYD9OxkXSJwtuI2LPYn3E6u6cO4E4Z6rImlhEN
         /6yHjRnInGzp/yk1QV/5Q4KbZgLoZ2zM+cxwuqOKQkD1q4oYm15UHqHr0Q1vCeXfIHZy
         /nKiJh1BtPC5aHj9/KeuCw6uinNbFbWbWBYyXMFpHUCBXLSb+ZEJRwn1sEGcObgTq2hP
         7pCw==
X-Gm-Message-State: AODbwcAa4Lv6evZfnyuOaDD0CjInjlbgRSA0cts5OSPodIq4cHHH/tfg
        EcJHrDBrS9+6Vw==
X-Received: by 10.84.217.91 with SMTP id e27mr34070097plj.87.1495510838008;
        Mon, 22 May 2017 20:40:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id k23sm28060540pgn.11.2017.05.22.20.40.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 20:40:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?F=C3=A9lix?= Saparelli <felix@passcod.name>
Cc:     git@vger.kernel.org
Subject: Re: [Non-Bug] cloning a repository with a default MASTER branch tries to check out the master branch
References: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>
Date:   Tue, 23 May 2017 12:40:36 +0900
In-Reply-To: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>
        (=?utf-8?Q?=22F=C3=A9lix?= Saparelli"'s message of "Tue, 23 May 2017
 09:42:12 +1200")
Message-ID: <xmqqa864mea3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Félix Saparelli <felix@passcod.name> writes:

> I created a git repository that, for joke reasons, has a single branch
> called MASTER (in uppercase). Upon cloning this repo, git attempts to
> checkout the master branch (in lowercase), which does not exist.

See what Git told you carefully and you can guess, I think.

> $ git clone git@github.com:passcod/UPPERCASE-NPM.git
> Cloning into 'UPPERCASE-NPM'...
> remote: Counting objects: 14, done.
> remote: Compressing objects: 100% (11/11), done.
> remote: Total 14 (delta 3), reused 14 (delta 3), pack-reused 0
> Receiving objects: 100% (14/14), done.
> Resolving deltas: 100% (3/3), done.
> warning: remote HEAD refers to nonexistent ref, unable to checkout.

So you have MASTER but not master, but your HEAD still is pointing
at non-existing master.  As HEAD is the way the remote tells the
clone what the default branch to be checked out is, the command
reports "we cannot do a checkout of the default branch."

