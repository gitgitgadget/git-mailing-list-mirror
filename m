Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13A471F954
	for <e@80x24.org>; Thu, 23 Aug 2018 13:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbeHWQqX (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 12:46:23 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:37625 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbeHWQqW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 12:46:22 -0400
Received: by mail-wr1-f50.google.com with SMTP id u12-v6so3346341wrr.4
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 06:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nVridlJj90P6NqjLZwXpJhpt9wCzut/8dg+/8xe0RpA=;
        b=QWLr3uZHbxULSQ00qQ/g1vOjbYRrVYo+oGUREabrAGK49tcw30Yx1wlOx0LPabgbSo
         oxMCpxVgMkW+BOnjt16a/qA3QL0MHnOHg4oD7RDXM85X53iIPUBzLqE2GqPpsa/bOo6e
         KQgfi6ez1KmjcG2+fZEDXQNtdVroUuOjuBMRiBE8i5UGq1JeI1orZ5bOurrlo5jDhIOE
         qbKwtzwAu5RTFlpvcRRLQSL0QnfDgKakI5OlY3Q+rr8nOTKEfPFmX46+bb16ITKGTwSv
         r2bPL5m3BSHnDjxaTvdc2sVNSB8gYAHIp0VBeYYEXPfyfPS3neDXM0Y9vgp/TqtA/n0p
         I1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nVridlJj90P6NqjLZwXpJhpt9wCzut/8dg+/8xe0RpA=;
        b=nNadvzpDJjmqeO4rOlWl1wmt6xeA9T88dfUu3Dg4Q95ssrSZz4I7h+9n6sCUpcLOeu
         3Ix3053CzODiWm71OgA+5Rw2U6VXD87y31aSfH/W4L91nmRYqxXz3dcVAof7i7eL4jfZ
         egB7ybxYcvjp4zB/0AHfeC+xcbU4Yk8LRXISHAmvtV24m9qG1Xu9iNAJ0OYdA7E5KHmc
         2xYVy+cZoGymL4Sgcea+uXMY84ggKq7u58nqggkhCxxKkHPH1dDyMUOaWQsMioIJCiLT
         mhAyfvHDnilHjYtRIWYV3IuFsW/Q2pZe91FnqBRvxVXUKCBGzuxEmrOa0giIJX19Lny6
         1EbA==
X-Gm-Message-State: APzg51AbmIkQnW62eTDDCEuU4JafHmSS5RXo1PJMqtx/jf6lSnY6is0q
        +K8O+2smAWQbyGeMEbVfJw8=
X-Google-Smtp-Source: ANB0VdYnRSiA+7bJq4ZutQ6t2ikQOyrD9t2v0slMCpP2L/vdqWX06AzYfba9X03Honi8zUCFzdyh0Q==
X-Received: by 2002:a5d:68c9:: with SMTP id p9-v6mr1234773wrw.108.1535030200858;
        Thu, 23 Aug 2018 06:16:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 72-v6sm5905325wrb.48.2018.08.23.06.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 06:16:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
        <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
        <20180821212923.GB24431@sigill.intra.peff.net>
        <20180822004815.GA535143@genre.crustytoothpaste.net>
        <20180822030344.GA14684@sigill.intra.peff.net>
        <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
        <20180822152306.GC32630@sigill.intra.peff.net>
        <20180823012343.GB92374@aiede.svl.corp.google.com>
        <20180823021618.GA12052@sigill.intra.peff.net>
        <20180823034707.GD535143@genre.crustytoothpaste.net>
        <20180823050418.GB318@sigill.intra.peff.net>
        <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
Date:   Thu, 23 Aug 2018 06:16:39 -0700
In-Reply-To: <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com> (Derrick
        Stolee's message of "Thu, 23 Aug 2018 06:26:58 -0400")
Message-ID: <xmqqefepkytk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I was thinking that having a mitigation for 2.19 is best, and then we
> can focus as part of the 2.20 cycle how we can properly avoid this
> cost, especially when 32 is a valid option.
> ...
> ... to
> take a 'hasheq' approach [2] like Peff suggested [3]. Since that
> requires auditing all callers of hashcmp to see if hasheq is
> appropriate, it is not a good solution for 2.19 but (in my opinion)
> should be evaluated as part of the 2.20 cycle.

Thanks for thoughtful comments.  I think it makes sense to go with
the "tell compiler hashcmp() currently is only about 20-byte array"
for now, as it is trivial to see why it cannot break things.

During 2.20 cycle, we may find out that hasheq() abstraction
performs better than hashcmp() with multiple lengths, and end up
doing that "audit and replace to use hasheq()".  But as you said,
it probably isnot a good idea to rush it in this cycle.
