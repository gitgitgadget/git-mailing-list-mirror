Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236421F453
	for <e@80x24.org>; Sun, 27 Jan 2019 06:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfA0Gyx (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 01:54:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35625 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfA0Gyx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 01:54:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so11616045ljb.2
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 22:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jb+QAcWdPKj+YcqaVONrvLsauB9HtjVQqFAKi2BE/6s=;
        b=smWG8hvqkbYj3V7MZO45WcHpjoaYXzHU4HNrrdr0M7TA0SQ3DZk8XtD+6xnp4EhdON
         J94llHzMSI1Jpi47WOkDUVpBRorkvEurJNFwSN831IXeT1cHgxLfDMIunseb9zZ5I/8Z
         HqRuuTd5yr0p+EQWUTuq+dRy6iKxXe/Pp/Ny7ZxsEh1A+ZkMEK3yl21ug/wu7085vmys
         M57ubUD82ZtpdtASzjgeScSWDS/gUUlsVC8otHARarnRQcFE0jaro9Wb/kZQSNsLt9LV
         8oH/IujFSlg7sz5NknywuTwvbuMVE8Ri52Rh33+fcfJXm+nqhaerQ4lwblTW0+dNdS1B
         MW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jb+QAcWdPKj+YcqaVONrvLsauB9HtjVQqFAKi2BE/6s=;
        b=qQf4er37ufDlxL2qvGy37IEwlJDM3+8oNiMhWLaI8jcXHWEmQL07VFJnX4fsItYdUc
         vbrskYuuhMJFgkjzEtl58xEaxEoHnxwz1a30R3bC+JYmfUEsuFrZsbWLhnPJ6uGNAY4l
         ASwFoKXg+kesP79hHfZfsPm025JNWGgWCuOYzrGzs4Wf49HLsJzABk/gTNnk7sFLhKU3
         zmu9Ua07ZyISJ7ViyI8seMLwGviOv7uAeHYodcWNVKpB4uxftxXyBHJSUm6s5PdNs169
         amLFAakKLcLsKE+NrgStCtyioaYH58zZi1/iEEEIlnjat8bIQRDWdAV8eEBUedWcBOlE
         7VRA==
X-Gm-Message-State: AJcUukd+SCXrzborbvsBbEYlaP6vn0pLwMqzfBxIvQtQb0HjH/6Fn/XT
        4xxSjNZv+HfxzuPWIS7hRD4v9W9Cnmlma7jnTD4=
X-Google-Smtp-Source: ALg8bN6yOlzqiEajgzgzTWcFlgS9usct0CVj+psnPWVXbZqImcvYrT7KMdDcSAlaUw3lwE0KNp55A7tiVhLbSSt0m6s=
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr11002972ljk.80.1548572091383;
 Sat, 26 Jan 2019 22:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20190126204951.42455-1-koraktor@gmail.com> <20190126204951.42455-3-koraktor@gmail.com>
 <CACsJy8C27hKNTyGE5P+F6nzszN_z85chEq8MvQ+BgiDAi=4jww@mail.gmail.com>
In-Reply-To: <CACsJy8C27hKNTyGE5P+F6nzszN_z85chEq8MvQ+BgiDAi=4jww@mail.gmail.com>
From:   Sebastian Staudt <koraktor@gmail.com>
Date:   Sun, 27 Jan 2019 07:54:14 +0100
Message-ID: <CA+xP2SahEsQKxmjasA5XjuaEVNjbRNiKQv9uKkFkWoORv7WAXQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Add test for describe with a bare repository
To:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am So., 27. Jan. 2019 um 01:25 Uhr schrieb Duy Nguyen <pclouds@gmail.com>:
>
> On Sun, Jan 27, 2019 at 3:51 AM Sebastian Staudt <koraktor@gmail.com> wrote:
> >
> > This ensures that nothing breaks the basic functionality of describe for
> > bare repositories. Please note that --broken and --dirty need a working
> > tree.
> >
> > Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> > ---
> >  t/t6120-describe.sh | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> > index 9a6bd1541f..ddd8cc307d 100755
> > --- a/t/t6120-describe.sh
> > +++ b/t/t6120-describe.sh
> > @@ -409,4 +409,11 @@ test_expect_success 'describe complains about missing object' '
> >         test_must_fail git describe $ZERO_OID
> >  '
> >
> > +test_expect_success 'describe works from outside repo using --git-dir' "
> > +  BARE_CLONE=$(mktemp -d) &&
>
> No, keep everything in $TRASH_DIRECTORY so it will be automatically cleaned.

Looks like a relic from trying to get Git to not find an appropriate
working tree.
$TRASH_DIRECTORY/bare works here, too.

>
> > +  git clone --bare '$TRASH_DIRECTORY' \$BARE_CLONE >/Users/koraktor/open-source/others/git/t/out &&
>
> Ehh.. I'm pretty sure I don't have /Users/koraktor on my system :)
> This looks like just debug code, I think you can drop ">.." part for
> all commands.
>

Sorry. A bit embarrassing to leave debugging code in place.
I will remove the output redirection and echo.


> > +  echo $PWD >/Users/koraktor/open-source/others/git/t/out &&
> > +  git --git-dir \$BARE_CLONE describe 2>&1 >/Users/koraktor/open-source/others/git/t/out
> > +"
> > +
> >  test_done
> > --
> > 2.20.1
> >
>
>
> --
> Duy
