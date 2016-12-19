Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D723F1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 13:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755354AbcLSNnw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 08:43:52 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:51635 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755228AbcLSNnv (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 08:43:51 -0500
X-AuditID: 1207440c-e53ff700000009a1-65-5857e411692c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 5D.1B.02465.114E7585; Mon, 19 Dec 2016 08:43:45 -0500 (EST)
Received: from [192.168.69.190] (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJDhhij001463
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 08:43:44 -0500
Subject: Re: [PATCH 5/5] check-ref-format: New --stdin option
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>, git@vger.kernel.org
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
 <20161104191358.28812-6-ijackson@chiark.greenend.org.uk>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <14d95a74-ad7e-a1dd-c3da-52afd53cede4@alum.mit.edu>
Date:   Mon, 19 Dec 2016 14:43:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161104191358.28812-6-ijackson@chiark.greenend.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqCv0JDzC4MoxRouuK91MFqtbFrE4
        MHl8O7WJ2ePzJrkApigum5TUnMyy1CJ9uwSujN+3ljAXLBGqmHZyCmsD43y+LkZODgkBE4kb
        X7cwdjFycQgJXGaUeP9mPyuEc4FJ4vusWYwgVcICthKNq5eygNgiAm4SZz81MoHYQgL1Em9e
        gjRwcrAJ6Eos6mkGinNw8ArYS+zvdgIJswioSuye9ResRFQgROLynKNsIDavgKDEyZlPwEZy
        CrhKfLnYzwxiMwvoSey4/osVwpaX2P52DvMERr5ZSFpmISmbhaRsASPzKka5xJzSXN3cxMyc
        4tRk3eLkxLy81CJdQ73czBK91JTSTYyQsOPZwfhtncwhRgEORiUeXsm3YRFCrIllxZW5hxgl
        OZiURHmnrA2JEOJLyk+pzEgszogvKs1JLT7EKMHBrCTCu/FeeIQQb0piZVVqUT5MSpqDRUmc
        V3WJup+QQHpiSWp2ampBahFMVoaDQ0mCt/8RUKNgUWp6akVaZk4JQpqJgxNkOA/QcIvHIMOL
        CxJzizPTIfKnGBWlxHmVQBICIImM0jy4XlhaeMUoDvSKMK8aSBUPMKXAdb8CGswENHhhN9jg
        kkSElFQDY3qf4QP+F/GSZ75/qdmVHGUu422T6L/qqsWv0Euffr/+lrOFJbsycNMqnYdSWbML
        8nkt/vGK28zL4vO7IemT32ga9XH3zIIabnsFtsxgR51T8/hWedyUefxi91qBft3+ZPl3qTIu
        bU0HwoX6Pi64s2iqkveCVhYLldLfn+9K3q+2drLk9P+txFKckWioxVxUnAgAsg2WneYCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/04/2016 08:13 PM, Ian Jackson wrote:
> Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
> ---
>  Documentation/git-check-ref-format.txt | 10 ++++++++--
>  builtin/check-ref-format.c             | 34 +++++++++++++++++++++++++++++++---
>  2 files changed, 39 insertions(+), 5 deletions(-)
> 
> [...]
> diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
> index 559d5c2..87f52fa 100644
> --- a/builtin/check-ref-format.c
> +++ b/builtin/check-ref-format.c
> @@ -76,6 +76,7 @@ static int check_one_ref_format(const char *refname)
>  int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
> +	int use_stdin = 0;
>  
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage(builtin_check_ref_format_usage);
> @@ -93,6 +94,8 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
>  			check_branch = 1;
>  		else if (!strcmp(argv[i], "--report-errors"))
>  			report_errors = 1;
> +		else if (!strcmp(argv[i], "--stdin"))
> +			use_stdin = 1;
>  		else
>  			usage(builtin_check_ref_format_usage);
>  	}
> @@ -100,8 +103,33 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
>  	if (check_branch && (flags || normalize))
>  		usage(builtin_check_ref_format_usage);
>  
> -	if (! (i == argc - 1))
> -		usage(builtin_check_ref_format_usage);
> +	if (!use_stdin) {
> +		if (! (i == argc - 1))
> +			usage(builtin_check_ref_format_usage);
> +
> +		return check_one_ref_format(argv[i]);
> +	} else {
> +		char buffer[2048];
> +		int worst = 0;
>  
> -	return check_one_ref_format(argv[i]);
> +		if (! (i == argc))
> +			usage(builtin_check_ref_format_usage);
> +
> +		while (fgets(buffer, sizeof(buffer), stdin)) {
> +			char *newline = strchr(buffer, '\n');
> +			if (!newline) {
> +				fprintf(stderr, "%s --stdin: missing final newline or line too long\n", *argv);
> +				exit(127);
> +			}
> +			*newline = 0;
> +			int got = check_one_ref_format(buffer);

Another minor point: project policy is not to mix declarations and code.
Please declare `got` at the top of the block.

> +			if (got > worst)
> +				worst = got;
> +		}
> +		if (!feof(stdin)) {
> +			perror("reading from stdin");
> +			exit(127);
> +		}
> +		return worst;
> +	}
>  }
> 

Michael

