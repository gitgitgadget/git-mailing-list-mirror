Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56571F954
	for <e@80x24.org>; Sat, 18 Aug 2018 16:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeHRTPD (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 15:15:03 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35466 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbeHRTPD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 15:15:03 -0400
Received: by mail-wm0-f52.google.com with SMTP id o18-v6so9999728wmc.0
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X/rBamTQ9MOsCGaFlxO+vdQlbnE7GbhLpEIZXuXt0YE=;
        b=VxxGmH5C5BYBy1G/UtyKvaa3yvvdKa7lAdHhmSgNDK4ArLQeM/8dD7HaG5GBu5h3cY
         Z/lx3d7C3mCwKKztUO2Cjvuz0yrXWwFNb5Q/UN8egpUWXx/cHPRnBeOVrfPB9GnfASN6
         wOsTsd3O/3iuXtLaJIY359duTCZ5j37osmzG/pBZkNkaZ0NU9zMm7iavbjS8c6/O7H29
         hqSqaJuxoymQkezTEhRAo7exCEfIhqJXa59e/uZNLuleDw8Touul4z7God66PMzbUgUA
         wGu0KfLzCK1NYIkWxlEEU2LZvbyk2LwdDVWNmMf5Oc9ihFTlUK3efi7HG1rrrSVBoJnO
         TCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X/rBamTQ9MOsCGaFlxO+vdQlbnE7GbhLpEIZXuXt0YE=;
        b=ltT0Qgikyx1rvaPCxvmQgA+1aYkHhcBx0LHiXX4cT/wrbZJX8+yktrvW8eQE4qTJD9
         JhuvZTKLVXn9JRtaRagajlZQP6Vlnx+9FcDuSEvOV+nYrwGDh6T62TXkjeC0j/fimEFS
         aekrpu0f45ll9n7dUXTqUPofhN2oQTQ53QjToPmn9WeILVueP9k0797beSVPa6Vmrj2K
         jIwLTyhOqO6d8Xz2GhDKC6xwQ1wMdBfzrikzqrB5lx/tyHHRBhmWKHxMJe/MB9oKN5bp
         e2uPKitnRNZGN8Au6moHkzypbp9ff5qmzKQCalqs2pQS4IjKyhbhadWQWw1FvpeVAH6D
         +nTQ==
X-Gm-Message-State: AOUpUlEmj1dQtk0C4x+g8AFZMgICTGgVC0afa85dFBmll+uuchAJeFHg
        /Cd9CeI85z1HcrRpbUjYvxY=
X-Google-Smtp-Source: AA+uWPw2WheKbvpPDi0qkr+w+nApE85ohRRiOqDNFMpd+v0G+bO3A0I/drLg58sM61pAcXXZK9ds9w==
X-Received: by 2002:a1c:b49:: with SMTP id 70-v6mr22900349wml.149.1534608409577;
        Sat, 18 Aug 2018 09:06:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w4-v6sm3722580wrt.40.2018.08.18.09.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 09:06:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, sunshine@sunshineco.com,
        jrn@google.com, git@vger.kernel.org
Subject: Re: Re* [PATCH v7 1/1] sideband: highlight keywords in remote sideband output
References: <20180807125108.104293-1-hanwen@google.com>
        <20180807125108.104293-2-hanwen@google.com>
        <xmqqd0ugc07x.fsf@gitster-ct.c.googlers.com>
        <xmqq8t54bzo4.fsf_-_@gitster-ct.c.googlers.com>
        <20180818063534.GD241538@aiede.svl.corp.google.com>
Date:   Sat, 18 Aug 2018 09:06:48 -0700
In-Reply-To: <20180818063534.GD241538@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Fri, 17 Aug 2018 23:35:34 -0700")
Message-ID: <xmqqefevacbr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> And here are some tests to squash in.

Thanks, will do.
