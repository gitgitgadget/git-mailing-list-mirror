Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1A421F404
	for <e@80x24.org>; Sat, 24 Mar 2018 20:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbeCXUcH (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 16:32:07 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38226 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752736AbeCXUcH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 16:32:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id m13so1918846wrj.5
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Ncja542zdLj67FPa9Sw6jfOnQZTgRjhr5BAY9mlWe4=;
        b=iXX1nCz1fj1COnbe6t6zgvAv+8Gk+QEBELMg6830K5DG5NgRIBDkIkNrYtt7ZN1hVQ
         0yJAJORZbbk3GJTwmXG8oXkou9bXeZQSUAnGH+WaieEYKbNaGliri4sHaGaSG7kknSUI
         lR7nJcMesdd6TGopE28iAR01OHM1JveBfm4nfz+EypLeRbGAu0ac+LoeIHM0oD4ZCHyT
         ZopvOUddcDv8TGG3HlCSkyUu13A1oUUZj8MZWznjqQTE6+r4GDMEjo2jZBPNMictGDEZ
         CptviyTDENXv2Z4SWOviWQ3smaiVfXyxpiwUVlN08uzNljKp+x14ZS3isEiWcide6zAR
         6+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Ncja542zdLj67FPa9Sw6jfOnQZTgRjhr5BAY9mlWe4=;
        b=s1BloE88vjA2vskqxOsj+mmt+mXYjsujxhKZg7XtSURCZRUiKsDZ7GwDWjc0xjpX3u
         PhM7lCLV1KL1E21bvrtOT/fd6J/QT1e9CsAIrMe4W62CNXtbir3tsYsNlGmnafVAfXjG
         uVdEKoLH9gv6Yl5Y4ZS/39guu8pzYk8fXj1JVhtGFRdkFqxlJCwCDadpqNzPw7ykvFyp
         ILfiI9/CTg5dXtmHfqLsDe66RK0Fu3wSpbPbt8aR0wChYYETWnVY2BUPjDDncMQHJj/L
         DUt/AWwRLQSP5SqYW5OjjOpyfWb3PRhzfFEKfWMiuGF5GHEvUvOAYDl2TyJYaKbhxNdi
         Kseg==
X-Gm-Message-State: AElRT7GTggkg7tdMlPCn6S14GwtLa8QbcKwf8pNvq33JUT9Fm7s5VHfh
        C/AtQwJxu7tzOYBXgcRn10Q=
X-Google-Smtp-Source: AG47ELv8PdcBaXJsGqD6kJH6+vOAnPBcTm/GO96D78tUX0Xj3+oEsJufEKg7lWJ/pFWZgCi5lsZaNQ==
X-Received: by 10.223.193.10 with SMTP id r10mr15153988wre.255.1521923525631;
        Sat, 24 Mar 2018 13:32:05 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id v4sm1960108wra.36.2018.03.24.13.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Mar 2018 13:32:04 -0700 (PDT)
Date:   Sat, 24 Mar 2018 20:35:27 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/4] worktree: be clearer when "add" dwim-ery kicks in
Message-ID: <20180324203527.GJ2224@hank>
References: <20180317220830.30963-1-t.gummerer@gmail.com>
 <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180317222219.4940-3-t.gummerer@gmail.com>
 <CAPig+cSsqqn+Wg6DEJRSge9mYqb1_jPXy5ORryrdA6+Omxne1A@mail.gmail.com>
 <CAPig+cQPhXxVswMbD5HsUJpa9AHfet4zFb+MV3FT_-CuZP8+gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQPhXxVswMbD5HsUJpa9AHfet4zFb+MV3FT_-CuZP8+gw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20, Eric Sunshine wrote:
> On Tue, Mar 20, 2018 at 3:26 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Sat, Mar 17, 2018 at 6:22 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >> Currently there is no indication in the "git worktree add" output that
> >> a new branch was created.  This would be especially useful information
> >> in the case where the dwim of "git worktree add <path>" kicks in, as the
> >> user didn't explicitly ask for a new branch, but we create one from
> >> them.
> >>
> >> Print some additional output showing that a branch was created and the
> >> branch name to help the user.
> >> [...]
> >> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> >> ---
> >> diff --git a/builtin/worktree.c b/builtin/worktree.c
> >> @@ -318,6 +318,9 @@ static int add_worktree(const char *path, const char *refname,
> >> +       if (opts->new_branch)
> >> +               fprintf(stderr, _("creating new branch '%s'"), opts->new_branch);
> >> +
> >>         fprintf(stderr, _("worktree HEAD is now at %s"),
> >>                 find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
> >
> > The "creating" message is missing a newline, which results in rather
> > ugly output:
> >
> >     creating new branch 'foo'worktree HEAD is now at ...
> 
> Also, I believe that the agreement[1] was that this message should say
> merely "creating branch", not "creating _new_ branch". And, indeed,
> patch 4/4 stealthily drops "new" from the message, but it really ought
> to be introduced with correct text in this patch, not fixed by 4/4.

Ah yeah thanks for catching those, will fix.

> [1]: https://public-inbox.org/git/xmqqh8qv9ojb.fsf@gitster-ct.c.googlers.com/
