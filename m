Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85C00200B9
	for <e@80x24.org>; Wed, 23 May 2018 01:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753618AbeEWBzh (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 21:55:37 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33075 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753545AbeEWBzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 21:55:36 -0400
Received: by mail-wr0-f196.google.com with SMTP id a15-v6so16171543wrm.0
        for <git@vger.kernel.org>; Tue, 22 May 2018 18:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ege6c3/aOF32tAO2/kPqisXSXxTgJwGl2XGehVQAeNY=;
        b=IybJ9AAi2uepfo4z0TjQiVRgWRwUavYCPDkL22CRvTt8tKz79cfodUx//eSbKiTUaM
         IXN+zuEXtPBYZHni8KJAI2PO3exB0/4oaS/dznK41E/Bw8JGlNgoG/VE7xyojR7OCHOT
         fvN5awWKAcYmubbkK48dtIM75NPQ61IgZD12PxYig9/PIwNwNPasTm8u3JZXOh10eq8R
         RzyF0KYV2K+btoQw5mCrvkiTwQ75tDKwF0vaMoBUkCuPuRFUiGr7pW0IZd+Ax36dTF6b
         KLipkjUHfpCp4ofDLzsSlkgRttW/vs86fBDA9YmkE7nzWcYRegiuD1h1PdnPutvhqpV7
         I35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Ege6c3/aOF32tAO2/kPqisXSXxTgJwGl2XGehVQAeNY=;
        b=PfngcGABPlVdnkWaZOdztFE8TQZC3KfV+YiR2m3Y9VblMbXoSPYKaGMZF7P3xG2XY8
         dWKZZJchk5tpnqx6IAddmPHW3h2TJeeHaxjrVssvYXFQt62L/8sFkbj8xf8X0CUIDL1A
         p0ww33vI0z1UJyQxIxdPImlJT3RtWavG3TDbKYbJVGz9oK0MrUYAJ8e2odZjG3ZimLu6
         djERu3OVTxCqgRIk5c1FoRH1mQXNCnDLMz/6ni2DO37Gwf7UZb6jnSrMmdzev2FD26FE
         E1ahktRFyQYdW3zlJN+3P6QWhzATHsfjuZ6QO0AHi+XJcfAitUpFvY0gPpaeokz/+W1a
         pHww==
X-Gm-Message-State: ALKqPwen1KTVRIBQBx6ZpUrzxU7TAME8aSplfXuisi9izt1hCUbC8SEh
        mDF6c4BE1ZLGZCpig5zwpFg=
X-Google-Smtp-Source: AB8JxZrQZxbFiCfDjeXeGic2MPeXz7bwafqu5TOUE7ukzH8zVV3cOmoeLUYreryIU/8iIddi0M+rkQ==
X-Received: by 2002:adf:e70d:: with SMTP id c13-v6mr656637wrm.203.1527040535147;
        Tue, 22 May 2018 18:55:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m64-v6sm1679175wmb.12.2018.05.22.18.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 18:55:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: should config options be treated as case-sensitive?
References: <alpine.LFD.2.21.1805220353370.989@localhost.localdomain>
        <87h8mz99d2.fsf@evledraar.gmail.com>
Date:   Wed, 23 May 2018 10:55:33 +0900
In-Reply-To: <87h8mz99d2.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 22 May 2018 14:13:13 +0200")
Message-ID: <xmqqo9h7w2y2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> The issues you note about the docs using foo.barbaz instead of
> foo.barBaz should be fixed, but as noted in the "Syntax" section of
> "git-config" we already document that the config keys are all
> case-insensitive. We just like talking about them as foo.barBaz because
> it makes for easier reading.

The first and the last level of configuration variable names are
case insensitive.

I said "first and last", as there are variables with 2-level and
3-level names.  "foo.barBaz" is two-level and it is the same
variable as "Foo.barbaz".  "remote.origin.url" is three-level, and
it is the same variable as "Remote.origin.URL", but it is not the
same variable as "remote.ORIGIN.url".

If the documention does not make it clear, then we have
documentation bug.  As you said, I think we are OK in the sense that
we do say a section or a variable name is icase and a subsection, if
exist, is case sensitive, but there might be a better way to convey
that fact without having the reader read the whole three paragraphs.


