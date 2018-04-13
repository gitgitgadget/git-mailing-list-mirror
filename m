Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F3AE1F42D
	for <e@80x24.org>; Fri, 13 Apr 2018 17:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750955AbeDMR5J (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 13:57:09 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:7660 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeDMR5I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 13:57:08 -0400
Received: from [192.168.2.201] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 72wZfiFM8C0Wb72waf7qUD; Fri, 13 Apr 2018 18:57:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1523642226;
        bh=aBSjYr8UINmtg6vAvHFw3gp5n+zGz0DSiJce0IucKAs=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=HJKS+LGq4GJNud7M/egbS8ZpXNgrAxEt8miQqi7y62UOJRTuRvjYeFE9N1TxhODqe
         NgR1OV7h8aiyyMI24jzyiLTHL4f8tr1aKm9JQGkWatmX/hUl6duR0fpqAc0iCd5bVt
         39mGpv0VDvpxH2c1vbjr7R8ZI5ek0jSEYIQuNLXU=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=Q+T8Hb+a c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=XGhs91ss3p6XzigbGvYA:9 a=B4v6LIeArFRCb6rf:21 a=tGUqaxwm-2-ohuB0:21
 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 05/15] sequencer: introduce the `merge` command
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de>
 <8a5ae61f603df8d8cb19268e1b8470f0a4993445.1523362469.git.johannes.schindelin@gmx.de>
 <55216d0b-cb37-6514-7f80-91f4617c105d@talktalk.net>
Message-ID: <85232331-97a0-7989-e095-854ed962c7a0@talktalk.net>
Date:   Fri, 13 Apr 2018 18:57:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <55216d0b-cb37-6514-7f80-91f4617c105d@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLc4AyebkRB1VyzisLwtfOoiQ6gVUxOsLLk66V89Ajl1cnCGtWfLg1BB1S8Wd5/j5jj5I1jBARumIqYeRZYeiJY7WxrZOORSBz0m6vSHOG6UK1E358h8
 5Lhp77x43BfGkfM90Jb7flTfhXfc0ipVWdCT/lS4bbojebnxdDFkQQdcAU2Pu8oMYHj0ehoxUGrmeYUjLfTgPgtj+zJd3Wa6lq54lInFTjRG0Ee1QBaGKyKw
 hkIBXznO9GZy/tRYp97F5+a/dt/sgk9qsnXy0lYaryOrJJxQ9s9JEsixrmNZqwcrMtL0qmQW7mtyMKnu8SiMjpUT3uGE5o1iff89Ynb/32z32blqh/3ebrEX
 xPcO28t0eaWmcWf8pxNiJ9FC3gtfxWob+K3Yx2S5TfQpGaFeZmhRv5lNknbOr5rzFPSjOmaZmKrrZSQvXZRaicfhsqAkpE6Aguq2BKGvgQMaA4m70IHJL97v
 6zgF0aPOWX9tXruPUxL9BhNnrBaLuaxVXTPX6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/04/18 11:12, Phillip Wood wrote:
> On 10/04/18 13:29, Johannes Schindelin wrote:
>> +static int do_merge(struct commit *commit, const char *arg, int arg_len,
>> +		    int flags, struct replay_opts *opts)
>> +{
>> +	int run_commit_flags = (flags & TODO_EDIT_MERGE_MSG) ?
>> +		EDIT_MSG | VERIFY_MSG : 0;
>> +	struct strbuf ref_name = STRBUF_INIT;
>> +	struct commit *head_commit, *merge_commit, *i;
>> +	struct commit_list *bases, *j, *reversed = NULL;
>> +	struct merge_options o;
>> +	int merge_arg_len, oneline_offset, ret;
>> +	static struct lock_file lock;
>> +	const char *p;
>> +
>> +	oneline_offset = arg_len;
>> +	merge_arg_len = strcspn(arg, " \t\n");
>> +	p = arg + merge_arg_len;
>> +	p += strspn(p, " \t\n");
>> +	if (*p == '#' && (!p[1] || isspace(p[1]))) {
>> +		p += 1 + strspn(p + 1, " \t\n");
>> +		oneline_offset = p - arg;
>> +	} else if (p - arg < arg_len)
>> +		BUG("octopus merges are not supported yet: '%s'", p);
>> +
>> +	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
>> +	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
>> +	if (!merge_commit) {
>> +		/* fall back to non-rewritten ref or commit */
>> +		strbuf_splice(&ref_name, 0, strlen("refs/rewritten/"), "", 0);
>> +		merge_commit = lookup_commit_reference_by_name(ref_name.buf);
>> +	}
>> +	if (!merge_commit) {
>> +		error(_("could not resolve '%s'"), ref_name.buf);
>> +		strbuf_release(&ref_name);
>> +		return -1;
>> +	}
>> +
>> +	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
>> +		return -1;
>> +
>> +	head_commit = lookup_commit_reference_by_name("HEAD");
>> +	if (!head_commit) {
>> +		rollback_lock_file(&lock);
>> +		return error(_("cannot merge without a current revision"));
>> +	}
>> +
>> +	if (commit) {
>> +		const char *message = get_commit_buffer(commit, NULL);
>> +		const char *body;
>> +		int len;
>> +
>> +		if (!message) {
>> +			rollback_lock_file(&lock);
>> +			return error(_("could not get commit message of '%s'"),
>> +				     oid_to_hex(&commit->object.oid));
>> +		}
>> +		write_author_script(message);
>> +		find_commit_subject(message, &body);
>> +		len = strlen(body);
>> +		if (write_message(body, len, git_path_merge_msg(), 0) < 0) {
>> +			error_errno(_("could not write '%s'"),
>> +				    git_path_merge_msg());
>> +			unuse_commit_buffer(commit, message);
>> +			rollback_lock_file(&lock);
>> +			return -1;
>> +		}
>> +		unuse_commit_buffer(commit, message);
>> +	} else {
>> +		struct strbuf buf = STRBUF_INIT;
>> +		int len;
>> +
>> +		strbuf_addf(&buf, "author %s", git_author_info(0));
>> +		write_author_script(buf.buf);
>> +		strbuf_reset(&buf);
>> +
>> +		if (oneline_offset < arg_len) {
>> +			p = arg + oneline_offset;
>> +			len = arg_len - oneline_offset;
>> +		} else {
>> +			strbuf_addf(&buf, "Merge branch '%.*s'",
>> +				    merge_arg_len, arg);
>> +			p = buf.buf;
>> +			len = buf.len;
>> +		}
>> +
>> +		if (write_message(p, len, git_path_merge_msg(), 0) < 0) {
>> +			error_errno(_("could not write '%s'"),
>> +				    git_path_merge_msg());
>> +			strbuf_release(&buf);
>> +			rollback_lock_file(&lock);
>> +			return -1;
>> +		}
>> +		strbuf_release(&buf);
>> +	}
>> +
>> +	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
>> +		      git_path_merge_head(), 0);
>> +	write_message("no-ff", 5, git_path_merge_mode(), 0);
>> +
>> +	bases = get_merge_bases(head_commit, merge_commit);
>> +	for (j = bases; j; j = j->next)
>> +		commit_list_insert(j->item, &reversed);
>> +	free_commit_list(bases);
>> +
>> +	read_cache();
>> +	init_merge_options(&o);
>> +	o.branch1 = "HEAD";
>> +	o.branch2 = ref_name.buf;
>> +	o.buffer_output = 2;
>> +
>> +	ret = merge_recursive(&o, head_commit, merge_commit, reversed, &i);
>> +	if (!ret)
>> +		rerere(opts->allow_rerere_auto);
>> +	if (ret <= 0)
>> +		fputs(o.obuf.buf, stdout);
>> +	strbuf_release(&o.obuf);
>> +	if (ret < 0) {
>> +		strbuf_release(&ref_name);
>> +		rollback_lock_file(&lock);
>> +		return error(_("conflicts while merging '%.*s'"),
>> +			     merge_arg_len, arg);
>> +	}
> 
> If there are conflicts then ret == 0 rather than -1
> 
>> +
>> +	if (active_cache_changed &&
>> +	    write_locked_index(&the_index, &lock, COMMIT_LOCK)) {
>> +		strbuf_release(&ref_name);
>> +		return error(_("merge: Unable to write new index file"));
>> +	}
>> +	rollback_lock_file(&lock);
>> +
>> +	ret = run_git_commit(git_path_merge_msg(), opts, run_commit_flags);
> 
> If there were conflicts this will try and run git commit with unmerged
> cache entries
> 
>> +	strbuf_release(&ref_name);
>> +
>> +	return ret;
>> +}
>> +
> 
> If the merge fails with an error rather than conflicts then I think it
> should be rescheduled as we do for picks that fail with an error. The
> patch below does that and also adjusts the logic following the merge so
> that it does not call 'git commit' when there are conflicts. I think we
> may want to say something about fixing the conflicts and running
> 'git rebase --continue' as we do for conflicts when picking.
> 
> Best Wishes
> 
> Phillip
> 
> --->8---
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> Subject: [PATCH] fixup! sequencer: introduce the `merge` command
> 
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index e1b9be7327..511b7fddca 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2807,27 +2807,26 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
>  	o.buffer_output = 2;
>  
>  	ret = merge_recursive(&o, head_commit, merge_commit, reversed, &i);
> -	if (!ret)
> -		rerere(opts->allow_rerere_auto);
> +	strbuf_release(&ref_name);
>  	if (ret <= 0)
>  		fputs(o.obuf.buf, stdout);
>  	strbuf_release(&o.obuf);
>  	if (ret < 0) {
> -		strbuf_release(&ref_name);
>  		rollback_lock_file(&lock);
> -		return error(_("conflicts while merging '%.*s'"),
> -			     merge_arg_len, arg);
> +		return ret;
>  	}
>  
>  	if (active_cache_changed &&
> -	    write_locked_index(&the_index, &lock, COMMIT_LOCK)) {
> -		strbuf_release(&ref_name);
> +	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
>  		return error(_("merge: Unable to write new index file"));
> -	}
>  	rollback_lock_file(&lock);
> +	if (!ret) {
> +		rerere(opts->allow_rerere_auto);
> +		error(_("conflicts while merging '%.*s'"), merge_arg_len, arg);
> +		return 1;
> +	}
>  
>  	ret = run_git_commit(git_path_merge_msg(), opts, run_commit_flags);
> -	strbuf_release(&ref_name);
>  
>  	return ret;
>  }
> @@ -3030,7 +3029,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  			return error(_("unknown command %d"), item->command);
>  
>  		if (res < 0 && (item->command == TODO_LABEL ||
> -				item->command == TODO_RESET)) {
> +				item->command == TODO_RESET ||
> +				item->command == TODO_MERGE)) {

Unfortunately it's not as simple as that - we only want to reschedule if
merge_recursive() fails, not if run_git_commit() does.


>  			/* Reschedule */
>  			todo_list->current--;
>  			save_todo(todo_list, opts);
> 

