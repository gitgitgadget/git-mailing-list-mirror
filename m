Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5CA71F453
	for <e@80x24.org>; Wed, 31 Oct 2018 06:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbeJaPja (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 11:39:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54706 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeJaPj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 11:39:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so13969849wma.4
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 23:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/gENSvuMCxcoW+auNzpHA/o5KQDXqms8M+icT1svh5E=;
        b=AFwtfwJoGVH6Y9XHSYx3n1yo48eLIFwh2L5mAki6h8EAwVZW6aXwsWG9VH/RGUV7+k
         JbrruUA57MKolhbO8kuiUsZ5G2PnmiCImYsHVAYcrAPOqehmR2t7Jbu9gV3S/DHM8JBR
         QWt6MmlrKe1CN9mUZYD9tNO+WSORFq/ZQFecKX51cPjcEhU30wTf6uTAh5fqTKyq1JS6
         7D/yv7EVCDYgjbenzuJF2pBDWLfY+A1LmlAuIeunac/m4Q0TzWOZkiKvDCiZVxU+z5I6
         4QktrczQdUE/+FmTn2DU3CHd8PdnM6YqhXfNjpsdp+co52gPeS3bh3YqeDGdw8x9TIle
         JRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/gENSvuMCxcoW+auNzpHA/o5KQDXqms8M+icT1svh5E=;
        b=HTMUezqnitiqthRkl2rC9nhEBZhc7ODGDnTXNQLJPak3t2uV/hGkXzOthkXa9/bC8i
         Y1+HseKRdr9Os9AgVRDovpQd9j+EjDOerIYfBKghvgJQYJT3DHvdiJt+aoh4N33/739V
         4vw4BnXUysYXsMXiEyyWI6g0jy2D0q+oxMOTMl9erXXanwyW9c1pHEhwlpUpzK2vcbaq
         eVWwIXXAhJm18nZy3zJly1fCGY/0SrGwzi7n5eERD47zrOAU5ZosV18mtu+/Cy4VdFjz
         LA1LJ3hDcw9l4uxnrJkjnYIIV84emy8mVl2EZ8GrTxlMutgOF1veyXl3oB18pVQD/pTb
         hhxw==
X-Gm-Message-State: AGRZ1gI47uJnWppBG3lCLuF9l/nWwerbPbZ4ruhZIPlGs0/IimXAQHiA
        vqdACp+a+av3NNjH1BcWTA9Ox+8vqy4=
X-Google-Smtp-Source: AJdET5fVMx5RdJNsomzgrEuUF0Uoc0xlEq9pMzvxourxKicF6Lfyq4daxTO0oaZKh9wGfpQ51IXvFA==
X-Received: by 2002:a1c:9f01:: with SMTP id i1-v6mr1218197wme.8.1540968160633;
        Tue, 30 Oct 2018 23:42:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x13-v6sm2320363wrq.56.2018.10.30.23.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 23:42:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH 01/24] Makefile: add pending semantic patches
References: <20181030220817.61691-1-sbeller@google.com>
        <20181030220817.61691-2-sbeller@google.com>
Date:   Wed, 31 Oct 2018 15:42:38 +0900
In-Reply-To: <20181030220817.61691-2-sbeller@google.com> (Stefan Beller's
        message of "Tue, 30 Oct 2018 15:07:54 -0700")
Message-ID: <xmqqzhuuvcpt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> [Missing: SZEDERs sign off, so I also do not sign off]

At least to me, based on my reading of DCO in
Documentation/SubmittingPatches, this reasoning does not make much
sense.
