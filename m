Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C041FAF4
	for <e@80x24.org>; Fri, 10 Feb 2017 09:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbdBJJQx (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 04:16:53 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36760 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdBJJQs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 04:16:48 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so2206725pfo.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 01:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kF6x/3he/rU9NH12OALf6mSY/Rxqy/xTp9RFWY0KWbA=;
        b=ra/KuLkP96sybbaii8E+6lpbWluXBKR+abUF+DVSQYA06wedCDaPdKm5YwUc+3HN/b
         vm+C34df391zWJf5W9bizMr4rcW3pF6u4h5nhvWOqQz7/7XMDIIwc/p8DiwjAED2nGle
         GPop6ZfDa7EaNiUdEJZ9BJHlG9iqiGvpX/Bu6Wl0FRz+i0SQ2AhfYAy9Ey7cka6qOncI
         kdBeSEsp/yxu7roBuYMBfMGQCVy/F7k7U4fedLsi8yu3r4hoR4YaQWbnjkK/H4lNv5s3
         0CXI75q7V1rG2EnwGzBvpRber7p3eNSZ14POJROujJ7SfWd+vuOyCnw9a73b8EMjdfbr
         KN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kF6x/3he/rU9NH12OALf6mSY/Rxqy/xTp9RFWY0KWbA=;
        b=lMe/yR4d1XzeanP5JfP3vRycdM7P+KanxfrKr27tjK3iUDWTz/I0tkAmwtSaSiFfzK
         TElxbP5gbce3rqO0PQnpNHCy2iFB0z+wxLkANWVgXPXaq5XV8XdMS39xnXU+KQKN+kGk
         b4tXkYeua8qy9zt9JWrkMX9o1fNExqEIahihFUI0NEyxMvpU+9dL5lzMZCTcgCHCN3Do
         amHGHYEFqshD2wUc6AWBJlZPegN6WcxJ3DlU79JWI3gQIsClPnFNWIb++rMp9SrcgqLq
         y4/Flf83uLDHJnQrJL71VN1lH+488juZTpTgJQwExBM5gaQLJIQHmLRNhykmnCeQbIY+
         7wFA==
X-Gm-Message-State: AMke39lXGZmrN46c++9sL+nT4pizT5WDvQOqRU+IQEE1GVlqVBoomIQFFYgh2SwhjDoBbw==
X-Received: by 10.84.198.35 with SMTP id o32mr10061581pld.135.1486718207797;
        Fri, 10 Feb 2017 01:16:47 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id p14sm478111pfl.75.2017.02.10.01.16.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 01:16:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, peff@peff.net, pclouds@gmail.com
Subject: Re: [PATCH v2] gc: ignore old gc.log files
References: <20170209191724.3987-1-dturner@twosigma.com>
Date:   Fri, 10 Feb 2017 01:16:45 -0800
In-Reply-To: <20170209191724.3987-1-dturner@twosigma.com> (David Turner's
        message of "Thu, 9 Feb 2017 14:17:24 -0500")
Message-ID: <xmqq37fmmmma.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> The intent of automatic gc is to have a git repository be relatively
> low-maintenance from a server-operator perspective.  

This is diametrically opposite from how I recall the auto-gc came
about in Sep 2007.  The primary purpose was to help desktop clients
that never runs repack.

By pointing this out, I do not mean that we shouldn't make auto-gc
work well in the server settings.  I however do not want our log
messages to distort history in order to justify a change that is
worth making, and I do not think this change needs to do that.
For example, a paragraph like this:

    It would be really nice if the auto gc mechanism can be used to
    help server operators, even though the original purpose it was
    introduced was primarily to help desktop clients that never
    repacks.

followed by a description of what makes it not exactly helpful for
server operators in the current behaviour (iow, "what is it that you
are fixing?"), would be a useful justification that is faithful to
the history.  Of course, ", even though..." part is irrelevant
and/or unnecessary in that description of the motivation, and if you
omit it, I wouldn't call that is distorting the history.

> Of course, large
> operators like GitHub will need a more complicated management strategy,
> but for ordinary usage, git should just work.

True.  "should just work" may want to be replaced by what exactly
are the things it currently does that you view as its problems.

Once you say that, "git learns to do x and y" in the next paragraph,
i.e. the description of the solution to the problem, starts making
sense.

>
> In this commit, git learns to ignore gc.log files which are older than
> (by default) one day old.  It also learns about a config, gc.logExpiry
> to manage this.  There is also some cleanup: a successful manual gc,
> or a warning-free auto gc with an old log file, will remove any old
> gc.log files.
>
> So git should never get itself into a state where it refuses to do any
> maintenance, just because at some point some piece of the maintenance
> didn't make progress.  That might still happen (e.g. because the repo
> is corrupt), but at the very least it won't be because Git is too dumb
> to try again.

IOW, what you wrote in this last paragraph can come earlier to
explain what you perceive as problems the current behaviour has.

> Signed-off-by: David Turner <dturner@twosigma.com>
> Helped-by: Jeff King <peff@peff.net>
> ---

A v2 patch is unfriendly to reviewers unless it is sent with summary
of what got changed since v1, taking input from the discussion on
the previous round, and here before the diffstat is a good place to
do so.

> +gc.logExpiry::
> +	If the file gc.log exists, then `git gc --auto` won't run
> +	unless that file is more than 'gc.logExpiry' old.  Default is
> +	"1.day".  See `gc.pruneExpire` for more possible values.
> +

Micronit.  Perhaps you meant by "more possible values" "more ways to
specify its values", IOW, you didn't mean to say "instead of 1.day,
you can say 2.days".

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 331f21926..46edcff30 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -33,6 +33,7 @@ static int aggressive_window = 250;
>  static int gc_auto_threshold = 6700;
>  static int gc_auto_pack_limit = 50;
>  static int detach_auto = 1;
> +static unsigned long gc_log_expire_time;
>  static const char *prune_expire = "2.weeks.ago";
>  static const char *prune_worktrees_expire = "3.months.ago";
>  
> @@ -76,10 +77,12 @@ static void git_config_date_string(const char *key, const char **output)
>  static void process_log_file(void)
>  {
>  	struct stat st;
> -	if (!fstat(get_lock_file_fd(&log_lock), &st) && st.st_size)
> +	if (!fstat(get_lock_file_fd(&log_lock), &st) && st.st_size) {
>  		commit_lock_file(&log_lock);
> -	else
> +	} else {
> +		unlink(git_path("gc.log"));
>  		rollback_lock_file(&log_lock);

After we grab a lock by creating gc.log.lock, if we fail to fstat(2),
we remove gc.log?  That does not sound quite right, as the failure
to fstat(2) sounds like a log-worthy event.  Removing the log after
noticing that we didn't write anything (i.e. st.st_size being 0) is
quite sensible, though.

> @@ -111,6 +114,11 @@ static void gc_config(void)
>  	git_config_get_int("gc.auto", &gc_auto_threshold);
>  	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
>  	git_config_get_bool("gc.autodetach", &detach_auto);
> +
> +	if (!git_config_get_value("gc.logexpiry", &value)) {
> +		parse_expiry_date(value, &gc_log_expire_time);
> +	}

Drop {}?

> @@ -290,19 +298,34 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>  static int report_last_gc_error(void)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> -	int ret;
> +	int ret = 0;
> +	struct stat st;
> +	char *gc_log_path = git_pathdup("gc.log");
>  
> -	ret = strbuf_read_file(&sb, git_path("gc.log"), 0);
> +	if (stat(gc_log_path, &st)) {
> +		if (errno == ENOENT)
> +			goto done;
> +
> +		ret = error(_("Can't read %s"), gc_log_path);

You probably want to use error_errno() instead here.  This is not
"can't read"; your stat() noticed there is something wrong and you
gave up before you even attempted to read.

> +		goto done;
> +	}
> +
> +	if (st.st_mtime < gc_log_expire_time)
> +		goto done;

OK.

> +	ret = strbuf_read_file(&sb, gc_log_path, 0);
>  	if (ret > 0)
> -		return error(_("The last gc run reported the following. "
> +		ret = error(_("The last gc run reported the following. "
>  			       "Please correct the root cause\n"
>  			       "and remove %s.\n"
>  			       "Automatic cleanup will not be performed "
>  			       "until the file is removed.\n\n"
>  			       "%s"),
> -			     git_path("gc.log"), sb.buf);
> +			    gc_log_path, sb.buf);
>  	strbuf_release(&sb);
> -	return 0;
> +done:
> +	free(gc_log_path);
> +	return ret;
>  }

OK.

> @@ -349,6 +372,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  	argv_array_pushl(&prune_worktrees, "worktree", "prune", "--expire", NULL);
>  	argv_array_pushl(&rerere, "rerere", "gc", NULL);
>  
> +	/* default expiry time, overwritten in gc_config */
> +	parse_expiry_date("1.day", &gc_log_expire_time);

Alternatively, we can mimick the way in which prune_expire and
prune_worktrees_expire are set up (i.e. they are kept as strings,
configuration overwrites the string), and then turn the final string
into value after gc_config() returns.  I think what you wrote here
may be simpler.  Nice.

>  	gc_config();
>  
>  	if (pack_refs < 0)
> @@ -448,5 +473,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  		warning(_("There are too many unreachable loose objects; "
>  			"run 'git prune' to remove them."));
>  
> +	if (!daemonized)
> +		unlink(git_path("gc.log"));
> +

OK.  We want to remove "gc.log" after running a successful
foreground gc and this does exactly that.
