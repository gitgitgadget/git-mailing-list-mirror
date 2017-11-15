Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C88FC202D7
	for <e@80x24.org>; Wed, 15 Nov 2017 01:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755211AbdKOBwL (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 20:52:11 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:52833 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbdKOBwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 20:52:09 -0500
Received: by mail-io0-f182.google.com with SMTP id u42so8515238ioi.9
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 17:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUPa/coz2I7JApyyd7CupcammwdXBaxRzYArLifRzK0=;
        b=PhgTOJxZVFG3q013AHObg8Yqr4xYOMrRxSEypbVvOJfxUCZnk6poPLtlgDPDJdU6In
         5Y/QzE0oU0YGhWeCUJhx4Xjw3QQXWgOxtuMb+EQU063tfeikNc3dzSecLiSK/0WJQsmo
         Oc1oyN2g0UXuK5sOUElPt1sRPLn04052WlaD/u9XV8Xr7tJIH534BJJhJ34lOzysX1bD
         Tl7/xMOiefpXp3E5lHawe/wGtkOCFg9lbD+8+hEaYgcsMZIOtpLScICzzq9J11fxbf6e
         3EMVSmeyOKO+QZBgACZKlD91H9E+Q06JDihSno7WBaGr5NljmG1Ri5qzagIj+uaqUH/s
         l51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUPa/coz2I7JApyyd7CupcammwdXBaxRzYArLifRzK0=;
        b=QM5Ul3viVCITKIaeFbZyoTdYXENKX/Uce3zmzm/iQ3rhMOeC1+kROmI6EMhdNIB+43
         d9lNS8f+trzVbemsJcCvgvhGO+R8AvThI3AGD3rszjQGnl5z7kzP/bPC6hSY8p3Wc7io
         qsWf3JHtIH8LrwPqm5YhaRoxC2IeYdXRxiqJYAIdjQWNIcUuikEoDteDVxrTkNiESFF5
         GcYmsGb9Sck5b0Ae9ltwLF/hUTJvWlmbc/AiDkaWgUwuMuolAesOZQlXNvBSbc7OtGN2
         UXdtb8G8JHkUedXg4B1LLlxTgsBVdLo0ExO8IQxgzZk/sPiWDUBKPh3mAvR3NqSLJ4Jb
         z+Aw==
X-Gm-Message-State: AJaThX5UJBljFJT1kTtmKQ5ezXcdt0EO8TwVF8V5cBaUBvDsf9rf4KyI
        USz5z9ASVpAEG1p+O5gWYfEJAwQjKUs=
X-Google-Smtp-Source: AGs4zMbpaXCSwf2EbZuOrh5OBDKb5TiDbPVUkHI8Wm8jAhmlNwW+LUqicoG86he4rbhB78Z1je5tEA==
X-Received: by 10.107.131.99 with SMTP id f96mr14360511iod.215.1510710728716;
        Tue, 14 Nov 2017 17:52:08 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:68e8:a345:46:2771])
        by smtp.gmail.com with ESMTPSA id e203sm6164912itb.32.2017.11.14.17.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 17:52:08 -0800 (PST)
Date:   Tue, 14 Nov 2017 17:52:07 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCHv4 7/7] builtin/describe.c: describe a blob
Message-Id: <20171114175207.f23d492045d52b8aa16c00be@google.com>
In-Reply-To: <20171115003043.24080-8-sbeller@google.com>
References: <20171115003043.24080-1-sbeller@google.com>
        <20171115003043.24080-8-sbeller@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 14 Nov 2017 16:30:43 -0800
Stefan Beller <sbeller@google.com> wrote:

> The walking is performed in reverse order to show the introduction of a
> blob rather than its last occurrence.

The code as implemented here does not do this - it instead shows the last
occurrence.

>  NAME
>  ----
> -git-describe - Describe a commit using the most recent tag reachable from it
> +git-describe - Describe a commit or blob using the graph relations

I would write "Describe a commit or blob using a tag reachable from it".

> +If the given object refers to a blob, it will be described
> +as `<commit-ish>:<path>`, such that the blob can be found
> +at `<path>` in the `<commit-ish>`. Note, that the commit is likely
> +not the commit that introduced the blob, but the one that was found
> +first; to find the commit that introduced the blob, you need to find
> +the commit that last touched the path, e.g.
> +`git log <commit-description> -- <path>`.
> +As blobs do not point at the commits they are contained in,
> +describing blobs is slow as we have to walk the whole graph.

I think some of this needs to be updated?

> +static void process_object(struct object *obj, const char *path, void *data)
> +{
> +	struct process_commit_data *pcd = data;
> +
> +	if (!oidcmp(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
> +		reset_revision_walk();
> +		describe_commit(&pcd->current_commit, pcd->dst);
> +		strbuf_addf(pcd->dst, ":%s", path);
> +		pcd->revs->max_count = 0;
> +	}
> +}

Setting max_count to 0 does not work when reverse is used, because the
commits are first buffered into revs->commits (see get_revision() in
revision.c). There doesn't seem to be a convenient way to terminate the
traversal immediately - I think setting revs->commits to NULL should
work (but I didn't check). Remember to free revs->commits (using
free_commit_list) first.

> +test_expect_success 'describe a blob at a tag' '
> +	echo "make it a unique blob" >file &&
> +	git add file && git commit -m "content in file" &&
> +	git tag -a -m "latest annotated tag" unique-file &&
> +	git describe HEAD:file >actual &&
> +	echo "unique-file:file" >expect &&
> +	test_cmp expect actual
> +'

This is probably better named "describe a blob at a directly tagged
commit". (Should we also test the case where a blob is directly
tagged?)

> +test_expect_success 'describe a blob with its last introduction' '
> +	git commit --allow-empty -m "empty commit" &&
> +	git rm file &&
> +	git commit -m "delete blob" &&
> +	git revert HEAD &&
> +	git commit --allow-empty -m "empty commit" &&
> +	git describe HEAD:file >actual &&
> +	grep unique-file-3-g actual
> +'

The description is not true: firstly, this shows the last occurrence,
not the last introduction (you can verify this by adding another commit
and noticing that the contents of "actual" changes), and what we want is
not the last introduction anyway, but the first one.
