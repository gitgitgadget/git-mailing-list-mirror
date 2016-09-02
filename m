Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 148021FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 23:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbcIBX6R (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 19:58:17 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35553 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752509AbcIBX6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 19:58:16 -0400
Received: by mail-it0-f42.google.com with SMTP id e124so65242982ith.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 16:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i/mr5xVGd7OLpM5xBz3/7MpguKUfzuOrMjdwoKbdG60=;
        b=KUYp+gp4ERa6dzi9JjPxX6GZBcRojBRFKQFCQoMhQ0pjEaAPIcESE2jl4MNi4ul3ll
         P1n8zW8j4wWBKG4/uzlVqNhWoJrh6KjBnkMGOvv4HZMmNynxqfminSXDwEIUfLQ9EvaF
         nGmu8DylK6h/mj7L/u5vEKDWn2KgsaGVZw0lIDvyJvIox+Nn7aeLYv79J1RgW/z8oVZB
         8G99nX4QtfPeupFlcYH1F2JphQXPBRrp68uv3j7tTGvtGN1yJii9Tys/v0ysuVRA1K3H
         iDTFZCCzVDj2ha5jT2lwF64kjSPqaA/3rPJCqZpcxuXsOidXmh5uIh4CfJDGeTx/A+AU
         T+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i/mr5xVGd7OLpM5xBz3/7MpguKUfzuOrMjdwoKbdG60=;
        b=G3HxvJ1ViQjqc4ImB4Le0pKqNklww681/pGr0gdBzUqVvyxnNwuOPJvgk7Uxd80vcd
         zTJxMPBOlXDBnrIrm7Gam8xJZ4NkUL2cpMldscrn8gjY0X24lcv1i7DFAvXHoGcUUGwX
         +b9i842OGhlbY2/DOeZsl9zi1RMLiuR5GUyONQrf4rIqvfdCa239ZF8p9gr/Vcqx864N
         7vDTyCMBXqTiv4szBK/4PL9bBU73NCymPvAFjOv90xCaHngbFUJZbLUSy+YcDrCgSO72
         dc8oohFgQBJ5PTUFQHXgus55UbCwCPdr/FHqUVyHPwNxd3AViZi4QwgZWY/AGQT/XHN5
         PMuA==
X-Gm-Message-State: AE9vXwOsEn4dBsjXCrAAC1YX+6Wr4MfQz1HEOsB+QOqM1t3K2F6mK0vAwj9nH/XjSJoEEAHYnC3x8T3CBt3RFLoF
X-Received: by 10.107.134.87 with SMTP id i84mr2060431iod.165.1472860695357;
 Fri, 02 Sep 2016 16:58:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 2 Sep 2016 16:58:14 -0700 (PDT)
In-Reply-To: <CAMbP-nS_MM0QXgw183DLQPx1YU1BH8ytKCv86p-JSxzdb2jpQA@mail.gmail.com>
References: <CAMbP-nS_MM0QXgw183DLQPx1YU1BH8ytKCv86p-JSxzdb2jpQA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Sep 2016 16:58:14 -0700
Message-ID: <CAGZ79kYhV30AuXUKtp3oewMpnEk5vD=HvRUJTTFaEdsacu3tGw@mail.gmail.com>
Subject: Re: Bug Report: Too many untracked files (gitignore)
To:     Brian Levinstein <blevinstein@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 2, 2016 at 4:06 PM, Brian Levinstein <blevinstein@gmail.com> wrote:
> The relevant repo is here:
> https://github.com/blevinstein/dotfiles
>
> My gitignore file looks like this:
> https://github.com/blevinstein/dotfiles/blob/2400ca8642a7b454a2bfc54e8402343d008836aa/.gitignore
> It basically ignores all files, except for specifically whitelisted
> files. However, when I run "git status" (git version
> 2.8.0.rc3.226.g39d4020), I see the following untracked files:
>
> #       .bash_history
> #       .bash_logout
> #       .cache/
> #       [private]
> #       [private]
> #       .profile
> #       .viminfo
> #       dev/

For the specific files to be exclued, I'd recommend starting with a slash, e.g.

    !/.bashrc
    !/.vim/colors/*

If the pattern does not contain a slash /, Git treats it as a shell
glob pattern and checks
for a match against the pathname relative to the location of the
.gitignore file (relative
to the toplevel of the work tree if not from a .gitignore file).

See the notes section of https://git-scm.com/docs/gitignore

So I do not quite see the bug?

Stefan
