Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA1E91F859
	for <e@80x24.org>; Wed, 24 Aug 2016 09:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753907AbcHXJff (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 05:35:35 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:38001 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbcHXJfc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 05:35:32 -0400
Received: by mail-it0-f42.google.com with SMTP id n128so23917830ith.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 02:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xRQAulYJoislpIguV2ckibpnP+kBeVA7zRYuA1GIV6U=;
        b=dggNQ+oMuRB2LTZCL0vTyxgIZjER40BnvbTX7zg5CR2snygUfuFKN0YckIN5juEqW4
         8ouWYgWdqyK5XlFo4KbexjrikP7t8ydNXTJ84Un9YTOOeBQha+1fPw99+OAJK0K6rF6h
         h2MpPxzRGrZT5O8KjtyYqDkkz0g3k+9P9z695yRr1r7lClSmkME44gFr9iNKdwIAtpoJ
         k6eWtKCR0HQ6/Klrs0wKKf3Ny7ItyhauB66ONEJsb/YuaOAUBEl1V9KMWAZM4Lhj9YkD
         jIgb79hY3wxu0XBVwAFsnlb77vfQx0V4SjBLDlhsO462QTeLmYLB0HsZ6qL5mr/DQfiA
         08Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xRQAulYJoislpIguV2ckibpnP+kBeVA7zRYuA1GIV6U=;
        b=SqerT9cBEVgglhX5E83FhjOTPnFwpTkMwGY8MlEkx7ngkVRI6mI41FjnCK/wp7L11h
         mY9yw0E3Hj3AB5UD1U+1zTDyqn0p9BGtcD6NuIc87aidSGdOISqzvQxNoY1tNyyK0NCv
         i3YcDn6tmZ4dB4WicK0fNDklsmNL8MombVdkybCRt86rWWC1A6gP694r0o5SMyhsbz4G
         LpyBkQMWg9IFAJ61qRJxpPp5XJ3ZpznjdaEUB0E9AzTeij92h04hGEHhNgSuYVzj3IO3
         ur4Ar/udzofOItF6IXx4xIfFTrGlHxTlCXCgqQOLX4BBow8KThOCVnNgmtvi5YepuL9F
         Wf/w==
X-Gm-Message-State: AEkoouvyhWwkTltNrOaLLnbAiw6p7CneTYLwrHb7xB9BxravLqyjLvkuzZ1pjMbJhlqiqtfGMQFrSalLVsDJ3g==
X-Received: by 10.36.84.135 with SMTP id t129mr3138136ita.63.1472031331034;
 Wed, 24 Aug 2016 02:35:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.54.40 with HTTP; Wed, 24 Aug 2016 02:35:00 -0700 (PDT)
In-Reply-To: <f55e70fa-5244-66a0-d3a7-c6479528039d@drmicha.warpmail.net>
References: <CALqjkKZO_y0DNcRJjooyZ7Eso7yBMGhvZ6fE92oO4Su7JeCeng@mail.gmail.com>
 <f55e70fa-5244-66a0-d3a7-c6479528039d@drmicha.warpmail.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 24 Aug 2016 16:35:00 +0700
Message-ID: <CACsJy8CZf0O+uyQaeJ4gcx4XN8ivfFyni+3586WX_R2QM4XgVw@mail.gmail.com>
Subject: Re: Bug with git worktrees and git init
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     Max Nordlund <max.nordlund@sqore.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 10:21 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> I've cc'ed the master of worktrees.

Thanks for the analysis. I'll provide some patch as soon as possible.
This git-init may also be a good place to repair broken worktrees too
(e.g. because you moved a worktree manually)..

PS. Master? Wheeee I'm a master!! :D
-- 
Duy
