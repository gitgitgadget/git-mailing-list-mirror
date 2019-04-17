Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDD0420248
	for <e@80x24.org>; Wed, 17 Apr 2019 02:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfDQCj2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 22:39:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43462 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfDQCj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 22:39:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so25068570wrx.10
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 19:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b9SjaDPyApQ7iunejGTUH5PJEdWK1AReLh/89psF/fI=;
        b=JQXgx9Ge2YoxRcXbDJ+7DqVDqohmG3BH3urAGZZeqP5sikLlx5lPge4OUnYCw0dQX3
         noVr6QVABn18SBZfKccA9Js3/xnuiRLJyTVYDifAEGc1lRZiWT8grEIIk5CX9S+x3fEM
         daJuUkKoPNBXtPIDHhFfRahL9wIP/4xELnZHR/WErgyUTlOc8ThPtRkiTICph8oAJcYu
         1waMzT9AMIZ6VzziHACozvPajiO8ks9/bAZ7JuNDI8869aWd9CsfUyOsk8x1E+y9PhxL
         r/vcuMM6FCIN1f+pY0y+5uejxy4dvcnx20Mkss+0KK9I6OFhY0L+MfyNRaWPClBZ8soK
         LoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b9SjaDPyApQ7iunejGTUH5PJEdWK1AReLh/89psF/fI=;
        b=X4ycfanBvVzupZzlybvsJzlTnJyPr/B/rDFZrI5J/JH4V1b6IUeuhbDNJfLdWbty3S
         oVPPmm9ds2V5LnwAZSmRoGrX5dlM7Wz5YGPs8Yr5cxVHWtuYQ6kR0xLC2cJdEuB1YE0V
         nNvctW+Y+lXveZzCtKH+0V+zas3MsLr8T5gQnf8CbaPvoGJLlrQaEZZVBpeZEXzlcaEn
         wKqQ6IgHvx5FvN1TGYL+gCQWL/sVZLhuOi9q1Z+3NsAL14sJCgq5zS/Ym2EjGzpES4Wn
         4Inj+G/LB3N9RWtE5YXyaYY6LTiPAuayycMMwcoxiFpb/umFxZyl02iLQxruLmqfoOsb
         7k6g==
X-Gm-Message-State: APjAAAVoIRlYW1FnPukYLR7g0OjP18AYyNsMLtt4jby4c2uPJaAliy/C
        uUx6BZY9Li9/Z7NLFA2q71VutJjPNmM=
X-Google-Smtp-Source: APXvYqztcdbhw7j//eENhV8DGQcBUZQhfqr/KQ2nwR7AuHd0vxUJ2HmYctGZSBOsts9HJS6XbBInig==
X-Received: by 2002:adf:ffc2:: with SMTP id x2mr28766282wrs.86.1555468766460;
        Tue, 16 Apr 2019 19:39:26 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z19sm1056849wml.44.2019.04.16.19.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 19:39:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: jt/clone-server-option (was What's cooking in git.git (Apr 2019, #03; Tue, 16))
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
        <20190416173228.232980-1-jonathantanmy@google.com>
Date:   Wed, 17 Apr 2019 11:39:25 +0900
In-Reply-To: <20190416173228.232980-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 16 Apr 2019 10:32:28 -0700")
Message-ID: <xmqqy349nyn6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> * jt/clone-server-option (2019-04-15) 4 commits
>>  - SQUASH???
>>  - clone: send server options when using protocol v2
>>  - SQUASH???
>>  - transport: die if server options are unsupported
>> 
>>  "git clone" learned a new --server-option option when talking over
>>  the protocol version 2.
>>
>>  Getting there.
>
> With the two "SQUASH???" commits, I think that all outstanding comments
> have been addressed, and Jonathan Nieder has given his Reviewed-by [1]
> [2].

OK, so do you want me to do the squashing or are you sending the
final version with jrnieder's reviewd-by's?  Either is fine, but
I need to know to avoid waiting for an update that will not come.

