Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A97320188
	for <e@80x24.org>; Thu, 11 May 2017 03:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753419AbdEKDxO (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 23:53:14 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36626 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752398AbdEKDxN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 23:53:13 -0400
Received: by mail-pf0-f194.google.com with SMTP id n23so579736pfb.3
        for <git@vger.kernel.org>; Wed, 10 May 2017 20:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=IEfXkkJP1KS3s2ZV6LSPAeabLmCOn8bd7TH3glt16HU=;
        b=pwmVtLlML/KXKol4qGi8UhvxhtRMiEi9Ugvgtu0ZL9MEo+1N0XFezxmsP8ZoSi8arV
         bRdq0NV7Ho5ANVQlNfX0rBMFtO4luzHYHvu7Ia0Ha/MiuY1B9oeJuhu+Apnl+PkiQ3es
         NjzYuUwfG7CXSHMUjfol4N54FdpjCcc8QrnEVzQQMU7TUUq969n2VYcDWJN/0y0/T04U
         0xaMhNc+WGEb+KXLAp3kKE9a9SNaWWQRdxIsmST5c3M0oODhidE4F2hGukpb0m6h+Fws
         Lc1r1DdMhd/5sFsfc7UP9GaLlp/GWAUD9RUr5H3/heBZZ53aTlEFqk03ohSfrioi1usj
         EpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=IEfXkkJP1KS3s2ZV6LSPAeabLmCOn8bd7TH3glt16HU=;
        b=O7dxULLstPs2OUVprEjhvTe/i7M3HEUn7TJ9ujupPtWvZXZYHdj9Jctu6QJm+FdCWU
         13/emnIyF0MY9MEjlD53j/YyvHYVC70cTHyLPA3q4nvxMVfM2JousUG6mvDEus/OtJZT
         TaU1qfQCKtkhdyNFTGw4TQ5+cfaduJsGzdhvLTu8CO9IPgWPdLS7cnOw1QZV2xh85en4
         vzcW9uk2G1DFZ2DCNphTBa4RGeaPocXJXGTQLvOTaF0taWpd9YxbeLsNW87J/Kl99mUT
         RIuL3x7ythzox1UPrrPp5M8sAvMEO3raOi5F9coY5NBzyR4S5mT0aY2TzZhQhpyxbKR0
         G0XQ==
X-Gm-Message-State: AODbwcCbuPizrrxjgx4m6eFNcaGGd5NcDWn6lNwOpI4OfRExdk3ZYUV3
        67Wuz2gLzWPvhw==
X-Received: by 10.99.107.201 with SMTP id g192mr10146659pgc.149.1494474792458;
        Wed, 10 May 2017 20:53:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id l7sm667633pgn.10.2017.05.10.20.53.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 20:53:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org, rashmipai36@gmail.com
Subject: Re: [PATCH v2 3/3] git-filter-branch: make the error msg when missing branch more open
References: <20170503162931.30721-1-jn.avila@free.fr>
        <20170503210726.24121-1-jn.avila@free.fr>
        <20170503210726.24121-3-jn.avila@free.fr>
Date:   Wed, 10 May 2017 20:53:11 -0700
In-Reply-To: <20170503210726.24121-3-jn.avila@free.fr> (Jean-Noel Avila's
        message of "Wed, 3 May 2017 23:07:26 +0200")
Message-ID: <xmqq1srwcamw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noel Avila <jn.avila@free.fr> writes:

> git-filter-branch requires the specification of a branch by one way or
> another. If no branch appears to have been specified, we know the user
> got the usage wrong but we don't know what they were trying to do ---
> e.g. maybe they specified the ref to rewrite but in the wrong place.
>
> The safest solution is to just print the usage in this case.
>
> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> ---
>  git-filter-branch.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 2b8cdba15..bda2bae23 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -239,7 +239,7 @@ git rev-parse --no-flags --revs-only --symbolic-full-name \
>  sed -e '/^^/d' "$tempdir"/raw-heads >"$tempdir"/heads
>  
>  test -s "$tempdir"/heads ||
> -	die "Which ref do you want to rewrite?"
> +	usage
>  
>  GIT_INDEX_FILE="$(pwd)/../index"
>  export GIT_INDEX_FILE

I tend to agree with Ævar on this one.  It is not apparent to the
end user after this change what exactly was wrong in the input; for
that matter, it is not even clear that the command is refusing to
run because it found problem with the input.  

Trying to move away from asking "I didn't get that, what did you
mean?" is one thing, and that can be done by saying "no ref to
rewrite given" or something.  We may want to make it into a more
"positive" nudge, telling the user what to do, e.g. "give me the
refs to rewrite."

Thanks.



