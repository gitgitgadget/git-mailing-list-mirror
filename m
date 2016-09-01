Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 427AF2035F
	for <e@80x24.org>; Thu,  1 Sep 2016 08:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbcIAIdk (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 04:33:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35326 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbcIAIdg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 04:33:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id c133so2634716wmd.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 01:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KPT8IE1fMIV+vw9We/TOWDWrqGaxaO3Vi8b8czB73A4=;
        b=DxaJaGJ1feA9n4CRoI6+NcTIgWMwMEqjpaR0U0hnCVNTawly0Ezv8HPCOoDKOXhjLS
         DsglTYukpziuckSgqTfT/HRN1MRnlhoS5tFS9FG+W1bQ0ql8jDO23+id33/UFCjFCHkV
         +OAKkFz7ZeSOYnjGjRNwCzE7xAnSLkm3RDJ99R+ZXowuRQqQcDQnOdP6xC3ckPobnw+d
         linXvLFbudGYToaAsXeOrdXx3HAk9odXXjOhMbDm5NhQCHUk4Cx5TQCLKwQb3AYYkq6H
         FTlXYN0cJC1WBpSoTUYicy9XU1f56OfrZqXZDHMOkWUuVVWjfZHbmoTsxBvymDjget6j
         NTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPT8IE1fMIV+vw9We/TOWDWrqGaxaO3Vi8b8czB73A4=;
        b=VHxmyUcXsQYCp06eC6tWtetPmCDP+DBS/X6XziXE0M5Kne1g4VHd6g8TsMosAqTIW2
         w/UdmCG1dLZIt8PfkfFlmQbHvyoeYlTbIgpytabpfu1BqPBmRxSnhM1uhMXDbwhRLsmD
         aF8o1VsiU2vfe5DX4Ov98lIhVHOrZPbFhxRz5h9Eze/v/GyzOn8oKonAPz4PM23GbF3y
         ErYKOy2dpHv+Av5lYYNbBW1KV4jmz8n0/glE/gTZk+XQJMnj+VyCqdNuse9s8jRJ57XY
         XH31CqR9CzaxdngBNRgpkuJsH47u0sPQKDm0BBL8oQY1kg0kSn9cABqNBVPoIveyAt3/
         Sj0g==
X-Gm-Message-State: AE9vXwPYHm85piViLRZTAHd4hKTbzDD6TrhRYBN+ylmSjpOiz5wEx+xveW7DIrZ2gKWTMA==
X-Received: by 10.194.27.202 with SMTP id v10mr12366406wjg.140.1472718814219;
        Thu, 01 Sep 2016 01:33:34 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id q4sm4013585wjk.24.2016.09.01.01.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 01:33:33 -0700 (PDT)
Message-ID: <1472718812.4680.20.camel@kaarsemaker.net>
Subject: Re: [PATCH 32/34] sequencer (rebase -i): show the progress
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Thu, 01 Sep 2016 10:33:32 +0200
In-Reply-To: <3207457a57d056c3054faf718128fb5c806cb032.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
         <3207457a57d056c3054faf718128fb5c806cb032.1472633606.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On wo, 2016-08-31 at 10:56 +0200, Johannes Schindelin wrote:
> The interactive rebase keeps the user informed about its progress.
> If the sequencer wants to do the grunt work of the interactive
> rebase, it also needs to show that progress.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 89fd625..e8c6daf 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1218,6 +1218,7 @@ struct todo_list {
>  	struct strbuf buf;
>  	struct todo_item *items;
>  	int nr, alloc, current;
> +	int done_nr, total_nr;
>  };
>  
>  #define TODO_LIST_INIT { STRBUF_INIT }
> @@ -1329,6 +1330,17 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
>  	return res;
>  }
>  
> +static int count_commands(struct todo_list *todo_list)
> +{
> +	int count = 0, i;
> +
> +	for (i = 0; i < todo_list->nr; i++)
> +		if (todo_list->items[i].command != TODO_COMMENT)
> +			count++;
> +
> +	return count;
> +}
> +
>  static int read_populate_todo(struct todo_list *todo_list,
>  			struct replay_opts *opts)
>  {
> @@ -1355,6 +1367,22 @@ static int read_populate_todo(struct todo_list *todo_list,
>  	if (!todo_list->nr &&
>  	    (!is_rebase_i(opts) || !file_exists(rebase_path_done())))
>  		return error(_("No commits parsed."));
> +
> +	if (is_rebase_i(opts)) {
> +		struct todo_list done = TODO_LIST_INIT;
> +
> +		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
> +				!parse_insn_buffer(done.buf.buf, &done))
> +			todo_list->done_nr = count_commands(&done);
> +		else
> +			todo_list->done_nr = 0;
> +
> +		todo_list->total_nr = todo_list->done_nr
> +			+ count_commands(todo_list);
> +
> +		todo_list_release(&done);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1900,6 +1928,11 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  		if (save_todo(todo_list, opts))
>  			return -1;
>  		if (is_rebase_i(opts)) {
> +			if (item->command != TODO_COMMENT)
> +				fprintf(stderr, "Rebasing (%d/%d)%s",
> +					++(todo_list->done_nr),
> +					todo_list->total_nr,
> +					opts->verbose ? "\n" : "\r");
>  			unlink(rebase_path_message());
>  			unlink(rebase_path_author_script());
>  			unlink(rebase_path_stopped_sha());

(picking a random commit that shows this 'symptom')

You're sprinking a lot of is_rebase_i's around sequencer.c to make sure
there are no changes in behaviour. I wonder if the right balance has
been struck between 'no changes in behaviour' and 'common behaviour'.
For instance, in this case, maybe it would be a better idea for non-
rebase uses of the sequencer to also show progress.

D.
