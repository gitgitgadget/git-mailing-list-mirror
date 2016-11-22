Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF29A1FEEF
	for <e@80x24.org>; Tue, 22 Nov 2016 00:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbcKVAuB (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 19:50:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:53603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754542AbcKVAuA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 19:50:00 -0500
Received: from [192.168.178.43] ([88.71.235.101]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOTRh-1c5ONq2X2b-005n0Q; Tue, 22
 Nov 2016 01:49:47 +0100
Subject: Re: [PATCH v15 23/27] bisect--helper: `bisect_replay` shell function
 in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1b29-65f79716-42c6-4327-acda-8c8d0fe05471-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <1816d5b4-a4c1-7c97-09ff-b11001501423@gmx.net>
Date:   Tue, 22 Nov 2016 01:49:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1b29-65f79716-42c6-4327-acda-8c8d0fe05471-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Yer1xSWAS5Gs88GpzBy2HZdc4kzvBEf8mWhMKdvVfxPhfsSmnNy
 rRpbOGFYMSfAr4RIlf9OiNPyiicShYyE8EjgGiQuilEPmTFszanQa07mXNMmqoIq4jkzlGb
 myBMdDhSc0kNhDT5zl8RyK1eWIj+QYfRV3PceALelEIa5ZF5Ne7EglYKPfP6rgL8i3V65VO
 tKBYzsy1RP+QgDJUF6aOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:soQ3LzTSD04=:U9Tp1t2UqA3ZZaiXV5u5mp
 s/v8smYNMb9CrQFn25aVl4XVRlchY29symGwzDCT97Cl+3l3aRHQA9LDLs/HtXh0RBgm5LeNK
 mnwIqOqeNfnMGzy6EjtSjyXzVVkEYlimcivb4zCZJ6vBEwXBLXS3xkrm1hc7ZNUW6BgYV7n0T
 dAWweDF+/Jk1koMpIQnbEY8GKGeXVnTIBWGrx8IhldBhESJd2vAx3T1LQ/uFVqYMgOwC7RBVw
 QUx65zicDENpCpkShH4aK4n6BHKfyhdMx/LwwMOZOB7AB7YMNrV4FLE2sBZv1z7QHYZ/Dg8E9
 arMpwRqb/Qa7YcqqcOlEGtkmwKJaFGYC/Y77O/Xj1OWEKQh2iHYnth4to5Fsluk7chrO9qycc
 SOjHuF+G+u/sJKN9XHWxcb4JhG9b5T69w2uH/DjFg0gIEokxBwYKuT1yEWVEsMbJMzgsaxLea
 ekMaejhv7Xhvoq4p779dfkdmCm/7uRlqaXAqwXUd2qn59ev9YxigO2h7MK5vY7+shTJO/ZbMy
 BYOAK+Uia/pIYDhxzgga+R3OffW/KdDrpaOvYkHsL8+nid2Cj7ivLh6q+aUzUzRVNMd5nV5uo
 I6SDPbZKManSiHucMjR00J/ecLmxtGXlC1TI9Gh+aP25r0gDJHE0udscFrp+tGavnNd8061eZ
 5xAFoJNXr2wMqku8RT1WHr78VURIONPllLuzvUKIN2oHDFynmgVUjKaCuPd6zlqkikFn/Ebwr
 JJFN0NhQLc1zcUDbSG7OtfiTmjm9lmb7yLHBNUwZHo3hK3xRZS9yk/Pt6GJBDxWhaYNdPnXrR
 UfMtlDX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Okay Pranit,

this is the last patch for me to review in this series.

Now that I have a coarse overview of what you did, I have the general
remark that imho the "terms" variable should simply be global instead of
being passed around all the time.

I also had some other remarks but I forgot them... maybe they come to my
mind again when I see patch series v16.

I also want to remark again that I am not a Git developer and only
reviewed this because of my interest in git-bisect. So some of my
suggestions might conflict with other beliefs here. For example, I
consider it very bad style to leak memory... but Git is rather written
as a scripting tool than a genuine library, so perhaps many people here
do not care about it as long as it works...

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index c18ca07..b367d8d 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -601,7 +602,6 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
>  			terms->term_good = arg;
>  		} else if (!strcmp(arg, "--term-bad") ||
>  			 !strcmp(arg, "--term-new")) {
> -			const char *next_arg;

This should already have been removed in patch 15/27, not here.

> @@ -875,6 +875,117 @@ static int bisect_log(void)
>  	return status;
>  }
>  
> +static int get_next_word(const char *line, int pos, struct strbuf *word)
> +{
> +	int i, len = strlen(line), begin = 0;
> +	strbuf_reset(word);
> +	for (i = pos; i < len; i++) {
> +		if (line[i] == ' ' && begin)
> +			return i + 1;
> +
> +		if (!begin)
> +			begin = 1;
> +		strbuf_addch(word, line[i]);
> +	}
> +
> +	return i;
> +}
> +
> +static int bisect_replay(struct bisect_terms *terms, const char *filename)
> +{
> +	struct strbuf line = STRBUF_INIT;
> +	struct strbuf word = STRBUF_INIT;
> +	FILE *fp = NULL;

(The initialization is not necessary here.)

> +	int res = 0;
> +
> +	if (is_empty_or_missing_file(filename)) {
> +		error(_("no such file with name '%s' exists"), filename);

The error message is misleading if the file exists but is empty.
Maybe something like "cannot read file '%s' for replaying"?

> +		res = -1;
> +		goto finish;

		goto fail;
:D

> +	}
> +
> +	if (bisect_reset(NULL)) {
> +		res = -1;
> +		goto finish;

		goto fail;

> +	}
> +
> +	fp = fopen(filename, "r");
> +	if (!fp) {
> +		res = -1;
> +		goto finish;

		goto fail;

> +	}
> +
> +	while (strbuf_getline(&line, fp) != EOF) {
> +		int pos = 0;
> +		while (pos < line.len) {
> +			pos = get_next_word(line.buf, pos, &word);
> +
> +			if (!strcmp(word.buf, "git")) {
> +				continue;
> +			} else if (!strcmp(word.buf, "git-bisect")) {
> +				continue;
> +			} else if (!strcmp(word.buf, "bisect")) {
> +				continue;
> +			} else if (!strcmp(word.buf, "#")) {
> +				break;

Maybe it is more robust to check whether word.buf begins with #

> +			}
> +
> +			get_terms(terms);
> +			if (check_and_set_terms(terms, word.buf)) {
> +				res = -1;
> +				goto finish;

				goto fail;

> +			}
> +
> +			if (!strcmp(word.buf, "start")) {
> +				struct argv_array argv = ARGV_ARRAY_INIT;
> +				sq_dequote_to_argv_array(line.buf+pos, &argv);
> +				if (bisect_start(terms, 0, argv.argv, argv.argc)) {
> +					argv_array_clear(&argv);
> +					res = -1;
> +					goto finish;

					goto fail;

> +				}
> +				argv_array_clear(&argv);
> +				break;
> +			}
> +
> +			if (one_of(word.buf, terms->term_good,
> +			    terms->term_bad, "skip", NULL)) {
> +				if (bisect_write(word.buf, line.buf+pos, terms, 0)) {
> +					res = -1;
> +					goto finish;

					goto fail;

> +				}
> +				break;
> +			}
> +
> +			if (!strcmp(word.buf, "terms")) {
> +				struct argv_array argv = ARGV_ARRAY_INIT;
> +				sq_dequote_to_argv_array(line.buf+pos, &argv);
> +				if (bisect_terms(terms, argv.argv, argv.argc)) {
> +					argv_array_clear(&argv);
> +					res = -1;
> +					goto finish;

					goto fail;

> +				}
> +				argv_array_clear(&argv);
> +				break;
> +			}
> +
> +			error(_("?? what are you talking about?"));

I know this string is taken from the original source. However, even
something like error(_("Replay file contains rubbish (\"%s\")"),
word.buf) is more informative.

> +			res = -1;
> +			goto finish;

			goto fail;

> +		}
> +	}
> +	goto finish;

+fail:
+	res = -1;

I just wanted to make finally clear what I was referring to by the
"goto fail" trick. :D

Also I think the readability could be improved by extracting the body of
the outer while loop into an extra function replay_line(). Then most of
my suggested "goto fail;" lines simply become "return -1;" :)

> @@ -998,6 +1112,13 @@ int cmd_bisect__helper(...)
>   			die(_("--bisect-log requires 0 arguments"));
>   		res = bisect_log();
>   		break;
> +	case BISECT_REPLAY:
> +		if (argc != 1)
> +			die(_("--bisect-replay requires 1 argument"));

I'd keep the (already translated) string from the original source:
"No logfile given"


Cheers,
  Stephan
