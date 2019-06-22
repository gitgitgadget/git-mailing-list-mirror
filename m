Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1679C1F461
	for <e@80x24.org>; Sat, 22 Jun 2019 03:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfFVDCE (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 23:02:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32824 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFVDCD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 23:02:03 -0400
Received: by mail-io1-f66.google.com with SMTP id u13so493997iop.0
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 20:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbwsnexVvS9GWvhMH8MvQ3ytg74H34A22XI7qVJwrnA=;
        b=cgGEQwjZ6xRiwIt1sJnyXu9iSyjB4bu8CVAVqYUdDjuoSDmAzIJGCSv1t0P+QWXXHG
         nZt5HfXkTrEE+IZp3gToTKXI92VupL5s66zNa3GeCDCzozNO8q/oTsTjWi+MOMKeBlem
         zzdg6/oCSh5V/5JHHJHqpwkcC4CcxRz40JbnW+cy2iCrQnIgluy+bz7XPtrlkfl/Gjer
         zTFV0gTZXF1AbW2wBrYSsRv+63L7kOpJHvvL/OqmmLrXiZrSCibIoBb3Z27wRlc6dShd
         rfZ/sLPs65yMa8hpMqEmSRXjdy5Ef7mXgGswlpWFkiPOtTe/OjNBtcRunUzPvv0Tphol
         s59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbwsnexVvS9GWvhMH8MvQ3ytg74H34A22XI7qVJwrnA=;
        b=f34AKrQijl2U3XTcD6JpwTWtPm942cyURlmklZxJDirV0wvPALxL9zD5zH0cjWtyDO
         Te/eK7LYpAyzRAxoJCyBCCQANKRqh6ACbRwDynk+JQzBuaMXCXOTy2lpgDENegC1M2MV
         o0WXAHSw1zBLb7eO0OfpUjSS3wwdUHi2AFkHHAbZMyr+77SwZK/G/bkdc1Dx6VNhjy1u
         kS0NZdnRNGxyTKpymddXiZeSJqreVgHTMqwmZDz4/lxAyjpnvVjTXucYsP6h1jft4i50
         EXXGRoNyKFjeqHsprXOjKmsXF+zpUyMNZmIGRoPZfohIpuCrxq4VTW8sqBgV6/lThQJ8
         3o2A==
X-Gm-Message-State: APjAAAXkKqBJ7RNw4r3QdorW6MD5iX26JSNms/Z4R9lXoYj/Mty5K8Vi
        iLb2aF3RPcDVb2IMvIUk2xR0SBvF7QtjdlRg1d8=
X-Google-Smtp-Source: APXvYqwtQNRds9LomULOiy5G+enfMzY0qpkGtJ/BYuDyG0bb45+iCnsOdldzCSSnFatytt0Jc+WnCHMuf7GgCR1pS9o=
X-Received: by 2002:a6b:7312:: with SMTP id e18mr2503087ioh.156.1561172522774;
 Fri, 21 Jun 2019 20:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com> <20190621223107.8022-14-felipe.contreras@gmail.com>
In-Reply-To: <20190621223107.8022-14-felipe.contreras@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 22 Jun 2019 10:01:36 +0700
Message-ID: <CACsJy8AATA-7Z+HsA80NQ2j4Z9JeuSYXiBZLi=7FopzfLY1R+w@mail.gmail.com>
Subject: Re: [PATCH 13/14] completion: add default options
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 22, 2019 at 5:31 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Versions of Git older than v2.17 don't know about
> --git-completion-helper, so provide some defaults for them.
>
> Also, some commands fail if there's no Git repository available.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 97 +++++++++++++++++++++++++-
>  t/t9902-completion.sh                  |  4 +-
>  2 files changed, 98 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d3ee6c7dc2..922ba5f925 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -377,6 +377,100 @@ else
>         unset $(compgen -v __gitcomp_builtin_)
>  fi
>
> +__gitcomp_builtin_add_default=" --dry-run --verbose --interactive --patch --edit --force --update --renormalize --intent-to-add --all --ignore-
removal --refresh --ignore-errors --ignore-missing --chmod=
--no-dry-run -- --no-verbose --no-interactive --no-patch --no-edit
--no-force --no-update --no-renormalize --no-intent-to-add --no-all
--no-ignore-removal --no-refresh --no-ignore-errors
--no-ignore-missing --no-chmod"

And who's going to keep these uptodate? If you do this, might as well
delete --git-completion-helper

A more acceptable option might be regenerate git-completion.bash and
run --git-completion-helper to generate these, or make
git-completion.bash source a generated file. But that might need some
more build infrastructure, and people who just one to copy the file
might not like it.
-- 
Duy
