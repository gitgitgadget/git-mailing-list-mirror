Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AC411F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 18:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbcJESrh (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 14:47:37 -0400
Received: from mout.web.de ([212.227.17.11]:55855 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752257AbcJESrg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 14:47:36 -0400
Received: from [192.168.178.36] ([79.213.121.94]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LhNnw-1b5eJm3uam-00mY8M; Wed, 05 Oct 2016 20:47:31
 +0200
Subject: Re: [PATCH 16/18] count-objects: report alternates via verbose mode
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203618.m6kxd3b6h74jbmqz@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5df3d609-62c8-c5e7-d457-76e044ea6438@web.de>
Date:   Wed, 5 Oct 2016 20:47:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161003203618.m6kxd3b6h74jbmqz@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:fcyV7p0ozbcyxFrNNb88U95Qa3rXHRKTiI7V3SiMDPypL6CuJR5
 qsVhDDlzPnBCVvqGtHhXY4z3qiFkyAo8Etw/6bGlJ3FvDnP4NX8NMSq4MH4/j01wTiqNoy3
 0Cb+Um72CU/JEHcxBHmkr32z1j1kVi1s4e2Hl9Y/5oc/Rt/mzarU2cF4f8klh9/ahAov9PO
 6IRk/9vqwADdGqYEt36bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4J5ET7SO998=:4I+HZA81OYCKcyHto/ruWo
 wHzLYA5YDxw2ComxToDhl7PmibFokB9G6isdo+IE+uEev93zPUhio+hU34J99K6pmfQ1TtEK7
 OTXGUWw8ubLoxcMBr2z5FZPm4wIfpcIE9ucc3XKBYJ5zEDlnzWCR/cDNMaWeH5mmm7TH/j4Lx
 3W2YqyjZTKV+PRoXIkQQKmpVvqBWsbo7Q+tKwsPGzkMmVab5xS3+DGemc+EcPqojaoj5UX1Qp
 nU5EJOri8wd4E/vZQFtK34Ttf6+wtY/sz25xG5lhRHXCYp7wBGPUh8Tu0jVBCI+9BwM8EWsgJ
 gUgS6qp4cvWLysPzsmNyfttjQrI+4nX/t9Zv2TT6d8F6VAu/WS56bV88h9PmskWG6U1xL6sXK
 OPAzoD30Oy6fMm+OlHWk/P4Lx6X+MDws+lrTYKalLbL5X1nhJhEIWP8HsiaWLLgV7pPL44fkd
 bknr4GBXqdv2dlFQzaMCYzwyqN8GI6Zu9A9B10igp8VT5rXt0YBTPe6NV1qzAANtQKS/BDL7h
 Kex/rebSfV+9iM5J31MJQovg3KF2NSvetkOU1luNLQuq+Xld9ay1fG3Mdf2+KVmhdG/IzNL0Q
 YpjhJtoMaCLAckSVUa/T8sNtax+u+YmbmvCvUWtBJsrBcngrcMaRRPNaKYDfuRAwDbL1zKS3l
 AyF1C1znhY+XxNxntcvheCUgPtu22r8FUENVQSGSFXvj8hoeH6pk03gnSiu36ZfEejJj6RWR3
 Xvk6ovMw5do9aIzC7pr3P4vuDMgpu8kb9RFz6+Sgl5YNXqL1XoDWoGWn00/y5coasfOz2Qk4g
 22e5fIG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.10.2016 um 22:36 schrieb Jeff King:
> There's no way to get the list of alternates that git
> computes internally; our tests only infer it based on which
> objects are available. In addition to testing, knowing this
> list may be helpful for somebody debugging their alternates
> setup.
>
> Let's add it to the "count-objects -v" output. We could give
> it a separate flag, but there's not really any need.
> "count-objects -v" is already a debugging catch-all for the
> object database, its output is easily extensible to new data
> items, and printing the alternates is not expensive (we
> already had to find them to count the objects).

Good idea.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-count-objects.txt |  5 +++++
>  builtin/count-objects.c             | 10 ++++++++++
>  t/t5613-info-alternate.sh           | 10 ++++++++++
>  3 files changed, 25 insertions(+)
>
> diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
> index 2ff3568..cb9b4d2 100644
> --- a/Documentation/git-count-objects.txt
> +++ b/Documentation/git-count-objects.txt
> @@ -38,6 +38,11 @@ objects nor valid packs
>  +
>  size-garbage: disk space consumed by garbage files, in KiB (unless -H is
>  specified)
> ++
> +alternate: absolute path of alternate object databases; may appear
> +multiple times, one line per path. Note that if the path contains
> +non-printable characters, it may be surrounded by double-quotes and
> +contain C-style backslashed escape sequences.
>
>  -H::
>  --human-readable::
> diff --git a/builtin/count-objects.c b/builtin/count-objects.c
> index ba92919..a700409 100644
> --- a/builtin/count-objects.c
> +++ b/builtin/count-objects.c
> @@ -8,6 +8,7 @@
>  #include "dir.h"
>  #include "builtin.h"
>  #include "parse-options.h"
> +#include "quote.h"
>
>  static unsigned long garbage;
>  static off_t size_garbage;
> @@ -73,6 +74,14 @@ static int count_cruft(const char *basename, const char *path, void *data)
>  	return 0;
>  }
>
> +static int print_alternate(struct alternate_object_database *alt, void *data)
> +{
> +	printf("alternate: ");
> +	quote_c_style(alt->path, NULL, stdout, 0);
> +	putchar('\n');
> +	return 0;
> +}

Yeah, quoting paths makes sense.

> +
>  static char const * const count_objects_usage[] = {
>  	N_("git count-objects [-v] [-H | --human-readable]"),
>  	NULL
> @@ -140,6 +149,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
>  		printf("prune-packable: %lu\n", packed_loose);
>  		printf("garbage: %lu\n", garbage);
>  		printf("size-garbage: %s\n", garbage_buf.buf);
> +		foreach_alt_odb(print_alternate, NULL);
>  		strbuf_release(&loose_buf);
>  		strbuf_release(&pack_buf);
>  		strbuf_release(&garbage_buf);
> diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
> index b393613..74f6770 100755
> --- a/t/t5613-info-alternate.sh
> +++ b/t/t5613-info-alternate.sh
> @@ -39,6 +39,16 @@ test_expect_success 'preparing third repository' '
>  	)
>  '
>
> +test_expect_success 'count-objects shows the alternates' '
> +	cat >expect <<-EOF &&
> +	alternate: $(pwd)/B/.git/objects
> +	alternate: $(pwd)/A/.git/objects
> +	EOF
> +	git -C C count-objects -v >actual &&
> +	grep ^alternate: actual >actual.alternates &&
> +	test_cmp expect actual.alternates
> +'
> +
>  # Note: These tests depend on the hard-coded value of 5 as "too deep". We start
>  # the depth at 0 and count links, not repositories, so in a chain like:
>  #
>
