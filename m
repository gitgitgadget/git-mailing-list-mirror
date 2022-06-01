Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7868C43334
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 16:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348503AbiFAQvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 12:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353904AbiFAQug (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 12:50:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AB8A204B
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654102201;
        bh=3/TORt9+atFbUBFOWLxCtlfKrsrZXPDt9VQVnrhLqDs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dATBnWiJCQIH000d6snSWOCldXT3jHYUIVBqW0oBwZVzybxvwAzfxrmRL3tdKaFEJ
         fKw9CONtZBSkhFZVetZjDkmhAZfFf1HxhQkpw67ok+ZlljAsW/aU26mq3bYCQXxVfc
         MIkssL0cMi+2Ul3Id7iSHalCujiTiCXFbKysDxO8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([89.1.212.145]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXpQ-1oMwdl1cS8-00QVyM; Wed, 01
 Jun 2022 18:50:01 +0200
Date:   Wed, 1 Jun 2022 18:49:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 1/2] run-command: add an "ungroup" option to
 run_process_parallel()
In-Reply-To: <patch-v4-1.2-f1170b02553-20220531T173005Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206011630400.349@tvgsbejvaqbjf.bet>
References: <cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com> <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com> <patch-v4-1.2-f1170b02553-20220531T173005Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-578515744-1654100731=:349"
Content-ID: <nycvar.QRO.7.76.6.2206011837220.349@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:ETuZJzELjrgvwUL102nF9fcs9NytW3j8sh5LZTeNl4qKEVWF79P
 qrs3kngdVpyMQwnV9yweNQ49RlTIFDInPkHwXSZbdRyZAYxv1F4yEtvmhvq99OgifzjRc4K
 Y+i6hSuAA3m3jWbPqm+hwiV5BED+WXbMX5YIY3nwq5BeSZwSh7lnhB+0shLShUiBUmrMDTK
 rmEAhvATv42VMtd+U621Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:um8KJOk6wMc=:2Wbl1P82CKOLZkMiJlhcBP
 /FdNPtJehPIT/Mz15QJfYhTIEDYeC80AansTxiLIT5sP2WqFUprte5OjiSIfEb3IdWHvIV/aR
 Rr4FarPt4lOozecbcbS9xyK8sMasDoxE7O1FFN8qcrnu99EKhoWUj9oXiXnXTDVGIo3D54L3K
 DwGadEhLfi8+xWtJWYQps4eYgGbbT+ewDqp2JWVWMGGbHiXHVX7e+SxZjfeQZ1ziqsF7uMv6q
 8NJbQ1DZFbVQf+/b5rOkAA0liV5jLcssofUUEzgHTOkBhHWnshg0tjpUv8ckKx3iabzHAVE0C
 Ktz0yVTVYtt3KLsQ/pFr7fyLovJtaiahz3v1gyWx7j+yoeo3qWk84cnmuE0SbwnSJmhXGaIi3
 WbhvAtAtoGUP3G1ZdyGIj8DB/akFA119BEEbO5SQU+Cu0ubfvhPWb3DgfK+fTg77Jh8IZQn11
 FRBLJLzstMB4hNlLAuz51Zc3hVTTW8ULQb9RfbWA+f1fpHLD8Q+PQISUd2LzToPB8H2FbKxpG
 nTSW2EbheXdSs3dlI6JFihpZOIrJC9/Ku/RC69r7W6FtDztSlvwJCciSqxEbb2VHtErmV3ats
 L+zGSdELnEdInGcamZDjyV+gh6TGMUfG1VvSqIfLkk5X8VA3JRW9KAx4Z85wJLhQmDwzb6Lf7
 dxgCPZseumwTIRQM5yT6Itb8d6gfW8JCy1qCQ1rnE/K/4rBFVOsTN4OPAIlNZp02yh10OQVOd
 W7XEPATibu57Ih8eEIPhQhN5nHQautkUYxxy6cbKnUxGBr7B1hR+zF67zltZFYxMrBNia2rrE
 ehve35HiYcWTWIHnPbO/x3S/w7QrsOo9nkLeWzCgWOaz97zYKSH5a9zztT+OaCytuKOEFf5sK
 kJFKWvX8Z/M1UCpQGo4xyvF2IYTc8fjOekZBKRnD7lXBcYqYj+hygcAA6+bKkd/xrXInPXTka
 chAG118qpPMbGrlx9jBoW0o4x/peHS80VKxXDLDOFYQCCP7rDbK8pQGV5EguX9PoeYj9wEz97
 WHHAP6q3P6/kdPTPSrVBNeqL//+J3je4kYAfOGRcfnHfybbxX4/DY2rEPMqFZox+Szted7KP4
 VSD8yvTjMeo9QBfxvgOauXItUA9QpxFXmoIZQ2Oq7n473xCtkaE4uEh8w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-578515744-1654100731=:349
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2206011837221.349@tvgsbejvaqbjf.bet>

Hi =C3=86var,

what you work on here is important. Git v2.36.0 unfortunately had a couple
of bugs that were quickly discovered, and this here regression is the one
of them. The other known ones had been fixed after a little more than two
weeks, but another four weeks later, this regression still awaits fixing.

On Tue, 31 May 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Extend the parallel execution API added in c553c72eed6 (run-command:
> add an asynchronous parallel child processor, 2015-12-15) to support a
> mode where the stdout and stderr of the processes isn't captured and
> output in a deterministic order, instead we'll leave it to the kernel
> and stdio to sort it out.

It might be worth picking a better name than "ungroup". Maybe something
like "interleaved_output".

>
> This gives the API same functionality as GNU parallel's --ungroup
> option. As we'll see in a subsequent commit the main reason to want
> this is to support stdout and stderr being connected to the TTY in the
> case of jobs=3D1, demonstrated here with GNU parallel:
>
> 	$ parallel --ungroup 'test -t {} && echo TTY || echo NTTY' ::: 1 2
> 	TTY
> 	TTY
> 	$ parallel 'test -t {} && echo TTY || echo NTTY' ::: 1 2
> 	NTTY
> 	NTTY
>
> Another is as GNU parallel's documentation notes a potential for
> optimization. Our results will be a bit different, but in cases where
> you want to run processes in parallel where the exact order isn't
> important this can be a lot faster:
>
> 	$ hyperfine -r 3 -L o ,--ungroup 'parallel {o} seq ::: 10000000 >/dev/n=
ull '
> 	Benchmark 1: parallel  seq ::: 10000000 >/dev/null
> 	  Time (mean =C2=B1 =CF=83):     220.2 ms =C2=B1   9.3 ms    [User: 124=
.9 ms, System: 96.1 ms]
> 	  Range (min =E2=80=A6 max):   212.3 ms =E2=80=A6 230.5 ms    3 runs
>
> 	Benchmark 2: parallel --ungroup seq ::: 10000000 >/dev/null
> 	  Time (mean =C2=B1 =CF=83):     154.7 ms =C2=B1   0.9 ms    [User: 136=
.2 ms, System: 25.1 ms]
> 	  Range (min =E2=80=A6 max):   153.9 ms =E2=80=A6 155.7 ms    3 runs
>
> 	Summary
> 	  'parallel --ungroup seq ::: 10000000 >/dev/null ' ran
> 	    1.42 =C2=B1 0.06 times faster than 'parallel  seq ::: 10000000 >/de=
v/null '

This commit message talks a lot about GNU parallel.

It would make more sense to measure Git with that new mode, though, and
talk about that instead.

>
> A large part of the juggling in the API is to make the API safer for
> its maintenance and consumers alike.
>
> For the maintenance of the API we e.g. avoid malloc()-ing the
> "pp->pfd", ensuring that SANITIZE=3Daddress and other similar tools will
> catch any unexpected misuse.
>
> For API consumers we take pains to never pass the non-NULL "out"
> buffer to an API user that provided the "ungroup" option. The
> resulting code in t/helper/test-run-command.c isn't typical of such a
> user, i.e. they'd typically use one mode or the other, and would know
> whether they'd provided "ungroup" or not.
>
> We could also avoid the strbuf_init() for "buffered_output" by having
> "struct parallel_processes" use a static PARALLEL_PROCESSES_INIT
> initializer, but let's leave that cleanup for later.
>
> Using a global "run_processes_parallel_ungroup" variable to enable
> this option is rather nasty, but is being done here to produce as
> minimal of a change as possible for a subsequent regression fix. This
> change is extracted from a larger initial version[1] which ends up
> with a better end-state for the API, but in doing so needed to modify
> all existing callers of the API. Let's defer that for now, and
> narrowly focus on what we need for fixing the regression in the
> subsequent commit.
>
> It's safe to do this with a global variable because:
>
>  A) hook.c is the only user of it that sets it to non-zero, and before
>     we'll get any other API users we'll refactor away this method of
>     passing in the option, i.e. re-roll [1].
>
>  B) Even if hook.c wasn't the only user we don't have callers of this
>     API that concurrently invoke this parallel process starting API
>     itself in parallel.
>
> As noted above "A" && "B" are rather nasty, and we don't want to live
> with those caveats long-term, but for now they should be an acceptable
> compromise.
>
> 1. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20220518T195858Z=
-avarab@gmail.com/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  run-command.c               | 83 +++++++++++++++++++++++++++++--------
>  run-command.h               | 30 ++++++++++----
>  t/helper/test-run-command.c | 19 +++++++--
>  t/t0061-run-command.sh      | 35 ++++++++++++++++
>  4 files changed, 139 insertions(+), 28 deletions(-)

This is an uncomfortably large diffstat for a patch series that is
supposed to fix a regression. That makes it harder than necessary to
review, and hence unnecessarily blocks v2.36.2 (at least it was my
expectation that we would release that version relatively quickly, as the
regression fix already missed the v2.36.1 boat).

>
> diff --git a/run-command.c b/run-command.c
> index a8501e38ceb..324e9548469 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1471,6 +1471,7 @@ enum child_state {
>  	GIT_CP_WAIT_CLEANUP,
>  };
>
> +int run_processes_parallel_ungroup;

This global variable seems to exist solely to avoid extending the
signature of `run_processes_parallel_tr2()`. Let's not do that.

>  struct parallel_processes {
>  	void *data;
>
> @@ -1494,6 +1495,7 @@ struct parallel_processes {
>  	struct pollfd *pfd;
>
>  	unsigned shutdown : 1;
> +	unsigned ungroup : 1;
>
>  	int output_owner;
>  	struct strbuf buffered_output; /* of finished children */
> @@ -1537,7 +1539,7 @@ static void pp_init(struct parallel_processes *pp,
>  		    get_next_task_fn get_next_task,
>  		    start_failure_fn start_failure,
>  		    task_finished_fn task_finished,
> -		    void *data)
> +		    void *data, const int ungroup)
>  {
>  	int i;
>
> @@ -1559,13 +1561,19 @@ static void pp_init(struct parallel_processes *p=
p,
>  	pp->nr_processes =3D 0;
>  	pp->output_owner =3D 0;
>  	pp->shutdown =3D 0;
> +	pp->ungroup =3D ungroup;
>  	CALLOC_ARRAY(pp->children, n);
> -	CALLOC_ARRAY(pp->pfd, n);
> +	if (pp->ungroup)
> +		pp->pfd =3D NULL;
> +	else
> +		CALLOC_ARRAY(pp->pfd, n);
>  	strbuf_init(&pp->buffered_output, 0);
>
>  	for (i =3D 0; i < n; i++) {
>  		strbuf_init(&pp->children[i].err, 0);
>  		child_process_init(&pp->children[i].process);
> +		if (!pp->pfd)

It would be more logical to test for `pp->ungroup` than for `!pp->pfd`.
In other instances below, the patch uses `if (ungroup)` instead. Let's not
flip-flop between those two conditions, but the latter consistently.

> +			continue;

This avoids indenting the following two lines, at the price of
readability. The code would be more obvious if it made those two lines
contingent upon `!pp->ungroup`.

>  		pp->pfd[i].events =3D POLLIN | POLLHUP;
>  		pp->pfd[i].fd =3D -1;
>  	}
> @@ -1606,6 +1614,7 @@ static void pp_cleanup(struct parallel_processes *=
pp)
>   */
>  static int pp_start_one(struct parallel_processes *pp)
>  {
> +	const int ungroup =3D pp->ungroup;

It costs readers a couple of moments when they stumble over code that is
inconsistent with the existing code. In this instance, I find very little
value in the `const` qualifier. Actually, this entire line is probably not
worth having because `pp->ungroup` is just 4 characters longer than
`ungroup`.

This same comment applies to another hunk below, too.

Things like this do take focus away from reviewing the interesting part of
the contribution, which in particular in the case of a regression fix that
many are waiting for is something to avoid.

>  	int i, code;
>
>  	for (i =3D 0; i < pp->max_processes; i++)
> @@ -1615,24 +1624,30 @@ static int pp_start_one(struct parallel_processe=
s *pp)
>  		BUG("bookkeeping is hard");
>
>  	code =3D pp->get_next_task(&pp->children[i].process,
> -				 &pp->children[i].err,
> +				 ungroup ? NULL : &pp->children[i].err,
>  				 pp->data,
>  				 &pp->children[i].data);
>  	if (!code) {
> -		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> -		strbuf_reset(&pp->children[i].err);
> +		if (!ungroup) {
> +			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> +			strbuf_reset(&pp->children[i].err);
> +		}

In contrast to the change in `pp_init()`, this hunk is good, because it
makes the intention and implementation quite clear.

>  		return 1;
>  	}
> -	pp->children[i].process.err =3D -1;
> -	pp->children[i].process.stdout_to_stderr =3D 1;
> +	if (!ungroup) {
> +		pp->children[i].process.err =3D -1;
> +		pp->children[i].process.stdout_to_stderr =3D 1;
> +	}
>  	pp->children[i].process.no_stdin =3D 1;
>
>  	if (start_command(&pp->children[i].process)) {
> -		code =3D pp->start_failure(&pp->children[i].err,
> +		code =3D pp->start_failure(ungroup ? NULL : &pp->children[i].err,
>  					 pp->data,
>  					 pp->children[i].data);
> -		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> -		strbuf_reset(&pp->children[i].err);
> +		if (!ungroup) {
> +			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> +			strbuf_reset(&pp->children[i].err);
> +		}
>  		if (code)
>  			pp->shutdown =3D 1;
>  		return code;
> @@ -1640,14 +1655,29 @@ static int pp_start_one(struct parallel_processe=
s *pp)
>
>  	pp->nr_processes++;
>  	pp->children[i].state =3D GIT_CP_WORKING;
> -	pp->pfd[i].fd =3D pp->children[i].process.err;
> +	if (pp->pfd)
> +		pp->pfd[i].fd =3D pp->children[i].process.err;

Here, the patch uses `pp->pfd` instead of `pp->ungroup` again. It should
use only one of them for the many conditions that are added, not
flip-flop between them.

>  	return 0;
>  }
>
> +static void pp_mark_ungrouped_for_cleanup(struct parallel_processes *pp=
)
> +{
> +	int i;
> +
> +	if (!pp->ungroup)
> +		BUG("only reachable if 'ungrouped'");
> +
> +	for (i =3D 0; i < pp->max_processes; i++)
> +		pp->children[i].state =3D GIT_CP_WAIT_CLEANUP;
> +}

This function has but a single caller. It would improve readability to
insert the loop directly instead.

> +
>  static void pp_buffer_stderr(struct parallel_processes *pp, int output_=
timeout)
>  {
>  	int i;
>
> +	if (pp->ungroup)
> +		BUG("unreachable with 'ungrouped'");

Better: `BUG("pp_buffer_stderr() called in ungrouped mode")`

A similar issue exists in the next hunk.

> +
>  	while ((i =3D poll(pp->pfd, pp->max_processes, output_timeout)) < 0) {
>  		if (errno =3D=3D EINTR)
>  			continue;
> @@ -1674,6 +1704,10 @@ static void pp_buffer_stderr(struct parallel_proc=
esses *pp, int output_timeout)
>  static void pp_output(struct parallel_processes *pp)
>  {
>  	int i =3D pp->output_owner;
> +
> +	if (pp->ungroup)
> +		BUG("unreachable with 'ungrouped'");
> +
>  	if (pp->children[i].state =3D=3D GIT_CP_WORKING &&
>  	    pp->children[i].err.len) {
>  		strbuf_write(&pp->children[i].err, stderr);
> @@ -1683,6 +1717,7 @@ static void pp_output(struct parallel_processes *p=
p)
>
>  static int pp_collect_finished(struct parallel_processes *pp)
>  {
> +	const int ungroup =3D pp->ungroup;
>  	int i, code;
>  	int n =3D pp->max_processes;
>  	int result =3D 0;
> @@ -1697,8 +1732,8 @@ static int pp_collect_finished(struct parallel_pro=
cesses *pp)
>  		code =3D finish_command(&pp->children[i].process);
>
>  		code =3D pp->task_finished(code,
> -					 &pp->children[i].err, pp->data,
> -					 pp->children[i].data);
> +					 ungroup ? NULL : &pp->children[i].err,
> +					 pp->data, pp->children[i].data);
>
>  		if (code)
>  			result =3D code;
> @@ -1707,10 +1742,13 @@ static int pp_collect_finished(struct parallel_p=
rocesses *pp)
>
>  		pp->nr_processes--;
>  		pp->children[i].state =3D GIT_CP_FREE;
> -		pp->pfd[i].fd =3D -1;
> +		if (pp->pfd)
> +			pp->pfd[i].fd =3D -1;
>  		child_process_init(&pp->children[i].process);
>
> -		if (i !=3D pp->output_owner) {
> +		if (ungroup) {
> +			; /* no strbuf_*() work to do here */
> +		} else if (i !=3D pp->output_owner) {
>  			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
>  			strbuf_reset(&pp->children[i].err);
>  		} else {
> @@ -1748,8 +1786,13 @@ int run_processes_parallel(int n,
>  	int output_timeout =3D 100;
>  	int spawn_cap =3D 4;
>  	struct parallel_processes pp;
> +	const int ungroup =3D run_processes_parallel_ungroup;
>
> -	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb);
> +	/* unset for the next API user */
> +	run_processes_parallel_ungroup =3D 0;
> +
> +	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
> +		ungroup);
>  	while (1) {
>  		for (i =3D 0;
>  		    i < spawn_cap && !pp.shutdown &&
> @@ -1766,8 +1809,12 @@ int run_processes_parallel(int n,
>  		}
>  		if (!pp.nr_processes)
>  			break;
> -		pp_buffer_stderr(&pp, output_timeout);
> -		pp_output(&pp);
> +		if (ungroup) {
> +			pp_mark_ungrouped_for_cleanup(&pp);
> +		} else {
> +			pp_buffer_stderr(&pp, output_timeout);
> +			pp_output(&pp);
> +		}
>  		code =3D pp_collect_finished(&pp);
>  		if (code) {
>  			pp.shutdown =3D 1;
> diff --git a/run-command.h b/run-command.h
> index 5bd0c933e80..bf4236f1164 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -405,6 +405,9 @@ void check_pipe(int err);
>   * pp_cb is the callback cookie as passed to run_processes_parallel.
>   * You can store a child process specific callback cookie in pp_task_cb=
.
>   *
> + * See run_processes_parallel() below for a discussion of the "struct
> + * strbuf *out" parameter.
> + *
>   * Even after returning 0 to indicate that there are no more processes,
>   * this function will be called again until there are no more running
>   * child processes.
> @@ -423,9 +426,8 @@ typedef int (*get_next_task_fn)(struct child_process=
 *cp,
>   * This callback is called whenever there are problems starting
>   * a new process.
>   *
> - * You must not write to stdout or stderr in this function. Add your
> - * message to the strbuf out instead, which will be printed without
> - * messing up the output of the other parallel processes.
> + * See run_processes_parallel() below for a discussion of the "struct
> + * strbuf *out" parameter.
>   *
>   * pp_cb is the callback cookie as passed into run_processes_parallel,
>   * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> @@ -441,9 +443,8 @@ typedef int (*start_failure_fn)(struct strbuf *out,
>  /**
>   * This callback is called on every child process that finished process=
ing.
>   *
> - * You must not write to stdout or stderr in this function. Add your
> - * message to the strbuf out instead, which will be printed without
> - * messing up the output of the other parallel processes.
> + * See run_processes_parallel() below for a discussion of the "struct
> + * strbuf *out" parameter.
>   *
>   * pp_cb is the callback cookie as passed into run_processes_parallel,
>   * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> @@ -464,11 +465,26 @@ typedef int (*task_finished_fn)(int result,
>   *
>   * The children started via this function run in parallel. Their output
>   * (both stdout and stderr) is routed to stderr in a manner that output
> - * from different tasks does not interleave.
> + * from different tasks does not interleave (but see "ungroup" below).
>   *
>   * start_failure_fn and task_finished_fn can be NULL to omit any
>   * special handling.
> + *
> + * If the "ungroup" option isn't specified, the API will set the
> + * "stdout_to_stderr" parameter in "struct child_process" and provide
> + * the callbacks with a "struct strbuf *out" parameter to write output
> + * to. In this case the callbacks must not write to stdout or
> + * stderr as such output will mess up the output of the other parallel
> + * processes. If "ungroup" option is specified callbacks will get a
> + * NULL "struct strbuf *out" parameter, and are responsible for
> + * emitting their own output, including dealing with any race
> + * conditions due to writing in parallel to stdout and stderr.
> + * The "ungroup" option can be enabled by setting the global
> + * "run_processes_parallel_ungroup" to "1" before invoking
> + * run_processes_parallel(), it will be set back to "0" as soon as the
> + * API reads that setting.

A better idea would be to describe the "interleaved_output" mode first,
and then say "the rest of this comment deals with the non-interleaved
mode".

>   */
> +extern int run_processes_parallel_ungroup;
>  int run_processes_parallel(int n,
>  			   get_next_task_fn,
>  			   start_failure_fn,
> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index f3b90aa834a..6405c9a076a 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -31,7 +31,11 @@ static int parallel_next(struct child_process *cp,
>  		return 0;
>
>  	strvec_pushv(&cp->args, d->args.v);
> -	strbuf_addstr(err, "preloaded output of a child\n");
> +	if (err)
> +		strbuf_addstr(err, "preloaded output of a child\n");
> +	else
> +		fprintf(stderr, "preloaded output of a child\n");
> +
>  	number_callbacks++;
>  	return 1;
>  }
> @@ -41,7 +45,10 @@ static int no_job(struct child_process *cp,
>  		  void *cb,
>  		  void **task_cb)
>  {
> -	strbuf_addstr(err, "no further jobs available\n");
> +	if (err)
> +		strbuf_addstr(err, "no further jobs available\n");
> +	else
> +		fprintf(stderr, "no further jobs available\n");
>  	return 0;
>  }
>
> @@ -50,7 +57,10 @@ static int task_finished(int result,
>  			 void *pp_cb,
>  			 void *pp_task_cb)
>  {
> -	strbuf_addstr(err, "asking for a quick stop\n");
> +	if (err)
> +		strbuf_addstr(err, "asking for a quick stop\n");
> +	else
> +		fprintf(stderr, "asking for a quick stop\n");

This `if (err) strbuf_add... else fprintf...` pattern is a bit repetitive,
but in the interest of fixing a regression without risking to introduce
another regression, I agree that this should wait for later to be
addressed.

On the other hand, this issue is indicating that the API could be designed
better, e.g. by letting the `parallel_processes` struct provide a callback
function for printing or buffering messages.

At this stage, it is concerning that we introduce a feature that
needs to be designed well and therefore needs more time to be fleshed out,
when a regression fix rides on it that should be integrated swiftly and
does not allow for said time to flesh things out.

It is really unfortunate that the hook changes that made it into v2.36.0
are in such an unrevertable state. It would really make most sense, as
Junio suggested elsewhere in this thread, to roll back the changes that
introduced the regression, then spend the time it actually takes to design
the feature properly how hooks could be run via the
`run_processes_parallel()` API. Or spend the time to figure out that not
using the parallel API at all might be the best course of action, instead
executing the hook directly, using the standard `run_command()` API. That
may very well turn out to avoid some over-engineering, as an added benefit=
.

>  	return 1;
>  }
>
> @@ -411,6 +421,9 @@ int cmd__run_command(int argc, const char **argv)
>  	strvec_clear(&proc.args);
>  	strvec_pushv(&proc.args, (const char **)argv + 3);
>
> +	if (getenv("RUN_PROCESSES_PARALLEL_UNGROUP"))

Apart from using a naming scheme that is inconsistent with how Git does
similar things elsewhere, this environment variable seems to have been
introduced for the sole purpose of testing the `ungroup` mode.

Let's instead introduce a new `test-tool run-command` subcommand for that
specific purpose.

> +		run_processes_parallel_ungroup =3D 1;
> +
>  	if (!strcmp(argv[1], "run-command-parallel"))
>  		exit(run_processes_parallel(jobs, parallel_next,
>  					    NULL, NULL, &proc));
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index ee281909bc3..69ccaa8d298 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -134,16 +134,37 @@ test_expect_success 'run_command runs in parallel =
with more jobs available than
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'run_command runs ungrouped in parallel with more j=
obs available than tasks' '
> +	RUN_PROCESSES_PARALLEL_UNGROUP=3D1 \
> +	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\=
" Hello World" >out 2>err &&
> +	test_line_count =3D 8 out &&
> +	test_line_count =3D 4 err

Good. Testing for the line count avoids getting confused by interleaved
output.

Having said that, adding seven (!) new test cases merely to verify that
the `ungroup` mode does not break things is a bit excessive, in particular
since none of the test cases seem to _actually_ verify that the output is
interleaved. Remember, adding test cases is not free.

Ciao,
Johannes

> +'
> +
>  test_expect_success 'run_command runs in parallel with as many jobs as =
tasks' '
>  	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\=
" Hello World" 2>actual &&
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'run_command runs ungrouped in parallel with as man=
y jobs as tasks' '
> +	RUN_PROCESSES_PARALLEL_UNGROUP=3D1 \
> +	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\=
" Hello World" >out 2>err &&
> +	test_line_count =3D 8 out &&
> +	test_line_count =3D 4 err
> +'
> +
>  test_expect_success 'run_command runs in parallel with more tasks than =
jobs available' '
>  	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\=
" Hello World" 2>actual &&
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'run_command runs ungrouped in parallel with more t=
asks than jobs available' '
> +	RUN_PROCESSES_PARALLEL_UNGROUP=3D1 \
> +	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\=
" Hello World" >out 2>err &&
> +	test_line_count =3D 8 out &&
> +	test_line_count =3D 4 err
> +'
> +
>  cat >expect <<-EOF
>  preloaded output of a child
>  asking for a quick stop
> @@ -158,6 +179,13 @@ test_expect_success 'run_command is asked to abort =
gracefully' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'run_command is asked to abort gracefully (ungroup)=
' '
> +	RUN_PROCESSES_PARALLEL_UNGROUP=3D1 \
> +	test-tool run-command run-command-abort 3 false >out 2>err &&
> +	test_must_be_empty out &&
> +	test_line_count =3D 6 err
> +'
> +
>  cat >expect <<-EOF
>  no further jobs available
>  EOF
> @@ -167,6 +195,13 @@ test_expect_success 'run_command outputs ' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'run_command outputs (ungroup) ' '
> +	RUN_PROCESSES_PARALLEL_UNGROUP=3D1 \
> +	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\"=
 Hello World" >out 2>err &&
> +	test_must_be_empty out &&
> +	test_cmp expect err
> +'
> +
>  test_trace () {
>  	expect=3D"$1"
>  	shift
> --
> 2.36.1.1103.g036c05811b0
>
>

--8323328-578515744-1654100731=:349--
