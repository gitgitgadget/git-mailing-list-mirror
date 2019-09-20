Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3535A1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 22:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393818AbfITW30 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 18:29:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39533 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393795AbfITW3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 18:29:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so3606604wml.4
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WO1qyeRukYdaKQoeJ747541fH/nZPSh7evYwh84tmro=;
        b=MJUPUMJn8+AYxBfEmMVgNEHYMLt62a43Iyuw9hT25hj/aCMdA45EoR6B/ISyRzobH/
         wtnOFacsFKiUbULokQHTEBp7MGwX/roKsGi4kgBa/gYqVRwgUePwX1wEg6c3HMWrq+B8
         pjCO8iycnfzcR141shF2b4PqSifW6PVv7pDJMux9Y3xEC/JiMwC/tspVgn1mzax8qPZ3
         cphbkJo8uy0FL/4BCrlmixt/YtUBjpncc1CE1Ziwn4SvQdM+KLzc1HfXnffYxO2DG2+e
         CtlZ9wu663dJzM0Kmy+UUl7okt1eJY75StMaLmSpEjfdgN8tWM5QRlmzgJDzGshB7KiJ
         wOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WO1qyeRukYdaKQoeJ747541fH/nZPSh7evYwh84tmro=;
        b=YlVR1xxFDDBL5oR9GsTLraMQd/Ur62O0VVojpwcgomQ5SxexMj+IH8ThwfzJJC6bAE
         wZckDk+we8OHzHpNHA0NPwOxKNklHUSFXS8T3qdH0vluhxLXyNJiLhXMlzQKkzk2ls5W
         k2QB85oAyCmQPEgzEJqxxGn7PfBB7eRJs+wSDBO+bP9R8Sp4+oq+R7U/oY6cOk8afRPZ
         OKAqmVvqJkv9ng0RIdE3P6icZs+a8kZ0LfjH4v25ZrK7kBa7b5wdVhZuFdqSGkmms+50
         aPXJqDlJeVchHGXNaa+VO2FJYLpLGK9yPV6pQqazZ8FwLbAdxz686Z9pfY1WY6eo+YUc
         VPbQ==
X-Gm-Message-State: APjAAAWKSZqPNDcYn4eOKmohPA7nBG3KREBrVVaeoWFlWE2MWgeRwucT
        JLGCOikKCLz/6LfUZsQYEVY=
X-Google-Smtp-Source: APXvYqzgDO7eBlY6k+2uhxWs3MuAG2/TSJxgwMM4Y7bB3H0Dnc3d7TGY0iz1gc3z1hvC9PK9py94VA==
X-Received: by 2002:a05:600c:215a:: with SMTP id v26mr5426208wml.9.1569018563758;
        Fri, 20 Sep 2019 15:29:23 -0700 (PDT)
Received: from szeder.dev (x4db40123.dyn.telefonica.de. [77.180.1.35])
        by smtp.gmail.com with ESMTPSA id o188sm7949509wma.14.2019.09.20.15.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 15:29:22 -0700 (PDT)
Date:   Sat, 21 Sep 2019 00:29:20 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/15] t6120-describe: correct test repo history graph in
 comment
Message-ID: <20190920222920.GE26402@szeder.dev>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-2-szeder.dev@gmail.com>
 <xmqqv9tmskqt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv9tmskqt.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 02:47:38PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > At the top of 't6120-describe.sh' an ASCII graph illustrates the
> > repository's history used in this test script.  This graph is a bit
> > misleading, because it swapped the second merge commit's first and
> > second parents.
> 
> Hmm...
> 
> > +#       ,---o----o----o-----.
> > +#      /   D,R   e           \
> > +#  o--o-----o-------------o---o----x
> > +#      \    B            /
> > +#       `---o----o----o-'
> > +#                A    c
> 
> What's the first parent of the merge between 'B' and 'c' in this
> picture and how does the reader figure it out?  What about the same
> question on the direct parent of 'x'?  Is it generally accepted that
> a straight line denotes the first ancestry, or something?

I've always thought that the parents are numbered from top to bottom,
i.e. 'B' is the first parent of the first merge, and the unnamed
commit at the top is the first parent of the second merge.

Would it help if it were arranged like this:

  o---o-----o----o----o-------o----x
       \   D,R   e           /
        \---o-------------o-'
         \  B            /
          `-o----o----o-'
                 A    c

This is basically how 'git log --graph' would show them, except that
this is horizontal.

