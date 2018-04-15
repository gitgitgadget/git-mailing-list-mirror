Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 820EF1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 21:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDOVFv (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 17:05:51 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:43901 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752528AbeDOVFu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 17:05:50 -0400
Received: by mail-wr0-f173.google.com with SMTP id y7so20635052wrh.10
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kKZPQSIgE1GrWWAdhzUZ1zSXF467t8m1LT22xUC7yEk=;
        b=aIjRLAin0ES0Gah89v9X/nATJTLvWikzHPCCKzYMMC7VaO1zzCybEH6q4C+SRa5W6j
         eUPgfc9bffQ2nfQl5RC7YDglic58dLddxdENgL1TuPK4BaugvRkgAQC7U+Yn3snBC0ON
         PbdItyaf21+M96PJDCHT/f+uT0carmpV7w+iIyVX1+IyQvdw7r+uHurLtB1QZ3AIghzw
         E5+D73SY16RusTs0ATLdKB1PkZPjw9z/wZ56bmZcnpTNcLU3dBIgnYWaN2JysZ9S9F8E
         Od4um6DGo8CPeb9H1dh4bnltdXH3D1vjwGqtUP3rU/GUOINNctuY53q912JL6gJXR1Mg
         LE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kKZPQSIgE1GrWWAdhzUZ1zSXF467t8m1LT22xUC7yEk=;
        b=JwjtcFWETojdozsBkUPfuTvy/QmQ5mjeEXTjG/97JxB4w1Tmy37Td8IOSiXMds+sV7
         ICBy7gEDmGqINEO0gAn4KL/4y+PxCNzTaGHvn/bOAA+gb2cIQ6iNAIHDyr9Nz0mxqxSe
         zuAOb3v4bopEIlKS3v2WSiKc0FlZimvndNnIzaJNOhLJupBHa3189jn8fYC1pyDNQBdD
         nL3+84n881bnLtRfo60+NvcFJBcT68DW+DoZSVW+eqE7P2xbNIZ2Y+vom7EhIWJyx6/u
         htIz5HOBddVvevAA48E4kPgFuf8ozcVIAEWI5AHecKEjw+mVHIzDzlYaI1ZvUjlF3H7Q
         clFA==
X-Gm-Message-State: ALQs6tAiu5VYUpNAzkVoj5ltRxpGAU85DkXAZc5SJasXsCoG4yU8eiF2
        +gRyYn6SRu3g9fPlp+QvxdM=
X-Google-Smtp-Source: AIpwx48gQiPcWsCfFAr432qvjE6eQaGvLvJ8nqfK5Tc2b59g8mYCGcSFlxzy7ZOI1cXIO92QehN4gQ==
X-Received: by 10.28.45.200 with SMTP id t191mr8400158wmt.8.1523826349070;
        Sun, 15 Apr 2018 14:05:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 58sm23217437wrv.41.2018.04.15.14.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 14:05:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org
Subject: Re: .gitattributes lookup doesn't respect GIT_WORK_TREE
References: <877ep8p9yz.fsf@linux-m68k.org>
Date:   Mon, 16 Apr 2018 06:05:47 +0900
In-Reply-To: <877ep8p9yz.fsf@linux-m68k.org> (Andreas Schwab's message of
        "Sun, 15 Apr 2018 21:04:36 +0200")
Message-ID: <xmqqin8s18pg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> The functions in attr.c do not look at $GIT_WORK_TREE when trying to
> find the .gitattributes file.  Thus if you are not inside the work tree,
> but have GIT_WORK_TREE set attribute lookup will be wrong.

I may be mistaken (I do not have the code in front of me right now)
but IIRC after the setup.c code runs (which happens quite early in
the sequence that starts from git.c::cmd_main()), the Git process
moves to the top level of the working tree, and at that point there
is no reason to pay attention to $GIT_WORK_TREE or other mechanisms
that places the working tree at a non-standard location, because the
attributes (or any in-tree files like .gitignore or .gitmodules)
will be found relative to the current working directory no matter
what.  Did we break that recently?

