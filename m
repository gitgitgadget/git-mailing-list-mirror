Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A90C1FF1E
	for <e@80x24.org>; Mon, 30 Jan 2017 23:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbdA3XVp (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 18:21:45 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33285 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbdA3XVo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 18:21:44 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so24533776pfg.0
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 15:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pZIMpmq1MKIlbMyESskMH4/X8pdo9JJDvkpdILXaoT4=;
        b=tisO20GwFaBMws17vWRqnPNCiVxv4b3eyhG72sUu0d4p4tmmUuCZ4WMYq9V9NOf7Nf
         Ryx9Fse2zu/4C+KmW5L5VlWJepwtDlMaF7V3rIMYQK6JgDPAzxob6FR0dIp8hRfScleD
         XxMGnrllFwyw6/B9xXpfq555pPNTb/1+x6zXa+gY6WFUkTtQ6ayCoSjW0GJxniOlJEi4
         vENzr57RHvBDTTpV6xttHoKmMYUyJXABa3I/V6EsARwIhyOR7Bx6Izxhw4EhSLNpoZ+m
         v7Ne+CNYXIFjZC1kOMNrQwaNzUJQiTxiIb6RzM0qNEjtHWKr4iVlmBX8uERwWlq5eGNz
         +CIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pZIMpmq1MKIlbMyESskMH4/X8pdo9JJDvkpdILXaoT4=;
        b=XiQzXKVm4kJQdAnCK2Px9t77PjXpLf2ukEcQ5HmXbworWgKCnkACT55uSTIliQpx3E
         UoGWbwheSYE40/0wKbaLQYTO04h6rK41nlE1pxxWzoeJM6y6+MKskhO4JGTBJRfwq1mg
         vOofsxCdCGsoyXm46UVvpnt2EiASsBqe1gLXwwAe3W+OKiYHoxfhvD79gJdoLF13+oH7
         ztjkVLzNPU3Yr9W3q6Q5nyHjJQRc9hey64Bo0KGCyUQnBtWxJ4V7c2RInKLFr9ggXf6t
         Ud9skm56qkj2koOiKxjvawGB0LQ88gkjJ1V8UCjtVsqWyQJws477B/S20r+VhiNL5RIe
         BxDg==
X-Gm-Message-State: AIkVDXLMvi4hB0tlTN3mMu76jbaY8Mi6bddVj+NwpSp3Pbz3nERRHSM1pPH/vdDZlPf3yg==
X-Received: by 10.99.36.7 with SMTP id k7mr26725731pgk.199.1485818498681;
        Mon, 30 Jan 2017 15:21:38 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id x16sm35196052pfk.79.2017.01.30.15.21.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 15:21:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] merge-recursive: make "CONFLICT (rename/delete)" message show both paths
References: <1485636764.2482.2.camel@mattmccutchen.net>
Date:   Mon, 30 Jan 2017 15:21:37 -0800
In-Reply-To: <1485636764.2482.2.camel@mattmccutchen.net> (Matt McCutchen's
        message of "Sat, 28 Jan 2017 15:37:01 -0500")
Message-ID: <xmqqvaswrv5q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

> The current message printed by "git merge-recursive" for a rename/delete
> conflict is like this:
>
> CONFLICT (rename/delete): new-path deleted in HEAD and renamed in
> other-branch. Version other-branch of new-path left in tree.
>
> To be more helpful, the message should show both paths of the rename and
> state that the deletion occurred at the old path, not the new path.  So
> change the message to the following format:
>
> CONFLICT (rename/delete): old-path deleted in HEAD and renamed to
> new-path in other-branch. Version other-branch of new-path left in tree.

Sounds like a sensible goal.

> Please check that my refactoring is indeed correct!  All the existing tests pass
> for me, but the existing test coverage of these conflict messages looks poor.

This unfortunately is doing a bit too many things at once from that
point of view.  I need to reserve a solid quiet 20-minutes without
distraction to check it, which I am hoping to do tonight.

Thanks.

>
>  merge-recursive.c              | 117 ++++++++++++++++++++++-------------------
>  t/t6045-merge-rename-delete.sh |  23 ++++++++
>  2 files changed, 86 insertions(+), 54 deletions(-)
>  create mode 100755 t/t6045-merge-rename-delete.sh
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d327209..e8fce10 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1061,16 +1061,20 @@ static int merge_file_one(struct merge_options *o,
>  }
>  
>  static int handle_change_delete(struct merge_options *o,
> -				 const char *path,
> +				 const char *path, const char *old_path,
>  				 const struct object_id *o_oid, int o_mode,
> -				 const struct object_id *a_oid, int a_mode,
> -				 const struct object_id *b_oid, int b_mode,
> +				 const struct object_id *changed_oid,
> +				 int changed_mode,
> +				 const char *change_branch,
> +				 const char *delete_branch,
>  				 const char *change, const char *change_past)
>  {
> -	char *renamed = NULL;
> +	char *alt_path = NULL;
> +	const char *update_path = path;
>  	int ret = 0;
> +
>  	if (dir_in_way(path, !o->call_depth, 0)) {
> -		renamed = unique_path(o, path, a_oid ? o->branch1 : o->branch2);
> +		update_path = alt_path = unique_path(o, path, change_branch);
>  	}
>  
>  	if (o->call_depth) {
> @@ -1081,43 +1085,43 @@ static int handle_change_delete(struct merge_options *o,
>  		 */
>  		ret = remove_file_from_cache(path);
>  		if (!ret)
> -			ret = update_file(o, 0, o_oid, o_mode,
> -					  renamed ? renamed : path);
> -	} else if (!a_oid) {
> -		if (!renamed) {
> -			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
> -			       "and %s in %s. Version %s of %s left in tree."),
> -			       change, path, o->branch1, change_past,
> -			       o->branch2, o->branch2, path);
> -			ret = update_file(o, 0, b_oid, b_mode, path);
> -		} else {
> -			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
> -			       "and %s in %s. Version %s of %s left in tree at %s."),
> -			       change, path, o->branch1, change_past,
> -			       o->branch2, o->branch2, path, renamed);
> -			ret = update_file(o, 0, b_oid, b_mode, renamed);
> -		}
> +			ret = update_file(o, 0, o_oid, o_mode, update_path);
>  	} else {
> -		if (!renamed) {
> -			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
> -			       "and %s in %s. Version %s of %s left in tree."),
> -			       change, path, o->branch2, change_past,
> -			       o->branch1, o->branch1, path);
> +		if (!alt_path) {
> +			if (!old_path) {
> +				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
> +				       "and %s in %s. Version %s of %s left in tree."),
> +				       change, path, delete_branch, change_past,
> +				       change_branch, change_branch, path);
> +			} else {
> +				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
> +				       "and %s to %s in %s. Version %s of %s left in tree."),
> +				       change, old_path, delete_branch, change_past, path,
> +				       change_branch, change_branch, path);
> +			}
>  		} else {
> -			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
> -			       "and %s in %s. Version %s of %s left in tree at %s."),
> -			       change, path, o->branch2, change_past,
> -			       o->branch1, o->branch1, path, renamed);
> -			ret = update_file(o, 0, a_oid, a_mode, renamed);
> +			if (!old_path) {
> +				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
> +				       "and %s in %s. Version %s of %s left in tree at %s."),
> +				       change, path, delete_branch, change_past,
> +				       change_branch, change_branch, path, alt_path);
> +			} else {
> +				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
> +				       "and %s to %s in %s. Version %s of %s left in tree at %s."),
> +				       change, old_path, delete_branch, change_past, path,
> +				       change_branch, change_branch, path, alt_path);
> +			}
>  		}
>  		/*
> -		 * No need to call update_file() on path when !renamed, since
> -		 * that would needlessly touch path.  We could call
> -		 * update_file_flags() with update_cache=0 and update_wd=0,
> -		 * but that's a no-op.
> +		 * No need to call update_file() on path when change_branch ==
> +		 * o->branch1 && !alt_path, since that would needlessly touch
> +		 * path.  We could call update_file_flags() with update_cache=0
> +		 * and update_wd=0, but that's a no-op.
>  		 */
> +		if (change_branch != o->branch1 || alt_path)
> +			ret = update_file(o, 0, changed_oid, changed_mode, update_path);
>  	}
> -	free(renamed);
> +	free(alt_path);
>  
>  	return ret;
>  }
> @@ -1125,28 +1129,17 @@ static int handle_change_delete(struct merge_options *o,
>  static int conflict_rename_delete(struct merge_options *o,
>  				   struct diff_filepair *pair,
>  				   const char *rename_branch,
> -				   const char *other_branch)
> +				   const char *delete_branch)
>  {
>  	const struct diff_filespec *orig = pair->one;
>  	const struct diff_filespec *dest = pair->two;
> -	const struct object_id *a_oid = NULL;
> -	const struct object_id *b_oid = NULL;
> -	int a_mode = 0;
> -	int b_mode = 0;
> -
> -	if (rename_branch == o->branch1) {
> -		a_oid = &dest->oid;
> -		a_mode = dest->mode;
> -	} else {
> -		b_oid = &dest->oid;
> -		b_mode = dest->mode;
> -	}
>  
>  	if (handle_change_delete(o,
>  				 o->call_depth ? orig->path : dest->path,
> +				 o->call_depth ? NULL : orig->path,
>  				 &orig->oid, orig->mode,
> -				 a_oid, a_mode,
> -				 b_oid, b_mode,
> +				 &dest->oid, dest->mode,
> +				 rename_branch, delete_branch,
>  				 _("rename"), _("renamed")))
>  		return -1;
>  
> @@ -1665,11 +1658,27 @@ static int handle_modify_delete(struct merge_options *o,
>  				 struct object_id *a_oid, int a_mode,
>  				 struct object_id *b_oid, int b_mode)
>  {
> +	const char *modify_branch, *delete_branch;
> +	struct object_id *changed_oid;
> +	int changed_mode;
> +
> +	if (a_oid) {
> +		modify_branch = o->branch1;
> +		delete_branch = o->branch2;
> +		changed_oid = a_oid;
> +		changed_mode = a_mode;
> +	} else {
> +		modify_branch = o->branch2;
> +		delete_branch = o->branch1;
> +		changed_oid = b_oid;
> +		changed_mode = b_mode;
> +	}
> +
>  	return handle_change_delete(o,
> -				    path,
> +				    path, NULL,
>  				    o_oid, o_mode,
> -				    a_oid, a_mode,
> -				    b_oid, b_mode,
> +				    changed_oid, changed_mode,
> +				    modify_branch, delete_branch,
>  				    _("modify"), _("modified"));
>  }
>  
> diff --git a/t/t6045-merge-rename-delete.sh b/t/t6045-merge-rename-delete.sh
> new file mode 100755
> index 0000000..8f33244
> --- /dev/null
> +++ b/t/t6045-merge-rename-delete.sh
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +
> +test_description='Merge-recursive rename/delete conflict message'
> +. ./test-lib.sh
> +
> +test_expect_success 'rename/delete' '
> +echo foo >A &&
> +git add A &&
> +git commit -m "initial" &&
> +
> +git checkout -b rename &&
> +git mv A B &&
> +git commit -m "rename" &&
> +
> +git checkout master &&
> +git rm A &&
> +git commit -m "delete" &&
> +
> +test_must_fail git merge --strategy=recursive rename >output &&
> +test_i18ngrep "CONFLICT (rename/delete): A deleted in HEAD and renamed to B in rename. Version rename of B left in tree." output
> +'
> +
> +test_done
