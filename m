Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBF1C1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 02:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfHBC5b (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 22:57:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43999 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfHBC5b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 22:57:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so26048726pld.10
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 19:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xPeD8uQmotn6NbS1LGn7IuVAsoFlbh1fy5+Ih5bofaU=;
        b=tDAr9eNKLMPI05X2NfY9iAJj9PRvw26HEv0CJLcA/yrB4exdn6FFqGwNw3KE02CNzs
         mWCBNrzltF1aCi8tUOWrm+1mv7c+LgsRBKt7zEyfICw4YwcDRMlv8KLZwd+oPgS/2Zr1
         NcgNgCNPIHHI0RhX0oJ7yifPp6jpyX3kT0pPyglzV/Qy2hHGXKnBt+rzoNfqDwcC6LSH
         +nNGQ7OXsD/DA0nfRlGPZd20arTzFWfCAIE7nWuakS89PiDACMyj5oD3A91pjlSQserc
         b6GabuOq+2ylLvH4HHvjqduudIvznwReKZkYf/jX8KaDh64XL/pjD+5WVoZ7E0bpefRw
         NaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xPeD8uQmotn6NbS1LGn7IuVAsoFlbh1fy5+Ih5bofaU=;
        b=n74UW5viSzKinnNVUdM+goSE2glSC0Qb+x5gka8862c17EZ02hYqOHYuG4087MzE5X
         nwRBgVpTnhIIJz62RJQqJ6aoAVXyTJThVdOWaQngPPE9UXpsApSmxKqjZBmLcf88QkV7
         v3Eg6rvoVfwrKx3y/HxGGMfKlXj4cquclCTqn9GrDZOXoGQvks8JrSBdjGnWczFnLTQV
         rn+KPhmEIZ6onlp4I4P6Y4ToleDNPr94cK5F2+f1LAkKgDNpAYb3eTtZTUHg8AdbqEn8
         FYIh9I0Se0OAwIZyIWvPOijVO6vCBM8bTvCRfBuPcfsBgV/HAp84idgh57V/DXNHzFNf
         Wt8w==
X-Gm-Message-State: APjAAAULTNC4dBcbuCZvjluRlq3tXyEv1uvj19nxbbOKq2EL/xThxx/Q
        20EOJmpYpSxrgc0qZszEXtg=
X-Google-Smtp-Source: APXvYqx3dr9xUyb7c0+T0AMHlYdXZskRsLpQEFqd75uRDMIiJrtTMvQQW9WxrJQOHoCaYUJMG9xv+w==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr125187116plp.95.1564714650716;
        Thu, 01 Aug 2019 19:57:30 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id v7sm33366870pff.87.2019.08.01.19.57.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 19:57:30 -0700 (PDT)
Date:   Thu, 1 Aug 2019 19:57:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Bryan Turner <bturner@atlassian.com>
Subject: Re: cannot clone --single-commit instead of --single-branch
Message-ID: <20190802025728.GD54514@google.com>
References: <CA+KyZp6mYx4C22syAu=W2Okf7tDwtQ+7vVUBaQ-2D70PTS+GaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KyZp6mYx4C22syAu=W2Okf7tDwtQ+7vVUBaQ-2D70PTS+GaA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc: Duy, who might enjoy this walk through history)
Hi,

Alexander Mills wrote:

> git clone --single-branch=<sha>
>
> doesn't seem to work?

I've occasionally wanted something like this (actually, I've wanted to
pass a refname like "refs/meta/config").  builtin/clone.c contains

	static struct ref *find_remote_branch(const struct ref *refs, const char *branch)
	{
		struct ref *ref;
		struct strbuf head = STRBUF_INIT;
		strbuf_addstr(&head, "refs/heads/");
		strbuf_addstr(&head, branch);
		ref = find_ref_by_name(refs, head.buf);
		strbuf_release(&head);

		if (ref)
			return ref;

So far, what one would expect.

		strbuf_addstr(&head, "refs/tags/");
		strbuf_addstr(&head, branch);
		ref = find_ref_by_name(refs, head.buf);
		strbuf_release(&head);

Wait a second: a tag isn't a branch, so why do we accept it as a
value for --branch?  So this is stretching definitions a little
already.

"git log -L:find_remote_branch:builtin/clone.c" tells me this is from
v1.7.10-rc0~125^2~3 (clone: allow --branch to take a tag, 2012-01-16):

	Because a tag ref cannot be put to HEAD, HEAD will become detached.
	This is consistent with "git checkout <tag>".

I think ideally we could first check for a sha1 and then try the full
set of patterns from ref_rev_parse_rules.  What do you think?  Would
you be interested in taking a stab at it?

Thanks,
Jonathan
