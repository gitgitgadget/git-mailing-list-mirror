Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93A4820248
	for <e@80x24.org>; Wed,  3 Apr 2019 18:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDCS1F (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 14:27:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36346 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfDCS1F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 14:27:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so15794121ljg.3
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=pCAdb3BwveECDeCQpvGxQBF8M+SRLVjdfJeaN3xYlz0=;
        b=iu+TuWhgVjsa0lqP/7BG8sK4j5xe0x9+iyXlt6Dj4Bi7ddu4qm7fAjs2AxjBBz4p99
         2bSodurtMGYgO4jYrcpD+aDUfJxeXPXpSHKHjiQrZGvc2aH9HBnsdGTFxrqNpowgRB6D
         hF9yKSUjGPNKFpXdJzzXP6IH7VhYHifUe28Uyt6440VLBJvhV+40X7mFO2/JyOFmUsPj
         oWVZlC/NTnshhNr34NTgzCM+gxg+uA3eK0KpBQAw/rlTASmvXSgY5cMKkqrwLnExGUW2
         l3L5QMUzQcHCre/i9A4O8HS1xIbEZiFuLkRq7XbYn5WnmaSZxKVXU8kEQ7RoIH1SfI7e
         iezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=pCAdb3BwveECDeCQpvGxQBF8M+SRLVjdfJeaN3xYlz0=;
        b=G19zmug1UIHHYcpHwDQVIwJsnB/mhcg0L4djBu/qJlH+99YhsbjXY/7yZFGpRXqtbF
         c/90BioZTYPvHZfnmFvvZ73LwFsauMFGJKX6Pmjbe27X2fwKu+3XiefJxW6Ty8DUXH3g
         N3JKy8+HOcqTinaYsdnKL8Yy5pjCLIoDCi6J/CK5E+EoRiNeYA/mT2z/4woFoHykEvE+
         DjB0zO+KmDcDhhaNvlvcIYwJIYXzJXJvShr2s393b71U2+sxBJwHTpO+rXeZ6wSQOwDB
         scp4RuOpsLNLnbfnFxbWJa7gJPIjrm5iJZkaX1tgDnsU8IsT2pX1y3XXfL9RWz55I8fE
         RpwQ==
X-Gm-Message-State: APjAAAWWukC73G5ppPwJj9OTPZ/ZB1VfKkm8SjhWBeu79pWP7Oy3oPy2
        5pe7J05geayrUJIAfHo1DyOjplZlB3ExUWFCYH/LJg==
X-Google-Smtp-Source: APXvYqzelXYWKMMNexB+f/xe3h5zf6OAXd7KzqNCQ78XlR5uQC3C/ZgMwC7CNx/YGR5v9DtX927swmBSuFJpul0ppQQ=
X-Received: by 2002:a2e:5bdb:: with SMTP id m88mr718242lje.9.1554316023335;
 Wed, 03 Apr 2019 11:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
 <20190402230345.GA5004@dev-l> <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com> <xmqq7ecbscay.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7ecbscay.fsf@gitster-ct.c.googlers.com>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 3 Apr 2019 13:26:51 -0500
X-Google-Sender-Auth: GAt7W_cS5G0Q4GzzdHqbInKgshk
Message-ID: <CAHd499C9g3yPvs=wuaSuLrW=R09yjT5DcKHfpH9=PYYkAcpuhg@mail.gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 3, 2019 at 3:50 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I am not sure if this is so bad, actually.  Why do we need to treat
> > it as a mistake?  When a command that wants a commit is fed a tag
> > (either a tag that directly refers to a commit, or a tag that tags
> > another tag that refers to a commit), the command knows how to peel
> > so it's not like the user is forced to say "git log T^{commit}".
> >
> > And if something that *MUST* take a commit refuses to (or more
> > likely, forges to) peel a tag down to a commit and yields an error,
> > I think that is what needs fixing, not the command that creates a
> > tag.
> >
> > So, I am fairly negative on this change---unless it is made much
> > more clear in the doc and/or in the proposed log message what
> > practical downside there are to the end users if we do not stop this
> > "mistake", that is.
>
> Having said all that, I can sort-of see that it may make sense to
> forbid tagging anything but a commit-ish, either by default, or a
> "git tag --forbid-no-committish" that can be turned on with a
> configuration.

I don't really understand what part of the change is a negative for
you. Are you saying that `git tag` should peel the tags for you? Or
are you saying you don't like nested tagging to be opt-in and an error
otherwise?
