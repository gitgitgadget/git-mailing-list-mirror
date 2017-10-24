Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EB191FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 20:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbdJXUXd (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 16:23:33 -0400
Received: from mout.web.de ([212.227.15.4]:58921 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750897AbdJXUXc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 16:23:32 -0400
Received: from [192.168.178.36] ([91.20.60.28]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdJmT-1dOeB902q1-00iSXt; Tue, 24
 Oct 2017 22:23:30 +0200
Subject: Re: [PATCH 1/4] hashmap: introduce memhash_feed to access the
 internals of FNV-1 hash
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20171024185917.20515-1-sbeller@google.com>
 <20171024185917.20515-2-sbeller@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <06c950e8-92c6-4926-ccac-2827d480f373@web.de>
Date:   Tue, 24 Oct 2017 22:23:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171024185917.20515-2-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:whOW3RuD1ZGy2O1jIIb0zePOmnYZQT8F+hIIVIEY0L/oH22ffGK
 hPsMK0cg94bwXLDr3y33FLMD/VlZiBpEdI6v9rNdnjpbTVskZi/pycDuInSwd8ie5T30X0V
 26VTqgJqd2MQz0AiWUfHB03JMIDYHujhNFK83Uhjw/iNvQ2X2m12Pb0rPikjV+wWX3Ts4Rn
 sBr07VaVKubdzmDqd06eA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:siowf6ckmCQ=:2Fw2RSV16G8EdKrjBn2Mee
 fQUcBt+XshdG4N/95F9v8JjOnvOEW76NBpG0onpn3ReEew/oe4L7uaBbCCIDMTD6bd3SenGft
 fAdOnQLrOq6RJCFcKEjLETZD9x73+lXRr+nwTNvKEc3LR0uLY9WtriHBqMcT6ZDxXkky4NQu3
 z43Cqpgqe3vxX0JvELrAsaxrAMvux7zvbishxTNRqB5DVX2oPyjFzBtR50Gy1CETbGwj9W8Xf
 ZgyIoPSb7gTWTogru2bgAc5f/jMe18Hm95yfQzip7+d4hJw3oBN2bD9r95L28fJOk3j6oLxoF
 Rp3Qb0QqZVBlLHmtXFiy+dc9v1NfboJwXmbCzxufg+3tNAU2UU8xT/zEVLzeLwD86lqp3M9rr
 cIunGvO/9lt89XJmW33VsVcuWiYdae2C3qoN0d2Pusn6DU35qzIC9kpxUtttJ72Gb+T8CUso+
 LyONVElam9DqAAU/H/Hg+LXaJXEo+MBBd/aHEKgSPdneCPfs9ioBAmo1N0W/eOWPIE57RWgoO
 Q3D1ilTtXqGQ2VtHsc0MvRKwkjiXDwRScMGY+Ps3OWdhBet9oHazNE1HBvzsrQTIex2LlEWNQ
 l/Ov5UBNGxB6FG/Qz4ewk7TEXMRM2B5GAMX4oInQeheYNwNM0KCLaewpWMzHPJiTh1HamDvG+
 4sCDxSNbbf1LG58tQRAHcTogj5dDrv4AKbzWhWohUyMRan0KCEahnfI6FNKmkIAQUkhDnjEzL
 fpCl+QVdSqoIQUecGdfzXlhWhCJfyLYLCpgewhpNrsdJsacfrHqyQ/grSs7jybWJ9OGSABM6f
 z3cUsxG05VQ7jMIDkFq9qY5wD65A6jbnKahomee2qKyonEUfhk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.10.2017 um 20:59 schrieb Stefan Beller:
> This will be useful shortly.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   hashmap.c | 7 ++++++-
>   hashmap.h | 3 +++
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hashmap.c b/hashmap.c
> index d42f01ff5a..d103eb1fd2 100644
> --- a/hashmap.c
> +++ b/hashmap.c
> @@ -26,13 +26,18 @@ unsigned int strihash(const char *str)
>   	return hash;
>   }
>   
> +unsigned int memhash_feed(unsigned int hash_seed, const unsigned char next)

Why is the second parameter const and the first one isn't?  (We tend
not to bother with const for value types.)

> +{
> +	return (hash_seed * FNV32_PRIME) ^ next;
> +}
> +
>   unsigned int memhash(const void *buf, size_t len)
>   {
>   	unsigned int hash = FNV32_BASE;
>   	unsigned char *ucbuf = (unsigned char *) buf;
>   	while (len--) {
>   		unsigned int c = *ucbuf++;
> -		hash = (hash * FNV32_PRIME) ^ c;
> +		hash = memhash_feed(hash, c);

I guess compilers inline a copy of the function here with -O2.  My
knee-jerk reaction, however, is horror in the face of adding a function
call to the inner loop of a hash function.  Do you have performance
test results, ideally also with -O0?  And why not make memhash_feed()
an inline function or macro to sidestep that issue?

>   	}
>   	return hash;
>   }
> diff --git a/hashmap.h b/hashmap.h
> index 7cb29a6aed..c2464385ed 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -105,10 +105,13 @@
>    * `strihash` and `memihash` are case insensitive versions.
>    * `memihash_cont` is a variant of `memihash` that allows a computation to be
>    * continued with another chunk of data.
> + * `memhash_feed` takes just one character and returns the hash based off
> + * a previous hash.
>    */
>   extern unsigned int strhash(const char *buf);
>   extern unsigned int strihash(const char *buf);
>   extern unsigned int memhash(const void *buf, size_t len);
> +extern unsigned int memhash_feed(unsigned int hash_seed, const unsigned char next);
>   extern unsigned int memihash(const void *buf, size_t len);
>   extern unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len);
>   
> 
