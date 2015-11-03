From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/2] Limit the size of the data block passed to SHA1_Update()
Date: Tue, 03 Nov 2015 12:51:24 +0100
Message-ID: <56389FBC.7050909@web.de>
References: <xmqqpozsdrnl.fsf@gitster.mtv.corp.google.com> <1446533930-463-1-git-send-email-apahlevan@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: atousa.p@gmail.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 03 12:52:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zta8J-0006CZ-UF
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 12:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbbKCLwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 06:52:05 -0500
Received: from mout.web.de ([212.227.15.3]:51889 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbbKCLwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 06:52:03 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MCIoz-1Zl5gS2hAP-009C4K; Tue, 03 Nov 2015 12:51:49
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1446533930-463-1-git-send-email-apahlevan@ieee.org>
X-Provags-ID: V03:K0:G06d0kDue8GJT5w+z43BzEc81k9492Us3GBKRFJOeIwgpWtV4Kk
 VddoYMW4m9WWDrC1m7TJyMIR5NIb/O0ELjj75omYfdC18ArdOtHQnrGL6MEd7Tawf1NGlc/
 2GHlBmyEf/Xp5OtqGdBjlUZ4S9+1JApzJ+nreCLWKjfLVXB3Da/epSaGUiRWGCwML9TwF07
 TlQy947wAK2yUpS5ZE4sQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I+kVTdyw3UQ=:yy7fEVg5ZSWcLXv2ePKpf9
 CUmal76B/m6CDvL2B0audqJw7lR+teyBMfseu4WURgDKdFVmTOJAfaVXwK1HvdoCIzYkniqJE
 bpmo+7LMG2IQKDgxkRWSY50w9ccbldi8Fz1EIYUu5eFDaHNl0dpjWJMz/KiKuXUsSqDNwb2hR
 JW1d0ZID1CY17hrmrQ0TwivY9L8beKJVgm27LTZ4sBAtVAAl1USAz5grlYzWso4YyR/l57UjZ
 Z+gPP6pqNZp4bZgB5OUNeh9g1w3u48mtsvvVIPUksgUDVg/tpH5CnUGPKfdsIRKmbPmAbrVU4
 9ex/AItBBwlyj8SmTMm4dOtcbeOF+rp4aNVPPIR2e2bkE2XsIZQvb7EOzLy9uu1EHd9QIVYLJ
 9U5LJNje3ICcKuM3J6XvYWTDX6IjTohGMI7ZrJMlOCnwnAmvE/fJt6RM9ZZ3E9YN3yb+/ot3d
 KC0nTa5hGiFD4V0EJJooiuHWYBBM0TPlMsUS70NwTDyrmFdAUwCtgZHFCpwxXyVBB0a7yliBs
 OwCHkrkb+wtH5+N3JLcGTPI/VB9cRqvFPDuN6sbT7632YB+RK+JQkxUnfzcOrV95hHC5Vzdyi
 yhdfJEyWD7FDW/5/WU4M216Ja1EJNsa+eBKbriksSmIm3iG8CwgqOmh321natoo1jn3FIOvFG
 +ZNjERlyIkIBSKR/cKw4CVYBssGRG+INW9pb1IEXshDkqxZd8Yb9hL+hcjrEQf770grePMUVo
 a3GapIUlmW8CXViDqAd4nNUaNLoUDQ9nRgiUMAxAUx5zA/TjsZJ/qd44cS1PwV75qzPu3H4m 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280791>

On 11/03/2015 07:58 AM, atousa.p@gmail.com wrote:
> From: Atousa Pahlevan Duprat <apahlevan@ieee.org>
Minor comments inline
> diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
> index b864df6..d085412 100644
> --- a/block-sha1/sha1.h
> +++ b/block-sha1/sha1.h
> @@ -18,5 +18,5 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx);
>   
>   #define git_SHA_CTX	blk_SHA_CTX
>   #define git_SHA1_Init	blk_SHA1_Init
> -#define git_SHA1_Update	blk_SHA1_Update
> +#define platform_SHA1_Update	blk_SHA1_Update
>   #define git_SHA1_Final	blk_SHA1_Final
> diff --git a/cache.h b/cache.h
> index 79066e5..a501652 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -10,12 +10,21 @@
>   #include "trace.h"
>   #include "string-list.h"
>   
> +// platform's underlying implementation of SHA1
Please use /* */ for comments
>   #include SHA1_HEADER
>   #ifndef git_SHA_CTX
> -#define git_SHA_CTX	SHA_CTX
> -#define git_SHA1_Init	SHA1_Init
> -#define git_SHA1_Update	SHA1_Update
> -#define git_SHA1_Final	SHA1_Final
> +#define git_SHA_CTX		SHA_CTX
> +#define git_SHA1_Init		SHA1_Init
> +#define platform_SHA1_Update	SHA1_Update
> +#define git_SHA1_Final		SHA1_Final
> +#endif
> +
> +// choose whether chunked implementation or not
> +#ifdef SHA1_MAX_BLOCK_SIZE
> +int git_SHA1_Update_Chunked(SHA_CTX *c, const void *data, size_t len);
> +#define git_SHA1_Update       git_SHA1_Update_Chunked
> +#else
> +#define git_SHA1_Update       platform_SHA1_Update
>   #endif
>   
>   #include <zlib.h>
> diff --git a/compat/apple-common-crypto.h b/compat/apple-common-crypto.h
> index c8b9b0e..d3fb264 100644
> --- a/compat/apple-common-crypto.h
> +++ b/compat/apple-common-crypto.h
> @@ -16,6 +16,10 @@
>   #undef TYPE_BOOL
>   #endif
>   
> +#ifndef SHA1_MAX_BLOCK_SIZE
> +#error Using Apple Common Crypto library requires setting SHA1_MAX_BLOCK_SIZE
> +#endif
> +
>   #ifdef APPLE_LION_OR_NEWER
>   #define git_CC_error_check(pattern, err) \
>   	do { \
> diff --git a/compat/sha1_chunked.c b/compat/sha1_chunked.c
> new file mode 100644
> index 0000000..61f67de
> --- /dev/null
> +++ b/compat/sha1_chunked.c
> @@ -0,0 +1,19 @@
> +#include "cache.h"
> +
> +int git_SHA1_Update_Chunked(SHA_CTX *c, const void *data, size_t len)
> +{
> +	size_t nr;
> +	size_t total = 0;
> +	const char *cdata = (const char*)data;
> +
> +	while (len > 0) {
size_t is unsigned, isn't it ?
Better to use  "while (len) {"
> +		nr = len;
> +		if (nr > SHA1_MAX_BLOCK_SIZE)
> +			nr = SHA1_MAX_BLOCK_SIZE;
> +		platform_SHA1_Update(c, cdata, nr);
> +		total += nr;
> +		cdata += nr;
> +		len -= nr;
> +	}
> +	return total;
> +}
