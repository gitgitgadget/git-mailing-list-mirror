Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C7FB203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 18:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbcGUS51 (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 14:57:27 -0400
Received: from mout.web.de ([212.227.15.14]:57701 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858AbcGUS50 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 14:57:26 -0400
Received: from [192.168.178.36] ([79.213.113.124]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MX0VQ-1bnUtA26h2-00VzT6; Thu, 21 Jul 2016 20:57:12
 +0200
Subject: Re: [PATCH] submodule-config: use explicit empty string instead of
 strbuf in config_from()
To:	Heiko Voigt <hvoigt@hvoigt.net>
References: <578E7A07.8080006@web.de> <20160720082515.GA823@book.hvoigt.net>
Cc:	Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57911AFF.7030107@web.de>
Date:	Thu, 21 Jul 2016 20:57:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160720082515.GA823@book.hvoigt.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:eZMv7IERtGzRfDK+eLLASYBzItYc3mwR6AjpbWaO/IXNs+pyhVJ
 IA5TUml+Pe4082D94M2wKfc0yjDMjxieNMt9NLgoP763QcOfVnlIpnzNYh5T1KUjxbl7XBb
 CamHVUarj0IKh9Vk0/8Znvs03JblQGuTMYY0T7KiULyQzhfRQatxWGT7JT/SdDITeWzONkc
 uTbtxcGkN3fa77A3i2MbA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:UXBdf1VW8Cg=:6CYmJ49sDO1ul+m5LJwV4Y
 qhtJsueXSas8KkKFCCXWsqTibW568ZAh9tS0gHROXNNIFj/zj9xdu5FF9xol+NzOeQhbXYE2h
 vFwiZhr+QdYZHTXAFvkJFSDyUcjUVFseajmdlWYELU2t8N4PGyBJyiVDqEYOFD62V3ypsWDej
 yztLUNf6BCahypybZp6lJUBy9ZttctlFh5TXCnlsrvQSEk2ffFynHfwUO3Hmpe/otxEf4HFpp
 Mtn+ij2BP/05uXzsQhXHu44abNd5NgNCftbjHLOE1ptFICaMN1iMV0968vpzcGX0jTyFTAk2R
 QK8XG4RriPimTttv8r878fmOr6ZRTjj9vBFCraHwtL/a502f54SbSFw8Cxos/RqO8RmEso/V4
 dLpgHrvkW30HMDFQ+BFN2PoC2YTFSTPr+eC8/dsFUQ71IlPUyDcb1h103dw0Id0V02UTd9+S1
 IAbv2HDFQxshkiFRjBlqm1ucYq/kejL9yaQU4GvjJvO0Au4sQPNcq4OwOcM9RGx407nVtn9Yc
 zvM4UdyR/htoru0n/TP8vGufDTudTUSRmenW02kNENSth2mPQ1eEpsV5XW4+yJUPsJiCJt1wb
 EqWUwH1maYEjysgUUI8Q/fBf5O0pOmCC0ICCG2S7xy+UE1Nca7/NnuWQhm6jjaZt+ZLLOnmcl
 pXfKAJt73i2fguKBmkFkka2PX+VdAm1fyleMET9geyqTSuJrDBDw2Zv/kp6NkpPDHEpTzM4fl
 nFF22UMi3cA4VoJDYmDvngYlvJRw83kp1uxs1/oRDe9bcKKN2WbGwvoVYifBbN6hByX2SO4Er
 HoiauSS
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 20.07.2016 um 10:25 schrieb Heiko Voigt:
> Hi,
>
> On Tue, Jul 19, 2016 at 09:05:43PM +0200, René Scharfe wrote:
>> Use a string constant instead of an empty strbuf to shorten the code
>> and make it easier to read.
>
> This must have been some oversight from my original code. I also can not
> see any purpose.
>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> ... unless someone can come up with a suitable non-empty string to feed
>> to git_config_from_mem() as its name parameter.
>
> If we would want to be absolutely correct we could use something like
> "SHA1:.gitmodules". E.g. like we use to lookup the blob in
> gitmodule_sha1_from_commit():
>
> 	strbuf_addf(&rev, "%s:.gitmodules", sha1_to_hex(commit_sha1));
>
> And now I see where this was leftover from... before extracting this
> function this code was filling the strbuf.
>
> How about this instead?

I like it.

> ---8<------
> Subject: [PATCH] fix passing a name for config from submodules
>
> In commit 959b5455 we implemented the initial version of the submodule
> config cache. During development of that initial version we extracted
> the function gitmodule_sha1_from_commit(). During that process we missed
> that the strbuf rev was still used in config_from() and now is left
> empty. Lets fix this by also returning this string.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>
> Its not exactly pretty with all the releases before the returns but
> this is what I could quickly come up with...

Indeed.

>   submodule-config.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index 077db40..dccea59 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -371,9 +371,9 @@ static int parse_config(const char *var, const char *value, void *data)
>   }
>
>   static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
> -				      unsigned char *gitmodules_sha1)
> +				      unsigned char *gitmodules_sha1,
> +				      struct strbuf *rev)
>   {
> -	struct strbuf rev = STRBUF_INIT;
>   	int ret = 0;
>
>   	if (is_null_sha1(commit_sha1)) {
> @@ -381,11 +381,10 @@ static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
>   		return 1;
>   	}
>
> -	strbuf_addf(&rev, "%s:.gitmodules", sha1_to_hex(commit_sha1));
> -	if (get_sha1(rev.buf, gitmodules_sha1) >= 0)
> +	strbuf_addf(rev, "%s:.gitmodules", sha1_to_hex(commit_sha1));
> +	if (get_sha1(rev->buf, gitmodules_sha1) >= 0)
>   		ret = 1;
>
> -	strbuf_release(&rev);
>   	return ret;
>   }
>
> @@ -420,8 +419,10 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>   		return entry->config;
>   	}
>
> -	if (!gitmodule_sha1_from_commit(commit_sha1, sha1))
> +	if (!gitmodule_sha1_from_commit(commit_sha1, sha1, &rev)) {
> +		strbuf_release(&rev);
>   		return NULL;
> +	}
>
>   	switch (lookup_type) {
>   	case lookup_name:
> @@ -431,14 +432,19 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>   		submodule = cache_lookup_path(cache, sha1, key);
>   		break;
>   	}
> -	if (submodule)
> +	if (submodule) {
> +		strbuf_release(&rev);
>   		return submodule;
> +	}
>
>   	config = read_sha1_file(sha1, &type, &config_size);
> -	if (!config)
> +	if (!config) {
> +		strbuf_release(&rev);
>   		return NULL;
> +	}
>
>   	if (type != OBJ_BLOB) {
> +		strbuf_release(&rev);
>   		free(config);
>   		return NULL;
>   	}

A separate patch could combine the previous two conditionals; free(NULL) 
is allowed.

> @@ -450,6 +456,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>   	parameter.overwrite = 0;
>   	git_config_from_mem(parse_config, "submodule-blob", rev.buf,
>   			config, config_size, &parameter);
> +	strbuf_release(&rev);
>   	free(config);
>
>   	switch (lookup_type) {
>

