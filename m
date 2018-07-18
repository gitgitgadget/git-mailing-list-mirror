Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49421F597
	for <e@80x24.org>; Wed, 18 Jul 2018 18:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeGRS5I (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:57:08 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:52445 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeGRS5I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:57:08 -0400
Received: by mail-it0-f47.google.com with SMTP id p4-v6so5474636itf.2
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01nWJbJ5/NoBCVYtOcF7cSxe4nSOtD8gMBGjEx3rQC8=;
        b=iD/GX5FqYP9uoSLWqef0YzEH3HvgWT+E4oVFTwuKNbUIYiGZD7Iz6/QfjgDktzq6Ts
         OGgyCjDHrIdAj30LWyxAlkkI1Qek6Mwbn2J6dom8ZHt0Y/9rGtp8Ux9pYkk3xn6eOVho
         gKEkI9DxaXhEGm7Ko0dagOi2TmTwTli0Aw835oy5XNm36djSH3c3K6mBRXDYZr4vIfUU
         ufD5CLpxyp9N6NY57wAIC5Rc2P7Zpz0iSf10RDGSgQM1CKBrBhL0M1jOCrfIN7/FK8W/
         aqhfBa/ryZLfXYQ5OTNpnpp/NmAf4vAE4F97FSyK6+OwrVTZxmCvYxu5AKN2KPfDBb49
         t+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01nWJbJ5/NoBCVYtOcF7cSxe4nSOtD8gMBGjEx3rQC8=;
        b=biNCOJkChsn6FuOoyX5I4unUtTYsSnUXMcRmXbLFKxcnwzTFyntPQwu0TrUhZj7+nD
         2vvB/8CkSZW2T1IpmiBAd9+yqJkE9gtkmb/hxvmPc/K5zM8VqQUCVwgwSVN8PuIhxiM5
         qTEhN/MSMFvx9YJH4j1UgTwHOptTl2siywXDJsbGcXnwjz3SCdjevG7evF7jGVXJ14/Q
         z/kuI35KjwmWpGGzNxEG1LnpC5jrd5Im4Sty+WT0F4YXm2S1jTKH7CVgX7WBWEZGg23L
         v3/IasK0ibwNeHGRHEd6fwqeS+UgTprxcKdHry3YPYDT7hy1LZloEBRF7CxNDVVhS0Vj
         7bAw==
X-Gm-Message-State: AOUpUlHvThlqPZAZ2mX/cB1uMc4bK4eG01EUV5BkYghE91y6OwzJYa+4
        TSi+S7qDsZTfnhkUr4ZBEOHQP0N8LlwiSp2GOsc=
X-Google-Smtp-Source: AAOMgpfj9ZtfhTe7E6+QKWYPhbx1+65y4pOJIq7OVcg9YW/T21bpNBTrfGiAbY2aa6Ztjhgw/TKvUAGcNvJcuP+MDjk=
X-Received: by 2002:a24:c888:: with SMTP id w130-v6mr3171603itf.78.1531937882712;
 Wed, 18 Jul 2018 11:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180717210915.139521-1-bmwill@google.com> <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
 <20180718170846.GA17137@google.com> <CAGZ79kZ4HOvo-xaDK=USveJ5zaLdJSddh8XNxsOsFHQuu7KcZQ@mail.gmail.com>
In-Reply-To: <CAGZ79kZ4HOvo-xaDK=USveJ5zaLdJSddh8XNxsOsFHQuu7KcZQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 18 Jul 2018 20:17:36 +0200
Message-ID: <CACsJy8Ccjh+Fma_uYPN+_PxUOfAU0nLQVBbVoTLMonhc5ygKcg@mail.gmail.com>
Subject: Re: [RFC] push: add documentation on push v2
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 8:08 PM Stefan Beller <sbeller@google.com> wrote:
> P.S.: another feature that just came to mind is localisation of error messages.
> But that is also easy to do with capabilities (the client sends a capability
> such as "preferred-i18n=DE" and the server may translate all its errors
> if it can.
>
> That brings me to another point: do we assume all errors to be read
> by humans? or do we want some markup things in there, too, similar to
> EAGAIN?

We do have several classes of errors (fatal, error, warning) so at
least some machine-friendly code should be there. Perhaps just follow
many protocols out there (http in particular) and separate error codes
in groups. Then we can standardize some specific error codes later if
we want too but by default, error(), warning() or die() when running
in server context will have a fixed error code in each group.
-- 
Duy
