Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 206A220248
	for <e@80x24.org>; Mon,  8 Apr 2019 06:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfDHG5V (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 02:57:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37845 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDHG5V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 02:57:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so13367744wmf.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 23:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yXWnIJ7dhIRX/fiyw7C+PpPLCwK8Kl7zpuG/pc0H1bs=;
        b=qO8xCCexhkGcjkSacqXcp3vMdtjh4JdvK8Qdx3vGfl/xwj1rGw9a4+EtfzlHuDJ9tS
         CAEK2pfxKhKp1XJpzBQ22eQoSUq0BIHff2V4vJEKfkoYJ8igi1aMaGu/uyq7guQiLWtY
         02QbVn1VmnekUo1XQaPaB+3n/MDgWEVcODwfT26qgiPw5KomZUzmxjk97Yf/C3UYymIb
         fKF5c52FhUpNzwVSQlLaNhTbT3R8zO42Jv/MRgSxAP1vuC27hbUnvy2/dMfkyAClD+J6
         RTWZsaK/9FxJyy5v+2H+E4kOlHDENqYcEJPDmt2enQcTs6MLE8Ux/FdUFK64HhI/UXz9
         gwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yXWnIJ7dhIRX/fiyw7C+PpPLCwK8Kl7zpuG/pc0H1bs=;
        b=X9uymV2JpFvb7sl/18Tt3ldYRUiy3m4042IWJiyijjhMjUSMSSTEBiE6OkVTqCX6Ge
         7A1TeoNgeqSKvgPDKOzzM3dsQorXiF7v/u7WfO2toPQSbhFomf3if3P0wnabqGN/K6/s
         FRU4QWynnRzb/2/lgt9gxO+AeKovSZpidXDA+xJ2nlFF2eB4RtAYa4BNKQFoFO83krQD
         Cndfssoa2NKaM02tDH9NDHMiL3tycigrOAo2Kf+g4xQzNH8ALvS4EennZCMQ5uS3snqn
         vfLgHsXmX8smYEUYV5RlEClM+dSqrtuaKjj5FDXS3X0ojpgSZXVQIqlaugWeokGmQpEp
         JzdA==
X-Gm-Message-State: APjAAAXKFJTR8viBAAOAwu1laTSqqIpSO5EtnC4dLmQ4F6B5T8g85Fr6
        GD4jEwQPFU5P0nbJQHLYSEnpdbb7xmg=
X-Google-Smtp-Source: APXvYqzfFL/N+CQn1jLIw/VQNCZRE+YzOvj4N0fV3eOF1Z5Dk41jBcQaOXKb/Sgfb5qmpipM0l7+BA==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr16984301wmj.22.1554706639474;
        Sun, 07 Apr 2019 23:57:19 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a10sm30891099wrs.19.2019.04.07.23.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 23:57:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
        git@vger.kernel.org
Subject: Re: "commit --author=..." does not work if global email and name is not set
References: <CAA01Csp7y9=2n9=TNYMMw9LUO_cENz7FBeZjFrUd2FvHFT9NCQ@mail.gmail.com>
        <8636mvng8n.fsf@gmail.com>
Date:   Mon, 08 Apr 2019 15:57:18 +0900
In-Reply-To: <8636mvng8n.fsf@gmail.com> (Jakub Narebski's message of "Sat, 06
        Apr 2019 20:25:12 +0200")
Message-ID: <xmqq36mt9e7l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> As Junio said, the "--author=<author name and email>" sets the author
> identity, but not the committer identity; you can work around the issue
> with "git -c user.name=me -c user.email=me@email.my".

Having slept on this a bit, I am of two minds here.

It certainly is possible to change the rule to say that committer
identity, when not set at all, takes the default from the author
identity, if and only if the latter is explicitly given, and that
would certainly make it work as Piotr wanted to.

But then, that is only valid if the users use --author with the
author make that refers to self every time s/he makes a commit.  I
am not sure if that is a plausible use case.  The command line
option "--author" is really meant to be used one-off to name
somebody other than self in a rare occasion.  Use of --author that
breaks the built-in safety of committing under undesired identity
(e.g. "<user@localhost>") without realizing before the mistake is
buried deep in the history may not be such a goodidea.

> Better though is to focus on what you want, namely to prevent accidental
> commits without specified author, instead of how you want to achieve it,
> i.e. using --author to provide both author and committer identity (the
> XY problem).  On that machine with "automatic test account" set up
> pre-commit or commit-msg hook that fails if the GIT_AUTHOR_IDENT
> environment variable is not the "automatic test account".

It could be s/is not/is/ perhaps, but I do like the line of
reasoning and where it leads us.  "To prevent mistakes" is something
hooks are good for.

Thanks.
