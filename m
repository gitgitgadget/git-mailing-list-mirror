Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FDD72021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964793AbcKOXTj (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:19:39 -0500
Received: from mout.gmx.net ([212.227.15.18]:58948 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753173AbcKOXTi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:19:38 -0500
Received: from [192.168.178.43] ([88.70.147.72]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb5nF-1cUbS21T9F-00kfQf; Wed, 16
 Nov 2016 00:19:35 +0100
Subject: Re: [PATCH v15 13/27] bisect--helper: `bisect_start` shell function
 partially in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ad3-ea75ed97-2514-427e-8e57-9f10efd4e6e9-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <098cb39e-3c92-df56-1dc9-c529df817262@gmx.net>
Date:   Wed, 16 Nov 2016 00:19:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1ad3-ea75ed97-2514-427e-8e57-9f10efd4e6e9-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:VPyHgzzoqihcihA6Aw7NToD9w9+6aec4rVzXnoCVSSBuLITj/Cn
 OsMT2whRA076H+vqc8FpDuNmhXelKadhGnEBWoPT1BPhFkPznzXjqVP8ysTtQFvg5kPeh/o
 JpBztNC3EXtuZGdBvYtFe1T1SE0kF5ykmbUmMMi0ebsSlNNXSRrAzs7FzHRGClWHNvZe+7t
 Ty2DCzOILWTQX+2otaJ2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t+RGYDKNeHc=:uSTfAFxhnPKpPfxLoHv174
 8SVUMgYa3jobygTfErXxeY1YYghBprWUw6Y0o5CbRVDZ3lSTK7p5EP7A+vkfNzLVz8rQ0mRrx
 TsStAJAnFkIC/AV/1PExwVaclfeNtUneBXUiwrYFVc1QUoYcdAOcjXvV0uZ6RLBkntTj1mjE9
 rbK4aewgwS5NQu2FfEe/v3I/momxwzq5+qdYEExbtdH5UbEc/3DavD2FfOHpLQPseBtF00KoI
 YesmnpioL/3DnO4Io4pm9HVIXN2vQ9vuDYKvK7G7IViVHM/d8zgScg+MV+LiBuUbkjaU1KD8S
 AbaL+L6jh8315AQ6IBP3IPMPnrboJQwHksAi1tqjKGPneKAIB+KyaOiGd/8KsjoZlx+IRmn0N
 6lbiQNcEBVLljoY4dAoyPiA4v1IRRDscetp17M/f84sLwxDTzBTidbrChXJrPqIrb/CSvhD3n
 Inc5089qQEVsQmQrj18yRQe/Rct4xpR5qCaCkkvZzIcKlZOEWUDKB33HUHKmindU/4Ve55ssL
 WqkdQ7OAykcPfeVKJk6/2A8PsafdaJ146hIFsMquubdYMHsYP9Y6clYb8bpgLJKPBsq+roim2
 rD4SUuu3RDwHgVSE30N3veN1npLzuVHNZztaUJUoXWSd4kJ8yijC+MUQgkqCTP6aJet9HcXH6
 YXigJRNwYVcmVkQc3tDiky0+ng5JAvz5lh/BQugh8rlgp4F0iMg4u6es+8YusWYqZP2A/Y0Xl
 jbB6gZSwoIsXXm7SqW8ZWzz50uTjnP7iYKHMer2ey8ydcUWLE4hIJZdLTd9ydpck97OFA9mut
 CS2wNHu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 6a5878c..1d3e17f 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -24,6 +27,8 @@ static const char * const git_bisect_helper_usage[] = {
>  	N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
>  	N_("git bisect--helper --bisect-next-check [<term>] <TERM_GOOD> <TERM_BAD"),
>  	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
> +	N_("git bisect--helper --bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
> +					      "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),

Typo: "--bisect start" with space instead of "-"

> @@ -403,6 +408,205 @@ static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
>  	return 0;
>  }
>  
> +static int bisect_start(struct bisect_terms *terms, int no_checkout,
> +			const char **argv, int argc)
> +{
> +	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
> +	int flags, pathspec_pos, retval = 0;
> +	struct string_list revs = STRING_LIST_INIT_DUP;
> +	struct string_list states = STRING_LIST_INIT_DUP;
> +	struct strbuf start_head = STRBUF_INIT;
> +	struct strbuf bisect_names = STRBUF_INIT;
> +	struct strbuf orig_args = STRBUF_INIT;
> +	const char *head;
> +	unsigned char sha1[20];
> +	FILE *fp = NULL;
> +	struct object_id oid;
> +
> +	if (is_bare_repository())
> +		no_checkout = 1;
> +
> +	for (i = 0; i < argc; i++) {
> +		if (!strcmp(argv[i], "--")) {
> +			has_double_dash = 1;
> +			break;
> +		}
> +	}
> +
> +	for (i = 0; i < argc; i++) {
> +		const char *commit_id = xstrfmt("%s^{commit}", argv[i]);
> +		const char *arg = argv[i];
> +		if (!strcmp(argv[i], "--")) {
> +			has_double_dash = 1;

This is without effect since has_double_dash is already set to 1 by the
loop above. I think you can remove this line.

> +			break;
> +		} else if (!strcmp(arg, "--no-checkout")) {
> +			no_checkout = 1;
> +		} else if (!strcmp(arg, "--term-good") ||
> +			 !strcmp(arg, "--term-old")) {
> +			must_write_terms = 1;
> +			terms->term_good = xstrdup(argv[++i]);
> +		} else if (skip_prefix(arg, "--term-good=", &arg)) {
> +			must_write_terms = 1;
> +			terms->term_good = xstrdup(arg);
> +		} else if (skip_prefix(arg, "--term-old=", &arg)) {
> +			must_write_terms = 1;
> +			terms->term_good = xstrdup(arg);

I think you can join the last two branches:

+		} else if (skip_prefix(arg, "--term-good=", &arg) ||
+		           skip_prefix(arg, "--term-old=", &arg)) {
+			must_write_terms = 1;
+			terms->term_good = xstrdup(arg);

> +		} else if (!strcmp(arg, "--term-bad") ||
> +			 !strcmp(arg, "--term-new")) {
> +			must_write_terms = 1;
> +			terms->term_bad = xstrdup(argv[++i]);
> +		} else if (skip_prefix(arg, "--term-bad=", &arg)) {
> +			must_write_terms = 1;
> +			terms->term_bad = xstrdup(arg);
> +		} else if (skip_prefix(arg, "--term-new=", &arg)) {
> +			must_write_terms = 1;
> +			terms->term_good = xstrdup(arg);

This has to be terms->term_bad = ...

Also, you can join the last two branches, again, ie,

+		} else if (skip_prefix(arg, "--term-bad=", &arg) ||
+		           skip_prefix(arg, "--term-new=", &arg)) {
+			must_write_terms = 1;
+			terms->term_bad = xstrdup(arg);

> +		} else if (starts_with(arg, "--") &&
> +			 !one_of(arg, "--term-good", "--term-bad", NULL)) {
> +			die(_("unrecognised option: '%s'"), arg);
[...]
> +	/*
> +	 * Verify HEAD
> +	 */
> +	head = resolve_ref_unsafe("HEAD", 0, sha1, &flags);
> +	if (!head)
> +		if (get_sha1("HEAD", sha1))
> +			die(_("Bad HEAD - I need a HEAD"));
> +
> +	if (!is_empty_or_missing_file(git_path_bisect_start())) {

You were so eager to re-use the comments from the shell script, but you
forgot the "Check if we are bisecting." comment above this line ;-)

> +		/* Reset to the rev from where we started */
> +		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
> +		strbuf_trim(&start_head);
> +		if (!no_checkout) {
> +			struct argv_array argv = ARGV_ARRAY_INIT;
[...]
> +	if (must_write_terms)
> +		if (write_terms(terms->term_bad, terms->term_good)) {
> +			retval = -1;
> +			goto finish;
> +		}
> +

bisect_start() is a pretty big function.
I think it can easily be decomposed in some smaller parts, for example,
the following lines ...

> +	fp = fopen(git_path_bisect_log(), "a");
> +	if (!fp)
> +		return -1;
> +
> +	if (fprintf(fp, "git bisect start") < 1) {
> +		retval = -1;
> +		goto finish;
> +	}
> +
> +	sq_quote_argv(&orig_args, argv, 0);
> +	if (fprintf(fp, "%s", orig_args.buf) < 0) {
> +		retval = -1;
> +		goto finish;
> +	}
> +	if (fprintf(fp, "\n") < 1) {
> +		retval = -1;
> +		goto finish;
> +	}

... could be in a function like

static int bisect_append_log(const char **argv)
{
	FILE *fp = fopen(git_path_bisect_log(), "a");
	struct strbuf orig_args = STRBUF_INIT;
	if (!fp)
		return -1;

	if (fprintf(fp, "git bisect start") < 1) {
		retval = -1;
		goto finish;
	}

	sq_quote_argv(&orig_args, argv, 0);
	if (fprintf(fp, "%s", orig_args.buf) < 0 ||
	    fprintf(fp, "\n") < 1) {
		retval = -1;
		goto finish;
	}

finish:
	if (fp)
		fclose(fp);
	strbuf_release(&orig_args);

	return retval;
}

and then simply call

	retval = bisect_append_log(argv);

in bisect_start()... (This is totally untested.)

If you do not want that for some reason, you should at least fix

> +	if (!fp)
> +		return -1;

to retval = 1; goto finish; such that the other lists and strings are
released.

> +	goto finish;
> +finish:

The "goto finish" right above the "finish" label is unnecessary.

> +	if (fp)
> +		fclose(fp);
> +	string_list_clear(&revs, 0);
> +	string_list_clear(&states, 0);
> +	strbuf_release(&start_head);
> +	strbuf_release(&bisect_names);
> +	strbuf_release(&orig_args);
> +	return retval;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {

By the way, there are two spaghetti-ish ways to get rid of the

	retval = -1;
	goto finish;

line pair:

	goto fail;

and below the "return retval;" add

fail:
	retval = -1;
	goto finish;

and you can feel the touch of His Noodly Appendage. *scnr*

The other way is to keep the "goto finish" I deemed unnecessary (right
above the label), and expand it to:

	goto finish;
fail:
	retval = -1;
finish:
	...

Cheers
  Stephan
