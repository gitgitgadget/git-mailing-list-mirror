Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E76211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 11:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfANLNn (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 06:13:43 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:38884 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfANLNn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 06:13:43 -0500
Received: from [192.168.2.201] ([92.28.143.98])
        by smtp.talktalk.net with SMTP
        id j0BYgjMn0whzSj0BZgRn09; Mon, 14 Jan 2019 11:13:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1547464421;
        bh=OXqLQ5qoruoClfiRWumk4eVcmttHDb6yymHgzY0/zxc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=leV6qETA+gt7OV4JdYuZf21QSmRU4ywA9XQyataHfIiEyt+vJjZwq85ulmIJpRmYY
         BIP1omLQLDyj3cx+q6nZhTOyo1OMcGYq/60a09rMhxs55jwPtcDOF4DjCMrInP77dM
         M14snSzYr+gloJZ8/o9bJ2AnzJY2gKYkvXSPoQeU=
X-Originating-IP: [92.28.143.98]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=j7EZ+OPOvdswaUU3zPu4lA==:117
 a=j7EZ+OPOvdswaUU3zPu4lA==:17 a=IkcTkHD0fZMA:10 a=69EAbJreAAAA:8
 a=31m7A7WAi3OkZtQMsHkA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/7] Git.pm: introduce environment variable
 GIT_TEST_PRETEND_TTY
To:     Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
 <86d85face8ba543fb4a03adbc42dc930ee318f74.1545307756.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <fd6bab55-871c-4f4d-84e9-98bfe5d54f23@talktalk.net>
Date:   Mon, 14 Jan 2019 11:13:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <86d85face8ba543fb4a03adbc42dc930ee318f74.1545307756.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEh8W8j+ZA1KjDKENQQz/50HBVTuOCMwvDvSnAndpgyU8mQxU1bg8r8q2Cr6xbv/QKZcjN3V1gQFpFdMTYVF3tgOaJCQrillkmazBH3vl/vachm7gH00
 pkETBG3LQyxR7Ve3aOW0Z5Bag9LiPp5yJ5e7aaDUxz2J4TD1hJFLzUZe111OFNGo8CIfS9iHGWoZaf5Wwzs7A/dBCOgte7CA8lMg2VpF2albNhL+Jr3jwU1G
 MWkRHOptH3YBg5rNsI5L3AYevbStyA6rd/YRy7YaZuY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Salvica/Johannes

On 20/12/2018 12:09, Slavica Djukic via GitGitGadget wrote:
> From: Slavica Djukic <slawica92@hotmail.com>
> 
> To enable testing the colored output on Windows, enable TTY
> by using environment variable GIT_TEST_PRETEND_TTY.
> 
> This is the original idea by Johannes Schindelin.

I normally use GIT_PAGER_IN_USE=1 to force colored output, is there some
reason that does not work here?

Best Wishes

Phillip

> 
> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
> ---
>  color.c     | 4 ++++
>  perl/Git.pm | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/color.c b/color.c
> index ebb222ec33..4aa6cc3442 100644
> --- a/color.c
> +++ b/color.c
> @@ -323,6 +323,10 @@ static int check_auto_color(int fd)
>  {
>  	static int color_stderr_is_tty = -1;
>  	int *is_tty_p = fd == 1 ? &color_stdout_is_tty : &color_stderr_is_tty;
> +	
> +	if (git_env_bool("GIT_TEST_PRETEND_TTY", 0))
> +		return 1;
> +
>  	if (*is_tty_p < 0)
>  		*is_tty_p = isatty(fd);
>  	if (*is_tty_p || (fd == 1 && pager_in_use() && pager_use_color)) {
> diff --git a/perl/Git.pm b/perl/Git.pm
> index d856930b2e..51a1ce0617 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -757,7 +757,7 @@ and returns boolean (true for "use color", false for "do not use color").
>  
>  sub get_colorbool {
>  	my ($self, $var) = @_;
> -	my $stdout_to_tty = (-t STDOUT) ? "true" : "false";
> +	my $stdout_to_tty = $ENV{GIT_TEST_PRETEND_TTY} || (-t STDOUT) ? "true" : "false";
>  	my $use_color = $self->command_oneline('config', '--get-colorbool',
>  					       $var, $stdout_to_tty);
>  	return ($use_color eq 'true');
> 

