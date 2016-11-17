Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BA601FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 21:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbcKQVre (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 16:47:34 -0500
Received: from mout.gmx.net ([212.227.15.19]:50082 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751584AbcKQVrd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 16:47:33 -0500
Received: from [192.168.178.43] ([88.71.246.160]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHH6Z-1c2ngX2iu3-00E4YY; Thu, 17
 Nov 2016 22:47:30 +0100
Subject: Re: [PATCH v15 22/27] bisect--helper: `bisect_log` shell function in
 C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1b18-b81203b0-122f-4244-bfb2-9fac8ae71767-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <c49a6151-0827-cae5-0569-8f05515be0f9@gmx.net>
Date:   Thu, 17 Nov 2016 22:47:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1b18-b81203b0-122f-4244-bfb2-9fac8ae71767-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:KXJIdqF1eM/mIdINe5HrqxGjD7/o4SP2S9UJovUXy1uLUg1SVoN
 cmwWjkWG6cl11B0ZYzwP1ouLti7WKEsA2kfgV/iloechNyTd0dqQjICNqh8TNe64ZBrKeFO
 wfOTPX411tbG7g7Z4erdbK3vQZpmAfyws44p+o/71DXNKL+gyGbAJ98ePEH8+Coi29Ok4MT
 Tcqzsazc4i95AcOVylT+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+ZN5cYwPIMM=:AZVNMhQ9E/MjC2E+swaxV4
 97cmDtYdF0Xat1/VHbU4brsCwZ4eSihATEq2ZMnlJT2SNha3fvEncj5SwQyxcQvRotfOoSTwf
 CCKt7cEfNcTFxm6A/YFtkOQV2fhZJ0rlDKizrUTPzSK4aWYc+ZtFHW2eN2gIdh8Z79FYCCIXN
 8yDKxWJELVIHF95y7bI+L7wjCJ+wng+9ZrBGZjA+X9PJgObYgdClU6+Q81kk7olMQwEdIvQFq
 ASLHjyovXXxo4WSaHpGtouVgHg5fg1VJyRAphuz7uw1aQU/rNF5jq1nZxdwYQFvKH3bUncHHt
 zTxBCiascLPn2ugKR8MpXHItrhkdRWtvgUWlfA9yVHKDFSV8NPa5RaTKBUbhAQvQ8RwnU7NFS
 /e3JuUJnZJH8ecUP+VZcXoneUoFd6/cdG4P4hlsG+kKSgpwuoSulnz7JsxvAFwEwYAcvGU+D2
 IUsl+8EUM6BpSP8aiBPV9Z8GfrVvOXKr7VGN3Uls48Pi6Lk61wEgzOzqQg2LQ1rxlnkO22+nK
 J92tw4EkkT38NUiKaXOvVQpI8gC5p9cAppBENnheJBRvkPA6Q0g1yc0h+PvmpmOUVjVqc9Th5
 aCUG2iY30o3N3PYWvh/sxtc0Z68TWDQDEAGfluhZOQg4PX79evJNVIRnmfOo0UHp7x7NKq2f/
 j8sT5K9r+rcY3y8+OO6/w775m+iCr8U5nC7UgZRXTtrVN9Yf++gx8KZXoTIZMx2YH7JkjG6SP
 qZy91deZr6NWbAI+p4YUBn41pfY+Je1rwhwh1vIxQs5FdKu4EEk1pfyaqasdKs/bj3FAaVCd9
 70argX/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 493034c..c18ca07 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -858,6 +858,23 @@ static int bisect_state(struct bisect_terms *terms, const char **argv,
>  	return -1;
>  }
>  
> +static int bisect_log(void)
> +{
> +	int fd, status;
> +	fd = open(git_path_bisect_log(), O_RDONLY);
> +	if (fd < 0)
> +		return -1;
> +
> +	status = copy_fd(fd, 1);

Perhaps

	status = copy_fd(fd, STDOUT_FILENO);

> +	if (status) {
> +		close(fd);
> +		return -1;
> +	}
> +
> +	close(fd);
> +	return status;
> +}

That's weird.
Either get rid of the if() and actually use status:

	status = copy_fd(fd, STDOUT_FILENO);

	close(fd);
	return status ? -1 : 0;

or get rid of status and use the if:

	if (copy_fd(fd, STDOUT_FILENO)) {
		close(fd);
		return -1;
	}

	close(fd);
	return 0;

I'd recommend the shorter variant ;)

~Stephan
