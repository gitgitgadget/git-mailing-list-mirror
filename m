Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B640E1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 10:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeJVSfS (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 14:35:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33042 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbeJVSfR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 14:35:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id r25-v6so2613618edy.0
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 03:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YVMt413st4en8QrVHnc8r55PJp3TaJZd1mOJgFYVuDg=;
        b=g4FNwS1uLtydb2FL4e60Tj9aQ+ybCDTI34UiomrLKqTKVubZxkJRNnbvEW19Fhu0jI
         TDHWGzv9eUMT+F/EL9Yq04qwdMqB5mxNencH+LmR+gBGcWJMXFLDvAwKMS+PpGmT8Fb0
         Frg/iPcNt/YQCWXmI9VoU6l8/TDqZElrGax1pDX4k5W+3ZrENvpUjVtQ4eWyF5lZFme2
         yg7llB1+drqdOS561uBQutLt+83xbCpV0LnJPZr9thz1pJBzomUH1SeJTtifefUuoUnt
         Xg+zHj/IYdEd0XB9gb78QgnZCRRIYZ1wKI/BZoaK99pInRnhazYyCMcvr5eXYmXyEKDP
         E/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YVMt413st4en8QrVHnc8r55PJp3TaJZd1mOJgFYVuDg=;
        b=szZHAgtP98LGM4rWvImIAz6L8Ii+3ILYC83DrICpEFTDuGcHLmWZpTVnN7THYv5hZb
         o0MZnaypbfvOFUVOHkBREPWAYNzTXSBZX+5a4HQA+KLap3wju20paSbH7KuV9MXws4QI
         DQRjtyWBUUq49bKK86nQDTwxu6AW2SxwBTlM255ACsETVDt0WULhQE2XqsrWgmfk3iy9
         JF4+6yisWQcVNj4baKTMEsCzMNMnwtWxuiZJHEmCG3pmvUr6PzEzVxvlaVdglj32bv8E
         db5ba4jnq+/ftfCzHgmnkGAHjxQeKMW3Dj32FGlKdOiVoVMXcvC2S7KnKJWkWKQREdc6
         vHbA==
X-Gm-Message-State: ABuFfoj/oBrNMhsw3Lf7o5IffOhKbtV/H3EPIuzf+2w+XnCLz2kI00Py
        lddYZ0Opz+DUEP89hz1qp1U=
X-Google-Smtp-Source: ACcGV61Y0pLo+Vr9TKGUHyC1AsiyLj8N30vNwc0fY06pt3TdkTfN3JkbKmy0hTENBUVWYgGBx6MoFQ==
X-Received: by 2002:a50:e80c:: with SMTP id e12-v6mr12775755edn.117.1540203442271;
        Mon, 22 Oct 2018 03:17:22 -0700 (PDT)
Received: from szeder.dev (x4db968d4.dyn.telefonica.de. [77.185.104.212])
        by smtp.gmail.com with ESMTPSA id q12-v6sm13948501edd.35.2018.10.22.03.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 03:17:21 -0700 (PDT)
Date:   Mon, 22 Oct 2018 12:17:19 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] completion: use __gitcomp_builtin for format-patch
Message-ID: <20181022101719.GE30222@szeder.dev>
References: <20181021084102.8318-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181021084102.8318-1-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 21, 2018 at 10:41:02AM +0200, Nguyễn Thái Ngọc Duy wrote:
> This helps format-patch gain completion for a couple new options,
> notably --range-diff.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Of course it will be even better if I could complete the ref for
>  --range-diff=, but maybe another day.
> 
>  contrib/completion/git-completion.bash | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c8fdcf8644..065b922777 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1533,12 +1533,8 @@ _git_fetch ()
>  }
>  
>  __git_format_patch_options="
> -	--stdout --attach --no-attach --thread --thread= --no-thread
> -	--numbered --start-number --numbered-files --keep-subject --signoff
> -	--signature --no-signature --in-reply-to= --cc= --full-index --binary
> -	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
> -	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
> -	--output-directory --reroll-count --to= --quiet --notes
> +	--full-index --not --all --no-prefix --src-prefix=
> +	--dst-prefix= --notes
>  "

$__git_format_patch_options is also used when completing 'git
send-email's options, thus removing all these options will badly
affect that, and in fact makes 't9902-completion.sh' fail with:

  expecting success:
          test_completion "git send-email --cov" "--cover-letter " &&
          test_completion "git send-email ma" "master "
  
  --- expected    2018-10-22 09:03:42.255325418 +0000
  +++ out_sorted  2018-10-22 09:03:42.255325418 +0000
  @@ -1 +1 @@
  ---cover-letter
  +
  not ok 122 - send-email
  #
  #               test_completion "git send-email --cov" "--cover-letter " &&
  #               test_completion "git send-email ma" "master "
  #


>  _git_format_patch ()
> @@ -1551,7 +1547,7 @@ _git_format_patch ()
>  		return
>  		;;
>  	--*)
> -		__gitcomp "$__git_format_patch_options"
> +		__gitcomp_builtin format-patch "$__git_format_patch_options"

You sent out a separate bugfix patch (i.e. not a patch series)
"completion: fix __gitcomp_builtin no longer consider extra options"
in:

  https://public-inbox.org/git/20181021083731.8009-1-pclouds@gmail.com/

and this patch makes the completion of 'git format-patch' also use
extra options...  So, does this patch really work without that bugfix?

>  		return
>  		;;
>  	esac
> -- 
> 2.19.1.647.g708186aaf9
> 
