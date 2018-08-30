Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B483A1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 11:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeH3P2X (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 11:28:23 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:44780 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbeH3P2W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 11:28:22 -0400
Received: by mail-lf1-f48.google.com with SMTP id g6-v6so6861214lfb.11
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 04:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=PoredHVfj79wA7OpquVhjzUA/cvGnUDiPLnoDW/Fx/4=;
        b=Goy1sRmHxV8f6sy/k33GuY1Mu4du/qvXrnO5OjCeP1xwBKODMMrtrolHlE5nG7/atq
         RmZawNYjV7j/cJBnhSI8gz4YHzrj5ZOVrCxfOZAeBOGrzF8c0fe2XfEkL+d4t5p8pWNd
         LWU4WWI7WyvfggUnqbr06FxgGXNQeoYmDxYAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PoredHVfj79wA7OpquVhjzUA/cvGnUDiPLnoDW/Fx/4=;
        b=B5HZJ4vDC4SJ4FoKk5NRA+eddewwAsw4xK6yru5d0BgEYfuXifUchwLnHlZ3C8OM0L
         Dup2P4GomBDUIvRuqfKrKfrrYtoeFJpP3H1EKwSeO70Zie//pqy85fXkK5T7icBqdAut
         6RSq4zE+dckAmgJyfENVSYBzUOQni3GknrC2tPs7uv3v2PcKjej5+D2oUiAZud8iPk9T
         1liEAYCXy7eysfuKYc/wwIY49PYwzxzQjZVSGc70vKzOmiAEoZ+R2OS1AnJZIq4wVadw
         TWPcH0B/E8ht5pYnqHlep5lYooXHb5wBmmjd3MYhCS8LwOQqQWX3wZPOQ1ngi9J0k8Fh
         Hnzg==
X-Gm-Message-State: APzg51AiIWaD9Qv6kI07GdYSXlf7hGkQrC96+l0TvHfpBbdAy2kC1mF1
        7S7APk+0w/n2y0bhtiMtZqww1wX+SNQzTpUs
X-Google-Smtp-Source: ANB0Vdaip2P1eWGp2KipvCkCpIxt4seJ/FctdPD9+89P+KrxmZDBhLD+0l5YnjSHbESbeIpqBL1sVA==
X-Received: by 2002:a19:8f10:: with SMTP id r16-v6mr7586865lfd.1.1535628400351;
        Thu, 30 Aug 2018 04:26:40 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id i86-v6sm1254760lfb.67.2018.08.30.04.26.39
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 04:26:39 -0700 (PDT)
To:     Git Mailing List <git@vger.kernel.org>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: feature request: allow commit.email config setting
Message-ID: <0f66ad7a-2289-2cce-6533-a27e19945187@rasmusvillemoes.dk>
Date:   Thu, 30 Aug 2018 13:26:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of my dayjob, I did and still do some work on an upstream
project. A while ago, I was granted commit access to that project.
However, upstream asked that I would register with their system using a
private email, or at least one that wouldn't change if I changed jobs,
rather than my work email.

Now, I (and my employer) would like that the work I do as part of my
current job on that project has my work email in the Author field, but
since the commit access was granted to me privately/personally, it would
be nice if the Committer email was the one I used to register with their
system. I can set GIT_COMMITTER_EMAIL in the environment, but that is
rather inconvenient, since that means I have to remember to do that in
the shell I'm using for that particular project, and I can't use that
shell for other projects. So it would be really nice if I could set
commit.email = $private-email in the local .git/config for that
particular project. I don't personally have a use for commit.name (when
missing, that should just use user.name as usual), but it would probably
be most consistent to allow that too.

I tried looking into ident.c, but it doesn't seem like it is
straight-forward to implement. Probably fmt_ident, ident_default_email
etc. would need to be passed information about what purpose the ident is
to be used for. So before trying to implement this, I want to hear if
this is a reasonable thing to support. Also, I'm sure there are some
subtle semantics that would need to be decided and gotchas to watch out for.

Rasmus
