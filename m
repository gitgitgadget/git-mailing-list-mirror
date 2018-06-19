Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A7E1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 16:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966940AbeFSQLK (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 12:11:10 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44187 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966700AbeFSQKB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 12:10:01 -0400
Received: by mail-lf0-f67.google.com with SMTP id p23-v6so313757lfh.11
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1h/fzTKAJ+ikstKjVdj5+YnFd13N7nkXfyLuvhWDou0=;
        b=Np25q3ZH641TqKh9MdT2cdFdvaNUay2t5jE8Am1N56qqUWgpdlTvmxcgsuZpro44Ut
         57XTN73FsZ9BuSlD+BasckSnsSJy3Th7H711tdS1smbL7u73qih7mlmkBpGqCIg5Mv0H
         6IynJnhHVNMNTiEgz9PP+za4G0u16HJVeP6yb8M1/JzrKek+XU3KOIGcFqRkM2UoRqEQ
         y+pmVoTCi8ppOyHYv+DCfYOLADoDldd3CqqiqOI3Tx6o8WYJB5dwQmciSVzo600TytOM
         k+yOqp4HnK1j8pneBw79V7lecp1sNCGdOJMktsvz1/6xsznCyn6mNbX9FI3rva+Po8Bg
         rVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1h/fzTKAJ+ikstKjVdj5+YnFd13N7nkXfyLuvhWDou0=;
        b=SiVXNFVV4YuIl6OLSW8jZ092UDMa1b1ubyoPBaL3Hssv8uGnkuL0jj7U1npEX9kgAt
         bZ2/zgi0TCEcUQFHNOXXwrnnddA9okdgx4MkRT/NCOqkBCFYIzmdgLqgS9EcYc9+Ne2A
         ewbftNzWLZ9iG1gIUl7y+jEzpyb4bWB3+naExkBTWhUzikapSMc5okCq2DBUehaRIYco
         Sxxi44dKAjuAucsWj9WONitzSZuYFhsHG9t1efX63YvnbpORAzTrhx6qxngD5wd6eWng
         1pIW+3+PQxh6OJZ9q1MnxVmESf3VVIYcaR+R+XYA/MzFwonQS7iUewWwyGN5tkOPMVlI
         2fvw==
X-Gm-Message-State: APt69E1VxR0BN8e3/8fI78/vl5k04g4UxvGI4CNs+RzGkqv03i/cIwKu
        dUthBAIF5GxfxEignXtHbVw=
X-Google-Smtp-Source: ADUXVKIAXPdoWt2kgF4nZcR8Kc0gqhJWuyUowAMbQn7vAV57/bEH6f+uKNp85vLpdaxB0rXel8tmBA==
X-Received: by 2002:a2e:9b91:: with SMTP id z17-v6mr11359692lji.121.1529424600236;
        Tue, 19 Jun 2018 09:10:00 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x68-v6sm10877lfb.25.2018.06.19.09.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 09:09:59 -0700 (PDT)
Date:   Tue, 19 Jun 2018 18:09:57 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: Adding nested repository with slash adds files instead of gitlink
Message-ID: <20180619160956.GA21384@duynguyen.home>
References: <20180618111919.GA10085@book.hvoigt.net>
 <CACsJy8CJGditaq4CZfJctVAe9QCdapWQW=W--AumH-4RWWd=vA@mail.gmail.com>
 <20180618181215.GB73085@google.com>
 <20180619103632.GC10085@book.hvoigt.net>
 <CACsJy8DQ-GGEDiV0iA2kTgNgHcT1sSX2Oqb7VZcjyK1nBOFv+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DQ-GGEDiV0iA2kTgNgHcT1sSX2Oqb7VZcjyK1nBOFv+A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 05:16:17PM +0200, Duy Nguyen wrote:
> No actually, we could do better. Let me see if I can come up with a
> patch or something...

OK. What we currently do is, when we search for potential untracked
paths for adding to the index, we unconditionally ignore anything
inside ".git". For example, if "foo" is a submodule, "git add ." will
visit "foo/.git" then ignore its content completely.

We could do something very similar: when we visit "foo", if "foo/.git"
exists, we ignore it as well. In other words, we extend from "ignore
anything inside a git repository" to "ignore anything inside any other
git worktree".

The following patch basically does that. If you specify "git add
foo/bar". It will still visit "foo" first, realize that it's a
submodule and drop it. At the end, it will not report foo/bar as an
untracked (i.e. add-able) entry, so you can't add it.

I didn't test it extensively to see if it breaks anything though. And
I might need to check how it affects untracked cache...

-- 8< --
diff --git a/dir.c b/dir.c
index fe9bf58e4c..8a1a5d8dd5 100644
--- a/dir.c
+++ b/dir.c
@@ -1672,6 +1672,17 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	if (dtype != DT_DIR && has_path_in_index)
 		return path_none;
 
+	if (dtype == DT_DIR) {
+		int path_len = path->len;
+		int is_submodule;
+
+		strbuf_addstr(path, "/.git");
+		is_submodule = is_directory(path->buf);
+		strbuf_setlen(path, path_len);
+		if (is_submodule)
+			return path_none;
+	}
+
 	/*
 	 * When we are looking at a directory P in the working tree,
 	 * there are three cases:
-- 8< --
