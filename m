Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A4C1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 21:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbfAHVf6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 16:35:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38613 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfAHVf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 16:35:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so5575664wrw.5
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 13:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=g3VW8lHfKhZyyD9NhV1S0bRA2e/lZ16bFtNnMn2GNtA=;
        b=IUfJ4l/rPY5hgV6DGd/0K4/BB0K/PwC/WYdzvyArcwjdssxTxbhZvOZIMsqVYSRfBN
         yCAL0pJT/4HOfwEAul+XUvmT1mwlglCrcIHVKG2LVnqrBPwwD3sws1HXHK+e/b5UjTcM
         iyNfkH2VNxigoRDxCt6wc3YnNF0uSbBVNkBg+XGwH3XKKWFiAXtN1GhbGaiK9uFxUVMZ
         r+0nW5BF+1+Nx0pwQkW8Bqyq4Yc9Gx7XOwE2ANtghiGUwf1KwekiuMmmkXD9haOsys+n
         jU8YkkGIUz3rFjfP5wZz1OVcXaebgKhRgYTnI/57AArar5guHYCdvKnKxwm9FLjdcKJn
         7dzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=g3VW8lHfKhZyyD9NhV1S0bRA2e/lZ16bFtNnMn2GNtA=;
        b=KwMPyeqpoYz267vY3s0TmA+8X8sPxy4VDqQtPre07//5+avbtYcaGtkPci9UTcOACK
         h2kbWMz0zJ+h8Y2Oftrc7WfZv+5ZtQuAzwXRE1WHwtCK7Cc9kp47F/UQQ7ZinTtxB53i
         mntFSGYu6ji7YWZvKBHHBqbxR4UfgrMi0cBTDZZtK9mJwBN8TB05gmn9JQT38t9WXtLg
         J+rjAl22KPCsKbpHTRnNIS26tC2E3VsHd1xsdFSmjfCRU+cC8OIoeaDFCgSQ0iazZa5a
         REVFIxOcbnXIJpgKiL0AdAt9W/Ewm9K7WV1oj1Fs4xxQIRfHPnLLgopQXQZA/VPtc8r5
         Ez1g==
X-Gm-Message-State: AJcUuke36jjvvg6FVCyQP1jvn/KzCTso1dM5bM8QXRyg6oeo8B/PCOZe
        mP/ogOlPkR5qzDk+2YEo3cCiXPDA
X-Google-Smtp-Source: ALg8bN4xOsaFl159dRMjvR14/OP3D2u/UepiBcEfZCOmLcZm/myhiQbDHXuCs59XpvJ3jJW9jpRvcw==
X-Received: by 2002:a05:6000:1144:: with SMTP id d4mr2588269wrx.136.1546983355989;
        Tue, 08 Jan 2019 13:35:55 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x20sm14352365wme.6.2019.01.08.13.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 13:35:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: sb/more-repo-in-api, was Re: What's cooking in git.git (Jan 2019, #01; Mon, 7)
References: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
        <20190108212007.10855-1-jonathantanmy@google.com>
Date:   Tue, 08 Jan 2019 13:35:54 -0800
In-Reply-To: <20190108212007.10855-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 8 Jan 2019 13:20:07 -0800")
Message-ID: <xmqqr2dm4yth.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>>  The in-core repository instances are passed through more codepaths.
>
> I think this is ready to be considered for merging to next. This series looks
> good both to Stolee [1] and to me (I replied to a previous version with
> comments on patch 18 [2] which Stefan has addressed, as can be seen in the
> inter-diff provided by Junio [3] - I probably should have replied to the latest
> version stating this too).

Alright, thanks.

While attempting to resolve conflicts with this and Peff's "get rid
of has_sha1_file()" topic, I found it somewhat disturbing that
sha1-file.c still was a mixture of functions that do and do not take
the repository pointer, but perhaps it's something we need to polish
over time on top.
