Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 647D71F804
	for <e@80x24.org>; Fri, 28 Dec 2018 20:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388031AbeL1UMU (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:12:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37065 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbeL1UMT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:12:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so20487303wmd.2
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 12:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=EU0gGSihhnJ9sPyX3sdStORFYxgCevMMxOeOkmGqnx0=;
        b=VfFk3KyHVmQne9g972Zb/LvpFU703zS7+MB7VYWYsGY06Crtgd5GTD49CbK/JG2ytP
         Xu9YWLTD7lidg9a4I7SCKske1BuoPyWYMzquO3gzn9X3ZTSbT6nscMeXLTuWo55bGons
         BP+zRDW28yY6RweW8kJj24gVLwrfs9AxU5Nnl/tlVqVPMBopSsFIuakka/L4JOIeEntp
         g7yizLiu9Bu660g4WKBXTps6e4DPE4Ech24XdmDWzt3KX9sTSQOO4dfe+wGikXriXX1u
         YJOQAKonnlAph3BjWAOU7WMZUQIWHSsO3OZz6+v+MZvpSfVcsceLD7dE8NOk6Nssc3E3
         BJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=EU0gGSihhnJ9sPyX3sdStORFYxgCevMMxOeOkmGqnx0=;
        b=XDS25OS5aMVT60VcwuhfKv50xLCbOi3eSA3boEko/O4Jgo48pOsrm27F/BwNC+JIov
         jCC0N2H5CIw4nZF8BRTltJLq/MkwJ/lxDSqRF/5lMLkLpBOT/+PeYPB7J1DNnx3/W738
         XkSWJLagtbfl4tPRiqpGlI61iuo45e/I22qg5aakUurSKizrbaEOkgogVdmnVdQLO7Pq
         7oz/TAAHISgAzwippxZzu3ZHTPJenxNRg9YetMLFUT1pclM3RNrpjFoK0VkFf5xCVX3L
         FrNCn6ESLDP/Jzr2iE25awwMW2fWpl+Olgt+eFpTttPzNEqabeHU/ml1o72vosoW4SCz
         wELA==
X-Gm-Message-State: AJcUukfIP1wD0bYKs1vQUMgBZJpkYFy7csDaIUmQmaE7sP7aDLZY/238
        JDQVfcLtG8IbiYwqgqYRacs=
X-Google-Smtp-Source: ALg8bN7unAczr5Nx71zNkKgQlZjZPpoyltXbTZSmNlpv84egOO7VsCodqnOA6AS4qjsxztBkDNAkXA==
X-Received: by 2002:a1c:7c3:: with SMTP id 186mr12888687wmh.41.1546027937147;
        Fri, 28 Dec 2018 12:12:17 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l20sm74676890wrb.93.2018.12.28.12.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 12:12:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/23] sb/more-repo-in-api
Date:   Wed, 26 Dec 2018 10:42:34 -0800
References: <20181215000942.46033-1-sbeller@google.com>
Message-ID: <xmqq36qho1gf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I realized next has not been rewound, so I can resend sb/more-repo-in-api,
> which I hereby do. The changes are minimal and address the only comment
> by Jonathan so far.

Yeah, the only change I see matches what is in your range-diff after
applying them to my tree.

Will rewind 'next' by the end of the year and replace the topic.  Thanks.

> 1:  99017ffac8 ! 1:  f24b120287 submodule: use submodule repos for object lookup
>     @@ -40,12 +40,13 @@
>      - * attempt to lookup both the left and right commits and put them into the
>      - * left and right pointers.
>      +/*
>     -+ * Initialize 'out' based on the provided submodule path.
>     ++ * Initialize a repository struct for a submodule based on the provided 'path'.
>      + *
>      + * Unlike repo_submodule_init, this tolerates submodules not present
>      + * in .gitmodules. This function exists only to preserve historical behavior,
>      + *
>     -+ * Returns 0 on success, -1 when the submodule is not present.
>     ++ * Returns the repository struct on success,
>     ++ * NULL when the submodule is not present.
>        */
>      -static void show_submodule_header(struct diff_options *o, const char *path,
>      +static struct repository *open_submodule(const char *path)
>     @@ -59,6 +60,7 @@
>      +		return NULL;
>      +	}
>      +
>     ++	/* Mark it as a submodule */
>      +	out->submodule_prefix = xstrdup(path);
>      +
>      +	strbuf_release(&sb);
> 2:  809765861c = 2:  25190d6174 submodule: don't add submodule as odb for push
> 3:  4a7735da72 = 3:  965421aab2 commit-graph: convert remaining functions to handle any repo
> 4:  aeeb1ba49e = 4:  bf31f32723 commit: prepare free_commit_buffer and release_commit_memory for any repo
> 5:  5ffebe9463 = 5:  c4e54e6b0d path.h: make REPO_GIT_PATH_FUNC repository agnostic
> 6:  9c89920c46 = 6:  a7ed0c57ba t/helper/test-repository: celebrate independence from the_repository
