Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5E581F404
	for <e@80x24.org>; Thu, 29 Mar 2018 20:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeC2Upk (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 16:45:40 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41347 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbeC2Upi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 16:45:38 -0400
Received: by mail-wr0-f193.google.com with SMTP id f14so6484142wre.8
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 13:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2Vnz6ZLg9qcvL5MyNQCIj1g4gjuL9nsgLmNpHeuH7vY=;
        b=MB+PLptm5q2Dd0Hk5z/lKUyxvnG0VNXaqd0HgwA/2nK5julpw4H1bbLoysKH0ILg+z
         Ez+l0gGaWq+bi9pwDXNn7hpZ9jTlWocCQ9mcAHwFrlzQp2ygaCwLY5n7x7xNnOb82n2t
         PeAtuDRPeFCFzcwRE/A7PzvjdG1GKqZT70Zvc4omDPCztR26dC92x+uVGlNtRChLwg9c
         R7msK5o2lSMKdJiAIASY0xsGFwlflLmJ8WmTNg5A4PiLAtuDSH2IZ5ebLFBYsAlpn6mQ
         oYP2+ARaC7hwTtbEIGLzZY/ScT78dkM7W77EUGJMNvJ9CWINNNDclerSPOXcif34M63E
         keMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2Vnz6ZLg9qcvL5MyNQCIj1g4gjuL9nsgLmNpHeuH7vY=;
        b=jTSj5PPVicSJKrb/+XzSDoEBcIbkP2jzriOOX/EFeWPYwXkDOwi1Wysa12nKDhGO6y
         zPnKaKS0Xjffn0A2+Rxg0vRGo0fe3+rngNCCaWKDb9qlo9XpWFD8yRxi/NtVKTcWytXz
         jBK3i3AbMQYL/Tk/JIsa41Bbp8nz3pc21/VUWieG3xG5ju9mOV1GLUwMc/PCdBRWRsbR
         cRQ1X1X76s10l+xlUUL0jda4J7JCOdA76VST/mW+Ho+MJBRw4CWH12DNPNtXpjlPCxxu
         w+eSQotpcMANnUo2z5FC2GiJC8age3Cl3EvEGb4Ue52y67DadKts1r6/YZeZ2U1B/YEt
         yeQA==
X-Gm-Message-State: AElRT7Fwj+NSJ1DT178qIKC0eWFSMDP7U4gfHlbFl9PUxetKNrlW6PCq
        PMv79fv4SkcEFKsd7308DGI=
X-Google-Smtp-Source: AIpwx4+BKSh2LStnrGuObyad9RICPWyn1TnuwBwVvxJdH9iVSNDGHpH1JxCDRB/+GrhCBxbP3juhxw==
X-Received: by 10.223.177.145 with SMTP id q17mr7664413wra.26.1522356337304;
        Thu, 29 Mar 2018 13:45:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o23sm13751421wrf.93.2018.03.29.13.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Mar 2018 13:45:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 4/9] t1300: remove unreasonable expectation from TODO
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
        <5801f7529465b7dbdfbe3c105e2a8212c253ba0d.1522336130.git.johannes.schindelin@gmx.de>
        <20180329195218.GE2939@sigill.intra.peff.net>
Date:   Thu, 29 Mar 2018 13:45:35 -0700
In-Reply-To: <20180329195218.GE2939@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 29 Mar 2018 15:52:18 -0400")
Message-ID: <xmqq8taa626o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> An obvious question is whether we should preserve the original
> unrealistic parts by splitting it: the realistic parts into one
> expect_failure (that we'd switch to expect_success by the end of this
> series), and then an unrealistic one to serve as a documentation of the
> ideal, with a comment explaining why it's unrealistic.
>
> I doubt the "unrealistic" half would be serving much purpose though, so
> I'm OK to see it get eliminated here.

Likewise.  The series looks good so far.
