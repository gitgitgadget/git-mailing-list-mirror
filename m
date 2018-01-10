Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 023521F404
	for <e@80x24.org>; Wed, 10 Jan 2018 19:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeAJTrf (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 14:47:35 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:41847 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeAJTrd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 14:47:33 -0500
Received: by mail-qk0-f174.google.com with SMTP id a8so391202qkb.8
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 11:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R8KVt37sTyksBt0IjCb2l31feOhk/ixKIPt25A4bF0E=;
        b=drimRveu1RwlO1WbdHCsRS2jXa/bFtT7aT3LjUFYHCKIks+URIFK/nnjq7RPSvK9Ld
         MLojF/wfU6II8ZkABzRFoxcf2hUxqcndxKhIaMV5lSaFMToAWtyUMrjh29MbXBKNR5Rr
         k0NNT25ioR6Thle4CbOWEXw55EIJG7Es/aXK88/9VD9tdj0u8eL5t+kJVAzz2o5vHQSB
         VsBjnx8Lt3v2A2KsjRCmLrGvxyvfxctuVTcOTvCoFQ6sQubZvpNp9xqvyQthZZzRkg01
         +8eG5MW82vmu7hR+L+F0p5VqB/Cg3PIns06aRoX54D0oXHY1TyoBV5onOTsFiq690NzS
         +EPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R8KVt37sTyksBt0IjCb2l31feOhk/ixKIPt25A4bF0E=;
        b=pyG4grgSnf8qoK/ORvvmn04lCJH548vVrtEB/wOTCPamkO0Jg3ns4iy1gcC7Xfit3Q
         eW9NegKbKQFPUpqV2twxpkoV3NyEQxD2ESIE+YDg89L6ZuT3ov4iHQ31Zgji2skasYaE
         oaaA7jBhI++udhIze69c2pSSE6e1/UsV4MYTjIbxLCNyvaFFGtwx9A91n3jJ/zL9D6Bb
         54p0HKT3mDFy9Gx51Z4Cx59+sUOnNqMv95hMEQhPMirP5vHG3U17NJr1Erji7xMpF4Gr
         wk5OBdzZPaMtkMNsuv2wXp+idIGDlbbUPkcUGjNlp6qljq5UnuxfpjTWO0pJK+LW3MX6
         R3MQ==
X-Gm-Message-State: AKwxytd8njE5h3HiMb6vGCjAjSyxUU4F0sWFSxiuocDoQ+gn5bzyn9AC
        /hLeoIxUu4Q5sLeDqIV5r+NzcZvhzYYkZmUhfcrIGpWa
X-Google-Smtp-Source: ACJfBosAcsWqj2d80pJ2uGCej6JKPkocHyV8MRXKksvakZYNIX16aLbfrJ0SYqbl0HohzrQ49tnqv+YA0mA6ZrKINc4=
X-Received: by 10.55.162.150 with SMTP id l144mr17670220qke.336.1515613652482;
 Wed, 10 Jan 2018 11:47:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 10 Jan 2018 11:47:31 -0800 (PST)
In-Reply-To: <20180110110643.21465-1-pclouds@gmail.com>
References: <20180110110643.21465-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 10 Jan 2018 11:47:31 -0800
Message-ID: <CAGZ79kbUL6UBBB-wL+BxBdbomt+sxa66VVSYBxxBt6JVfPVfKA@mail.gmail.com>
Subject: Re: [PATCH/RFC] add--interactive: ignore all internal submodule changes
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 3:06 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> For 'add -i' and 'add -p' the only action we can take on a dirty
> submodule entry (from the superproject perspective) is its SHA-1. The
> content changes inside do not matter, at least until interactive add has
> --recurse-submodules or something.
>
> Ignore all dirty changes to reduce the questions 'add -i' and 'add -p'
> throw at the user when submodules are dirty.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  $DAYJOB started to use submodules and this annoys me so much when I
>  use 'git add -p'. I'm neither very familiar with add--interactive nor
>  submodules code but this seems to work. Hopefully it's a correct
>  change.

I would think this fixes your problem and it looks correct.

However I wonder about some subtle detail:
the "dirty" setting will ignore anything inside the submodule, and
only pay attention to the delta in gitlinks between HEAD and index.

Maybe we'd want to have a mode "dirty-except-submodule-HEAD",
which would ignore all submodule worktree changes, but if its HEAD
is different than the gitlink in the superproject index or HEAD, such that
checking out a different revision inside the submodule is not lost
when staging things in the superproject for a new commit?

>
>  git-add--interactive.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 28b325d754..964c3a7542 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -262,7 +262,7 @@ sub list_modified {
>                 }
>         }
>
> -       for (run_cmd_pipe(qw(git diff-files --numstat --summary --raw --)=
, @ARGV)) {
> +       for (run_cmd_pipe(qw(git diff-files --ignore-submodules=3Ddirty -=
-numstat --summary --raw --), @ARGV)) {
>                 if (($add, $del, $file) =3D
>                     /^([-\d]+)  ([-\d]+)        (.*)/) {
>                         $file =3D unquote_path($file);
> --
> 2.15.1.600.g899a5f85c6
>
