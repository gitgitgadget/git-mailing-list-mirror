Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E9E41F463
	for <e@80x24.org>; Tue, 17 Sep 2019 23:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfIQXCa (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 19:02:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42788 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfIQXCa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 19:02:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so3976664wrw.9
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rqlyu9zH96hYtd1HEdJZ9ZxYClqQz8gPiZCylfSiedA=;
        b=hZvsIXw2CmqIUI2CfY8IOsxprgIEw23vDrnlhzVMPflVH46VyW5REaQIOKo9hSxkUr
         SJUu76a6jxTuFSqPDvijIfxTT0enn4WkTW7zW9rLotIgwHAVFTXextBHPeGdNhtuCW0Z
         IFggD6yJJG4LKNqtL3+W45wGZhowRIisLwUoABvEkfEdi6KowMvZVQj+F3aCtglwvfBU
         XdPRSJ5dZiit4mzn3M/8xFLpkMvSrRj/ezIECeUoVw8HDRBv4qZStGyyXjSj+B1EgVN9
         zeZG6SqYTuEpF/Ekvsq0GPC9MJrww5ZpOYo3Dk88oLhyGNe03XbKPsMDDKexKH6hOI2V
         tnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rqlyu9zH96hYtd1HEdJZ9ZxYClqQz8gPiZCylfSiedA=;
        b=bDeUs7dF8bpz1aHCePZcwXpXAaD0E/ePicUdqtHMCVGbxsDX+VZAxh48Da3v0lgrP/
         DCEn/ghSSIB6faXd5mHMT3lEdXr7ka4BE243EH1O0YBBDx38rhkr7poD8muBKq/QmDUB
         VnWvpbRqweRkacCswoWTvXD/B3WmPCzQYlUm93BAeXRJUZA2myWg/BhfKULZ6jKPaowL
         UTe5LC1XidJs2hfsxpWCY+tkcldL6KeIPNKPf6bP/6aXyiz4DPCmA/Y2ng0LVyayXoDu
         jpP1c5gQyIdJ9b27BWKBUE02hv0pi3tuU5JIhEn9xQCVfmdZ2709x6Dpe4vKa0knNKWD
         gZuQ==
X-Gm-Message-State: APjAAAWbV56UVL5Zt+3cR4hKkU7O3VjPAejne0IGfSudfU/SNPkqVsJA
        C5R9pynSQBPgr5AJXmn3FL0=
X-Google-Smtp-Source: APXvYqy0P4cqsUMvftxDBVuas8Dp+ClkO4SsPUfTJL/4MFp1vE+buRZg0cjGAn9tQ4LoSuAzufr53A==
X-Received: by 2002:a5d:4d4f:: with SMTP id a15mr624218wru.267.1568761348067;
        Tue, 17 Sep 2019 16:02:28 -0700 (PDT)
Received: from szeder.dev (x4db91871.dyn.telefonica.de. [77.185.24.113])
        by smtp.gmail.com with ESMTPSA id y186sm530719wmb.41.2019.09.17.16.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 16:02:27 -0700 (PDT)
Date:   Wed, 18 Sep 2019 01:02:24 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [RFC PATCH] merge-recursive: symlink's descendants not in way
Message-ID: <20190917230224.GB29845@szeder.dev>
References: <CABPp-BHpXWF+1hKUTfn8s-y4MJZXz+jUVS_K10eKyD6PGwo=gg@mail.gmail.com>
 <20190917215040.132503-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190917215040.132503-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 17, 2019 at 02:50:40PM -0700, Jonathan Tan wrote:
> diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
> index ff641b348a..dfd617a845 100755
> --- a/t/t3030-merge-recursive.sh
> +++ b/t/t3030-merge-recursive.sh
> @@ -452,6 +452,33 @@ test_expect_success 'merge-recursive d/f conflict result' '
>  
>  '
>  
> +test_expect_success 'dir in working tree with symlink ancestor does not produce d/f conflict' '

This test needs the SYMLINKS prereq.

> +	git init sym &&
> +	(
> +		cd sym &&
> +		ln -s . foo &&
> +		mkdir bar &&
> +		touch bar/file &&

Nit: >bar/file (though because of the symlink this test won't be run
on the most fork()-challenged platform).

> +		git add foo bar/file &&
> +		git commit -m "foo symlink" &&
> +
> +		git checkout -b branch1 &&
> +		git commit --allow-empty -m "empty commit" &&
> +
> +		git checkout master &&
> +		git rm foo &&
> +		mkdir foo &&
> +		touch foo/bar &&
> +		git add foo/bar &&
> +		git commit -m "replace foo symlink with real foo dir and foo/bar file" &&
> +
> +		git checkout branch1 &&
> +
> +		# Exercise to make sure that this works without errors
> +		git cherry-pick master

Working without errors is great, but I think this test should also
check that the results are as expected, e.g. 'foo' is now a directory,
etc.

> +	)
> +'
> +
>  test_expect_success 'reset and 3-way merge' '
>  
>  	git reset --hard "$c2" &&
> -- 
> 2.23.0.237.gc6a4ce50a0-goog
> 
