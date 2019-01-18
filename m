Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FA8E1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 11:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfARLXO (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 06:23:14 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:54386 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfARLXO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 06:23:14 -0500
Received: from [192.168.2.201] ([89.242.180.111])
        by smtp.talktalk.net with SMTP
        id kSExg2csl5piAkSEygCJmP; Fri, 18 Jan 2019 11:23:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1547810592;
        bh=J+ICyb+b0jE67H4Criglg6wJ6iK4YN5ZVwRocHYHC+A=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iyLNx9KTDbEIng/MBiQdHeDs2gYQOka3FTyNjKeJbMj0kIMXV7PBp8QVd8Eu+fsVr
         qB7yNWIStcJkS3ulQ02iHSZgXv7knzm2qEbbyFvHQZwaNQI17Rf6Ic4O2Lw/byz4Ai
         f1Kt7Wgaox5JKus/0lTCx2xgguEseEJvGCJxXYfg=
X-Originating-IP: [89.242.180.111]
X-Spam: 0
X-OAuthority: v=2.3 cv=ROWd4bq+ c=1 sm=1 tr=0 a=yUcx3x9LIBXmIswB4ICbEw==:117
 a=yUcx3x9LIBXmIswB4ICbEw==:17 a=IkcTkHD0fZMA:10 a=69EAbJreAAAA:8
 a=SM-u77BZcpZjpLqoWoAA:9 a=QEXdDO2ut3YA:10 a=hC3hSVyoFnMA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 6/7] t3701-add-interactive: test add_i_show_help()
To:     Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
 <pull.103.v2.git.gitgitgadget@gmail.com>
 <2b4714b8d04f98a6d35f3f4f15881406fa87c320.1547797620.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <78b5a684-0963-0ca0-78fa-87bc4b18b3a6@talktalk.net>
Date:   Fri, 18 Jan 2019 11:23:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2b4714b8d04f98a6d35f3f4f15881406fa87c320.1547797620.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLFy0l9hvs6bxK4wTO9YIYXSkPEA9o9sMcwmuFH10zIlUETjnDIIFix8YKNUQri8VPerZT2OS4HUFwMSo8Z8O0u6Odmeex1LHRHZLlFkVkOIDz18AGZK
 Uu7SHKyk89X0+h3J9a1rT/hMif4zzYzrhtww/XlgxsC6Gs5uxlHoVMK9oGLlSupDoDCGXmBnu8MLRVMBqY0IswiB6C1xuqQYuAmZ6NW+TQ3Cy2a4iGNyKpWS
 fUbuaAyNkgnvx+UGxjTpvpmbZwmZjLWRdwJQ2RTLCvw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Slavica

Thanks for moving this up, it's really good to add the test before the
conversion to C.

Best Wishes

Phillip

On 18/01/2019 07:47, Slavica Djukic via GitGitGadget wrote:
> From: Slavica Djukic <slawica92@hotmail.com>
> 
> Add test to t3701-add-interactive to verify that add_i_show_help()
> outputs expected content.
> Also, add it before changing git-add--interactive.perl's help_cmd
> to demonstrate that there are no changes introduced by the
> conversion to C.
> Prefix git add -i call with GIT_PAGER_IN_USE=true TERM=vt100
> to force colored output on Windows.
> 
> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
> ---
>  t/t3701-add-interactive.sh | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 65dfbc033a..14e3286995 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -639,4 +639,28 @@ test_expect_success 'add -p patch editing works with pathological context lines'
>  	test_cmp expected-2 actual
>  '
>  
> +test_expect_success 'show help from add--helper' '
> +	git reset --hard &&
> +	cat >expect <<-\EOF &&
> +
> +	<BOLD>*** Commands ***<RESET>
> +	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
> +	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
> +	<BOLD;BLUE>What now<RESET>> <BOLD;RED>status        - show paths with changes<RESET>
> +	<BOLD;RED>update        - add working tree state to the staged set of changes<RESET>
> +	<BOLD;RED>revert        - revert staged set of changes back to the HEAD version<RESET>
> +	<BOLD;RED>patch         - pick hunks and update selectively<RESET>
> +	<BOLD;RED>diff          - view diff between HEAD and index<RESET>
> +	<BOLD;RED>add untracked - add contents of untracked files to the staged set of changes<RESET>
> +	<BOLD>*** Commands ***<RESET>
> +	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
> +	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
> +	<BOLD;BLUE>What now<RESET>> 
> +	Bye.
> +	EOF
> +	test_write_lines h | GIT_PAGER_IN_USE=true TERM=vt100 git add -i >actual.colored &&
> +	test_decode_color <actual.colored >actual &&
> +	test_i18ncmp expect actual
> +'
> +
>  test_done
> 

