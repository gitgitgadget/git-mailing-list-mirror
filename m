Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5FD21F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 23:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeJLHBJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 03:01:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44075 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeJLHBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 03:01:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so11457203wra.11
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 16:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Y3INhM3vmTB5O2HREo6LRuF6mlzCE4/0jzpMlNgB0Ao=;
        b=vKfeSVaQZKH3Y50x/gQymYT61jt+z/N0pHeqK6Kg5y9JW8H6z9rUKdNW065B39CVZt
         j9CvU2OIdQC14BaUpDETUcKe0mYAvpJjBkRbV0E4KjSBUX8VMtk4wjcJPdO0xg1/9A7t
         in352jGfsLhzKZVV4HiaSuha1omk+hD19cU2OmGagoNPA0j8lptO/nbFg7Y3Dyx5Rjni
         ZulYF38KJiJebWc+RiKrh210VlrxB858mVGabB6mRKkKF7Z1tb/NeugaGqSPdmL9DADQ
         EDScTeAnNgIdUIJOkNlZX7P4X+Xh6A4ZXZZklBCC3LFZjmnTqfdhDyiI7XSx7BQx42l3
         8hIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Y3INhM3vmTB5O2HREo6LRuF6mlzCE4/0jzpMlNgB0Ao=;
        b=KC8AlUjMIxFdJXgkoB3LaS+Kv6HukahKEKJBibKHPgZbTTBu6DJ5JFsi0GdekvbqM/
         JOSt1C+mzzw6DclvohBv/liimvM7BkmfbYSghL1T+4Vftyp3s+l4frl8DANqPGOp8YTw
         QarZ1wnpHA+QI7UI8xiIRW4mg66DBP3KV9Tm9JWf7PT84kDfzXJrWaK+VxTntQXZtDR1
         RCUeNGsdJE3zohdXOOESrMltPKc/X3D00EjcTi6ow9Y0iLV8m1lDx3uhc/ogjPjZpBR0
         pkdEj8vMVEsQGDIcho2rk8K4A0eEIBPu5Xi77yUdHED2hA7XUClINJqaJMNLN2wnSmh+
         c51w==
X-Gm-Message-State: ABuFfojauXO4I4q2bvsh0z8S5hOYt4sDb5MHmBSzOmcWr1A2WEA614LL
        rYrjYysJZWauYf7BEdGIP2k=
X-Google-Smtp-Source: ACcGV62j1KcyTBHzTknTGWFcKq3v8TZr3dOzFVheJJvo3WosVISGExP4eGRUfnDIglpx0R94uK3ZAA==
X-Received: by 2002:adf:ffc4:: with SMTP id x4-v6mr3177933wrs.222.1539300694537;
        Thu, 11 Oct 2018 16:31:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u76-v6sm38766924wmd.10.2018.10.11.16.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 16:31:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [RFC PATCH 00/19] Bring more repository handles into our code base
References: <20181011211754.31369-1-sbeller@google.com>
Date:   Fri, 12 Oct 2018 08:31:32 +0900
In-Reply-To: <20181011211754.31369-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 11 Oct 2018 14:17:35 -0700")
Message-ID: <xmqqr2gwdprf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Additionally each patch adds a semantic patch, that would port from the old to
> the new function. These semantic patches are all applied in the very last patch,
> but we could omit applying the last patch if it causes too many merge conflicts
> and trickl in the semantic patches over time when there are no merge conflicts.

That's an interesting approach ;-)

> The original goal of all these refactoring series was to remove add_submodule_odb 
> in submodule.c, which was partially reached with this series.

Yup, that is a very good goalpost to keep in mind.

> remaining calls in another series, but it shows we're close to be done with these
> large refactorings as far as I am concerned.

Nice.
