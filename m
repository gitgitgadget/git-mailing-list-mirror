Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35F211F453
	for <e@80x24.org>; Wed, 26 Sep 2018 11:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbeIZSLu convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 26 Sep 2018 14:11:50 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:42195 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeIZSLu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 14:11:50 -0400
Received: by mail-qk1-f180.google.com with SMTP id w73-v6so9683811qkb.9
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 04:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3wl0us479AG/p9IoiWTAoi7TsZ5B6xt3lXsettvijGs=;
        b=lvA5sWBUYIsuLffcguvazWs3///lOjY2valYc2Ro3XvZcRBw33f7J2PhDBo6dSpqbG
         bQ5bm6IAtaLYKX1BYUV0rFPYXCjFy3er1PaFmTfsmoTIKwYoo8ouh4boSYPcUBStG9va
         FAYCcI2WpO0dWHxl0dNc4Ypwh0GWZYXrTDrPz1Gi1QAIvVtUdZtXB4NyA9YnVT0/m7Jx
         F3kbPtRKJAvEkGXYwvMfT5PW4DlkkFA8UMK9Lr9NMCKaoioXlEYxYe+57rBPvQNnn3Ay
         SDw7Aj6N778fhNDWtNgX3ftt2j4IHx2F2PTuIN/HxUcs6Vh1KOSODzdvxbnZQ/oR9jcV
         WQUg==
X-Gm-Message-State: ABuFfoiEXNM7ufpBo+wlvhSDyQYwnU8w7e9QlxwZkvDe2Ma/4hTmlES4
        1vmkcZjbARVAsfnWsMSPoTUPGyacJnG2dqmWZE0=
X-Google-Smtp-Source: ACcGV61xbaQfryVpXXOZvYM6noas0jao3H/FFte9ntVfdSImbYHySKQb8UUw8p77W9bU7EM/fnVi1XKkRaDhk5gC5NM=
X-Received: by 2002:a37:9306:: with SMTP id v6-v6mr3824910qkd.36.1537963150620;
 Wed, 26 Sep 2018 04:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <CALOYryFX4PPR+=1L+sjEqPsdmNh_+vNxGf0wwuAgoYzau=GShw@mail.gmail.com>
 <CAN0heSrhaaP0ds8K92g9w5DAnbwuq8mM6WLKrTQ7e_a8Fku9KA@mail.gmail.com>
 <CALOYryEMB5HoCXbVKnc49KLkk2ySZjn4DG9RbJjQAvPn1H5K6Q@mail.gmail.com> <CAN0heSpUhzbTjceVhBxk_jjE=vOAVTzXGFQ=UL9Y+muJHe0S6w@mail.gmail.com>
In-Reply-To: <CAN0heSpUhzbTjceVhBxk_jjE=vOAVTzXGFQ=UL9Y+muJHe0S6w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 26 Sep 2018 07:59:00 -0400
Message-ID: <CAPig+cR8KyeihQbUbSP7Awz+NTbf8c3r-ZE9w2wjnvvEpU0gDg@mail.gmail.com>
Subject: Re: t7005-editor.sh failure
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     apyhalov@gmail.com, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 5:53 AM Martin Ågren <martin.agren@gmail.com> wrote:
> I came up with the following commit message. What do you think about it?
>
>     t7005-editor: quote filename to fix whitespace-issue
>
>     Commit 4362da078e (t7005-editor: get rid of the SPACES_IN_FILENAMES
>     prereq, 2018-05-14) removed code for detecting whether spaces in
>     filenames work. Since we rely on spaces throughout the test suite
>     ("trash directory.t1234-foo"), testing whether we can use the filename
>     "e space.sh" was redundant and unnecessary.
>
>     In simplifying the code, though, the commit introduced a regression around
>     how spaces are handled, not in the /name/ of the script, but /in/ the
>     script itself. The editor-script created looks like this:
>
>       echo space >$1
>
>     We will try to execute something like
>
>       echo space >/foo/t/trash directory.t7005-editor/.git/COMMIT_EDITMSG
>
>     Most shells seem to be able to figure out that the filename doesn't end
>     with "trash" but continues all the way to "COMMIT_EDITMSG", but at least
>     one shell chokes on this.
>
>     Make sure that the editor-script quotes "$1".

This description of the behavior is misleading (actually, actively
wrong). Shells are not somehow inferring that the space is part of the
redirect filename. The missing piece is that the following all behave
the same:

    echo foo bar >cow
    echo >cow foo bar
    echo foo >cow bar

That is, they all create a file named "cow" with content "foo bar".
So, in your example:

    echo space >/foo/t/trash directory.t7005-editor/.git/COMMIT_EDITMSG

what is actually happening is that it is creating a file named
"/foo/t/trash" with content "space
directory.t7005-editor/.git/COMMIT_EDITMSG".

As for the "ambiguous redirect" diagnostic, that seems to be Bash
trying to be helpful in reporting what is likely a programming error
(that is, forgetting to double-quote the expansion).
