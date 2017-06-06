Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A0A220D0C
	for <e@80x24.org>; Tue,  6 Jun 2017 01:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbdFFBww (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 21:52:52 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35924 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbdFFBwv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 21:52:51 -0400
Received: by mail-pg0-f65.google.com with SMTP id v18so8197248pgb.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 18:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=e5k27mhr//GUZIgjxW7oJx2/epj5/PcEKLFZ5f2ArwY=;
        b=Cj3KaSwHYe+xneFE+HUQU2/lVRQcZ8Q4R6+HEYErESoVvA/y8vDP2vbF1H251cgsIl
         NwNJROuAh5qkkwS/ylMSjgljQMmi/P2HBm08Fm1VxBU8OVvZFK7jE4it81r10o1In6sL
         zL9WUr5I1mDLPw7xHvcL3dGeCkIwoTKhj/7rjKYBVS8bGpTr1xzbZWkx/glPHnf44mzN
         qFiceo4Jzs3aon2kU9/redChxDZeKaqB5aplhG/u5353yTFRblWxtgvJ5M8LMoRtoD8t
         k3AOm6ajyPv0z3R7rOgMlqs5X8yUXK6VihqhfTeb1DZ3F9fhmLwe/7YnIS5R3FUU7p5h
         0xVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=e5k27mhr//GUZIgjxW7oJx2/epj5/PcEKLFZ5f2ArwY=;
        b=NnTLHq47flh2ITMmbRGVsr1D4tXqzNcQSPYR1FquoDl2a9TiRiiN3i02/UOvwLSQ/U
         y39qAYqCwWvHSv4cupzSJ2mskcaSszbY5pIX67bF36u2ytluYA7g+DjlRGKGJzNcFICY
         VmV6U6d1VCEqJcCCQ7bdtfrjOZRsOgqKxAK9Z5TcqrH8esycSaZKKPJYknDsBfx5V8sJ
         VdjcioVgjWKiUsoKDBTUSEsdpMKXblmKEDHckrfseNyCwaiGYZ/fzhnT2STQrYKHDQ3n
         HluCU+s+jL0QmckkoSNWVBJcjQ7yb5Xd/m7ZS1qGPp9c4tMq679H+QVFqx2KETKrH5cf
         FMSw==
X-Gm-Message-State: AODbwcAf35gXLmfpzdfMQfCWXAsjOqJDqsQMKJkr/+LHg6G5nxmepUqT
        Ir/yoyYEHXHYxQ==
X-Received: by 10.98.158.138 with SMTP id f10mr12413772pfk.177.1496713970504;
        Mon, 05 Jun 2017 18:52:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:5d03:f5d1:882a:10e])
        by smtp.gmail.com with ESMTPSA id w3sm18539873pfw.19.2017.06.05.18.52.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 18:52:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What does this output of git supposed to mean ?
References: <1496671452.4809.2.camel@gmail.com>
        <20170605231058.pgb4fgfb4z45bzmk@genre.crustytoothpaste.net>
        <CAGZ79kYp6GepJxZjaXhosX=vCh0vwa57+zFHK2gHFociiyTnDg@mail.gmail.com>
        <xmqqd1ai9bhf.fsf@gitster.mtv.corp.google.com>
        <20170606011151.qe5ycih77vqlqgme@genre.crustytoothpaste.net>
        <CAJZjrdWoK__rZVCG3vRSSEOPgxK7b_wWjpJ3YUQcLxw+J8KfGQ@mail.gmail.com>
Date:   Tue, 06 Jun 2017 10:52:48 +0900
In-Reply-To: <CAJZjrdWoK__rZVCG3vRSSEOPgxK7b_wWjpJ3YUQcLxw+J8KfGQ@mail.gmail.com>
        (Samuel Lijin's message of "Mon, 5 Jun 2017 21:39:52 -0400")
Message-ID: <xmqqvao9991r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> For what it's worth, I've never quite understood the "Initial commit"
> message, because the repository is in a state where there are no
> commits yet, not when HEAD is pointing to a root commit.

Ah, that is true.  The message in the "status" output attempts to
tell you that you are about to make the "initial commit", because
"status" was not originally a thing (it was just the message when
"git commit" gives you while you compose the commit log message).

In the context of "status", it probably is more logically correct if
it said "No commit yet" or something.  This is no longer "is initial
harder than root?" ;-)

