Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DDBC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiEWNZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiEWNZi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:25:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5077E3A70A
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653312322;
        bh=YAgiU3rW/92GMDVApFk9LG4ESqK8G6DEaE+HAwVG8jk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kf8P/0ubo98sWTSwV3Bfz6rWJ0Ox1+VJmMBppJc2WMsLSH3V8skO6X+qaRxG9X1mu
         OU7Kh1MKSdQzLy5TQDMnzF6Bml7pJHToJp+DoaIjHP/1WQ8oiyr9MfRlqBUMJbFlwP
         4wqVgy0bFF3hrepkMHjoDylJL/BRHJ0lx4+hZxSo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6qM-1nRWYQ2uvE-00lW61; Mon, 23
 May 2022 15:25:22 +0200
Date:   Mon, 23 May 2022 15:25:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] revert: optionally refer to commit in the "reference"
 format
In-Reply-To: <xmqqsfp2b30k.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205231507350.352@tvgsbejvaqbjf.bet>
References: <xmqqsfp2b30k.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Fg/SxiU9hCXSFLRotczDUFO49C5k7dbMp9t2OKCv/uXKwOx7p5z
 C9WzDdG8QOzmhADoWcfhrFfxIytihjmbyWQZd+SmCxtqYACaNc6iirrNewwI2LWlm/jppKH
 LBO7vXlwva38uMwZMkQtKQZLzCBFXLw4SXC9OKJVxD/v2GaL7zIC/lmxK2oRjDPZmV/Hmfe
 7NLgn3tby5aA3yPDvkknA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U2VFlHwiHWU=:raVB79AAxDSLaOL63JoXXS
 czF75GiVWQNgZ9wJ0tjol5T4myGCEyrfr3n+SSGKP13reE14jbhmljAOX4GgZuzBchELbIcAL
 CbcD7ieyWL+VQH7e1kzrzXjoUtLyuHcshcf77JCyqHEP83TXl/Uw5uoprRBdmR/DWCavFoQTl
 re3Ku9rGPJ0GyZlK2KInTZm78pgfT0YBh94Jvz3KGz4eruL+Vu0mw12BDg7Exsdw2zngdtilE
 PZtF/lk9GBDslZxcLFzVcDH0uG+ajHzE6tnFSNHK9TvIAdjGYjzxq7Z6R5qNp/RLpIfM1ei0C
 TS3uRxeoKoxr9A8M5t7RidY0dInbEfflUU05CAeN3Os69yPJNVJZN6DkRnU1VJIVTsiwhu0nQ
 Z41+knivxIHPe11OhuwwXRCPXydHxKIpwsEvpB5eFR9JtT/n6Zy2iZmyCsfPD7t1+ZQYZl9Ux
 CHale+gbaMfe6qyCAApuJEkBIEzPrKgfJMPtBPwfBrLn5O+EZRhS6mdoXnkgAksiPTEPXrFOl
 feGJwjEDkAxiTy2wVbQAtM3z6qWzplvMgM2MyusxiBhWMoXqqLfOr7yvQUFviwdakuceSfTYn
 CynOpBcb3yBgqcV3L5lf1LwKMBp0MvgTcc2g8lESlDAHyiVrfsyVT8/wkoQ2/lfoJZigrteGM
 m900spo2x59+ZZItnDmyiHrXx2CddE50pM7CRpcbSsNqnNTG4gHF/0dsMNuc6cD9mJ1GmI7Rw
 G48SltGJdm8SkE6at0IJhatFJYdSmSv5SdzdvJlDphLC+11YMb/kCwt+AUA8v4NmJGrNu9f9Z
 glGJ3BSHy9p3WIIKI6lYMXp+jKAIGQtTCxgqJITB5SkotmzL+Q54cDC62ZZgbqs/mV3RUuMYU
 MXdf+Fgh8q+uDqUOCJHoRt7TkM50N/0RzWixKGwkFW75P8CPVQLjVrQ1YGo+zh5JOkkTN7ROH
 qsH/zWhS4oEdJ5Q+FryLj1hpe7suSnhOi7OUFDEFU8NfaedNVgny8nmaqHbPvuWPYO5lRqa9j
 tfzeVeZOsZCnOdTxddRKUpk/UhPFsU6iXhRF3AOVDtUu5ejrYbPPE2thGD59xK6yYstADB0n2
 bM8jtaBN74ZF+++bVDMsgxk+gxtp1/WcdRFZmTAnM8HbwEOBnBXvWZp6w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 21 May 2022, Junio C Hamano wrote:

> A typical "git revert" commit uses the full title of the original
> commit in its title, and starts its body of the message with:
>
>     This reverts commit 8fa7f667cf61386257c00d6e954855cc3215ae91.
>
> This does not encourage the best practice of describing not just
> "what" (i.e. "Revert X" on the title says what we did) but "why"
> (i.e. and it does not say why X was undesirable).
>
> We can instead phrase this first line of the body to be more like
>
>     This reverts commit 8fa7f667 (do this and that, 2022-04-25)
>
> so that the title does not have to be
>
>     Revert "do this and that"
>
> We can instead use the title to describe "why" we are reverting the
> original commit.

Good idea, the `reference` text is so much more pleasant to read (and it
also makes things somewhat proof against rebasing and transitioning to
SHA-256).

> Introduce the "--reference" option to "git revert", and also the
> revert.reference configuration variable, which defaults to false, to
> tweak the title and the first line of the draft commit message for
> when creating a "revert" commit.

At some stage, we may even default to `revert.reference=3Dtrue`?

> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index bb92a4a451..8463fe9cf7 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -117,6 +117,15 @@ effect to your index in a row.
>  	Allow the rerere mechanism to update the index with the
>  	result of auto-conflict resolution if possible.
>
> +--reference::
> +	Instead of starting the body of the log message with "This
> +	reverts <full object name of the commit being reverted>.",
> +	refer to the commit using "--pretty=3Dreference" format
> +	(cf. linkgit:git-log[1]).  The `revert.reference`
> +	configuration variable can be used to enable this option by
> +	default.
> +
> +

Is that extra empty line intentional?

>  SEQUENCER SUBCOMMANDS
>  ---------------------
>  include::sequencer.txt[]
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 51776abea6..ada51e46b9 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -116,6 +116,8 @@ static int run_sequencer(int argc, const char **argv=
, struct replay_opts *opts)
>  			N_("option for merge strategy"), option_parse_x),
>  		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
>  		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> +		OPT_BOOL(0, "reference", &opts->commit_use_reference,
> +			 N_("use the 'reference' format to refer to commits")),
>  		OPT_END()
>  	};
>  	struct option *options =3D base_options;
> diff --git a/sequencer.c b/sequencer.c
> index a5f678f452..97abd5932b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -221,6 +221,9 @@ static int git_sequencer_config(const char *k, const=
 char *v, void *cb)
>  		return ret;
>  	}
>
> +	if (!strcmp(k, "revert.reference"))
> +		opts->commit_use_reference =3D git_config_bool(k, v);
> +
>  	status =3D git_gpg_config(k, v, NULL);
>  	if (status)
>  		return status;
> @@ -2059,6 +2062,20 @@ static int should_edit(struct replay_opts *opts) =
{
>  	return opts->edit;
>  }
>
> +static void refer_to_commit(struct replay_opts *opts,
> +			    struct strbuf *msgbuf, struct commit *commit)
> +{
> +	if (opts->commit_use_reference) {
> +		struct pretty_print_context ctx =3D {
> +			.abbrev =3D DEFAULT_ABBREV,
> +			.date_mode.type =3D DATE_SHORT,
> +		};
> +		format_commit_message(commit, "%h (%s, %ad)", msgbuf, &ctx);

It is somewhat sad that we have to semi-duplicate [*1*] this format here
and do not have something like an enum value we can use instead.

> +	} else {
> +		strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
> +	}
> +}
> +
>  static int do_pick_commit(struct repository *r,
>  			  struct todo_item *item,
>  			  struct replay_opts *opts,
> @@ -2167,14 +2184,19 @@ static int do_pick_commit(struct repository *r,
>  		base_label =3D msg.label;
>  		next =3D parent;
>  		next_label =3D msg.parent_label;
> -		strbuf_addstr(&msgbuf, "Revert \"");
> -		strbuf_addstr(&msgbuf, msg.subject);
> -		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
> -		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
> +		if (!opts->commit_use_reference) {
> +			strbuf_addstr(&msgbuf, "Revert \"");
> +			strbuf_addstr(&msgbuf, msg.subject);
> +			strbuf_addstr(&msgbuf, "\"");
> +		} else {
> +			strbuf_addstr(&msgbuf, "DESCRIBE WHY WE ARE REVERTING HERE");
> +		}

We often tell newcomers that we prefer the shorter conditional block to
come first. Maybe you want to do that here, too? I don't mind the current
form, though.

> +		strbuf_addstr(&msgbuf, "\n\nThis reverts commit ");
> +		refer_to_commit(opts, &msgbuf, commit);
>
>  		if (commit->parents && commit->parents->next) {
>  			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
> -			strbuf_addstr(&msgbuf, oid_to_hex(&parent->object.oid));
> +			refer_to_commit(opts, &msgbuf, parent);
>  		}
>  		strbuf_addstr(&msgbuf, ".\n");
>  	} else {
> diff --git a/sequencer.h b/sequencer.h
> index da64473636..698599fe4e 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -49,6 +49,7 @@ struct replay_opts {
>  	int reschedule_failed_exec;
>  	int committer_date_is_author_date;
>  	int ignore_date;
> +	int commit_use_reference;
>
>  	int mainline;
>
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.=
sh
> index 8617efaaf1..36f9565b92 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -159,6 +159,7 @@ test_expect_success 'cherry-pick works with dirty re=
named file' '
>  '
>
>  test_expect_success 'advice from failed revert' '
> +	test_when_finished "git reset --hard" &&
>  	test_commit --no-tag "add dream" dream dream &&
>  	dream_oid=3D$(git rev-parse --short HEAD) &&
>  	cat <<-EOF >expected &&
> @@ -174,4 +175,34 @@ test_expect_success 'advice from failed revert' '
>  	test_must_fail git revert HEAD^ 2>actual &&
>  	test_cmp expected actual
>  '
> +
> +test_expect_success 'identification of reverted commit (vanilla)' '

It might make sense to replace "vanilla" by "default format".

> +	test_commit to-ident &&
> +	test_when_finished "git reset --hard to-ident" &&
> +	git checkout --detach to-ident &&
> +	git revert --no-edit HEAD &&
> +	git cat-file commit HEAD >actual.raw &&
> +	grep "^This reverts " actual.raw >actual &&
> +	echo "This reverts commit $(git rev-parse HEAD^)." >expect &&

I was a bit puzzled about this dance, as I had expected this instead:

	grep "^This reverts commit $(git rev-parse HEAD^)\\.$" actual.raw

but I guess you wanted to make sure that the file contents of `actual` are
shown if no match was found?

If that was the intention, we may want to add a test helper that I know
from other test frameworks, something like `test_contains` that takes a
regex and a file and prints out the full contents if no match was found.

It's obviously not necessary to add this test helper in this patch series
of a single patch ("separation of concerns"), just food for thought.

> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'identification of reverted commit (reference)' '
> +	git checkout --detach to-ident &&
> +	git revert --reference --no-edit HEAD &&
> +	git cat-file commit HEAD >actual.raw &&
> +	grep "^This reverts " actual.raw >actual &&
> +	echo "This reverts commit $(git show -s --pretty=3Dreference HEAD^)." =
>expect &&
> +	test_cmp expect actual
> +'

If it was up to me, I would combine these three test cases, if only to
help the `--run=3D<single-number>` case (the latter two depend on the side
effect of the first one to create a `to-ident` tag).

> +
> +test_expect_success 'identification of reverted commit (reference)' '
> +	git checkout --detach to-ident &&
> +	git -c revert.reference=3Dtrue revert --no-edit HEAD &&
> +	git cat-file commit HEAD >actual.raw &&
> +	grep "^This reverts " actual.raw >actual &&
> +	echo "This reverts commit $(git show -s --pretty=3Dreference HEAD^)." =
>expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.36.1-298-g81715a4e6d

Looks good, I have no objections against merging this as-is.

Ciao,
Dscho

Footnote *1*: https://github.com/git/git/blob/v2.36.1/pretty.c#L103-L104
also has the `%C(auto)` prefix, which we obviously do not need here.
