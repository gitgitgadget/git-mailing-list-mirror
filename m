Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84A6D1FC14
	for <e@80x24.org>; Mon, 21 Nov 2016 21:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754861AbcKUVfa (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 16:35:30 -0500
Received: from mout.gmx.net ([212.227.17.21]:59094 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754362AbcKUVf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 16:35:28 -0500
Received: from [192.168.178.43] ([92.76.234.104]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8mCe-1c3OsL0ghQ-00C9he; Mon, 21
 Nov 2016 22:35:25 +0100
Subject: Re: [PATCH v15 15/27] bisect--helper: `bisect_next` and
 `bisect_auto_next` shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1af0-5d688c2e-868d-4d8c-a8fd-9a675f7f01da-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <06402c8a-14a4-3d70-8d98-659cfe9f1aa2@gmx.net>
Date:   Mon, 21 Nov 2016 22:35:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1af0-5d688c2e-868d-4d8c-a8fd-9a675f7f01da-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Oeaatbt3vVZonxbBEypN5e/jHvURdFnP0b272yvAHPTMYgUUtrC
 1qIlZCRc0nkJn7NM0ZGy0D2PAR9A5nHXAVGCdnilOPiLAjGIMoPBtkWc40Zr1mo9QRmCWZT
 L2vSX9tt1uhhxMsmfotzcHVi27dRQWKBDYq2xTPTssvopqgfKHTJnxccr7rGWP3PpbjgXS9
 UmO8DGpDmPWeBW9pLqCtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P5SzwANxFVg=:DfYDBpBItT5Y3zM5hxCn3j
 keoFNiLnshkUM/EkYKGV27ykyuTeemAGtty9ofuOnBrR9Nw2DIp9E2QmHW/tSvBEoZztevoY6
 WCcBrddWCmpiYgt/HHzcYaR3sychtUaX5jV7fEbVzIwVEFEA4vpmq/GV3XhtiDa5iJDCLMvdK
 KzA385/4AQHS0VEpNJVNI/+yN0elq83xB5m5gYH770X6QfxR/fIs7IzvfJYyDNmWS/psxTmU4
 ge/7IFCX86BGp32X36BrUM1ND1SVaZp+B8ne2xXYUPqitF66gYEsOFhDxwF5TJqx78F4bHA3E
 nEgnS2+4qjZ4brZX6t7rH5BjBi9p121MHybK8brbmgFuAZsthY92kulu9ndPBSLm9Ik3XNgrf
 NgCdWH5RU0TnMh918Ju/SCeTFWbNiYSk/FZFkk4B0lpmBYca+wOZZLttpNdVBdqwWHDELOoKi
 blI66iMzD9y9pnKA/Y/2SIGS+Ln/AxRk/fqeFzXAwN8MVYh2neoPLGKdPukle0ylVNaO6SWhT
 SnQYeAlWQNqxcUR8VMx8CywKHXsamSSvJQtTNqd1altkkXhekfzjiZaS6J7PlfZ449eTuN7wn
 CWo7nozLXjqRdjbxibdV+nmfkYq6RJwjDcVVybsBU68EDP7Pvg+p0fA1ZIlBGWrgnBDGfVY8/
 +ecPBkfPupV4kB0oduFXPNr8DnmvMBy3ULvoTaAAJGJ0Ryqk8USE4uZYErLufQbt8rohUAK8c
 Uup7rbdL1G68rQkx69scIQGb/iKWKfdnFaQBTnhhPmluaeQhbH0v4m1rkzRU7KZc9IsqY7MMc
 CikGuCl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pranit,

in this mail I review the "second part" of your patch: the transition of
bisect_next and bisect_auto_next to C.

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1d3e17f..fcd7574 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -408,6 +411,136 @@ static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
>  	return 0;
>  }
>  
> +static int register_good_ref(const char *refname,
> +			     const struct object_id *oid, int flags,
> +			     void *cb_data)
> +{
> +	struct string_list *good_refs = cb_data;
> +	string_list_append(good_refs, oid_to_hex(oid));
> +	return 0;
> +}
> +
> +static int bisect_next(struct bisect_terms *terms, const char *prefix)
> +{
> +	int res, no_checkout;
> +
> +	/*
> +	 * In case of mistaken revs or checkout error, or signals received,
> +	 * "bisect_auto_next" below may exit or misbehave.
> +	 * We have to trap this to be able to clean up using
> +	 * "bisect_clean_state".
> +	 */

The comment above makes no sense here, or does it?

> +	if (bisect_next_check(terms, terms->term_good))
> +		return -1;
> +
> +	no_checkout = !is_empty_or_missing_file(git_path_bisect_head());
> +
> +	/* Perform all bisection computation, display and checkout */
> +	res = bisect_next_all(prefix , no_checkout);

Style: there is a space left of the comma.

> +
> +	if (res == 10) {
> +		FILE *fp = NULL;
> +		unsigned char sha1[20];
> +		struct commit *commit;
> +		struct pretty_print_context pp = {0};
> +		struct strbuf commit_name = STRBUF_INIT;
> +		char *bad_ref = xstrfmt("refs/bisect/%s",
> +					      terms->term_bad);
> +		int retval = 0;
> +
> +		read_ref(bad_ref, sha1);
> +		commit = lookup_commit_reference(sha1);
> +		format_commit_message(commit, "%s", &commit_name, &pp);
> +		fp = fopen(git_path_bisect_log(), "a");
> +		if (!fp) {
> +			retval = -1;
> +			goto finish_10;
> +		}
> +		if (fprintf(fp, "# first %s commit: [%s] %s\n",
> +			    terms->term_bad, sha1_to_hex(sha1),
> +			    commit_name.buf) < 1){
> +			retval = -1;
> +			goto finish_10;
> +		}
> +		goto finish_10;
> +	finish_10:
> +		if (fp)
> +			fclose(fp);
> +		strbuf_release(&commit_name);
> +		free(bad_ref);
> +		return retval;
> +	}
> +	else if (res == 2) {
> +		FILE *fp = NULL;
> +		struct rev_info revs;
> +		struct argv_array rev_argv = ARGV_ARRAY_INIT;
> +		struct string_list good_revs = STRING_LIST_INIT_DUP;
> +		struct pretty_print_context pp = {0};
> +		struct commit *commit;
> +		char *term_good = xstrfmt("%s-*", terms->term_good);
> +		int i, retval = 0;
> +
> +		fp = fopen(git_path_bisect_log(), "a");
> +		if (!fp) {
> +			retval = -1;
> +			goto finish_2;
> +		}
> +		if (fprintf(fp, "# only skipped commits left to test\n") < 1) {
> +			retval = -1;
> +			goto finish_2;
> +		}
> +		for_each_glob_ref_in(register_good_ref, term_good,
> +				     "refs/bisect/", (void *) &good_revs);
> +
> +		argv_array_pushl(&rev_argv, "skipped_commits", "refs/bisect/bad", "--not", NULL);
> +		for (i = 0; i < good_revs.nr; i++)
> +			argv_array_push(&rev_argv, good_revs.items[i].string);
> +
> +		/* It is important to reset the flags used by revision walks
> +		 * as the previous call to bisect_next_all() in turn
> +		 * setups a revision walk.
> +		 */
> +		reset_revision_walk();
> +		init_revisions(&revs, NULL);
> +		rev_argv.argc = setup_revisions(rev_argv.argc, rev_argv.argv, &revs, NULL);
> +		argv_array_clear(&rev_argv);
> +		string_list_clear(&good_revs, 0);
> +		if (prepare_revision_walk(&revs))
> +			die(_("revision walk setup failed\n"));
> +
> +		while ((commit = get_revision(&revs)) != NULL) {
> +			struct strbuf commit_name = STRBUF_INIT;
> +			format_commit_message(commit, "%s",
> +					      &commit_name, &pp);
> +			fprintf(fp, "# possible first %s commit: "
> +				    "[%s] %s\n", terms->term_bad,
> +				    oid_to_hex(&commit->object.oid),
> +				    commit_name.buf);
> +			strbuf_release(&commit_name);
> +		}
> +		goto finish_2;
> +	finish_2:
> +		if (fp)
> +			fclose(fp);
> +		string_list_clear(&good_revs, 0);
> +		argv_array_clear(&rev_argv);
> +		free(term_good);
> +		if (retval)
> +			return retval;
> +		else
> +			return res;
> +	}
> +	return res;
> +}

It would be much nicer if you put the (res == 10) branch and the
(res == 2) branch into separate functions and just call them.
Then you also won't need ugly label naming like finish_10 or finish_2.
I'd also (again) recommend to use goto fail instead of setting retval to
-1 separately each time.

I'd also recommend to use a separate function to append to the bisect
log file. There is a lot of duplicated opening, checking, closing code;
IIRC such a function would also already be handy for some of the
previous patches.

> +
> +static int bisect_auto_next(struct bisect_terms *terms, const char *prefix)
> +{
> +	if (!bisect_next_check(terms, NULL))
> +		return bisect_next(terms, prefix);
> +
> +	return 0;
> +}

Hmm, the handling of the return values is a little confusing. However,
if I understand the sh source correctly, it always returns success, no
matter if bisect_next failed or not. I do not know if you had something
special in mind here.

>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
> @@ -643,6 +794,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  			 N_("print out the bisect terms"), BISECT_TERMS),
>  		OPT_CMDMODE(0, "bisect-start", &cmdmode,
>  			 N_("start the bisect session"), BISECT_START),
> +		OPT_CMDMODE(0, "bisect-next", &cmdmode,
> +			 N_("find the next bisection commit"), BISECT_NEXT),
> +		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
> +			 N_("verify the next bisection state then find the next bisection state"), BISECT_AUTO_NEXT),

The next bisection *state* is found?

> diff --git a/git-bisect.sh b/git-bisect.sh
> index f0896b3..d574c44 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -139,45 +119,7 @@ bisect_state() {
>  	*)
>  		usage ;;
>  	esac
> -	bisect_auto_next
[...deleted lines...]
> +	git bisect--helper --bisect-auto-next || exit

Why is the "|| exit" necessary?

> @@ -319,14 +260,15 @@ case "$#" in
>  	help)
>  		git bisect -h ;;
>  	start)
> -		bisect_start "$@" ;;
> +		git bisect--helper --bisect-start "$@" ;;
>  	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
>  		bisect_state "$cmd" "$@" ;;
>  	skip)
>  		bisect_skip "$@" ;;
>  	next)
>  		# Not sure we want "next" at the UI level anymore.
> -		bisect_next "$@" ;;
> +		get_terms
> +		git bisect--helper --bisect-next "$@" || exit ;;

Why is the "|| exit" necessary? ;)


Furthermore:
Where is the bisect_autostart call from bisect_next() sh source gone?
Was it not necessary?

~Stephan
