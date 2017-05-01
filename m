Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09751F829
	for <e@80x24.org>; Mon,  1 May 2017 03:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035563AbdEAD2R (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 23:28:17 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34299 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035556AbdEAD2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 23:28:16 -0400
Received: by mail-pg0-f66.google.com with SMTP id t7so14461758pgt.1
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 20:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jFngK7j2hybEc8ZnslnIr8eY7q7vtV10rCkd9tZpNEo=;
        b=tNG4t/LvefWVirThSv8bPMX8kmAAlvjQRcUvWCBx5tG64Tx5/R3ICHBLzCKQitfYXZ
         gSaqczyMdjDb7EO4EuVrMiMrwRwWRNhcOEwtwaOWPSN5vK5sMd3mmS8hpybuCNgAEM2A
         bJgjf/5WiKISp2K2C7sC1PLz+tyRPkL1Y5Dl5AEQJgKWO9yQAnuPqKuOWbQMdjaxGOcG
         ZoPd3Vhi/e3kdnPwc1B8JwySpd0EEtCGPqm6XCf4sNGKZc6qq52SkCaRxJRBJB44mTi1
         yxUOCWM4CAEU/C4ldlg3xUZAYNgKXPNr6DE1bOc7Ua1D9qClDIc2qwx/j1XKto/uDSzX
         BRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jFngK7j2hybEc8ZnslnIr8eY7q7vtV10rCkd9tZpNEo=;
        b=iTf8WMWXMYE1jp7JdP/tbcK80flZGcG03RHQjXU65cOm8pC0CVWIdhBQuyVdSXY325
         99BpzRv1C5uT7n25wd+ahytHxjdDzayXMml0b+IH3V4Ldz5wC+9PaBM0br2unYP+J3B1
         TvNgk2jvBZdy0z0HJXwKFs7vjXCnwMKa4pVMp81C65oxauGI+Fed2gykK39REbpZgVcl
         DMfA4bQJRWR/BN9gkOm04P/CcYvl13/61/FcbKMq36oEYQaTjBNDub/eRI4QM6vcNTEe
         Iuo9jOlpKrZmtEcTinL5eVAo8PpB+SaQ1eI7GUGbJHtqXgkUBUzslniv3hzF4np606tg
         8UsA==
X-Gm-Message-State: AN3rC/6fjTCYXx3WscpWnqz4FWN/8Ff2W1QJUzSoEtk5BAmRVNeWG/nD
        YNXymBiERNotsA==
X-Received: by 10.84.241.194 with SMTP id t2mr31779253plm.48.1493609295747;
        Sun, 30 Apr 2017 20:28:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id g71sm20903005pfc.41.2017.04.30.20.28.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 20:28:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] submodule: change string_list changed_submodule_paths
References: <20170428235402.162251-1-bmwill@google.com>
        <20170428235402.162251-5-bmwill@google.com>
Date:   Sun, 30 Apr 2017 20:28:14 -0700
In-Reply-To: <20170428235402.162251-5-bmwill@google.com> (Brandon Williams's
        message of "Fri, 28 Apr 2017 16:54:00 -0700")
Message-ID: <xmqqr309gss1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Eliminate a call to 'xstrdup()' by changing the string_list
> 'changed_submodule_paths' to duplicated strings added to it.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  submodule.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 7baa28ae0..3bcf44521 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -20,7 +20,7 @@
>  static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
>  static int config_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>  static int parallel_jobs = 1;
> -static struct string_list changed_submodule_paths = STRING_LIST_INIT_NODUP;
> +static struct string_list changed_submodule_paths = STRING_LIST_INIT_DUP;
>  static int initialized_fetch_ref_tips;
>  static struct oid_array ref_tips_before_fetch;
>  static struct oid_array ref_tips_after_fetch;
> @@ -939,7 +939,7 @@ static void submodule_collect_changed_cb(struct diff_queue_struct *q,
>  			struct string_list_item *path;
>  			path = unsorted_string_list_lookup(&changed_submodule_paths, p->two->path);
>  			if (!path && !is_submodule_commit_present(p->two->path, p->two->oid.hash))
> -				string_list_append(&changed_submodule_paths, xstrdup(p->two->path));
> +				string_list_append(&changed_submodule_paths, p->two->path);

I notice that "path" is not used at all, and other users of this
string list do not even bother using a variable, i.e.

	if (!unsorted_string_list_lookup(&changed_submodule_paths, ...))

In fact, it might be even better to use a hashmap for this instead?

The call to string_list_clear() onthis list tells it to free the
util field, and I went to see what we are storing in the util field,
but it seems that it is freeing NULLs, which is somewhat misleading
and time-wasting on the code readers.  Using hashmap may also clear
this up.

But all of the above are not within the scope of this topic ;-)
