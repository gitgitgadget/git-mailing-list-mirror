Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0FD61F45F
	for <e@80x24.org>; Tue,  7 May 2019 04:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfEGES7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 00:18:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39908 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfEGES7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 00:18:59 -0400
Received: by mail-io1-f66.google.com with SMTP id m7so10834619ioa.6
        for <git@vger.kernel.org>; Mon, 06 May 2019 21:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webstech-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXZoURWjNMENUOHC8ffRuwq1BftoTw/HLNgbJn5fyLk=;
        b=tZupat50CQNJ1g37CJmn2dDG0UGVcYBqTSm1lxu6R7H6vGm5Bw5zXEgGsLrinYr5ic
         kEu0ICxelr9pw6/wFqdaN6QCV2IoPpFo8sisw6g+Umop4yIG8ucQ8JQ6rTQpj2cITNev
         gqarp/eTh08DpEjVTe07WysQQXNZIuXQ4jzqlN86+jpYfPpD26OAwq3PQR/9jSo1NcI8
         PS+0J5w247eqfD4yYobx/ieT4sz06Yyu202rdvAEIP1NS4ttsPOI4hEI4Eqi8D7KF0qH
         pdhmoW4l0rsaM281pXYqOdH6lfPRTBXR7FHYa5FyOaZfc2zzsJ/q9TiZYOPitZ0O4fb9
         xkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXZoURWjNMENUOHC8ffRuwq1BftoTw/HLNgbJn5fyLk=;
        b=hndKYPNHuGyRe3/jA7F/T5EGdxjAmbIfy1NKmId5E6YTtD9qzlw6wdvLkU0XZn7IJ4
         aL7Ws59qBJ3FrFrbwGm9lrhceMHK2WwsiqaYGxJhehFXzHZdA/lPvXHGgYc/Em1HKROo
         aGiRF0uHmXF9ZDCHbzWOBw7WXaC9dtPZVRubiORpb+vPZzQjm2b0uStCKxZItFIUeMSW
         KIpa/eh//yCQRkeotvFFdfSeRUia+sX4kAK6m+/+8xBBzvA/9E601XpQxF+9Fo4Vc3m6
         KtNRJIAaxuDhTvOzRvCiR5icZb6zOdVAPcQThh4G701lxIwmhq+nGY+xKZpT7HtD/HcJ
         W0Xw==
X-Gm-Message-State: APjAAAUxi3ofP9xHmR37ea1YKdxh61/RMGxk/I3yRVZ4VKJwOEf/+wOS
        MZOkrdyKoSVk3BVeE8O6Rx65QE7pB9hs9C274/35pg==
X-Google-Smtp-Source: APXvYqx34fuf72VW417ncGryMYyiVIDSbqEcA6DrIWc4Zk5qQN3jnh/LbaoyNuj12gtUg4Iy7pRmB/ryglxS5AjcZiU=
X-Received: by 2002:a5e:890f:: with SMTP id k15mr19592679ioj.68.1557202738128;
 Mon, 06 May 2019 21:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.59.git.gitgitgadget@gmail.com> <pull.59.v2.git.gitgitgadget@gmail.com>
 <bcbffa141116f869db40e4572f9824a3d090c20c.1541026721.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1811061501210.86@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1811061501210.86@tvgsbejvaqbjf.bet>
From:   Chris Webster <chris@webstech.net>
Date:   Mon, 6 May 2019 21:18:55 -0700
Message-ID: <CAGT1KpVn536+B6-8=opNAVnz3_w13Kx3LyED0Gbk+4DtwmoP6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] diff-highlight: Use correct /dev/null for UNIX and Windows
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I know these can take some time but is this pending any update from
me?  The accepted changes will be merged back into the diff-so-fancy
project.

There was a question about other uses of /dev/null.  In the contrib
directory, there are a couple of uses.

contrib/buildsystems/engine.pl - not clear if this is still of use or
always expects to always be running in a mingw type environment.
contrib/mw-to-git/git-remote-mediawiki.perl - this is cloned from a
separately maintained github project.  Should any changes be issues on
that project?

thanks,
...chris.

On Tue, Nov 6, 2018 at 6:02 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> List,
>
> I have no idea why this mail made it to GitGitGadget's email account but
> not to the Git mailing list... Sorry about that.
>
> Ciao,
> Johannes
>
> On Wed, 31 Oct 2018, Chris. Webster via GitGitGadget wrote:
>
> > From: "Chris. Webster" <chris@webstech.net>
> >
> > Use File::Spec->devnull() for output redirection to avoid messages
> > when Windows version of Perl is first in path.  The message 'The
> > system cannot find the path specified.' is displayed each time git is
> > run to get colors.
> >
> > Signed-off-by: Chris. Webster <chris@webstech.net>
> > ---
> >  contrib/diff-highlight/DiffHighlight.pm | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
> > index 536754583b..7440aa1c46 100644
> > --- a/contrib/diff-highlight/DiffHighlight.pm
> > +++ b/contrib/diff-highlight/DiffHighlight.pm
> > @@ -4,6 +4,11 @@ use 5.008;
> >  use warnings FATAL => 'all';
> >  use strict;
> >
> > +# Use the correct value for both UNIX and Windows (/dev/null vs nul)
> > +use File::Spec;
> > +
> > +my $NULL = File::Spec->devnull();
> > +
> >  # Highlight by reversing foreground and background. You could do
> >  # other things like bold or underline if you prefer.
> >  my @OLD_HIGHLIGHT = (
> > @@ -134,7 +139,7 @@ sub highlight_stdin {
> >  # fallback, which means we will work even if git can't be run.
> >  sub color_config {
> >       my ($key, $default) = @_;
> > -     my $s = `git config --get-color $key 2>/dev/null`;
> > +     my $s = `git config --get-color $key 2>$NULL`;
> >       return length($s) ? $s : $default;
> >  }
> >
> > --
> > gitgitgadget
> >
