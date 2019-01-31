Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402861F453
	for <e@80x24.org>; Thu, 31 Jan 2019 19:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfAaTJm (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 14:09:42 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35376 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfAaTJm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 14:09:42 -0500
Received: by mail-wr1-f44.google.com with SMTP id 96so4584110wrb.2
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 11:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eM+xkwxqMgteTrjmUnQWSlMebjIjgjBBv8/DSx88k8Y=;
        b=HD7TjzBAgHsygJzhq4t9JjJOqOOHkyzPlZCaGwjeNs+PuYCBqk/5g/8JVeh+OI2Zm7
         4aH4tY2JCXWXnNsJObt9x7r8FYj1vKz/soxjfsKzR9C9Ui10Wz6rCEmfRLMN/tQSzm8J
         I0hKP430xOLXk1J9dqxdP28gb+qevxHJLSuhuRGuGLqkeTMfYmV8cTzNKj0DwdwYjxLm
         /VgehgzGS40eOJM0DISPbFMMp/+grh4Guo4TsKIiyJsLZowVB0hXmHrrsRbo3Dy62aks
         iFLjkdeqiITZ3Ppspfz+SnPNJYMz3P0t3N07CMTCSHD+uwNVVLQAGLL149P27e0qDOG5
         verQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eM+xkwxqMgteTrjmUnQWSlMebjIjgjBBv8/DSx88k8Y=;
        b=kwgOSxKpO0+rJ7okSc7SmrnbybhQktNdEPaR5aIT/TJBGE1G98iweXDCmWKpFkv7f6
         0l1AcUzTWzDC088XtzHZsQkCN5m0FacXWmm/ytYILSEEnZ8dAdKAp6o3WdLlLxyes6q3
         lh5eW5CZUzMkO3v/4Gy8nBCNz9SFvkraXMsG4gK+gYEzUuqV72ncV7KI1B+tyhaL50zq
         aeNE19HIG8ttWGLw2r5MwNF+K4QD0xZirX9TGdYHvcbtHbkxq/1AdgYnrXsMM69rUfzw
         eRBSgerghO2HocTxIKe5xgMsS6UYk57UXDR93opaBqMdfFcBe6qbwcrC8e+h/253i3FW
         bngg==
X-Gm-Message-State: AJcUukfH3JJdOYlCTvX7LtvCdlw3P6/+roSVhi5YQK55jxo2wUNnwZXu
        RPcSzWDmoVwymvPNOVuto4k=
X-Google-Smtp-Source: ALg8bN532q4ve/QWABniAoky9Uhqlf5mVvrVnq2loQvsnayIWvMsRny/I0+SmA4iF2vl6TNRbvUhjg==
X-Received: by 2002:adf:e891:: with SMTP id d17mr38272448wrm.140.1548961780642;
        Thu, 31 Jan 2019 11:09:40 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a12sm6357147wrm.45.2019.01.31.11.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 11:09:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: New command/tool: git filter-repo
References: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com>
Date:   Thu, 31 Jan 2019 11:09:39 -0800
In-Reply-To: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 31 Jan 2019 00:57:36 -0800")
Message-ID: <xmqq36p83aq4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> git-filter-repo[1], a filter-branch-like tool for rewriting repository
> history, is ready for more widespread testing and feedback.  The rough
> edges I previously mentioned have been fixed, and it has several useful
> features already, though more development work is ongoing (docs are a
> bit sparse right now, though -h provides some help).
>
> Why filter-repo vs. filter-branch?

How does it compare with bfg-repo-cleaner?  Somehow I was led to
believe that all serious users of filter-branch like functionality
are using bfg-repo-cleaner instead.
