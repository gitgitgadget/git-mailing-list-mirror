Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95B4C1FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 13:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbdJTNQY (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 09:16:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:59449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751154AbdJTNQX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 09:16:23 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOCSm-1eB0oC3hES-005Zen; Fri, 20
 Oct 2017 15:16:20 +0200
Date:   Fri, 20 Oct 2017 15:16:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Alex Vandiver <alexmv@dropbox.com>
cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 4/4] fsmonitor: Delay updating state until after split
 index is merged
In-Reply-To: <05670bb6e3c6378119b1649144c80dd6d72bfe29.1508461850.git.alexmv@dropbox.com>
Message-ID: <alpine.DEB.2.21.1.1710201503380.40514@virtualbox>
References: <20171020011136.14170-1-alexmv@dropbox.com> <05670bb6e3c6378119b1649144c80dd6d72bfe29.1508461850.git.alexmv@dropbox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jWukY/jRa0lUojR/E/lRUc/bLZfEMq26JeSzUoxwhXqquXnvVnG
 vS1l6d+p7yVJw0htuc5TFEyAHIgOnM0lKaqaj+g7EAnY/pnjvjcc0Bx/mptyeGdK8CLjN+v
 O2bN+i4Ubtm+CbqFA5hshYYkGOlQlSvNlH3LImkWZFOTeE72nDcRZiPLIgF20IYoV4I0XVx
 u984jRIrcvWtghsnCFukA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zzUSa/5tdmE=:xSJdG9PPBU4qtPtSIr5WKF
 fWJIvYv4C1Nls5f7WzN3D95yIn5HrqyD7Oq3exIMmAl+qF+D0sQ3beLzVov9A9bj39Z8K3ss9
 N2NJM7gclesNoRfJIopMysfXiToustSf1/2iA67hl1MVzWebGJl0zbcINYTBCKy6ia/yXnVxP
 fN7TDoW4wHXz3fmchHA95IcgHRVbO9BusUbewA8mDOq/HSbYcOyLVEihW0mb8xZSpT87oxZ3P
 UCqtshAcX9SNxLaUwSm6vO6W1mo9LLh/bGEXDY/w3oQ89BJXsFn48l3DG8d/UjTE2qS4SUC4E
 ZMzr85dy/1AlGSVsSkmwiDg+xlTY8wHNeg8IDgCGpgLf2GQUh8z8kqy6gADythoh3BG3cuwYU
 I+ZlbEAiFleNnzOkQSyIf3vHCakZNtJVZQU1lzLskyHnnI0Z2cd03mxnuTe4yt/sDXVN8QmX7
 EcknGRb6CvjVM/zxVEjU0ussmAplDxj7AjyxYi+lglzhWJdwNBG88ARttwH9W6+TI7JNPn28w
 57PSs7C7WRlN83cMW1QhMiOa9RokvQNvzf1kQljwqk+jCmh9MooXpajs8uOofCPa3UBIzOTJF
 YPUXi1U8Vc82YxSlQJMpMyQ29D/HKZ4urozT0KFUMU1gt/dhZlTVH+3huH9bKry8avwL+QY6v
 1DnnEoO5U0oj4VjB8Tc9wTPDk1iH/9JKuPYKWAASW4TZMJtDZQv280P6qXmv3B/zd/XrORDBO
 fHLtTlDW0yL67zStVtVNKW6+rV8xFPXZB/4KYtK+mkXYuJhZTvWtXe7jFrZZ/3rhyTJCEsQ4t
 RgxuDkd5okqGCX00r2SC8rnEY70yBYEUtsijFAlagiAxS44C2dYynEsoI59yNWIWu/RB9xr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Thu, 19 Oct 2017, Alex Vandiver wrote:

>  extern struct index_state the_index;
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 7c1540c05..4c2668f57 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -49,20 +49,7 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
>  		ewah_free(fsmonitor_dirty);
>  		return error("failed to parse ewah bitmap reading fsmonitor index extension");
>  	}
> -
> -	if (git_config_get_fsmonitor()) {
> -		/* Mark all entries valid */
> -		for (i = 0; i < istate->cache_nr; i++)
> -			istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
> -
> -		/* Mark all previously saved entries as dirty */
> -		ewah_each_bit(fsmonitor_dirty, fsmonitor_ewah_callback, istate);
> -
> -		/* Now mark the untracked cache for fsmonitor usage */
> -		if (istate->untracked)
> -			istate->untracked->use_fsmonitor = 1;
> -	}
> -	ewah_free(fsmonitor_dirty);
> +	istate->fsmonitor_dirty = fsmonitor_dirty;

From the diff, it is not immediately clear that fsmonitor_dirty is not
leaked in any code path.

Could you clarify this in the commit message, please?

> @@ -238,6 +225,29 @@ void remove_fsmonitor(struct index_state *istate)
>  
>  void tweak_fsmonitor(struct index_state *istate)
>  {
> +	int i;
> +
> +	if (istate->fsmonitor_dirty) {
> +		/* Mark all entries valid */
> +		trace_printf_key(&trace_fsmonitor, "fsmonitor is enabled; cache is %d", istate->cache_nr);

Sadly, a call to trace_printf_key() is not really a noop when tracing is
disabled. The call to trace_printf_key() hands off to trace_vprintf_fl(),
which in turn calls prepare_trace_line() which asks trace_want() whether
we need to trace, which finally calls get_trace_fd(). This last function
initializes a trace key if needed, and this entire call stack takes time.

In this case, where we trace whether fsmonitor is enabled essentially once
during the life cycle of the current Git command invocation, it may be
okay, but later we perform a trace for every single ie_match_stat() call,
which I think should be guarded to avoid unnecessary code churn in
performance critical code paths (O(N) is pretty good until the constant
factor becomes large).

> +		for (i = 0; i < istate->cache_nr; i++) {
> +			istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
> +		}
> +		trace_printf_key(&trace_fsmonitor, "marked all as valid");
> +
> +		/* Mark all previously saved entries as dirty */
> +		trace_printf_key(&trace_fsmonitor, "setting each bit on %p", istate->fsmonitor_dirty);
> +		ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
> +
> +		/* Now mark the untracked cache for fsmonitor usage */
> +		trace_printf_key(&trace_fsmonitor, "setting untracked state");
> +		if (istate->untracked)
> +			istate->untracked->use_fsmonitor = 1;
> +		ewah_free(istate->fsmonitor_dirty);

At this point, please set istate->fsmonitor_dirty = NULL, as it is not
immediately obvious from this patch (or from the postimage of this diff)
that the array is not used later on.

> +	} else {
> +		trace_printf_key(&trace_fsmonitor, "fsmonitor not enabled");
> +	}
> +
>  	switch (git_config_get_fsmonitor()) {
>  	case -1: /* keep: do nothing */
>  		break;
> diff --git a/read-cache.c b/read-cache.c
> index c18e5e623..3b5cd00a2 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -330,6 +330,10 @@ int ie_match_stat(struct index_state *istate,
>  		return 0;
>  	if (!ignore_fsmonitor && (ce->ce_flags & CE_FSMONITOR_VALID))
>  		return 0;
> +	if (ce->ce_flags & CE_FSMONITOR_VALID)
> +		trace_printf_key(&trace_fsmonitor, "fsmon marked valid for %s", ce->name);
> +	if (ignore_fsmonitor)
> +		trace_printf_key(&trace_fsmonitor, "Ignoring fsmonitor for %s", ce->name);

This is the code path I am fairly certain should not be penalized if
tracing is disabled.

Ciao,
Johannes
