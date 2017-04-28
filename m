Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64434207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 15:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969521AbdD1PLI (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 11:11:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:60042 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968160AbdD1PLG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 11:11:06 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbfnB-1dMTk22kZZ-00J6ZC; Fri, 28
 Apr 2017 17:10:56 +0200
Date:   Fri, 28 Apr 2017 17:10:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 6/9] rebase -i: check for missing commits in the
 rebase--helper
In-Reply-To: <xmqqh91ao1of.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704281659010.3480@virtualbox>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de> <38bf320ec802386975843de6b5da4bbf823fb184.1493207864.git.johannes.schindelin@gmx.de> <xmqqh91ao1of.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MILbNYd1CAaDBrOp4J2TIA9mi+kO5LnmWvOJXF3IkF4Zg9Ox/tF
 6aVARAXYNGuNZDCEeWQOFsF1/Gn77XajLmouATo2/zRYX0gZqdrJBxRVmUxlr/JonKRuvrh
 +Xx/WTKNwY9aacqvNm4GOPkPmmUdPH9YtXN4gfKQSyEUISGx9o5urA6JxtD9yOLWa1AVMHz
 dxJH1SNxcefmW6knJkJmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CVoc/yofhIY=:15/Uk4WjsSedHl0x8MFRFs
 T/WezuSwZIPxbn/BnFCX/48Jr3so7tLWRoaKMErA6qp5TsUFPk8Ix4sP2o0cOuxexbBD69Ubi
 rHRaTkGF8Le1+1tdWzpVhewW/LcxRwhV7onFDMuD0WGJOu1CzgCyJtY1M6ICcEpFSJTzckUo4
 gKYSVhdTxx/e5ZYa3F5PgpqLSfvVUWT4t60+pmxyutlaSVondr9EmMcN7DIcTtdKoypjMsCLY
 ORF6UmUnWW5qH6RnA4dzry16GoSfY9pqqwI/mEYZVY7prB0uEDpFJvzq5f8fZnwuz+tGmky9d
 8p2rQwQehYNanEk/uGVeoE76o/K7sVAB0swtcaUr2y99WJZqnQQZKOWf/gy4VmjqGldWCvxFN
 hkgvE9nAnkb1zuXnqFm4wgmPm/ZoHhjdtCOCgYZNjxT4QfMui1Fo8z6/qDkvMPQi+vsyVWwsG
 k8iEfdYEQddCUVkD1ZIUx0YTddtsdA8JVbiQPpb25yuum/q7QbE8oq0ypXYu1/ZrXjDjTF+Me
 NhF7UNHf1VAM/MRZYxfR/rYeOk9WqXsqhvvTkfiN+HDYRyetAnxU6EcvbgDt2WuO4wB6alxH0
 Igc3usBbQKMKGuX4QvCtZvyDsb962WnyxgbpLandX1VgIoEuiF5/1BhrIvpoQzHg9riqPlWnj
 kYVZWt1ZTxM+TMXAZEVTlQUttW4AOdc9OQIC4tSZRPKRuPwaZaKIo0VwI/g+quh4prI02VzL9
 O6Nrazbk1NKNucUW2f3Ue8voKBT4h1VurfMBocSYJMSFWKR3AJxWZm7X5y8wsfWynzWuBy48t
 HuVBfEf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,


On Wed, 26 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > -check_todo_list
> > +git rebase--helper --check-todo-list || {
> > +	ret=$?
> > +	checkout_onto
> > +	exit $ret
> > +}
> 
> I find this a better division of labor between "check_todo_list" and
> its caller.  Compared to the original that did the "recover and exit
> with failure" inside the helper, this is much easier to see what is
> going on.

Yes. My first attempt did not even checkout <onto>, and it was
surprisingly difficult to pin that one down. I would never have expected
check_todo_list to have that side effect.

> > +/*
> > + * Check if the user dropped some commits by mistake
> > + * Behaviour determined by rebase.missingCommitsCheck.
> > + * Check if there is an unrecognized command or a
> > + * bad SHA-1 in a command.
> > + */
> > +int check_todo_list(void)
> > +{
> > +	enum check_level check_level = get_missing_commit_check_level();
> > +	struct strbuf todo_file = STRBUF_INIT;
> > +	struct todo_list todo_list = TODO_LIST_INIT;
> > +	struct commit_list *missing = NULL;
> > +	int raise_error = 0, res = 0, fd, i;
> > +
> > +	strbuf_addstr(&todo_file, rebase_path_todo());
> > +	fd = open(todo_file.buf, O_RDONLY);
> > +	if (fd < 0) {
> > +		res = error_errno(_("could not open '%s'"), todo_file.buf);
> > +		goto leave_check;
> > +	}
> > +	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> > +		close(fd);
> > +		res = error(_("could not read '%s'."), todo_file.buf);
> > +		goto leave_check;
> > +	}
> > +	close(fd);
> > +	raise_error = res =
> > +		parse_insn_buffer(todo_list.buf.buf, &todo_list);
> > +
> > +	if (check_level == CHECK_IGNORE)
> > +		goto leave_check;
> 
> OK, so even it is set to ignore, unreadable todo list will be shown
> with a loud error message that tells the user to use --edit-todo.
> 
> What should happen when it is not set to ignore and we found the
> todo list unacceptable, I wonder?

Whoops. In case of a parse error, it does not make sense to check, does
it. Fixed.

> > +	/* Get the SHA-1 of the commits */
> > +	for (i = 0; i < todo_list.nr; i++) {
> > +		struct commit *commit = todo_list.items[i].commit;
> > +		if (commit)
> > +			commit->util = todo_list.items + i;
> > +	}
> 
> It does not look like this loop is "Get(ting) the SHA-1 of the commits"
> to me, though.  It is setting up ->util to be usable as a back-pointer
> into the list.

Right, and that is not even necessary. It is even incorrect, as we release
the todo_list and read git-rebase-todo.backup into the same data
structure, possibly reallocating the array, therefore the pointers may
become stale. So I went with your suggestion further down to use (void *)1
instead.

Also, the comment is actively wrong, I agree. I changed it to

	/* Mark the commits in git-rebase-todo as seen */

> > +	todo_list_release(&todo_list);
> 
> But then the todo-list is released?  The util field we have set, if
> any, in the previous loop are now dangling, no?

Right.

> > +	strbuf_addstr(&todo_file, ".backup");
> > +	fd = open(todo_file.buf, O_RDONLY);
> > +	if (fd < 0) {
> > +		res = error_errno(_("could not open '%s'"), todo_file.buf);
> > +		goto leave_check;
> > +	}
> > +	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> > +		close(fd);
> > +		res = error(_("could not read '%s'."), todo_file.buf);
> > +		goto leave_check;
> > +	}
> > +	close(fd);
> > +	strbuf_release(&todo_file);
> > +	res = !!parse_insn_buffer(todo_list.buf.buf, &todo_list);
> 
> Then we read from .backup; failure to do so does not result in the
> "you need to --edit-todo" warning.

Correct. At this point, we could even add

	if (res)
		die("BUG: cannot read '%s'", todo_file.buf);

(moving the strbuf_release(&todo_file) below, of course), as the .backup
file is not intended to be edited by the user, i.e. it is the original
todo which should *never* be unparseable.

> > +	/* Find commits that are missing after editing */
> > +	for (i = 0; i < todo_list.nr; i++) {
> > +		struct commit *commit = todo_list.items[i].commit;
> > +		if (commit && !commit->util) {
> > +			commit_list_insert(commit, &missing);
> > +			commit->util = todo_list.items + i;
> > +		}
> > +	}
> 
> And we check the commits mentioned in the backup; any commit whose
> util is not marked in the previous loop is noticed and thrown into
> the missing list.
> 
> The loop we later have does "while (missing)" and does not look at
> commit->util for commits that are *not* missing, i.e. the ones that
> are marked in the previous loop, so it does not matter that their
> util field have dangling pointers.  In that sense, it may not be
> buggy, but it is misleading.  The only thing these two loops care
> about is that the commits found in the earlier loop get their util
> field set to non-NULL, so instead of using "todo_list.items+i",
> perhaps doing this
> 
> 	if (commit)
> 		commit->util = (void *)1; /* mark as seen */
> 
> in the earlier loop instead would be much less confusing.

... and doing the same in this loop. I agree, that's exactly what I
changed it to.

> > +	/* Warn about missing commits */
> > +	if (!missing)
> > +		goto leave_check;
> 
> If there is no missing one, we may still return error about
> unacceptable backup file.  But if we read backup fine and didn't
> find anything missing, we'll return silently and with success.  OK.
> 
> > +	if (check_level == CHECK_ERROR)
> > +		raise_error = res = 1;
> 
> Otherwise, we found missing ones and we want to report here.
> 
> The reason why I started reading this function aloud was because I
> found two variables (raise_error and res) somewhat confusing.  I
> think what the code does makes sense, but I still find the way how
> the code expresses the logic with these two variables confusing.
> Perhaps somebody else can hopefully offer possible improvements, as
> I do not offhand think of a way better than what is currently in
> this patch myself.

I renamed the `raise_error` variable to `advise_to_edit_todo`. The `res`
does not need renaming, methinks, as it is used everywhere else in that
file to indicate the return value.

Ciao,
Dscho
