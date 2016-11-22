Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5F2D1F4CF
	for <e@80x24.org>; Tue, 22 Nov 2016 00:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbcKVAM3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 19:12:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:64868 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbcKVAM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 19:12:28 -0500
Received: from [192.168.178.43] ([92.76.234.104]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIu7d-1cAtRA0JiL-002Ubq; Tue, 22
 Nov 2016 01:12:25 +0100
Subject: Re: [PATCH v15 19/27] bisect--helper: `bisect_state` & `bisect_head`
 shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1b54-0ac61448-98b1-4c7d-bfdd-47af95f52153-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <0cc22155-2b3f-b69c-9ed4-2b1c55e40eee@gmx.net>
Date:   Tue, 22 Nov 2016 01:12:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1b54-0ac61448-98b1-4c7d-bfdd-47af95f52153-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:9HnuG7T8E4G8ycT9TStINfvQMr0XmQYW8Q+pneyOb6D+qjO99TE
 FN+uS8G6J27TUzDxfQmd57xSPfuL47x8cOhDd9GkN0wbxKasoNolgsqN5H4OyW+UDK2Ou7J
 wH6+L+8MGAuxIUwHn8VrJG65gBvwttxLK+mBJunblxF0tlMaHApmBdrr0tBMfCVFbyiEaGU
 4fEVUBZXAPg5j2LKgzXIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u6uJudVXtok=:69EFDixmrhL8X/8ahVadKt
 M+ANwa3xCWwRuX8Q6rQIF7Yy3u+lcSzj95Hoab7MgwuCft+nQzMqkV9Gd+iUoGAbIaX/6fH54
 DAMXhlMWenKO9ZrkTy0kRTME8GF40VlfCrk/7T7dgYTGrZIfS2K6h5QjcfkmLSg9BpLj8O8XN
 AXnLoTTL2lHX5Cp1cj3OauwQ70i6IMBXDrZTuvmmtHsOPFWQxUpdtEl+JMm0R/BT7uZyiOqnu
 MSFu9oxXql51hXBfumTLy1VVVKnp9HpUgRX5gDTpdupeg70iROJsIok8lC+zEY6glj4YBvwNz
 3kMR700Y8GRcD3VKNA98dVJe+PB0P/Ld7jKJQlk1C6dJ/MtY9NVPMpmIPt+Y94T10xmusXtao
 9rgTzRUZxrXtyHB0meGEUt+WbhjJ/2EjNtuys/dT0KAFntqKMtGLjAaczEpT3LBGy67YyJ8S8
 eUWiXI4Y/g9+3QH6/czTc9r2pBhl1i7w39ZMyrWth5Rl9madF0SUnhDbEzyFcrq8pJA0pF2As
 3hmh97NljidSCC7jAzeDy5I/o0aP7o5gBH6ibi1hem0qnjnyfhNis8yaCCrx9qFVV4RU4fP7D
 gHG6MD2AID3uUdt6Fo1Yebll2+Ur2oFuk9+m/I94tAC0hzJQyDZ4Aq84polF01Q64RTc6LcYt
 Es5ZNzaNp3BWlPQXogKpqkE21L/dOdk6f6asEqAcenm+BLyrzYWoj/EyRrdfjQdq7nsf/E3Bx
 DJaiJTAbVbq4VrgnPQSZj2U9qXPdt7CGmg7uer1SyOLvwvEBphNxC8tcF7DAm8ieMwULfGbfZ
 5HIwha+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> Reimplement the `bisect_state` shell function in C and also add a
> subcommand `--bisect-state` to `git-bisect--helper` to call it from
> git-bisect.sh .
> 
> Using `--bisect-state` subcommand is a temporary measure to port shell
> function to C so as to use the existing test suite. As more functions
> are ported, this subcommand will be retired and will be called by some
> other methods.
> 
> `bisect_head` is called from `bisect_state` thus its not required to
> introduce another subcommand.

Missing comma before "thus", and "it is" (or "it's") instead of "its" :)

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1767916..1481c6d 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -784,6 +786,79 @@ static int bisect_autostart(struct bisect_terms *terms)
>  	return 0;
>  }
>  
> +static char *bisect_head(void)
> +{
> +	if (is_empty_or_missing_file(git_path_bisect_head()))
> +		return "HEAD";
> +	else
> +		return "BISECT_HEAD";
> +}

This is very shellish.
In C I'd expect something like

static int bisect_head_sha1(unsigned char *sha)
{
	int res;
	if (is_empty_or_missing_file(git_path_bisect_head()))
		res = get_sha1("HEAD", sha);
	else
		res = get_sha1("BISECT_HEAD", sha);

	if (res)
		return error(_("Could not find BISECT_HEAD or HEAD."));

	return 0;
}

> +
> +static int bisect_state(struct bisect_terms *terms, const char **argv,
> +			int argc)
> +{
> +	const char *state = argv[0];
> +
> +	get_terms(terms);
> +	if (check_and_set_terms(terms, state))
> +		return -1;
> +
> +	if (!argc)
> +		die(_("Please call `--bisect-state` with at least one argument"));

I think this check should move to cmd_bisect__helper. There are also the
other argument number checks.

> +
> +	if (argc == 1 && one_of(state, terms->term_good,
> +	    terms->term_bad, "skip", NULL)) {
> +		const char *bisected_head = xstrdup(bisect_head());
> +		const char *hex[1];

Maybe:
		const char *hex;

> +		unsigned char sha1[20];
> +
> +		if (get_sha1(bisected_head, sha1))
> +			die(_("Bad rev input: %s"), bisected_head);

And instead of...

> +		if (bisect_write(state, sha1_to_hex(sha1), terms, 0))
> +			return -1;
> +
> +		*hex = xstrdup(sha1_to_hex(sha1));
> +		if (check_expected_revs(hex, 1))
> +			return -1;

... simply:

		hex = xstrdup(sha1_to_hex(sha1));
		if (set_state(terms, state, hex)) {
			free(hex);
			return -1;
		}
		free(hex);

where:

static int set_state(struct bisect_terms *terms, const char *state,
                                                 const char *hex)
{
	if (bisect_write(state, hex, terms, 0))
		return -1;
	if (check_expected_revs(&hex, 1))
		return -1;
	return 0;
}

> +		return bisect_auto_next(terms, NULL);
> +	}
> +
> +	if ((argc == 2 && !strcmp(state, terms->term_bad)) ||
> +			one_of(state, terms->term_good, "skip", NULL)) {
> +		int i;
> +		struct string_list hex = STRING_LIST_INIT_DUP;
> +
> +		for (i = 1; i < argc; i++) {
> +			unsigned char sha1[20];
> +
> +			if (get_sha1(argv[i], sha1)) {
> +				string_list_clear(&hex, 0);
> +				die(_("Bad rev input: %s"), argv[i]);
> +			}
> +			string_list_append(&hex, sha1_to_hex(sha1));
> +		}
> +		for (i = 0; i < hex.nr; i++) {

... And replace this:

> +			const char **hex_string = (const char **) &hex.items[i].string;
> +			if(bisect_write(state, *hex_string, terms, 0)) {
> +				string_list_clear(&hex, 0);
> +				return -1;
> +			}
> +			if (check_expected_revs(hex_string, 1)) {
> +				string_list_clear(&hex, 0);
> +				return -1;
> +			}

by:

			const char *hex_str = hex.items[i].string;
			if (set_state(terms, state, hex_string)) {
				string_list_clear(&hex, 0);
				return -1;
			}

> +		}
> +		string_list_clear(&hex, 0);
> +		return bisect_auto_next(terms, NULL);
> +	}
> +
> +	if (!strcmp(state, terms->term_bad))
> +		die(_("'git bisect %s' can take only one argument."),
> +		      terms->term_bad);
> +
> +	return -1;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -823,6 +899,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  			 N_("verify the next bisection state then find the next bisection state"), BISECT_AUTO_NEXT),
>  		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
>  			 N_("start the bisection if BISECT_START empty or missing"), BISECT_AUTOSTART),
> +		OPT_CMDMODE(0, "bisect-state", &cmdmode,
> +			 N_("mark the state of ref (or refs)"), BISECT_STATE),

"mark the state of the given revs"

Note that rev != ref

> @@ -902,6 +980,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		terms.term_bad = "bad";
>  		res = bisect_autostart(&terms);
>  		break;
> +	case BISECT_STATE:
> +		if (argc == 0)
> +			die(_("--bisect-state requires at least 1 argument"));

"at least one revision"

> diff --git a/git-bisect.sh b/git-bisect.sh
> index cd56551..a9eebbb 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -61,44 +51,7 @@ bisect_skip() {
>  		esac
>  		all="$all $revs"
>  	done
> -	eval bisect_state 'skip' $all
[...deleted lines...]
> +	eval git bisect--helper --bisect-state 'skip' $all

I think you don't need "eval" here any longer.

> @@ -184,8 +137,8 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
>  			state="$TERM_GOOD"
>  		fi
>  
> -		# We have to use a subshell because "bisect_state" can exit.
> -		( bisect_state $state >"$GIT_DIR/BISECT_RUN" )
> +		# We have to use a subshell because "--bisect-state" can exit.
> +		( git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN" )

The new comment is funny, but you don't need a subshell here any longer.

~Stephan
