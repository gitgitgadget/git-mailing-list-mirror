Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55A5C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 22:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiE0WEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 18:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiE0WEd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 18:04:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995243BA55
        for <git@vger.kernel.org>; Fri, 27 May 2022 15:04:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gk22so5741482pjb.1
        for <git@vger.kernel.org>; Fri, 27 May 2022 15:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PoBWl8Y1q0nMNQgaZE54Ifz7PIjCa3zsWUh+SgoFE+o=;
        b=b6Ku3VSWrRWKyfnzzs1Peup2IvsV/Qb2YPRnJBhreBNutMLVZ35axTZAz7GSCWxRyZ
         hIWov1lqug1nzI7P0ZBJWmfk3w3CyApGRK3xZsfmdn+h6Xcis9bQrION8QuBjzx3jRcZ
         sxBvnU+p1GXiqkBGaKzNo17HZXhGVa2DtpBQcnczAvn+Sr5kVl2R+/T2Zn0oL6H60f4G
         z6LKXsOTEKoYyJ/S3z/X89CAuJyynvPc4GyVdI+Z2yp76jSpAdICd+itJrtVzMRyS9uC
         B+m20Zv46hgom20aCqm5C8jYYzMgvZJpr0OnpyrslNNbbF9CuqkFhaGD/ZIQce3wQSRg
         yUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PoBWl8Y1q0nMNQgaZE54Ifz7PIjCa3zsWUh+SgoFE+o=;
        b=ZsnFaSWB0ZcniK3qAx/8v48AFNPixjm6pp27DwyPzZFF8N56hnGkFkQzE1fQi85wuC
         IaZmwSoiVhV+CCj+pDeVQnx+0UiFQcosx+6NNzivD8o6+Xb+fmNcvpgZBHz4D65NHm07
         3SAwNyO6CbEU5u4H2T1KWxQ3dC77hpkRhfWhpH9vR/9y1xe2ofzP/QUq4J4WCLp+U/dG
         6twEPhZ0FtIVJb2OERCrWvaDS7cZ8KNeJpxHmX5LTQk0XAcfr4ITatg+bxIMY6vMBf5q
         d6CitIc+WLozlGznHFGLAAm6kJh7pwpr4nuxPK+pVDTAv47yYLQRnQBLvnkKs2GiDMb6
         7RFw==
X-Gm-Message-State: AOAM531Nd9S0pKSnydPc0qmLLBi4JtjAEs3MaHpGTXZurNlD9qr7Dya5
        OYpqWB//7tjIKYSqRjGelo85aChsFnrm
X-Google-Smtp-Source: ABdhPJw9Uk7QPyBH0Aec+v8r6oxQlCPeN0aoa/tLk/1z0vTN3H99eM16jr8+QYrirrHFS94WgAh+kg==
X-Received: by 2002:a17:902:d48a:b0:163:8365:b69f with SMTP id c10-20020a170902d48a00b001638365b69fmr8545038plg.50.1653689070133;
        Fri, 27 May 2022 15:04:30 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a030d00b001df8ddd97ebsm2074990pje.55.2022.05.27.15.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 15:04:29 -0700 (PDT)
Message-ID: <418e50c8-afec-3b51-53c0-bb84e37af6f2@github.com>
Date:   Fri, 27 May 2022 15:04:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [WIP v2 3/5] mv: check if <destination> exists in index to handle
 overwriting
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com, newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-4-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220527100804.209890-4-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Originally, moving a sparse file into cone can result in unwarned
> overwrite of existing entry. The expected behavior is that if the
> <destination> exists in the entry, user should be prompted to supply
> a [-f|--force] to carry out the operation, or the operation should
> fail.
> 
> Add a check mechanism to do that.
> 
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/mv.c                  | 23 +++++++++++------------
>  t/t7002-mv-sparse-checkout.sh |  2 +-
>  2 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 32ad4d5682..62284e3f86 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -185,16 +185,6 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  
>  		length = strlen(src);
>  		if (lstat(src, &st) < 0) {
> -			/*
> -			 * TODO: for now, when you try to overwrite a <destination>
> -			 * with your <source> as a sparse file, if you supply a "--sparse"
> -			 * flag, then the action will be done without providing "--force"
> -			 * and no warning.
> -			 *
> -			 * This is mainly because the sparse <source>
> -			 * is not on-disk, and this if-else chain will be cut off early in
> -			 * this check, thus the "--force" check is ignored. Need fix.
> -			 */
>  

Given that this removes the "TODO" comment you just added in the previous
patch, I agree with Stolee's suggestion [1] that you mention this context in
the patch 2 commit message rather than a code comment. The commit message of
*this* patch already explains the behavior you're correcting, so I don't
think any other changes would be needed here.

[1] https://lore.kernel.org/git/0884b97b-0745-5cad-3034-a679be5d6c3a@github.com/

>  			int pos = cache_name_pos(src, length);
>  			if (pos >= 0) {
> @@ -203,8 +193,17 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  				if (ce_skip_worktree(ce)) {
>  					if (!ignore_sparse)
>  						string_list_append(&only_match_skip_worktree, src);
> -					else
> -						modes[i] = SPARSE;
> +					else {
> +						/* Check if dst exists in index */
> +						if (cache_name_pos(dst, strlen(dst)) >= 0) {
> +							if (force)
> +								modes[i] = SPARSE;
> +							else
> +								bad = _("destination exists");
> +						}
> +						else
> +							modes[i] = SPARSE;
> +					}
>  				}
>  				else
>  					bad = _("bad source");
> diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
> index 581ef4c0f6..2c9008573a 100755
> --- a/t/t7002-mv-sparse-checkout.sh
> +++ b/t/t7002-mv-sparse-checkout.sh
> @@ -272,7 +272,7 @@ test_expect_success 'can move out-of-cone file with --sparse' '
>  	test_path_is_file sub/file1
>  '
>  
> -test_expect_failure 'refuse to move sparse file to existing destination' '
> +test_expect_success 'refuse to move sparse file to existing destination' '
>  	git sparse-checkout disable &&
>  	git reset --hard &&
>  	mkdir folder1 &&

The rest of this looks good to me!
