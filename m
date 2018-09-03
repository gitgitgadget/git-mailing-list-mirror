Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE431F404
	for <e@80x24.org>; Mon,  3 Sep 2018 19:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeICXch (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 19:32:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:40365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727493AbeICXch (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 19:32:37 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LxxNo-1frNy71jgS-015Idr; Mon, 03
 Sep 2018 21:11:03 +0200
Date:   Mon, 3 Sep 2018 21:11:02 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 20/20] stash: replace all `write-tree` child
 processes with API calls
In-Reply-To: <c26283d74e3f761a554940e3e0db13cef1b613d5.1535665109.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809032110520.71@tvgsbejvaqbjf.bet>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com> <c26283d74e3f761a554940e3e0db13cef1b613d5.1535665109.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UZedlozznmvro/yQ4T3DQmpnM+G8kpXi+2CxlVi0BOpFiLO9Ik4
 PFggAyy4HzWpkRCatAU3uXwvlVhYLtkpbGInCFClbuxmBfxO89dfzc/oHlF8vEQyZ73Eqwc
 YyuliEQD97Pf8ONXrIRpPciUhn4snMSCXLR2wfE7ZWjabkL+sfUgX7QnYcgtYJ/0Fz2zRdv
 bZg5csBYUmMZWc6Wx2x4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UA5JYzixdjY=:8Hcj1sTkUav6c37UgQi1kM
 NhiXGu8orYXlc4M1s4lRgUOX5fidZQAqT2wrmWdJn1yTtFGlIzccvS+mMMbu1vh22PYC0w32O
 TyPsF7j5nLf9Wk8iH373EYz3Veo2ZI2gGfb8XPxGs1cy5z0B3KDWT1CDh3pxTOcrd/O1FtrSt
 +/O7g3XLX8pAnrXEnj9uZY7GHUP3M0YwT0ngL4IYxliBCXsiwdm+omxPOnLYc6lE9LZNrXr55
 xJYFXs5f4TOzAUlb4Kq9fg+2yM+1cRhRY8xPKKDi5GiDnRLdJ7QH/xlyM/0sTssRycTfHQeyJ
 k6uLm1uQbhaHWsL9A42pnKQAtSUC8cqfPykcqRh3W0smeqIlhJMcz2ZcFCuvvn4RC+VTnxZ5E
 iGMgXsOV6oILHego71gxsJR4idzY1oFDshZ2Ps3bLTuU9Jn1mjQXVUsS93Lx/RkbSvOCPVnYs
 SfHuYkRfLRo0bnkzoRouO3WH9mqjW3mhDzoSrsmdhmA+lT7cHeApcM8jQXhsi4GrzJmIpTATf
 /JoXS12qJCor1/JXWDiBruxx+fBycTvsgvP2tKiqT7EiXd2vBXMdK/vdj519rpAyJNp/zYcuo
 0Iu7wP4pB84LiAZ58aqJtSPiGq5bSJpV0YSXGsojJxlhPJFQ6ac42qnKW2MW25i8QPns2xJ+O
 qhX/93prHReJQ1azWFrLCQXe6eNbJs6SPKFxLITCJgPthNnoHQvfpWTRB2GxbS6zEp05LhMSB
 AIIBqTHvHTRY5spMil1NdLndcA/u0u3vsapeuuZK+YE6S3g71Frc9KVrgxWbwrZmq9RvXTAot
 KdiMBj+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Fri, 31 Aug 2018, Paul-Sebastian Ungureanu wrote:

> This commit replaces spawning `git write-tree` with API calls.
> 
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  builtin/stash.c | 41 ++++++++++++-----------------------------
>  1 file changed, 12 insertions(+), 29 deletions(-)

Very nice!

Thanks,
Dscho

> 
> diff --git a/builtin/stash.c b/builtin/stash.c
> index ba5818e24e..dd1084afd4 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -910,9 +910,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg)
>  {
>  	int ret = 0;
>  	struct strbuf untracked_msg = STRBUF_INIT;
> -	struct strbuf out = STRBUF_INIT;
>  	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
> -	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
> +	struct index_state istate = { NULL };
>  
>  	cp_upd_index.git_cmd = 1;
>  	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
> @@ -927,15 +926,11 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg)
>  		goto done;
>  	}
>  
> -	cp_write_tree.git_cmd = 1;
> -	argv_array_push(&cp_write_tree.args, "write-tree");
> -	argv_array_pushf(&cp_write_tree.env_array, "GIT_INDEX_FILE=%s",
> -			 stash_index_path.buf);
> -	if (pipe_command(&cp_write_tree, NULL, 0, &out, 0,NULL, 0)) {
> +	if (write_index_as_tree(&info->u_tree, &istate, stash_index_path.buf, 0,
> +				NULL)) {
>  		ret = -1;
>  		goto done;
>  	}
> -	get_oid_hex(out.buf, &info->u_tree);
>  
>  	if (commit_tree(untracked_msg.buf, untracked_msg.len,
>  			&info->u_tree, NULL, &info->u_commit, NULL, NULL)) {
> @@ -944,8 +939,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg)
>  	}
>  
>  done:
> +	discard_index(&istate);
>  	strbuf_release(&untracked_msg);
> -	strbuf_release(&out);
>  	remove_path(stash_index_path.buf);
>  	return ret;
>  }
> @@ -956,11 +951,10 @@ static int stash_patch(struct stash_info *info, struct pathspec ps, int quiet)
>  {
>  	int i;
>  	int ret = 0;
> -	struct strbuf out = STRBUF_INIT;
>  	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
>  	struct child_process cp_add_i = CHILD_PROCESS_INIT;
> -	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
>  	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
> +	struct index_state istate = { NULL };
>  
>  	remove_path(stash_index_path.buf);
>  
> @@ -985,17 +979,12 @@ static int stash_patch(struct stash_info *info, struct pathspec ps, int quiet)
>  		goto done;
>  	}
>  
> -	cp_write_tree.git_cmd = 1;
> -	argv_array_push(&cp_write_tree.args, "write-tree");
> -	argv_array_pushf(&cp_write_tree.env_array, "GIT_INDEX_FILE=%s",
> -			 stash_index_path.buf);
> -	if (pipe_command(&cp_write_tree, NULL, 0, &out, 0,NULL, 0)) {
> +	if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
> +				NULL)) {
>  		ret = -1;
>  		goto done;
>  	}
>  
> -	get_oid_hex(out.buf, &info->w_tree);
> -
>  	cp_diff_tree.git_cmd = 1;
>  	argv_array_pushl(&cp_diff_tree.args, "diff-tree", "-p", "HEAD",
>  			 oid_to_hex(&info->w_tree), "--", NULL);
> @@ -1011,7 +1000,7 @@ static int stash_patch(struct stash_info *info, struct pathspec ps, int quiet)
>  	}
>  
>  done:
> -	strbuf_release(&out);
> +	discard_index(&istate);
>  	remove_path(stash_index_path.buf);
>  	return ret;
>  }
> @@ -1020,10 +1009,9 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
>  {
>  	int ret = 0;
>  	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
> -	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
> -	struct strbuf out = STRBUF_INIT;
>  	struct strbuf diff_output = STRBUF_INIT;
>  	struct rev_info rev;
> +	struct index_state istate = { NULL };
>  
>  	set_alternate_index_output(stash_index_path.buf);
>  	if (reset_tree(&info->i_tree, 0, 0)) {
> @@ -1062,20 +1050,15 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
>  		goto done;
>  	}
>  
> -	cp_write_tree.git_cmd = 1;
> -	argv_array_push(&cp_write_tree.args, "write-tree");
> -	argv_array_pushf(&cp_write_tree.env_array, "GIT_INDEX_FILE=%s",
> -			 stash_index_path.buf);
> -	if (pipe_command(&cp_write_tree, NULL, 0, &out, 0,NULL, 0)) {
> +	if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
> +				NULL)) {
>  		ret = -1;
>  		goto done;
>  	}
>  
> -	get_oid_hex(out.buf, &info->w_tree);
> -
>  done:
> +	discard_index(&istate);
>  	UNLEAK(rev);
> -	strbuf_release(&out);
>  	object_array_clear(&rev.pending);
>  	strbuf_release(&diff_output);
>  	remove_path(stash_index_path.buf);
> -- 
> 2.19.0.rc0.22.gc26283d74e
> 
> 
