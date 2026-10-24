Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792849877;
	b=fMv/pwrgws4T5KDTHN7p6l25yaz+e79QEJshh5DVZZj6shqvhVvihC/CzzNVEaGV6KqQ
	 Upu6jg31Z7tESctNuQsTxosmYicPzaV3ycIMIJj7Y4bLgepxo2zXS/muqIFaGqHz31Xva
	 l9n6FvT3CLd7CIXGuOjytSi9tISUiLqUTvz/3u2kFm5LYZhz1Q6VonCSrzaRifAd59WO1
	 J9+lS1sSvBkcWAjCn+ZDkJcHkqwZU5VHAedmgA+NeNt7vlIhsinct7/7RlU8qZ5328Jvk
	 +HfEcnm4nad+KKnR9LTUUtBOk7zlbJPom/GfDqZwStJYH2aklia1m8VUzTvsPVFxMjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792849877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=vOrIYgmB43cPkcJmyorStnQT8nSQuMW84H+jZTxvU4c=;
	b=By3mlPKeaR3KFyjgfPEU5qW46Y3LCTzQZYKfBRtjzZ3fRIuMEbGq7EBOet3WtTqXOuLe
	 QYgtVQfKb/pI4my6QkSjgBTlsib1j7wPWFHBu7+qLLQzwErgwanVi6SUI5BBqpyn4L/MW
	 0tF2cbaomfJKwYp4sIUBhDJHTtv0ISWbL53Zq4AJxBbLRL6z6cyrHyDdVhQVGE69YeE6P
	 bL/Wx4JtypDjUD6BC9YjV3MWtCwWRtcn+amKXChfhdLwRXCJh6VeDn1o+pktKC1nf7r8E
	 2cykhkxRdz0qUaHa44vBK7gdMPk4YWe0VdgsM012OwduG9CfNT9THpdawQWgYdT2I3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YMVmHyw6;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B61606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 13:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46B61606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YMVmHyw6
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e00eee27dso1092141f8f.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 06:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792849876; x=1793454676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vOrIYgmB43cPkcJmyorStnQT8nSQuMW84H+jZTxvU4c=;
        b=YMVmHyw636h/3tV3bjcgnOxGfN47JSOt7aguqwDpB5edZoMRLZs/opEwq1xXpc2rCf
         Kn7se0Pjnc3AuRuX1jPUaVuH2hcob39rWWhbmnojgqdJiEAJ9P1SsQjM7I3x0UAF71Te
         sKMZHK2nWbM61deurTAUn5FQkFVy3FU0446izweSbkSjmLZMxs30L1BVrF6zaUpPrAgC
         MxC/neqH0aKH8ARoyRqfMttaFei2QfOfbYGtXe/2gdZaF4irmlu5SfxRBTYIgFvULuOy
         CCxCwelDAZdxrTc0NEAQ1FPvQ8Cl0zzZYIJMlzgEjNANZUak/437lKzaZqyFgZ50O7fr
         q1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792849876; x=1793454676;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vOrIYgmB43cPkcJmyorStnQT8nSQuMW84H+jZTxvU4c=;
        b=pHJdSWkKAy9XAcOwoO8U8XBE5Jnd+SpwUp0InvLwcAJkZA7xsNiFaBQ6y/Qqm7Y9S4
         oYQtN+Qd3ls4aS7vwlWKDOIS90Bg4N0EwJw5arGPDaEevM2CGVv43+MSCLy8chbH/e7k
         0DvRNn0JQmp6nI83M5Kc566Fwil4gLBFSgNI5lUY7SdlSaNI9DRyhHONAmKY1Wc1/d9k
         WH2EB7kJfGw5OGNB1sEHBucs3FBctHm/HsztoNaRM1B+eAGE02nsdAwWcqgd3/eZkiPn
         GUY7taNPNsMveN5ca124P4YoqbQrrMD+R7oFlVsrbqyjXNME8SN2OjvnYRQF1ktIBft3
         7NPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWz0cTIOL1NS3W+MLjyAv/1K4opD5FxkRKIxSe4vjC7UYFELB1dA0Ekueb8PzEAjHBloE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK67py2yRJW6pdslHqAYZJHG5PwKEOnzyZ2KG6ETYHeyr3FCs5x
	3bOOJ3KjbMpVbQFJggxkPJugQ1XKUbhTrF+KhC9j5fMC7TrmE+XbLKSXpjMqrw==
X-Gm-Gg: AYBFou1kub536zvxRLFjHcnzdIErMsjS2puUsGxRwf+vHarvarqsQ12YjokGdAw3r1b
	Fu6BNGJ77nS6R3FVemcFkKvIOyMyDkFjAmSPEOeCd7jGXPkCmsRPqYCUrSW3qWveAjaiArAfMMc
	X9dLjsqvejbI7WHC4gf7AR5hVtATups66Kx0ZjoZnH6TaD+Nqc8WdeI+AN/zA9AjYPJRaKIQDt5
	JQb/v4d3n90TZSYTb64tB3se6VYpBJyW65nQtWDB/J7X6z2VuEWNCFtWms80sKeA2iBanSbs6Uk
	KFN0pmaLanZbCOiR7JffFwaxXjFGH6iwVCkTTFxoB+y9nYhBT+1zoex2cm00h74w5U3tZisWn9A
	OUJf9W5l7xsQIdRKisaelNxmuOCOH0FzKW0omT3E6CdJDuIAvR6ddlChYQUmJRw1gZHLFUaaI2d
	je7vcx1py26Dp9i9DJ88q2TWtWJAYFcNFT57moe4z1vDM2Z4myluH2hSQGQyyv9WqvUUwvLqGH0
	ZOb9CEsGTdIOJVh9qyY0x931VBCYY+R4YCEmjc1tZzo9axHUkJAVetcV3SUzOvWCKTfSLMtUdTi
	19agSfO2j+spy1r3A8lrdv95oz1cC2ZBdg==
X-Received: by 2002:adf:e889:0:b0:48e:932:aef5 with SMTP id ffacd0b85a97d-48e3eb8bafdmr2285469f8f.21.1792849875307;
        Sat, 24 Oct 2026 06:51:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd354asm4161305f8f.43.2026.10.24.06.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 06:51:14 -0700 (PDT)
Message-ID: <bfc2b43a-6198-47b0-8868-d92551548f22@gmail.com>
Date: Sat, 24 Oct 2026 14:51:13 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/3] reflog: add --operations and --historical-branch
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 18/10/2026 19:27, Harald Nordgren via GitGitGadget wrote:
> Create a better reflog. Follows the discussion in
> https://lore.kernel.org/git/akZfm-igZKeHaDST@pks.im/.
> 
> "git reflog" lists every step of a rebase and every branch switch, which
> makes it hard to see what was done and on which branch. This adds two
> options to "git reflog" and "git log -g":
> 
>   * --operations shows one entry per command, folding a rebase into the entry
>     that finished or aborted it, and leaves out entries that change no
>     branch.

I'm rather skeptical of this in its current form. Not all commands that 
modify the working tree update the reflog and some commands such as "git 
cherry-pick A B C" create multiple reflog entires that are 
indistinguishable from multiple invocations of a single command. The 
message you cite above is arguing that we need a separate operations log 
if we want to overcome these problems. Most of what this option does can 
be achieved by looking at the branch reflog instead (I really wish that 
"git reflog" defaulted to the current branch rather than HEAD). I'm not 
opposed to supporting some kind of filtering/simplification particularly 
for HEAD, but we should not pretend we're showing users one entry per 
command.

>   * --historical-branch decorates each entry with the branch HEAD was on when
>     it was recorded.

I quite like this idea, but think it would be nicer implemented as a 
format specifier ("%gb" seems to be free) so that users can use it in 
their custom formats. I'd be quite happy to change the default format do
for HEAD to include the branch name after the reflog message but I'm not 
sure others would be so keen (perhaps we could get away with guarding 
any change by isatty()/GIT_PAGER_IN_USE?).

If we're going to do this we should make sure it supports "git rebase 
<upstream> <branch>" so that the branch names are accurate. That is a 
bit involved because you have to compare the name of the branch being 
rebased (which is in the "(finish)" reflog message) to the name of the 
branch that was checked out before (which isn't in that message so you 
have to go looking for a previous rebase or checkout). It also needs to 
take account of rebases that checkout a detached HEAD which don't have 
the "(finish)" message and those that checkout an up-to-date branch or 
detached HEAD where the message is "$GIT_REFLOG_ACTION: checkout 
$revision". I've got a patch [1] that fixes this for "@{-N}" which I 
think works, but it needs some more tests.

Thanks

Phillip

[1] 
https://github.com/git/git/compare/master...phillipwood:git:fix-nth-prior-checkout

> Changes in v2:
> 
>   * Move the "historical branch" rightward in the display for cleaner
>     alignment.
>   * Improve commit messages.
> 
> Harald Nordgren (3):
>    reflog: name the strings that mark switches, renames and rebase steps
>    reflog: add --operations to show one entry per command
>    reflog: add --historical-branch to name the branch of each entry
> 
>   Documentation/git-reflog.adoc       |   4 +
>   Documentation/rev-list-options.adoc |  21 +++
>   builtin/branch.c                    |   3 +-
>   builtin/checkout.c                  |   3 +-
>   builtin/rebase.c                    |  17 +--
>   log-tree.c                          |  28 +++-
>   object-name.c                       |   3 +-
>   reflog-walk.c                       | 183 +++++++++++++++++++++++--
>   reflog-walk.h                       |   6 +-
>   reflog.h                            |   6 +
>   revision.c                          |  14 ++
>   revision.h                          |   2 +
>   sequencer.c                         |  13 +-
>   t/t1414-reflog-walk.sh              | 198 ++++++++++++++++++++++++++++
>   wt-status.c                         |   3 +-
>   15 files changed, 471 insertions(+), 33 deletions(-)
> 
> 
> base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2448%2FHaraldNordgren%2Freflog-operations-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2448/HaraldNordgren/reflog-operations-v2
> Pull-Request: https://github.com/git/git/pull/2448
> 
> Range-diff vs v1:
> 
>   1:  d95ed5bd67 ! 1:  745929bd80 reflog: name the strings that mark switches, renames and rebase steps
>       @@ Metadata
>         ## Commit message ##
>            reflog: name the strings that mark switches, renames and rebase steps
>        
>       -    "git checkout" records a move of HEAD in the reflog as "checkout:
>       -    moving from <old> to <new>", "git branch -m" records a rename of the
>       -    current branch as "Branch: renamed <old> to <new>", and "git rebase"
>       -    marks where it starts and ends with steps like "rebase (start)" and
>       -    "rebase (finish)". "@{-<n>}" and "git status" read the switch message
>       -    back, each with its own copy of the prefix, and a later commit adds a
>       -    reader for all of them.
>       +    The next commit adds "git reflog --operations", which finds branch
>       +    switches, branch renames and the start and end of a rebase by the
>       +    messages they leave in the reflog. The commands that write these
>       +    messages spell out the strings by hand, and "@{-<n>}" and "git status"
>       +    each keep their own copy of the switch prefix to read it back. Reading
>       +    them in one more place would add yet another copy that has to stay in
>       +    sync.
>        
>       -    Name these strings in reflog.h and use them where the messages are
>       -    written and read, so they cannot drift apart.
>       +    Name the strings once in reflog.h and use the names wherever the
>       +    messages are written or read: the "checkout: moving from " prefix
>       +    written by "git checkout", the "Branch: renamed " prefix written by
>       +    "git branch -m", and the "start", "finish" and "abort" steps written
>       +    by "git rebase".
>       +
>       +    No change in behavior.
>        
>            Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>        
>   2:  579e13b36a = 2:  1c47ba225e reflog: add --operations to show one entry per command
>   3:  4efe74b04e ! 3:  aa5a98b80d reflog: add --historical-branch to name the branch of each entry
>       @@ Commit message
>            still point at that commit, and a rebased or amended commit has none.
>        
>            Teach "git reflog" and "git log -g" a "--historical-branch" option
>       -    that decorates each entry with the branch it was made on, in place of
>       -    the refs that point at the commit now. The name is colored like a
>       -    branch decoration:
>       +    that shows the branch each entry was made on before its message, in
>       +    place of the refs that point at the commit now. The hashes and
>       +    selectors stay lined up in their columns, and the name is colored like
>       +    a branch decoration:
>        
>              $ git reflog --historical-branch
>       -      4e5f6a7 (topic) HEAD@{0}: commit: add tests
>       -      1a2b3c4 (topic) HEAD@{1}: checkout: moving from main to topic
>       -      8c9d0e1 (main) HEAD@{2}: commit: fix typo
>       +      4e5f6a7 HEAD@{0}: (topic) commit: add tests
>       +      1a2b3c4 HEAD@{1}: (topic) checkout: moving from main to topic
>       +      8c9d0e1 HEAD@{2}: (main) commit: fix typo
>        
>            Every entry gets a name, including ones whose commits are no longer on
>            any branch. Entries from before a branch was renamed show its old name,
>       @@ Documentation/git-reflog.adoc: actions, and in addition the `HEAD` reflog record
>         branch are left out, and a rebase is shown as a single entry instead
>        -of one entry for each commit it replayed.
>        +of one entry for each commit it replayed. With `--historical-branch`,
>       -+each entry is decorated with the branch it was made on.
>       ++each entry shows the branch it was made on before its message.
>         
>         The "list" subcommand lists all refs which have a corresponding reflog.
>         
>       @@ Documentation/rev-list-options.adoc: Under `--pretty=reference`, this informatio
>         	rebase started. It is an error to use this option unless
>         	`--walk-reflogs` is in use.
>         
>       ++ifndef::git-rev-list[]
>        +`--historical-branch`::
>       -+	Decorate each reflog entry with the branch `HEAD` was on when
>       -+	the entry was recorded, such as `(topic)`, in place of the refs
>       -+	that point at the commit now. When `HEAD` was detached, the
>       -+	entry shows `(detached at <commit>)`. For the reflog of any
>       -+	other ref, the name of that ref is shown. It is an error to use
>       -+	this option unless `--walk-reflogs` is in use.
>       ++	Show the branch `HEAD` was on when each reflog entry was
>       ++	recorded, such as `(topic)`, before the reflog message, in
>       ++	place of the refs that point at the commit now. When `HEAD` was
>       ++	detached, the entry shows `(detached at <commit>)`. For the
>       ++	reflog of any other ref, the name of that ref is shown. It is
>       ++	an error to use this option unless `--walk-reflogs` is in use.
>       ++endif::git-rev-list[]
>        +
>         `--merge`::
>         	Show commits touching conflicted paths in the range `HEAD...<other>`,
>       @@ log-tree.c: void format_decorations(struct strbuf *sb,
>         	}
>         }
>         
>       -+static void show_historical_branch(struct rev_info *opt)
>       ++static void format_historical_branch(struct strbuf *sb,
>       ++				     struct rev_info *opt)
>        +{
>        +	const char *branch = get_reflog_branch(opt->reflog_info);
>        +	enum git_colorbool use_color = opt->diffopt.use_color;
>       @@ log-tree.c: void format_decorations(struct strbuf *sb,
>        +
>        +	color_commit = diff_get_color(use_color, DIFF_COMMIT);
>        +	color_reset = decorate_get_color(use_color, DECORATION_NONE);
>       -+	fprintf(opt->diffopt.file, "%s (%s%s%s%s%s)%s",
>       -+		color_commit, color_reset,
>       -+		decorate_get_color(use_color, DECORATION_REF_LOCAL),
>       -+		branch, color_reset, color_commit, color_reset);
>       ++	strbuf_addf(sb, "%s(%s%s%s%s%s)%s ",
>       ++		    color_commit, color_reset,
>       ++		    decorate_get_color(use_color, DECORATION_REF_LOCAL),
>       ++		    branch, color_reset, color_commit, color_reset);
>        +}
>        +
>         void show_decorations(struct rev_info *opt, struct commit *commit)
>       @@ log-tree.c: void show_decorations(struct rev_info *opt, struct commit *commit)
>         		if (slot && *slot)
>         			fprintf(opt->diffopt.file, "\t%s", *slot);
>         	}
>       -+	if (opt->historical_branch) {
>       -+		show_historical_branch(opt);
>       -+		return;
>       -+	}
>       - 	if (!opt->show_decorations)
>       +-	if (!opt->show_decorations)
>       ++	if (!opt->show_decorations || opt->historical_branch)
>         		return;
>         	format_decorations(&sb, commit, opt->diffopt.use_color, NULL);
>       + 	fputs(sb.buf, opt->diffopt.file);
>       +@@ log-tree.c: void show_log(struct rev_info *opt)
>       + 			graph_show_oneline(opt->graph);
>       + 		}
>       + 		if (opt->reflog_info) {
>       ++			struct strbuf branch = STRBUF_INIT;
>       ++
>       + 			/*
>       + 			 * setup_revisions() ensures that opt->reflog_info
>       + 			 * and opt->graph cannot both be set,
>       + 			 * so we don't need to worry about printing the
>       + 			 * graph info here.
>       + 			 */
>       ++			if (opt->historical_branch)
>       ++				format_historical_branch(&branch, opt);
>       + 			show_reflog_message(opt->reflog_info,
>       + 					    opt->commit_format == CMIT_FMT_ONELINE,
>       + 					    opt->date_mode,
>       +-					    opt->date_mode_explicit);
>       ++					    opt->date_mode_explicit,
>       ++					    branch.buf);
>       ++			strbuf_release(&branch);
>       + 			if (opt->commit_format == CMIT_FMT_ONELINE)
>       + 				return;
>       + 		}
>        
>         ## reflog-walk.c ##
>        @@
>       @@ reflog-walk.c: void get_reflog_message(struct strbuf *sb,
>         const char *get_reflog_ident(struct reflog_walk_info *reflog_info)
>         {
>         	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
>       +@@ reflog-walk.c: timestamp_t get_reflog_timestamp(struct reflog_walk_info *reflog_info)
>       + }
>       +
>       + void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
>       +-			 struct date_mode dmode, int force_date)
>       ++			 struct date_mode dmode, int force_date,
>       ++			 const char *branch)
>       + {
>       + 	if (reflog_info && reflog_info->last_commit_reflog) {
>       + 		struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
>       +@@ reflog-walk.c: void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
>       + 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
>       + 		get_reflog_selector(&selector, reflog_info, dmode, force_date, 0);
>       + 		if (oneline) {
>       +-			printf("%s: %s", selector.buf, info->message);
>       ++			printf("%s: %s%s", selector.buf, branch,
>       ++			       info->message);
>       + 		}
>       + 		else {
>       +-			printf("Reflog: %s (%s)\nReflog message: %s",
>       +-			       selector.buf, info->email, info->message);
>       ++			printf("Reflog: %s (%s)\nReflog message: %s%s",
>       ++			       selector.buf, info->email, branch,
>       ++			       info->message);
>       + 		}
>       +
>       + 		strbuf_release(&selector);
>        
>         ## reflog-walk.h ##
>        @@ reflog-walk.h: struct date_mode;
>       @@ reflog-walk.h: struct date_mode;
>         int add_reflog_for_walk(struct reflog_walk_info *info,
>         			struct commit *commit, const char *name);
>         void show_reflog_message(struct reflog_walk_info *info, int,
>       - 			 struct date_mode, int force_date);
>       +-			 struct date_mode, int force_date);
>       ++			 struct date_mode, int force_date,
>       ++			 const char *branch);
>         void get_reflog_message(struct strbuf *sb,
>         			struct reflog_walk_info *reflog_info);
>        +const char *get_reflog_branch(struct reflog_walk_info *reflog_info);
>       @@ t/t1414-reflog-walk.sh: test_expect_success '--operations shows a rebase as one
>        +		cd operations &&
>        +
>        +		cat >expect <<-\EOF &&
>       -+		(topic) HEAD@{0}: rebase (finish): returning to refs/heads/topic
>       -+		(topic) HEAD@{1}: rebase (pick): C
>       -+		(topic) HEAD@{2}: rebase (pick): B
>       -+		(topic) HEAD@{3}: rebase (pick): A
>       -+		(topic) HEAD@{4}: rebase (start): checkout main
>       -+		(topic) HEAD@{5}: checkout: moving from main to topic
>       -+		(main) HEAD@{6}: commit: upstream
>       -+		(main) HEAD@{7}: checkout: moving from topic to main
>       -+		(topic) HEAD@{8}: commit: C
>       -+		(topic) HEAD@{9}: commit: B
>       -+		(topic) HEAD@{10}: commit: A
>       -+		(topic) HEAD@{11}: checkout: moving from main to topic
>       -+		(main) HEAD@{12}: commit (initial): base
>       ++		HEAD@{0}: (topic) rebase (finish): returning to refs/heads/topic
>       ++		HEAD@{1}: (topic) rebase (pick): C
>       ++		HEAD@{2}: (topic) rebase (pick): B
>       ++		HEAD@{3}: (topic) rebase (pick): A
>       ++		HEAD@{4}: (topic) rebase (start): checkout main
>       ++		HEAD@{5}: (topic) checkout: moving from main to topic
>       ++		HEAD@{6}: (main) commit: upstream
>       ++		HEAD@{7}: (main) checkout: moving from topic to main
>       ++		HEAD@{8}: (topic) commit: C
>       ++		HEAD@{9}: (topic) commit: B
>       ++		HEAD@{10}: (topic) commit: A
>       ++		HEAD@{11}: (topic) checkout: moving from main to topic
>       ++		HEAD@{12}: (main) commit (initial): base
>        +		EOF
>        +		git reflog --historical-branch >out &&
>        +		cut -d " " -f 2- out >actual &&
>       @@ t/t1414-reflog-walk.sh: test_expect_success '--operations shows a rebase as one
>        +	(
>        +		cd operations &&
>        +		hash=$(git rev-parse --short HEAD) &&
>       -+		echo "<YELLOW>$hash<RESET><YELLOW> (<RESET><BOLD;GREEN>topic<RESET><YELLOW>)<RESET>" >expect &&
>       ++		echo "<YELLOW>$hash<RESET> HEAD@{0}: <YELLOW>(<RESET><BOLD;GREEN>topic<RESET><YELLOW>)<RESET> rebase (finish): returning to refs/heads/topic" >expect &&
>        +		git reflog --historical-branch --decorate --color -1 >out &&
>       -+		test_decode_color <out | sed "s/ HEAD@.*//" >actual &&
>       ++		test_decode_color <out >actual &&
>        +		test_cmp expect actual
>        +	)
>        +'
>       @@ t/t1414-reflog-walk.sh: test_expect_success '--operations shows a rebase as one
>        +test_expect_success '--historical-branch names the ref of other reflogs' '
>        +	(
>        +		cd operations &&
>       -+		echo "(main) main@{0}: commit: upstream" >expect &&
>       ++		echo "main@{0}: (main) commit: upstream" >expect &&
>        +		git reflog -1 main --historical-branch >out &&
>        +		cut -d " " -f 2- out >actual &&
>        +		test_cmp expect actual
>       @@ t/t1414-reflog-walk.sh: test_expect_success '--operations shows a pull --rebase
>        +		cd downstream &&
>        +		echo "(topic)" >expect &&
>        +		git reflog --historical-branch >out &&
>       -+		cut -d " " -f 2 out | sort -u >actual &&
>       ++		cut -d " " -f 3 out | sort -u >actual &&
>        +		test_cmp expect actual
>        +	)
>        +'
>       @@ t/t1414-reflog-walk.sh: test_expect_success '--operations shows a pull --rebase
>        +		test_commit E &&
>        +
>        +		cat >expect <<-\EOF &&
>       -+		(renamed) HEAD@{0}: commit: E
>       -+		(renamed) HEAD@{1}: Branch: renamed refs/heads/topic to refs/heads/renamed
>       -+		(topic) HEAD@{3}: commit: D
>       ++		HEAD@{0}: (renamed) commit: E
>       ++		HEAD@{1}: (renamed) Branch: renamed refs/heads/topic to refs/heads/renamed
>       ++		HEAD@{3}: (topic) commit: D
>        +		EOF
>        +		git reflog --historical-branch -3 >out &&
>        +		cut -d " " -f 2- out >actual &&
>       @@ t/t1414-reflog-walk.sh: test_expect_success '--operations shows a pull --rebase
>        +		git checkout renamed &&
>        +
>        +		cat >expect <<-EOF &&
>       -+		(renamed) HEAD@{0}: checkout: moving from $(git rev-parse F) to renamed
>       -+		(detached at $(git rev-parse --short F)) HEAD@{1}: commit: F
>       ++		HEAD@{0}: (renamed) checkout: moving from $(git rev-parse F) to renamed
>       ++		HEAD@{1}: (detached at $(git rev-parse --short F)) commit: F
>        +		EOF
>        +		git reflog --historical-branch -2 >out &&
>        +		cut -d " " -f 2- out >actual &&
> 

