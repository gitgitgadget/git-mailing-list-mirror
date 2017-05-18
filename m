Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4004201A7
	for <e@80x24.org>; Thu, 18 May 2017 02:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbdERCqj (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 22:46:39 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36304 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752823AbdERCqj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 22:46:39 -0400
Received: by mail-pg0-f68.google.com with SMTP id h64so4078018pge.3
        for <git@vger.kernel.org>; Wed, 17 May 2017 19:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FcCjsqCp+TkkL2RZPP0hnQXHkaY9pm16nV2sMaZ2ztg=;
        b=cyCuQjFxHrwAOx3hfo1TfrS7Mum6Oi3AOnNUPtbGPjGsCyilIpZVXC0jBGnzCByyC8
         F1g43QICi0Vg/hv2VTkfz7k13R8kJJleQv9MQaIcJB87yyhq4IHpeT8Ha7H9Fsyt0xjQ
         a/a3w1GpGdJ6T4QPHMVGGHJPDdcM4dfQgshOKy0/fQuohUB79AmH0fhJ7992LBwWlp3p
         PrpibjWR1r+LPoeHkFY83cjEdKSIu7CIpU6tIqYKRmOb3wY5xNeLEyA4kEsxrCQJKnZ8
         E2+KzH5l96cf0/JsmF3Y1qYY4BLlh2nNj0IrJ3lABpAVGM9IHKspexpDamKlrApiIKoY
         MclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FcCjsqCp+TkkL2RZPP0hnQXHkaY9pm16nV2sMaZ2ztg=;
        b=P450JsqmGB+w/nqLEaIhNtqBqRPp6BQobM5kvydrG4iWsEEY4QF5NWAnNLEoqJ6W5c
         xFFl0tHuvMtISAdk6e3vi1rvqS1A+KANnPOyZA2IAfFdkQiFwxCnvcmTtzFh6loTCciS
         n+YXCBjCT/TWXKhI16EwWTfpAV/bYrCxEwrRHnh+HCsbrJfmWTMQl9ch1Xt9UdMSM3RI
         O8ZridnAko26xf6KFiJjl+T4ltw/1/yaiMDe7A8FYGAtcK85+ugW+X695qpqTeqGZ7Fh
         AaMOjpBqy3enGWX6BbdBV+ToGRJwJKmzBYYWfRJ146mRXEzgysmuzJn7eG+DQRT+QVh8
         Qo+A==
X-Gm-Message-State: AODbwcAlaCwfrkSp2coNn7AbUqPJJD69e9VgcPzARmWd5sZeINY678zR
        yNLbQZjMZXKtuA==
X-Received: by 10.84.217.206 with SMTP id d14mr2119518plj.140.1495075598258;
        Wed, 17 May 2017 19:46:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f155:f4fa:305b:79e3])
        by smtp.gmail.com with ESMTPSA id t5sm5984131pgt.19.2017.05.17.19.46.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 19:46:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 8/8] t7061: status --ignored now searches untracked dirs
References: <20170516073423.25762-1-sxlijin@gmail.com>
        <20170505104611.17845-1-sxlijin@gmail.com>
        <20170516073423.25762-9-sxlijin@gmail.com>
Date:   Thu, 18 May 2017 11:46:36 +0900
In-Reply-To: <20170516073423.25762-9-sxlijin@gmail.com> (Samuel Lijin's
        message of "Tue, 16 May 2017 03:34:23 -0400")
Message-ID: <xmqqshk2vq43.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
> ---

This was fixed at "hide untracked" patch, so squash these changes in
to that commit and add something like

    This fixes known breakages in t7061 documented earlier in the series.

at the end of the log message of that one.  The same for 7/8, which
was fixed in "teach clean -d to skip dirs" patch.

Thanks.


>  t/t7061-wtstatus-ignore.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
> index 15e7592b6..fc6013ba3 100755
> --- a/t/t7061-wtstatus-ignore.sh
> +++ b/t/t7061-wtstatus-ignore.sh
> @@ -12,7 +12,7 @@ cat >expected <<\EOF
>  !! untracked/ignored
>  EOF
>  
> -test_expect_failure 'status untracked directory with --ignored' '
> +test_expect_success 'status untracked directory with --ignored' '
>  	echo "ignored" >.gitignore &&
>  	mkdir untracked &&
>  	: >untracked/ignored &&
> @@ -21,7 +21,7 @@ test_expect_failure 'status untracked directory with --ignored' '
>  	test_cmp expected actual
>  '
>  
> -test_expect_failure 'same with gitignore starting with BOM' '
> +test_expect_success 'same with gitignore starting with BOM' '
>  	printf "\357\273\277ignored\n" >.gitignore &&
>  	mkdir -p untracked &&
>  	: >untracked/ignored &&
