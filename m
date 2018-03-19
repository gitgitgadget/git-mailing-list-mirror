Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E07071F404
	for <e@80x24.org>; Mon, 19 Mar 2018 17:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967732AbeCSRCu (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 13:02:50 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:52402 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967709AbeCSRCp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 13:02:45 -0400
Received: by mail-wm0-f50.google.com with SMTP id l9so7409309wmh.2
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rn1mZeJrJbDsRuhNU8B2LGQ3dUhc9/i1jE+d5JkajSA=;
        b=W5ny22BChiBJ5gY5TBzT7JjR9JjFPhwbTF7e8MPeehEkCUDHTpmsagpBzyLdTjjZyv
         oduPGGflVJ6jNUkoyyOfMqe+3WmpVNsutfywx8hTgs75J9HlexM7JX2FFbsno594Q6pD
         Bx8yR6XydVXRq1jKtwX6XukaJBu+eV6MPAopSnBkaHBMjkSns8fGl/2U1oExcnSxBsR8
         CqQ3bvrQzy0WKdl6yBKpwVL+y6i/n7kVin2WlUjNTOURijRaHuqWqUGATpzXUqiazgPJ
         7Ir4sXjZkfunrl651r5ULzSVMJbjxb7oalZ+21zTfMn48S+WO2PMeNLIn3ph9Z4rWb50
         2pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rn1mZeJrJbDsRuhNU8B2LGQ3dUhc9/i1jE+d5JkajSA=;
        b=e7YCGpI1E7ZRRkASWn5UpwhmYsn6ygSbgael1PbWCap7G4wcOuZYhWAJtpof7RsAig
         gSdsiY2/tTgrinmCk5euOXCC2A9fZVFOoGEfUZTn4rNw7rurtKSrxEAN9o81Oykt3CMk
         OiOfpZORV8kKaNK45g2ZPcGhWqJ1xNSQSDxlY1vrJA1cuHSgORAp3wQKWg5c0q3Z6Bf3
         sTq1mMvajM+kdfSlZm0q+qoZTKltjjf9BjB0z+tIod4OYlxm4aES8D9bq4p7Ix/aDb3M
         UN+mBkxy5B+HNnaWj1++JQ8+ZtLJH220oukclcfXqYn0hpoxpKLKEQcvHbNbeFQNqB29
         /4mw==
X-Gm-Message-State: AElRT7EV0QMrTRAInks5EqRMCznEJnMRYmJh039ZZ48wtQM3rT1OY+4A
        Mx6b+LPL7i/PolN6arM+ngs=
X-Google-Smtp-Source: AG47ELvsbtqEclprLrLSCHf+Y7ruf1PRbOiZcCC3ughnnVRLyzR7pSSL75hJswVN2LCdNnx3y724cw==
X-Received: by 10.28.19.206 with SMTP id 197mr9933657wmt.89.1521478963394;
        Mon, 19 Mar 2018 10:02:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e67sm1137124wmf.20.2018.03.19.10.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 10:02:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v6 0/3] RUNTIME_PREFIX relocatable Git
References: <20180319025046.58052-1-dnj@google.com>
Date:   Mon, 19 Mar 2018 10:02:42 -0700
In-Reply-To: <20180319025046.58052-1-dnj@google.com> (Dan Jacques's message of
        "Sun, 18 Mar 2018 22:50:43 -0400")
Message-ID: <xmqqfu4wvw0d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Jacques <dnj@google.com> writes:

> This patch set expands support for the RUNTIME_PREFIX configuration flag,
> currently only used on Windows builds, to include Linux, Darwin, and
> FreeBSD. When Git is built with RUNTIME_PREFIX enabled, it resolves its
> ancillary paths relative to the runtime location of its executable
> rather than hard-coding them at compile-time, allowing a Git
> installation to be deployed to a path other than the one in which it
> was built/installed.
>
> Note that RUNTIME_PREFIX is not currently used outside of Windows.
> This patch set should not have an impact on default Git builds.
>
> I'm dusting this back off now that avarab@'s Perl Makefile simplification
> patch set has landed. It's been a few months, so I'm a bit rusty, but I think
> that I've incorporated all of the feedback. Please take a look and let me know
> what you think!

Yay.  Thanks for rebooting the effort.
