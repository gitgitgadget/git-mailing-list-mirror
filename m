Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C815520248
	for <e@80x24.org>; Tue, 19 Mar 2019 09:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfCSJYK (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 05:24:10 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:38265 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfCSJYK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 05:24:10 -0400
Received: by mail-ed1-f51.google.com with SMTP id q14so336320edr.5
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 02:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=p7rv5afh1HOG46+t6gkiieKRpQsM7EWiDjWzvS2Jb50=;
        b=Y0C3wlkPAeeTfAhF0TBjepvzM22cJ5de+2md3Zv0nMbNIfmQN8LqRyV11J/Th0an5o
         rOwau4sQxK5+VapaIpS/uJENwjNBlyjQ+JhujWE2i58j1SnvUhcFjwMa3JPxM3H4eo/3
         t777zsWo1AUIm5/5Mm4AI+u3SUwogGuRE2w7uxIjjk3WyxAMi28mZ52FiyQeQd/OQ9Cq
         i6CJHDaJMDQs9EK6IrR7Fyvo8CvRSkO7Y3/EjFRbECPElDh4h8aXmGOR8ccBtDp/rMKO
         OvkRcp4w208arhSQtAKZ6TRXnQBK+f7TkVgwJhBAlyKsq11ofUaXFt/EN1SkMVZbhU6b
         IGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=p7rv5afh1HOG46+t6gkiieKRpQsM7EWiDjWzvS2Jb50=;
        b=jOOX5Ma79VW/tJF/90Yjp3ixQm9yAlOVLTy1ZR8T2x8KD58VxHXRldsiDkWkGVD7Lb
         E4w7+CwwFZQPeUJ5RfwX9dFVMlwY/4GrElYnqN+k7LF0UA/RXrPAp3w3tTyobWT2JUxw
         cjBfDFPcEbQMQateDhTw709eZbnMF8YPMS318lxFlfe35uhOQ0fwSZjkoK6lAdjcKOn2
         JUtv/SQaZ0hJU+XPhciTOo+58uyWScgQWjqN5YYZp4wwDtKcqHEoV/yaHH85QDUtrD9B
         PO4QTy1pzaPRl9mhxZR7yRMSvXYbk8vzh8/auKwtMgQdYdyD9Hyfxq0EUASB2umDTo82
         JTDg==
X-Gm-Message-State: APjAAAVF5el2OLDzh1/Vl2O9VYeYEqWfZ1226yH9pmnMJZkCaqxRGHfx
        GiFUjKR+sSXocMLVz672oPvrLAyGV3A=
X-Google-Smtp-Source: APXvYqwgJ5lBH7+2MUvoQKmnvjktP9K7EIYVHfihj9l+Tw5w+JIuFc/I8nVym2OHOZN5Xsp9Ex4Qsg==
X-Received: by 2002:a50:be42:: with SMTP id b2mr16047423edi.78.1552987448451;
        Tue, 19 Mar 2019 02:24:08 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id i19sm2918367ejh.44.2019.03.19.02.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 02:24:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Dimitri Joukoff <dimitri.joukoff@griffithuni.edu.au>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git server side "pre-receive" hook to create new repositories
References: <SYXPR01MB095712C6765970605923A2FDDD4E0@SYXPR01MB0957.ausprd01.prod.outlook.com> <20190319070629.GE31801@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190319070629.GE31801@sigill.intra.peff.net>
Date:   Tue, 19 Mar 2019 10:24:06 +0100
Message-ID: <87d0mndxop.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 19 2019, Jeff King wrote:

> On Sat, Mar 09, 2019 at 10:46:09AM +0000, Dimitri Joukoff wrote:
>
>> Thus, this feature request is asking that the 'pre-receive' hook
>> triggers when someone tries to push to a repository regardless of
>> whether the repository exists.  This would allow automatic creation of
>> new repositories and smooth the work-flow described above.  If the
>> semantics of the existing 'pre-receive' hook are such that it would not
>> be suitable for such a purpose, then an alternative way of providing the
>> call-back ability would be implemented.
>
> The pre-receive hook is a bit too late for this. It runs after the
> server has told the client what it has in the repo, the client decides
> what to push, and the server has received the pack. So receive-pack
> would have to know about this and fake having an empty repository. And
> then figure out where to store the incoming packfile, since we have no
> repo.
>
> So I think it would have to be another hook that runs before the rest of
> receive-pack. I.e., a system-level config option that says "if you are
> asked to accept a push for a repo and it doesn't exist, run this instead
> and then run as usual".
>
> It does feel a little error-prone, though, if the client does not
> positively say "I want you to create this if it doesn't exist".
> Otherwise if I do "git push server:my-misspelled-repo.git", the result
> is going to be rather confusing. And retro-fitting that into the
> receive-pack protocol is going to be tricky.
>
> It would be much easier to have a separate endpoint for the client to
> say "please make this repo if it doesn't exist". And then just run that
> before doing the push.
>
> For an unrestricted client connecting over ssh, we already have that:
> you can just run "ssh $host git init /path/to/repo". There isn't a
> similar thing that can be done over HTTP, though.

Sounds simpler to just change the user's login shell to a wrapper that
checks if the repo exists, and if not create it before proceeding.

The same with http(s). I.e. in whatever webserver that's now pointing to
git-http-backend as a script point to the same wrapper script.
