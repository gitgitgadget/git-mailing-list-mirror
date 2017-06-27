Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4113920401
	for <e@80x24.org>; Tue, 27 Jun 2017 16:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbdF0QZV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 12:25:21 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34869 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbdF0QZT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 12:25:19 -0400
Received: by mail-pf0-f171.google.com with SMTP id c73so19035943pfk.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Cz82d/LKvuWnM9zeoDn0RVztaVWoQZj4x4MZf+KxnAA=;
        b=oxSdpIKdcpgzLzBBJbGwUIFrWCNwyHkLgrw9PviVRu8qu9TJCyMDqJX4K+flVt4S/N
         Fb5g8ojKR2LmVoGzo02e+aYBByVxRMozLev+lLZmXX1PKO4kBnjk6URViS8KP3tXlwuG
         DlJsIs46rX0Y74uq+AMqYvIY1URIz6jP2n6aIE9fN4mDLJYFGuUR8VMCwBUfnl+bgPVr
         2x4Q0TpCOhsbVIZ72akLJgubUteYC35bNXm+f8SCxMs5iCUPT7Jq9SjkytQrqUh2HmKG
         r3++DMl9t/ibNlhVeJWBWM4DfwNB4qh1pSBoZNlclVtUFL5brkiaaPGceCG3QRRi9Iok
         aM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Cz82d/LKvuWnM9zeoDn0RVztaVWoQZj4x4MZf+KxnAA=;
        b=U4c5CNOdUS3W0UzhPVgybN10QuKlI+aGq/10ObOa12Qrae+AWYvDpZBQena6EUeFiX
         grChFUHnMMfgxKweagbSVhqdI/vs+7y5AgBZMBXFENj1hZJA5bjZO+SAVFH+v9Lpyvu+
         Tc96RvkyQN4ubrUXR7vUYFdziIiiVTyIAkwY31ZRJgAEH4R+V82QiapiXKA+ycXmP44U
         F7n39CM3bjZjEkZu5xLQ3eXAcA97il7VAO96vZHI116aHpSxdYZCFpPW7p28NoVNIfnY
         j29eiwXGCqsGErrkkBsVn0cewYbTqgLpVjlWlK13KzF9eGqq3ferFYlNWmSxTUAjOBrQ
         lfZw==
X-Gm-Message-State: AKS2vOylLOE0Y+7oUP/ATloQitlaIN1X6ENyiq+UWuZtm+yFEm4ep5ag
        QqMv/JABuT6Omw==
X-Received: by 10.101.83.135 with SMTP id x7mr6216515pgq.63.1498580719138;
        Tue, 27 Jun 2017 09:25:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id g15sm6617308pfe.70.2017.06.27.09.25.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 09:25:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Kebe <michael.kebe@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Solaris 11.3 SPARC grep problem with t1450-fsck.sh
References: <CAKKM46uJLu+w-UUFZc1HRar3apAD6Db2KD+GjiNL5v+Q2Ni7hA@mail.gmail.com>
Date:   Tue, 27 Jun 2017 09:25:17 -0700
In-Reply-To: <CAKKM46uJLu+w-UUFZc1HRar3apAD6Db2KD+GjiNL5v+Q2Ni7hA@mail.gmail.com>
        (Michael Kebe's message of "Tue, 27 Jun 2017 14:15:43 +0200")
Message-ID: <xmqqa84t2yaa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Kebe <michael.kebe@gmail.com> writes:

> Running the test suite on Solaris 11.3 SPARC fails on a test in t1450-fsck.sh.
>
> not ok 60 - fsck --name-objects
> #
> #               rm -rf name-objects &&
> #               git init name-objects &&
> #               (
> #                       cd name-objects &&
> #                       test_commit julius caesar.t &&
> #                       test_commit augustus &&
> #                       test_commit caesar &&
> #                       remove_object $(git rev-parse julius:caesar.t) &&
> #                       test_must_fail git fsck --name-objects >out &&
> #                       tree=$(git rev-parse --verify julius:) &&
> #                       grep "$tree (\(refs/heads/master\|HEAD\)@{[0-9]*}:" out
> #               )
>
> Solaris has /usr/bin/grep and /usr/bin/ggrep. grep is a solaris
> version and ggrep is the GNU grep.

We do not need GNUism, but many tools that come in /usr/bin have
been found unfit.  I thought that Solaris users were expected to set
SANE_TOOL_PATH to point at /usr/xpg[46]/bin to avoid this problem.

Ah, wait, that particular grep may have GNUism.  If you changed it
to

    egrep "$tree \((refs/heads/master|HEAD)@{[0-9]*}:" out

does it make it pass for you?
