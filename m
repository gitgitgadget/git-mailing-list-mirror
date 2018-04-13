Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD2781F424
	for <e@80x24.org>; Fri, 13 Apr 2018 08:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbeDMIwx (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 04:52:53 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33707 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeDMIww (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 04:52:52 -0400
Received: by mail-wm0-f47.google.com with SMTP id o23so6148125wmf.0
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 01:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=guj5jkSSaPkjAFBVEguGRhZpCqzDOo2eCHZCgGUYDvY=;
        b=OQgQ6j66CAAkV/7s2i/Ncf6//i05JyKvhHV0ci+eaUPo5wEniOaVL8VjDyEx6dkXHF
         DsiDosiYpVtQYphgTi6Ma3dsYhQu25DOOLWMoSjWLhgtDy5LZr+RPNJuzAY9MXoxuRlR
         z5/JmZQYxX95197OcQnzqB2ahFEGoy9wpCSlYLH1O9ge4dcG5fmCLEL42ENjUw6NBAm4
         JJneLfBMWI7440nPWwt61lCGe5z+QiXZ1fzm2O7QIyQYS6oPnxZzgKJFxFmR+B5QDjDe
         eWfMsSVV3LfANGB3WoICl0WQpoSCUdupIO/0qdTSGswXxrZdynaENhKWCXl90obpNRG9
         dplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=guj5jkSSaPkjAFBVEguGRhZpCqzDOo2eCHZCgGUYDvY=;
        b=YmLv0A/OYozFJ/mTekVB8AdSeQfsGclRJT4xOkWXAkKyBoAdX4ux1aZ+h9hdiPy6+H
         ZlPvIaPFWRTylVhI+XfTNTRbx8E3dS4RPIGDQkUoIEBptoNkghbK07brulgfeJ5Joufx
         2PcIcJ77g8v+eSdAmcZ8KGrWkRaqSZhEzfywTKfrnkF1up3gs+VjPHCWoe0HOKg3v3nF
         uHO0+lWwU7U9/+IXiJ/HbNhXf2KggmjE+THjU43ulZz+q6oARuWXblPjUJce2hkCIjVj
         zoijKOOe6FCrtJtEiwRQWwYuHUp+jCvHB0jwevbKY6YjDV9BJoZeh/poWx6Bis0GiOiO
         KQgg==
X-Gm-Message-State: ALQs6tDeY2F95EcCpjoHZfkc5cKW+WBBSqk+61uZn8pcxJztqAc9ItK2
        02rgPzuWzJtzl1NGRVK2x/Gh/9lK5D0=
X-Google-Smtp-Source: AIpwx4/S/j/oeauaw8JEBkzXYmZ9qcDSLgN73DUqdPDD/or7EibQBLZMGAeBfRbXhie119MUJZ/uLg==
X-Received: by 10.28.236.76 with SMTP id k73mr2748666wmh.122.1523609571257;
        Fri, 13 Apr 2018 01:52:51 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abrf152.neoplus.adsl.tpnet.pl. [83.8.99.152])
        by smtp.gmail.com with ESMTPSA id y4sm3791128wrh.39.2018.04.13.01.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Apr 2018 01:52:49 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: File versioning based on shallow Git repositories?
References: <hbf.20180412fvfi@bombur.uio.no>
        <87d0z4b6ti.fsf@evledraar.gmail.com>
        <4af21bcd-7a68-50df-4cce-0b050ccaeb90@usit.uio.no>
Date:   Fri, 13 Apr 2018 10:52:45 +0200
In-Reply-To: <4af21bcd-7a68-50df-4cce-0b050ccaeb90@usit.uio.no> (Hallvard
        Breien Furuseth's message of "Thu, 12 Apr 2018 21:36:40 +0200")
Message-ID: <86efjjmqsi.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no> writes:

> Also maybe it'll be worthwhile to generate .git/info/grafts in a local
> clone of the repo to get back easily visible history.  No grafts in
> the original repo, grafts mess things up.

Just a reminder: modern Git has "git replace", a modern and safe
alternative to the grafts file.

Best,
--=20
Jakub Nar=C4=99bski
