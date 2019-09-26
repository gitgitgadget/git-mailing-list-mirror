Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D0161F463
	for <e@80x24.org>; Thu, 26 Sep 2019 18:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfIZSdx (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 14:33:53 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:37482 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZSdx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 14:33:53 -0400
Received: by mail-lf1-f53.google.com with SMTP id w67so2467202lff.4
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vF10kJqjoEL1sPWZjSbwxjj1quilMJLZC8t/74TlSoo=;
        b=MdEMGB04gc5ZtXVMogzdtjdWdvOQ44K/r0M9Y9VfA5qAWsu8n0WhRkNqD4GYZz8Huj
         jrlaAI4vs6Y72zkXhu1YWo1+vHAKL+/YJq/zZVG6i3bVCnGXkbjc67Q9xeHhNTidu5/m
         urJaASmPGL9AHIPJSPUU8+8Fzc1wvGzOF/bMEegEEej6YyK1glGHFRXKFQ85Z7YSc3Av
         jK+IksozKMZEhTtb3v37iqWsmAuOPtisTQp0F04L3jRn9q6YJ9ADx4Jb41Bs4rtYypXa
         F0aR3QWcDe7k8R0YsKLemisFBgGCgX8QWOoDXrRYSmWoDmukopARoCPm/osd393w1TNX
         6a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vF10kJqjoEL1sPWZjSbwxjj1quilMJLZC8t/74TlSoo=;
        b=qE5A+tL4cJcgEGzv1FXETv9WQtbL7pYKmuKiRkRYrPdq+XHdXgedVYT9wANGtt7niG
         XgC0L5MTdQGeydM8q8obI7RDBhbUgBQgFyMfYJXbihIG8K+/2Cb28qFeSrMezJCiz22u
         zQORRm4CqzgyApWFXT/6kjmKa8VPd26/1c+JttQBpfc1uk7jn4TrTS8yhp6+rqg/Czz+
         DLaWJlgTGavWK561K2EJNuE4DZIUDlff4XEpoZnPPsL8QUtr9iswYW5msh4/sA9ybAse
         +N5CgpSV0UehrXLDvxzpYxU6sn3SabBWhP3btqzs6fCi3sBsj28w6IQV5AGyhLNHTogY
         wOJA==
X-Gm-Message-State: APjAAAU45n7V/R1iPbIEP/f16sjfrwiTXgh/Ot5shm/zhab15aVkK189
        fdnN3VZ0DnFTjIcGOIE85NnCZdhDE1iqgb2teB5EIe9QuzY=
X-Google-Smtp-Source: APXvYqy02438MtBR0pXU8/711fLcuTpWv5tL8cz4NjFgvkWByUPZwQobWsWtNOpX7g+Oe6V6IQf+SA0eyFTKHWaqtZg=
X-Received: by 2002:ac2:5633:: with SMTP id b19mr243945lff.103.1569522831372;
 Thu, 26 Sep 2019 11:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=KMJmYtVaATFkOPcboAdkLvpZFbWAo4QAE0-uC6RL4Lqg@mail.gmail.com>
 <20190914211509.sjy6lh2rlcl32lj5@yadavpratyush.com> <20190914212732.plymb3vnz3dv4rmc@yadavpratyush.com>
 <CAGr--=LmhE9m9V4Dq8Zt0aXqdThzrNnWSnxWawVZiLYTKbL2ig@mail.gmail.com> <20190916180059.aifw5r4c4k5o5hur@yadavpratyush.com>
In-Reply-To: <20190916180059.aifw5r4c4k5o5hur@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Thu, 26 Sep 2019 20:33:40 +0200
Message-ID: <CAGr--=+SNO7GuHH-dE_ZnrJDCa8tv8EA5LMrVGwsMTRpxhzEZA@mail.gmail.com>
Subject: Re: git-gui: automatically move focus to staged file before typing
 commit message?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Honestly I'll need some help to get this one implemented. The only
implementation I've got working currently, is to change Alt+4 key bind
to do the following:
- Focus the "Staged Changes" widget (which will select a path in the
list, if it isn't focused already), then
- Focus the "Commit Message" widget

=C2=AF\_(=E3=83=84)_/=C2=AF
Birger
