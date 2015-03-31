From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH/RFC 2/4] t1505: add tests for '-' notation in rev-parse
Date: Tue, 31 Mar 2015 06:55:54 +0200
Message-ID: <551A28DA.2050402@web.de>
References: <1427737315-7229-1-git-send-email-kenny.lee28@gmail.com> <1427737315-7229-3-git-send-email-kenny.lee28@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 06:57:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcoFF-0000eq-4V
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 06:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbbCaE4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 00:56:23 -0400
Received: from mout.web.de ([212.227.17.11]:53853 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbbCaE4W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 00:56:22 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M6V1T-1ZMwrD2Ntz-00yNnE; Tue, 31 Mar 2015 06:56:16
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <1427737315-7229-3-git-send-email-kenny.lee28@gmail.com>
X-Provags-ID: V03:K0:wDUam9sJE8O36bbR2PlByp2KIRObXpBhX4wmc8LQ0X745WhnDa8
 bcdkdYEF4DhvRACL5IZUdG9VjrtlMZc99XEz4kGSYrWSesR2ycxG8t5ZFyQatbq8tus68IE
 DfBy3nrZRJn+dGChVfw+DGuTCr/G5hKqnlxBqo/kR0DPsWutc4AZvE0FpUKwdDVJc2gG7ka
 APgSncrqbLqAh8KqztmiA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266512>

On 03/30/2015 07:41 PM, Kenny Lee Sin Cheong wrote:
> Signed-off-by: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
> ---
>   t/t1505-rev-parse-last.sh | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/t/t1505-rev-parse-last.sh b/t/t1505-rev-parse-last.sh
> index 4969edb..a1976ad 100755
> --- a/t/t1505-rev-parse-last.sh
> +++ b/t/t1505-rev-parse-last.sh
> @@ -33,19 +33,23 @@ test_expect_success 'setup' '
>   # and 'side' should be the last branch
>   
>   test_expect_success '@{-1} works' '
> -	test_cmp_rev side @{-1}
> +	test_cmp_rev side @{-1} &&
> +	test_cmp_rev side -
>   '
(Beside that "-" is often used for "stdin" in many unix-like tools,
and my favorite would be "-1" ):

I think the test heading should be updated as well:

test_expect_success '@{-1} or - works' '
	test_cmp_rev side @{-1} &&
	test_cmp_rev side -
  '


>   
>   test_expect_success '@{-1}~2 works' '
> -	test_cmp_rev side~2 @{-1}~2
> +	test_cmp_rev side~2 @{-1}~2 &&
> +	test_cmp_rev side~2 -~2
>   '
>   
>   test_expect_success '@{-1}^2 works' '
> -	test_cmp_rev side^2 @{-1}^2
> +	test_cmp_rev side^2 @{-1}^2 &&
> +	test_cmp_rev side^2 -^2
>   '
>   
>   test_expect_success '@{-1}@{1} works' '
> -	test_cmp_rev side@{1} @{-1}@{1}
> +	test_cmp_rev side@{1} @{-1}@{1} &&
> +	test_cmp_rev side@{1} -@{1}
>   '
>   
>   test_expect_success '@{-2} works' '
