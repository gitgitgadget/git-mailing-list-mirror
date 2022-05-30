Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D75C433F5
	for <git@archiver.kernel.org>; Mon, 30 May 2022 16:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbiE3Qkt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 12:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbiE3Qkr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 12:40:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0975F8DD
        for <git@vger.kernel.org>; Mon, 30 May 2022 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653928832;
        bh=GYyek9LLrm4BcqSqZHph1bSeql8h+24IvahNyjJRLBI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GWrZ4H4uvIK0KGJX+UEAHF30CDmYHvZqYi1WjdQW4FdD03Jlh7IKCI8FkVzbzP54P
         YFW5DzSz1JjNtuSa6Twbtd53XtpuMYt5GWOhk+95bM0uqF/aa0tjYlTVH0okhwRSBw
         gsAQ7ljOL/eQApQ1oLnfmBOFwssdDMIXzIz2QFQQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([89.1.212.145]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9QC-1ncoa412Jg-00s7K7; Mon, 30
 May 2022 18:40:32 +0200
Date:   Mon, 30 May 2022 18:40:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3] revert: optionally refer to commit in the "reference"
 format
In-Reply-To: <xmqq8rqn7buk.fsf_-_@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205301837280.349@tvgsbejvaqbjf.bet>
References: <xmqqsfp2b30k.fsf@gitster.g> <nycvar.QRO.7.76.6.2205231507350.352@tvgsbejvaqbjf.bet> <xmqq35gzn9vk.fsf@gitster.g> <xmqq8rqn7buk.fsf_-_@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WXcyT6lncS0ZwfMGV8X/7HLH8ccBMItrOV8ffca7OCEXjlFuqPp
 ADJI8s02kWJYP0FBu3HldTytaX566yRJmC8a7NEYWeK8xv8CXh3D59b8xEB8VOkCUFzKY70
 zn/ONzarEedBgOg2BgqPI3UGcwdGbdMoNEqiFEpkYIK5bajAzASNlq1ymOcYVu0sqkWzuNb
 xZTWEJLB7exbk463a8S4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4mj25nSfuvo=:SUTkbHueHrBoDNAX6N3S6P
 qRqsaV6ojWl0lIRVKAhD2RqUCGGhJ+3P/gcIkCi0fa9qjJN9MF9wUzSKM6z5WWjQTjEykKiJ4
 fY3wnXu9BqCYTCB7gngQw7RnRIGLbhQceOXp1bz6yIAvGUsmcTx+JwbVhVngUAVgKVyQikOSj
 GBqYc7GDMqZAfySGJSN9pQXPXXlVfMn7ZxcztE4n9qIPQflLSLEdfCyrclifpbVz//ZG8nz2+
 9nzgjISu7NBWGJaynDrG38mcmtIKoLknRfwOrkJ7VxdGQ/dXfwofPq/BnId57hlORsJsbSLWW
 p29l4Oguu/0DyHPcglY2NnvAI9Jc+CU52zV40UXFoWJIwginnb/ASSARl4+AbMF2WKk1WI0g5
 A81HNKJdqhguwQRF0+y4U8qcqjClFRgXoY/dP9edrxVgWkkQwppuK7hrKegA9/XjePFxKuau8
 KRGZiwMX//MkeDvRofi3IQOGbpE+Av1WG8ahp3DBskqdydbKNJ4ZqjKalxTOUKHSEAJcfQXCy
 QddEGj4KNJoB0T0UdmhDF7jMeNtmcMopA/dTGDy+VJGJiOpMx09BXmA+E6AQXyyo1jrXiqCLE
 k6YUmj8oRpn5DAxGWl9DS/ZUCip8D9z9BexRjw1F2bcyJHZ7JOwN3rZw9fpIJ46dyGNcP1CUi
 SmnGhNDKDJUhwS0qCqafo9Jl2FtkwXMKEAOOrZVRvrdXEr9Bd1yxFUeKC3PuHvT0EeIsTUlzL
 Dmyw7QaXLOqLfptmVPh5J44yW/6/VKWLk4RKd4FeXe0O7iiijy4s2+11pztR4+MDY0HmBqjbh
 A/YMFykTRxg8YX4eSjm9nghCxcjuVwnsb0m325v56CQc1Sp1xtgJ1TcIwzJNonlRE+D0NWlcv
 tnKgVLzerFvzulEpTTX9M1lTu8JeRCnEccrl8t7xQ8rhSVqMElVI1Q9fOyVjxsTi+WeBjrdHM
 O/DDOjBvkidsm2lujrzcLKKrsqJMggHrPIWgDh44nlp2y8P6iXLLEafGqpVXEVljCFoBizg35
 5O43yMmUITx+V3gkDy9UKWffJO+tVsYrB9uj7WftBObLcFvVShk7kAsu7L8C3LRTV9Qv+Dvvo
 vYJAtiPGLNfasm8lx9NyxVmMKL6rmcPRzU6gLqzXmrYATMMa2O9Rm2bDQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 26 May 2022, Junio C Hamano wrote:

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
>
> Introduce the "--reference" option to "git revert", and also the
> revert.reference configuration variable, which defaults to false, to
> tweak the title and the first line of the draft commit message for
> when creating a "revert" commit.
>
> When this option is in use, the first line of the pre-filled editor
> buffer becomes a comment line that tells the user to say _why_.  If
> the user exits the editor without touching this line by mistake,
> what we prepare to become the first line of the body, i.e. "This
> reverts commit 8fa7f667 (do this and that, 2022-04-25)", ends up to
> be the title of the resulting commit.  This behaviour is designed to
> help such a user to identify such a revert in "git log --oneline"
> easily so that it can be further reworded with "git rebase -i" later.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * The only difference since the second one is that the first line of
>    the log message template is commented out and has asterisks to
>    draw more attention.  The last paragraph (new) in the proposed
>    log message explains the rationale behind this design.

While it may be more purist to try to force the user to provide a
description by having a non-comment placeholder there, from my experience
with PullRequest/Issue templates convinces me that the comment is the more
practical approach.

Looking good,
Dscho

>
>    Third-time a charm, hopefully.
>
> Range-diff against v2:
> 1:  4152fc2092 ! 1:  f4325a503a revert: optionally refer to commit in th=
e "reference" format
>     @@ Commit message
>          tweak the title and the first line of the draft commit message =
for
>          when creating a "revert" commit.
>
>     +    When this option is in use, the first line of the pre-filled ed=
itor
>     +    buffer becomes a comment line that tells the user to say _why_.=
  If
>     +    the user exits the editor without touching this line by mistake=
,
>     +    what we prepare to become the first line of the body, i.e. "Thi=
s
>     +    reverts commit 8fa7f667 (do this and that, 2022-04-25)", ends u=
p to
>     +    be the title of the resulting commit.  This behaviour is design=
ed to
>     +    help such a user to identify such a revert in "git log --onelin=
e"
>     +    easily so that it can be further reworded with "git rebase -i" =
later.
>     +
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
>       ## Documentation/config/revert.txt (new) ##
>     @@ sequencer.c: static int do_pick_commit(struct repository *r,
>      -		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
>      -		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
>      +		if (opts->commit_use_reference) {
>     -+			strbuf_addstr(&msgbuf, "DESCRIBE WHY WE ARE REVERTING HERE");
>     ++			strbuf_addstr(&msgbuf,
>     ++				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
>      +		} else {
>      +			strbuf_addstr(&msgbuf, "Revert \"");
>      +			strbuf_addstr(&msgbuf, msg.subject);
>
>  Documentation/config/revert.txt |  3 +++
>  Documentation/git-revert.txt    |  9 +++++++++
>  builtin/revert.c                |  2 ++
>  sequencer.c                     | 33 ++++++++++++++++++++++++++++-----
>  sequencer.h                     |  1 +
>  t/t3501-revert-cherry-pick.sh   | 31 +++++++++++++++++++++++++++++++
>  6 files changed, 74 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/config/revert.txt
>
> diff --git a/Documentation/config/revert.txt b/Documentation/config/reve=
rt.txt
> new file mode 100644
> index 0000000000..797bfb6d62
> --- /dev/null
> +++ b/Documentation/config/revert.txt
> @@ -0,0 +1,3 @@
> +revert.reference::
> +	Setting this variable to true makes `git revert` to behave
> +	as if the `--reference` option is given.
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
> index a5f678f452..96fec6ef6d 100644
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
> +	} else {
> +		strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
> +	}
> +}
> +
>  static int do_pick_commit(struct repository *r,
>  			  struct todo_item *item,
>  			  struct replay_opts *opts,
> @@ -2167,14 +2184,20 @@ static int do_pick_commit(struct repository *r,
>  		base_label =3D msg.label;
>  		next =3D parent;
>  		next_label =3D msg.parent_label;
> -		strbuf_addstr(&msgbuf, "Revert \"");
> -		strbuf_addstr(&msgbuf, msg.subject);
> -		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
> -		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
> +		if (opts->commit_use_reference) {
> +			strbuf_addstr(&msgbuf,
> +				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
> +		} else {
> +			strbuf_addstr(&msgbuf, "Revert \"");
> +			strbuf_addstr(&msgbuf, msg.subject);
> +			strbuf_addstr(&msgbuf, "\"");
> +		}
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
> index 8617efaaf1..a386ae9e88 100755
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
> +test_expect_success 'identification of reverted commit (default)' '
> +	test_commit to-ident &&
> +	test_when_finished "git reset --hard to-ident" &&
> +	git checkout --detach to-ident &&
> +	git revert --no-edit HEAD &&
> +	git cat-file commit HEAD >actual.raw &&
> +	grep "^This reverts " actual.raw >actual &&
> +	echo "This reverts commit $(git rev-parse HEAD^)." >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'identification of reverted commit (--reference)' '
> +	git checkout --detach to-ident &&
> +	git revert --reference --no-edit HEAD &&
> +	git cat-file commit HEAD >actual.raw &&
> +	grep "^This reverts " actual.raw >actual &&
> +	echo "This reverts commit $(git show -s --pretty=3Dreference HEAD^)." =
>expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'identification of reverted commit (revert.referenc=
e)' '
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
> 2.36.1-331-g1b5d92e060
>
>
