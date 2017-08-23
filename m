Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6093220899
	for <e@80x24.org>; Wed, 23 Aug 2017 21:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754170AbdHWVM0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 17:12:26 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34372 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbdHWVMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 17:12:25 -0400
Received: by mail-qt0-f180.google.com with SMTP id p10so7090989qte.1
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 14:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LKwVu0AyrunSuXArjaPM2W3wROZFobAlgRKCAcNdyrk=;
        b=ZL/WAZDWEaFfaUCmq7TTKsSkhbQ4fU9P24taKCwdcaxuULOJOwdm7HR1BOdpm6Mrmb
         YsB7NL91Kc0yLrnjSzGt+XlbI/FfLntAPEfWqRpKl9uSmhFBTBHd/bCgPH8aFsZznx7K
         IUleXExlQVaSDc6f2411Eg3L4RTTjt4TVhsi6V3lF3Nt26G8KYHBN0yVLkqthL1w8Md1
         j3p9TU5Z0KdoUr5eUc4IKWTGvBu+DKW2K0/lMGfiwId6TeqMY5EyzCpoeDTHYG+pEJed
         tZtJbMj8/XvfSfeORSxZaI3WIzr8ODYUK4U02UFPGQhjRbUbAeS+hmUAUuH0h5iYJ7Jh
         NbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LKwVu0AyrunSuXArjaPM2W3wROZFobAlgRKCAcNdyrk=;
        b=PpZkf3cD0aJbVMM3YPjoYC+HgsVMw96Y6BiZ9gsQwDkkgIwQ9+yPYizjHPmi3dYfbj
         f0zU8QhIdBKRZVDFRO/vBV2oM4K0hml7AqY1VMsoYk5/x/p7jtruNN88PBnBeob06oHF
         Q7Izdq1HOq/NNvrlHsk8hBwW7FNP5Pk7774w5D1ZJZjZRXkEGX4lceXvhiWAWImeCiIG
         TqGIAOXw4JeO4PhVWB/SM2e6sB+l2REcoWfMUubSjaUUWxZQgnG2sjyxNc91011veSm4
         Tuy/VnHjoUWc1VqvtLxefNDYXZazT2pD2OCQfAFkEwYxGOr2RLofigby8JwmsFYMQjXY
         Nr/g==
X-Gm-Message-State: AHYfb5hQrqkoQfhz+D0h6/5x+aSxMY3AuSfZOarx3uPrlitQOY1vs2OL
        qj9js4DEkpH3aE485HfGFKKmnz3fxw==
X-Received: by 10.200.38.212 with SMTP id 20mr5701604qtp.112.1503522745128;
 Wed, 23 Aug 2017 14:12:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.129.34 with HTTP; Wed, 23 Aug 2017 14:12:04 -0700 (PDT)
In-Reply-To: <xmqqlgmaxbuc.fsf@gitster.mtv.corp.google.com>
References: <CACPiFCJH7RSb_rz6M6ADuGi0q+oeWYhE1fNMQC0EUcCn_kCJwg@mail.gmail.com>
 <xmqqlgmaxbuc.fsf@gitster.mtv.corp.google.com>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 23 Aug 2017 17:12:04 -0400
Message-ID: <CACPiFCJCgKtTbKX8jCSC3QgMKZ7Usu2ojqXe5w_QAHwk7T4M-A@mail.gmail.com>
Subject: Re: Should rerere auto-update a merge resolution?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 4:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Between these two steps:
>
>>  - I reset hard, retry the merge, using --no-commit, rerere applies what it knows
>>  - I fix things up, then commit
>
> You'd tell rerere to forget what it knows because it is wrong.

Hi Junio!

thanks for the quick response.

Questions

 - when I tell it to forget, won't it forget the pre-resolution state?
my read of the rerere docs imply that it gets called during the merge
to record the conflicted state.

 - would it be a feature if it updated its resolution db
automagically? rerere is plenty automagic already...

cheers,



m
-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
