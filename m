Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99D8A1F461
	for <e@80x24.org>; Wed, 15 May 2019 18:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfEOS7v (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 14:59:51 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:38704 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfEOS7v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 14:59:51 -0400
Received: by mail-ed1-f41.google.com with SMTP id w11so1306396edl.5
        for <git@vger.kernel.org>; Wed, 15 May 2019 11:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=wUgq3LK4Uw2PzQHh26eOLVdqQQGzFPdOV6mF3ZsMQj0=;
        b=ALrUhDUTBKyxvXtfOz4hwW1JyPv0ieleRfd+uVXhPqKBGIx2Ryd2zwYA2ljFn1Yktg
         PznaZCJ7lnt4hgl3jqjVX+agJKbcrKa17C/FtEBiFN5/9xSwvmO/d5Y5V0JNeTGNuscm
         StKnhoiExbaDl1EcqmVt2mg3MDboFj4xPDl9FiU0BBDsTsTPcD/sRIyrnwuR3sIzVt6i
         ZMWEP5CAtBTK9sRsqCSM8p5HRFrVXmjyNcV+5fxDzXlV2fmr3AfOE1oTHeUVxh1+Rb1k
         2/C+0jb4t0PKDfPNzq5QKgv4b2uj8tufDPMdzROYnJcXxfvrS1QRXiJNS58z8FQSPGq/
         z6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=wUgq3LK4Uw2PzQHh26eOLVdqQQGzFPdOV6mF3ZsMQj0=;
        b=SYE3B5J+9pOr55EFkhznlJMOTZ2pU+kUJA75VEBzsTyp8MySumRLYHdfosn4Y2ul2R
         1J9U9QjOz9T45KAZ7kUzPjnt25d8VIzYl40V6M2d55LCKAy2/wEJWRKsEM+vW+c0oEB3
         KHY9qV76fDDra8M8FViZgs/k2J3Q40KYILWK+Wq/5UVydxdXw0s4h1WozwDnCHBTjmCy
         5VLh0LW58M115gQGIdaVZJTrZK7uuIaNA6M10Gc+lbfQz5qphKcu+/UYUP3JxrGDCIYF
         CnM4T8+g1Gly1QoBlMpdPy6GE625gLKNwgMoeyg2oYRTI36MU//oerqZfQh8NbQhuxCz
         mGkw==
X-Gm-Message-State: APjAAAWu070S/DCU76FMwlpH3QK6ta2FxMrtIX1hz5LkSlgUwfI9+uDo
        KEb8eddJ1aQoBhLlfhSH5wk=
X-Google-Smtp-Source: APXvYqxS97mSwJqEBM1kpAvyCF6/y2rr4EV1NUYxjYL0K/wiLTDoFdUWX3HnBey/lf2hcT+SpOpVuw==
X-Received: by 2002:aa7:d617:: with SMTP id c23mr45095736edr.74.1557946789513;
        Wed, 15 May 2019 11:59:49 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id s7sm1056787eda.62.2019.05.15.11.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 11:59:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Git ransom campaign incident report - May 2019
References: <CACPiFCJdXsrywra8qPU3ebiiGQP3YPC6g-_Eohbfwu_bQgfyVg@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACPiFCJdXsrywra8qPU3ebiiGQP3YPC6g-_Eohbfwu_bQgfyVg@mail.gmail.com>
Date:   Wed, 15 May 2019 20:59:47 +0200
Message-ID: <8736lfwnks.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 15 2019, Martin Langhoff wrote:

> Spotted this on the internet...
>
> https://github.blog/2019-05-14-git-ransom-campaign-incident-report/
>
> Haven't hacked on git for a while, and I am not affiliated with any of
> the stakeholders. However, reading it, I wanted to slam my head on the
> desk.
>
> IIRC, git will sanely store a password elsewhere if it gets to prompt
> for it. Should we be trying to unpack usernames/passwords from HTTP
> urls, and DTRT with them?
>
> Are there other ways this could be made better?

I think we should do nothing.

The linked blog post really manages to bury the lead. I guess you'll get
that when PR at three different companies gets a say. For those looking
for a brief summary, here's mine:

    Some people using git hosting sites "git clone"'d https URLs to
    their repos with username/passwords in them. They then pointed a
    webserver at their checked-out directory, and got pwned by someone
    scraping "/.git/config" from public websites looking for
    credentials.

Trying to mitigate this in git is just going to annoy users who are
doing this in the context of an otherwise secure workflow. The users who
were affected by this are probably also the sort of users who are
hardcoding their AWS password in some JavaScript checked into their
project or whatever, there's only so much you can do.

It's probably more productive to say convince whoever maintains the
default nginx/apache etc. docker image to default to some Fisher-Price
mode where dotfiles aren't served up by default.

Or, for GitLab/GitHub etc. to discourage use of https API tokens in
favor of SSH deploy keys. OpenSSH goes out of its way to not allow you
to provide paswords in URLs, on the command-line etc. in anticipation of
exactly this sort of scenario. Even then I've seen users write say
docker images where they manage to hardcode an SSH private key in a
public image out of convenience or lazyness (say needing "git clone"
something during the image build).
