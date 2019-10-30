Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D24F11F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 17:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfJ3RQ3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 13:16:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43668 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfJ3RQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 13:16:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id s4so3530022ljj.10
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=swOU9CfUBTJQMZsP1iyh+HkxGmjELSHx1Yklx6BlPIA=;
        b=OWVABVWwclEqMf+JEjitupGxK4nTcf7jbobeLWgCqk7lAoxCz2boYWaNglf6gq+WzB
         1EXF6e1eYx61+oO+ZWcgOOgTUV7iTjToBj5/vtv5jbQBOA7NBAYLAI5BbUc7Y/IlBQGt
         3XVkruLVxVnI9vwgyK4ZaHUfPwR7/CixjUMhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swOU9CfUBTJQMZsP1iyh+HkxGmjELSHx1Yklx6BlPIA=;
        b=TLPIj9FPylSmqvuKuExOt5dV1da9qo+VeQdQ0jKMuCd5M5QdfhZziYSqu2lNH/262b
         4N28MlSw+YPVfCmT3yiHOcVjw1f9MxSkAIAegtolCXHk5eqWSYFt08FPFRsyk69Usgx0
         Iv1JWTVybQz1EK/w+W6y4ClX52iZ6icM/Pgbgxu6mZ0llfOCh7Mtte6dy6qIaMes+0I9
         e7wE+ZBU4EIvAcWqFZBpS5bNZWmJ/un9Qc+FXGidV/aKKETizCwnapEjBGVZHCknL+/Q
         1S0itnM6M/uav/bHvNWqZFICt/APMyMUOMeQfP9SrRk4hg2drDBHlTwlkR3B/TdAhW0/
         H7AQ==
X-Gm-Message-State: APjAAAWMnxBhQgDHu0dEZcnDTZ4uCjMfFcz+sTCbvmIYswyqZLKaTTQ7
        RIjm77tqaIHKJI9m1aqNJJG3y3vI2JpN5s6RqqYkHwNYnKyeICW7
X-Google-Smtp-Source: APXvYqzA1aqxeyVKUKF1+1joMLK7NNpgmf6Efz0ek/QmKkE+shb1q/+5+tTk0ECo0WCOwkZUt8c+UxQUrsY/X0uETA0=
X-Received: by 2002:a2e:9546:: with SMTP id t6mr564990ljh.219.1572455787023;
 Wed, 30 Oct 2019 10:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.436.git.1572418123.gitgitgadget@gmail.com> <CAKPyHN1p+xRAF3Mjg_XqRiEUviGjj8ifP5FM=1hVb5LZUshzLw@mail.gmail.com>
In-Reply-To: <CAKPyHN1p+xRAF3Mjg_XqRiEUviGjj8ifP5FM=1hVb5LZUshzLw@mail.gmail.com>
From:   Jonathan Gilbert <logic@deltaq.org>
Date:   Wed, 30 Oct 2019 12:16:04 -0500
Message-ID: <CAPSOpYufF8B0sBUUYqBx5YTxH+02qRom+tz4a0_2iBcNOvvMXA@mail.gmail.com>
Subject: Re: [PATCH 0/2] git-gui: revert untracked files by deleting them
To:     "Bert Wesarg bert.wesarg-at-googlemail.com |GitHub Public/Example Allow|" 
        <xlwsizdz58ciy7t@sneakemail.com>
Cc:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 30, 2019 at 4:09 AM Bert Wesarg
bert.wesarg-at-googlemail.com |GitHub Public/Example Allow|
<xlwsizdz58ciy7t@sneakemail.com> wrote:
> in Git speak, that operation is called 'clean' (see 'git clean') why
> should we overload the 'revert' operation here?

It's less about overloading the 'revert' operation as overloading the
UI action which is currently called "Revert". I think it would be a
worse experience to have to activate a different option to remove
unwanted files as to remove unwanted changes. Maybe the UI option
could be renamed "Revert & Clean" or something?

As a side note, `git clean untracked-file` won't do anything with a
default configuration, you have to explicitly `-f` it. Not sure if
that's relevant, but it does feel like a higher barrier to entry than
`git revert`.

Thanks,

Jonathan Gilbert
