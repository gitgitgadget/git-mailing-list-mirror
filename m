Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB74211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 11:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfANLRd (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 06:17:33 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:45790 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfANLRc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 06:17:32 -0500
Received: from [192.168.2.201] ([92.28.143.98])
        by smtp.talktalk.net with SMTP
        id j0FGgjNQSwhzSj0FHgRn8I; Mon, 14 Jan 2019 11:17:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1547464651;
        bh=zjRHN1lV6wc5/tR1qaXycygMAHpX8cFxqnZ9HurbTcY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VItqLj4ZUuAnDHTTrRrnATzRetNB8cXDDAN4daf+ZnIv7B86Rj+1BzuOqiXsKiwrV
         aS9C3fJidz/CIHlgEzCxfj4onaJaVrAHU1Gp7qNom0OEqwzi2+89jO8J0Eob0AgwXE
         ZMBqNWPbbBY9YWZdb7Zd14x9lY+BBHSAnb/fMk70=
X-Originating-IP: [92.28.143.98]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=j7EZ+OPOvdswaUU3zPu4lA==:117
 a=j7EZ+OPOvdswaUU3zPu4lA==:17 a=IkcTkHD0fZMA:10 a=69EAbJreAAAA:8
 a=1sCsXwKYC2YAI3qntNQA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/7] add--interactive.perl: use add--helper --show-help
 for help_cmd
To:     Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
 <060806010e77ee81c251d88629c16ae001247a70.1545307756.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <e8e7ee69-67d2-dc96-722a-8b16aa3f26ec@talktalk.net>
Date:   Mon, 14 Jan 2019 11:17:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <060806010e77ee81c251d88629c16ae001247a70.1545307756.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfE2NGA6mYlCDPSVvjv2o63AE3Pie+8uhF1ulLTBNtfNj87Wmf2CEzlPUSEmArul54oNgv/HqL6JuHl9pwmJwM6aVCnsBbqCut+zTpHztwjMrPKzmoMkt
 EOpNQjstXt44YC6cSx+PNt727vthKCRlrUy010j3styuQY8NwqAvsFusSnqRoJWZl/WrtYdodxriJO9fPWvFUxf3Ec9tifRZHADsVCk8DtJYPhHhq3eDMmeb
 Ul9nRClMvifF4UyHHReexOruPrAUsC2qk9rhrSUBsVQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Slavica

On 20/12/2018 12:09, Slavica Djukic via GitGitGadget wrote:
> From: Slavica Djukic <slawica92@hotmail.com>
> 
> Change help_cmd sub in git-add--interactive.perl to use
> show-help command from builtin add--helper.
> 
> Add test to t3701-add-interactive to verify that show-help
> outputs expected content. Use GIT_PRETENT_TTY
> introduced in earlier commit to be able to test output color
> on Windows.
> 

It's great to see you adding a test for this, if it isn't too much work
perhaps you could add it before changing the implementation to
demonstrate that there are no changes introduced by the conversion to C.

Best Wishes

Phillip

> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
> ---
>  git-add--interactive.perl  | 11 +----------
>  t/t3701-add-interactive.sh | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index a6536f9cf3..32ee729a58 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1717,16 +1717,7 @@ sub quit_cmd {
>  }
>  
>  sub help_cmd {
> -# TRANSLATORS: please do not translate the command names
> -# 'status', 'update', 'revert', etc.
> -	print colored $help_color, __ <<'EOF' ;
> -status        - show paths with changes
> -update        - add working tree state to the staged set of changes
> -revert        - revert staged set of changes back to the HEAD version
> -patch         - pick hunks and update selectively
> -diff          - view diff between HEAD and index
> -add untracked - add contents of untracked files to the staged set of changes
> -EOF
> +	system(qw(git add--helper --show-help));
>  }
>  
>  sub process_args {
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 65dfbc033a..9c9d5bd935 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -639,4 +639,29 @@ test_expect_success 'add -p patch editing works with pathological context lines'
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
> +	<BOLD;BLUE>What now<RESET>> 
> +	<BOLD;RED>status        - show paths with changes
> +	update        - add working tree state to the staged set of changes
> +	revert        - revert staged set of changes back to the HEAD version
> +	patch         - pick hunks and update selectively
> +	diff          - view diff between HEAD and index
> +	add untracked - add contents of untracked files to the staged set of changes<RESET>
> +	<BOLD>*** Commands ***<RESET>
> +	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
> +	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
> +	<BOLD;BLUE>What now<RESET>> 
> +	Bye.
> +	EOF
> +	test_write_lines h | GIT_TEST_PRETEND_TTY=1 git add -i >actual.colored &&
> +	test_decode_color <actual.colored >actual &&
> +	test_i18ncmp expect actual
> +'
> +
>  test_done
> 

