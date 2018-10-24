Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 114D31F453
	for <e@80x24.org>; Wed, 24 Oct 2018 15:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeJXXnW (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 19:43:22 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41567 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeJXXnW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 19:43:22 -0400
Received: by mail-io1-f68.google.com with SMTP id q4-v6so3361323iob.8
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOFLBEOizXxc3XQFqTA2ZwCUt0VgGhvBpO1qW4y8YRc=;
        b=Hy7Sa/1jUxDOl9NE/oqF6NfezplDUzoq2wJJbQoIa5wyDONUM2rEYRuLPP9lDqIDic
         PNpq2NjasoorvKAhJVWnlBGllKpPUljAB/7D1c4g7meWzqKiI2BAE0Ztkn7IH34B/NhS
         T1eNNGS88KLDQakLeUpx2NnUftRuEd4gg9bo6FBz3C8LHy6OzDTogmaqyDuWeZ3RJ3En
         kK2UTdEqO+8ooAK3lxsC0U7ZIh3+2+MGIa2UYvOBsZF4zpahvkViqMXYq42OWjXA6hQa
         orr84Iq9dW0FB2CIYVdMHoPP6NZ5beQ6WoksQ6QvuNI/eXZXwyegnON7OouOaJOI9edE
         fzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOFLBEOizXxc3XQFqTA2ZwCUt0VgGhvBpO1qW4y8YRc=;
        b=F+tMfphab9rnlq8sLHFFl6dLkA3ZuR5foHvNMrZZFkGS7dy47xawoYf1/Ykr5Usl9D
         O/Tk0iWj8qfPultaELVb4CC2kreEJrS1HYj8eeK8YOGm8uUTIap4Xwyl3HtqWxsOl26X
         7Tsqj73hZmPTN5oUajXKlpX/3Z8IZ3NQm+yivYTf/WyaGFmEGIgMCTcNks3FJtPj61+a
         JjRE4KweEqiEZDLpjSEgjvBdXo27IRt7OWUHfbjvhOlpJfyffugbQmZjFmUZdBnEqvlm
         cik16olZR5yu1XxKuI89PNDyTVBAxAuYgfEA5Mk2sS82hXHvhX5TOWIxPPFujiOl8flD
         MNEQ==
X-Gm-Message-State: AGRZ1gJubKF0suPHW+lB7wEI5blIujfgfOeAnA42pZ6+iSfRyUoe9vhS
        jzDWLea74Nm41GK0Orb63BknhgFpi2iv3oaGV1s=
X-Google-Smtp-Source: AJdET5eHhusU3HR+VUOhzu+yES4ALUdT73g6gTYadElT29bDFNud/FT0dPrwjY5tUfqmlru/ZorQzHnJO+slggbl8ZY=
X-Received: by 2002:a6b:6f06:: with SMTP id k6-v6mr5933050ioc.236.1540394092426;
 Wed, 24 Oct 2018 08:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAGOLd-7Hi+tssj4ozKPd04squ-PuFwtt6f2nhbZp-zKwy62pVQ@mail.gmail.com>
 <CAGOLd-5Gbt6fQTvm+7018uX+8WF7NUWpa1sFWAg3-5bxtmOt-Q@mail.gmail.com>
In-Reply-To: <CAGOLd-5Gbt6fQTvm+7018uX+8WF7NUWpa1sFWAg3-5bxtmOt-Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 24 Oct 2018 17:14:26 +0200
Message-ID: <CACsJy8C7pArdayQu9Kh5z6dczCqV_=XJP4wzR_dcm_W3MgG+Jg@mail.gmail.com>
Subject: Re: bug?: git grep HEAD with exclude in pathspec not taken into account
To:     christophe.bliard@trux.info
Cc:     Git Mailing List <git@vger.kernel.org>,
        Rafael Ascensao <rafa.almas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 4:55 PM Christophe Bliard
<christophe.bliard@trux.info> wrote:
>
> Hi,
>
> I observed an unexpected behavior while using git grep with both git
> 2.19.1 and 2.14.3. Here is how to reproduce it:
>
> > git init
> Initialized empty Git repository in /private/tmp/hello/.git/
> > echo foo > fileA
> > echo 'foo is false+' > fileB
> > git add fileA
> > git commit -m fileA
> [master (root-commit) f2c83e7] fileA
>  1 file changed, 1 insertion(+)
>  create mode 100644 fileA
> > git add fileB
> > git commit -m fileB
> [master e35df26] fileB
>  1 file changed, 1 insertion(+)
>  create mode 100644 fileB
> > git --no-pager grep foo HEAD -- ':!fileA'
> HEAD:fileB:foo is false+
> > git --no-pager grep foo HEAD -- ':!fileB'
> HEAD:fileA:foo
> HEAD:fileB:foo is false+
>
> In the last command, fileB appears in grep results but it should have
> been excluded.
>
> If the HEAD parameter is removed, it works as expected:

It's probably a bug. We have different code paths for matching things
with or without HEAD, roughly speaking. I'll look into to this more on
the weekend, unless somebody (is welcome to) beats me first.

Another thing that might also be a problem is, negative patterns are
supposed to exclude stuff from "something" but you don't specify that
"something" (i.e. positive patterns) in your grep commands above. If
"grep foo HEAD -- :/ ':!fileB'" works, then you probably just run into
some undefined corner case.
-- 
Duy
