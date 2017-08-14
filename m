Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0EF220899
	for <e@80x24.org>; Mon, 14 Aug 2017 17:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbdHNRyq (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 13:54:46 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35532 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdHNRyo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 13:54:44 -0400
Received: by mail-yw0-f175.google.com with SMTP id l82so59094868ywc.2
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jzSaznWnkvHoMUKZKIEjGUTDFI0TZamhfdjpqdZeu74=;
        b=dvpTZfwKm+dGaz9lKUh07LDlelsrWPjJL55FMf5ZAmtDbBGMcvYo/tWyk2mTg8O9yG
         FznF3L+MNJ0kTt+Zd1rQSiAICxud8zTcnU+r2QaR8U+q78bktgY7UpJj9nDb/+pvZpJ1
         q+D7M60azTENcyNtc/pXburSJth38GROAu8I5jjpTTUnXMrhbhqxfaSPu/01iUYsCR2V
         wUzWzM6zlL3s1NTOItDc3i07OUeRWz8dEkzy/PMcwArx8u2m0rL22sCK0LqCiNlJcZja
         /9q/QF4RMy+KIBqO9sVLsQa+F0h+EBIKYoRMvn6NE8Tk30FTpwdLUnUdBBNU/pgg8P5T
         VqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jzSaznWnkvHoMUKZKIEjGUTDFI0TZamhfdjpqdZeu74=;
        b=UkVFVFqxjjTWQmvVlFuADHHPAx6DnNiOIpTLrbOKzLzvVW8DMdBvvzckP+p4+WwWBQ
         jE19+ZSeeFud1nrF55J7UNCtQm8+OKgdg2gqcha/YVlDNgHxhO/GvoGXFIbFhamJm0dD
         bxj5KdifIm0xlqLwNabrDRVmtBZV7gihHeDO7wrPxT9E06ivZvc0zzGFjMwCNwhsKD6O
         Ib25xVKMMXf/p80awj+5FwgoGGz9Gapr/TVzgwhpnsp1wDNSp0Qwiz+u2nEiadbGxFY5
         pwbK+18Jl5MDMEatywNrsFDqLbY8cdz8MSofPu/wef7B+xpTf8p098+vMAm5ZeGWJckZ
         GQIg==
X-Gm-Message-State: AHYfb5iLHOhXGqJKAmyE+1FVIpkrrT9z+HLw0VuaP7tc64qJ2WwTfz+F
        FEJuJjbvpJgBwl57+vU0Faw+aEw+FQJ6GW8=
X-Received: by 10.37.51.7 with SMTP id z7mr20394036ybz.145.1502733283659; Mon,
 14 Aug 2017 10:54:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.75.3 with HTTP; Mon, 14 Aug 2017 10:54:43 -0700 (PDT)
In-Reply-To: <20170814084646.30781-1-kaarticsivaraam91196@gmail.com>
References: <20170711141111.7538-3-kaarticsivaraam91196@gmail.com> <20170814084646.30781-1-kaarticsivaraam91196@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 10:54:43 -0700
Message-ID: <CAGZ79kYPE1qQT6Lqd4M=uBUjX3e3p-ABOEm+ggAJMgfw0ENB0Q@mail.gmail.com>
Subject: Re: [PATCH] hook: use correct logical variable
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 1:46 AM, Kaartic Sivaraam
<kaarticsivaraam91196@gmail.com> wrote:
> Sign-off added should be that of the "committer" not that of the
> "commit's author".
>
> Use the correct logical variable that identifies the committer.
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  This fixes a small issue when trying to do the following with the script enabled,
>
>     $ git commit --amend -s
>
>  If the commit being amended was signed off by the commit's author then the above command
>  would *append* the sign-off of the committer followed by that of the commit's author.
>  That' because the script is invoked only after the sign-off is added by the '-s' option AND
>  the default of 'trailer.ifexists' for interpret-trailers currently defaults to the 'addIfDifferentNeighbor'
>  thus interpret-trailer fails to identify the existing sign-off of the commit's author and adds it.

The background knowledge provided up to here seems like
a valuable information that we'd want to preserve in the commit
history, i.e. make it part of the commit message?

Code looks good.

Thanks,
Stefan

>
>  Anyways, it doesn't make sense for a script to add the sign-off of the commit's author. So,
>  fixing it seemed correct to me.
>
>  templates/hooks--prepare-commit-msg.sample | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
> index a84c3e5a8..12dd8fd88 100755
> --- a/templates/hooks--prepare-commit-msg.sample
> +++ b/templates/hooks--prepare-commit-msg.sample
> @@ -34,7 +34,7 @@ SHA1=$3
>  #  *) ;;
>  # esac
>
> -# SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
> +# SOB=$(git var GIT_COMMITTER_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
>  # git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"
>  # if test -z "$COMMIT_SOURCE"
>  # then
> --
> 2.14.1.534.g641031ecb
>
