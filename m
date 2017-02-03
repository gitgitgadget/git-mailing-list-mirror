Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DC2F1F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 20:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbdBCUqZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 15:46:25 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35967 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbdBCUqY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 15:46:24 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so2834931pgf.3
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 12:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Mb15fIfFmF0B/5L+EDNuOXskWxUO06mRiax5oaqeQZY=;
        b=GXS47EDeJgeCIV6dxKeJPhN0wOBjyAYzji6pSNlfCfkeJ3l074gNVxHIR7zPyuKy9B
         3Y/AZfyXIOsExAneNLdAn45RNIMYPX7EuAreYlTK3X6kydcTZWYwcK/UYSVX+qn6wQgv
         +QPTXFWDeD6fvkBGC7Ww2EDw0C9dOvCePwqyO1eVN7mb9nwKeavI0rFUohk8sK3ibZLm
         Q4rbPgWb5h0CVu9sG77Z7K6vmgJv73ghdNbtkqKwrK8QzbzMVTCSTrlqJhABK0vOorX8
         wKY8NZvPv3jAFJ5+F1Yd8mKY6VxSJ/to62DQDtgZXYpMp+BNT7SitcK5guiQryqvURNZ
         vNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Mb15fIfFmF0B/5L+EDNuOXskWxUO06mRiax5oaqeQZY=;
        b=TLQ1qstVFROiiA6+lA9ddNsOyU/89OSLosgE4u6MFN/5w/61GDDadoFrlVXQETEVN1
         r7pkAyVUdIXzQOoRGTlbeEJ88g0KV6WmSzT3sKT7Gy5gvgG48m3e4Z8FsD+S48vJN3h6
         BfyNd9PqrR6LO2QxD32xFb04H5eADk6S6X7NvbZ1oL+q8WDqqLOw/GmyfH2ms7kIJrVo
         J+MW6zMz4oT+x4mYyVg+sMgIqr36w9UfykTltY8147lUsQSgN+OGoAqRi346jNG5OtDr
         ZoItKnTByEOinGBBdCqn1/szpB+bXGKPljTuxjs40MkL2Dj1LhfofOwiBGDleXlBdRjG
         jA5g==
X-Gm-Message-State: AIkVDXLrex0BERQ5pwoHiYD/O007UdFWeljRalFAPFPgoNY79rN2BqyhWwEXCxJywyyosA==
X-Received: by 10.99.99.193 with SMTP id x184mr20435138pgb.226.1486154783648;
        Fri, 03 Feb 2017 12:46:23 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd9f:576d:b8fa:253a])
        by smtp.gmail.com with ESMTPSA id v186sm69819966pgv.44.2017.02.03.12.46.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 03 Feb 2017 12:46:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2] reset: add an example of how to split a commit into two
References: <20170203202833.17666-1-jacob.e.keller@intel.com>
Date:   Fri, 03 Feb 2017 12:46:20 -0800
In-Reply-To: <20170203202833.17666-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Fri, 3 Feb 2017 12:28:33 -0800")
Message-ID: <xmqqzii3dmub.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> +Split a commit into two::

Let's say "...into two (or more)" to match what appears in
"SPLITTING COMMITS" section of "rebase -i" documentation.  Yours is
written as a sequence of more concrete steps than the existing one
over there, so it may also make sense to add reference to bring
readers of "git rebase --help" to this section.

> ++
> +Suppose that you have created a commit, but later decide that you want to break
> +apart the changes into two logical chunks and commit each separately. You want

"two (or more)" again.  In <5> you already hint that the user can
repeat 2-4 number of times.

> +to include part of the original commit into the first commit, while including
> +the remainder in a second commit. You can use git reset to rewind the history
> +without changing the index, and then use git add -p to interactively select
> +which hunks to put into the first commit.
> ++
> +------------
> +$ git reset HEAD^                           <1>
> +$ git add -p                                <2>
> +$ git diff --cached                         <3>
> +$ git commit -c HEAD@{1}                    <4>
> +...
> +$ git add ...                               <5>
> +$ git diff --cached                         <6>
> +$ git commit ...                            <7>
> +------------
> ++
> +<1> First, reset the history back one commit so that we remove the original
> +    commit, but leave the working tree with all the changes.
> +<2> Now, interactively select hunks to add to a new commit using git add -p.
> +    This will ask for each hunk separately and you can use simple commands like
> +    "yes, include", "no don't include" or even "edit".
> +<3> Once satisfied with the hunks, you should verify that it is what you
> +    expected by using git diff --cached to show all changes in the index.
> +<4> Next, commit the changes stored in the index. "-c" specifies to load the
> +    editor with a commit message from a previous commit so that you can re-use the
> +    original commit message. HEAD@{1} is special notation to reference what
> +    HEAD used to be prior to the reset command. See linkgit:git-reflog[1] for
> +    more details.
> +<5> Now you've created the first commit, and can repeat steps 2-4 as often as
> +    you like to break the work into any number of commits. Here we show a second
> +    step which simply adds the remaining changes.
> +<6> Then check again that the changes are what you expected to add.
> +<7> And finally commit the remaining changes.
> +
