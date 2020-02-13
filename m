Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94711C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 14:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726702073C
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 14:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgBMODi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:03:38 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:51881 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbgBMODi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 09:03:38 -0500
Received: by mail-wm1-f50.google.com with SMTP id t23so6386452wmi.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 06:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=js3teiP1CXKZZ33ZVfok0jKTc/5wGzdTnFovlG0+4UM=;
        b=ZtODYsiT3TaRInTI50/0uoLOf9wLC3djTkqwBQ6Rq9FAd7oZz6Aa9aQgN/qLjkFi8h
         muq6CT1eiJ1iF6s14a4lQ9tEtJRGwuj27QIsBPkqwglEaZyqgKuzBkQ0dcAhEdRcrFjU
         PfsfrLuex7nEGL/zRHvc83p+jrfO4jW9a543J21v6Rs52PhTkG2Cs2fMRMH7FmXRj+r3
         CDiCHYyj40cy1pvkgPGOv3124rjggjSXqSp8g2KYEWN/FSADs4lOgYbIfhgDs2BqT3NV
         VDYoYGPivAk/zJ6xcgRH+IclzSKBb7sG5GkzwilMcvuigf0w02J9PRWOvgAyq5Gx+EOW
         W6eQ==
X-Gm-Message-State: APjAAAWEqVHxo4l6IAKSUsYNjfr6z9lWjKUY4MCHgMwo9mXMoFWwqRDi
        8qOD0+nXfiwY/USjgZzlTfBN9fktda0=
X-Google-Smtp-Source: APXvYqy147jswIQgwEvdXhRckly+omqCHXWhacN/sd2AlGP1gewp+QmafwQfGPIi5taUpVbx3H2CIQ==
X-Received: by 2002:a1c:964f:: with SMTP id y76mr5873149wmd.62.1581602615512;
        Thu, 13 Feb 2020 06:03:35 -0800 (PST)
Received: from rhea.home.vuxu.org ([2001:920:1998:b54:35fc:a20f:1b22:9bb7])
        by smtp.gmail.com with ESMTPSA id n8sm2847163wrx.42.2020.02.13.06.03.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 06:03:34 -0800 (PST)
Received: from localhost (rhea.home.vuxu.org [local])
        by rhea.home.vuxu.org (OpenSMTPD) with ESMTPA id 137ac306
        for <git@vger.kernel.org>;
        Thu, 13 Feb 2020 14:03:31 +0000 (UTC)
From:   Leah Neukirchen <leah@vuxu.org>
To:     git@vger.kernel.org
Subject: Verbosity of git checkout (was Re: Git tedious verbosity)
In-Reply-To: <CAF8BazA_Nd82keE6XG5XV5+bq0FekZYuq_ifUMAvgvd0-iGetQ@mail.gmail.com>
        (Aleksey Midenkov's message of "Mon, 10 Feb 2020 21:49:23 +0300")
References: <CAF8BazCScMN1sBspcCycOJBcepbkKfJUvh_hL9MSgNVvs4jKGQ@mail.gmail.com>
        <CAF8BazA_Nd82keE6XG5XV5+bq0FekZYuq_ifUMAvgvd0-iGetQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Thu, 13 Feb 2020 15:03:31 +0100
Message-ID: <87blq2futo.fsf_-_@vuxu.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aleksey Midenkov <midenok@gmail.com> writes:

> Can you please disable all these meaningless messages which become
> more and more plentiful with each new version, like:
>
> Updated 1 path from the index

Actually, I want *this* message to be more verbose, but I don't think
that's implemented.  Could "git checkout" get a flag to print the
files being overwritten, instead of only a count?

Best,
-- 
Leah Neukirchen  <leah@vuxu.org>  https://leahneukirchen.org/
