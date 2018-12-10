Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE3D820A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 03:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbeLJDr2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 22:47:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56183 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeLJDr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 22:47:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so9366758wmc.5
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 19:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A+MlAZNR2JCtNL0OrGoDkGuyM7Hctz9vCfuy8CDetYg=;
        b=Q0Xqn48/SFx9/q529bwIcHIPwqE7rcjDZfA6ttBPXxXT/1TKMrXDMFRXPtrfXuIH1n
         Ck5kSA7SP/z0gQ56Zyaea8aXMSZy/Sd8hxLtUiV17fT/esCrEicVrl02HikaU9HO2iuh
         yxGR7i2w2/FW54/T1GuoIqssBn1pI0+5LzSh9U66tmhmn/NpDwKNCEZXb8jUvehI2oqP
         f2Y676E4Nzjm01qsRtX9jhs3KyTlSFQ8oG5iH3MniWA4UWJW3TVFwMWRa00wuFFE2Q6p
         He/A7C80JopBC3Sc4RnejWQ/7t8dYWGzAX8E+ZNXMYbjX3ezXTauQO4GgPnbUgKRYuDO
         OaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A+MlAZNR2JCtNL0OrGoDkGuyM7Hctz9vCfuy8CDetYg=;
        b=AaiT8TiXhRcZQMqbGCQd1yJxkDJBH0BPsTpyzlUSAlntJns1h0JM0lE1q+hV0gueTO
         3DKp5h1097AXa8j79oAqIP84Uzt0VUOpDC9Q0McQXzVnz72/8FIXXq3V/oEL6lKA2j5W
         QQTB55jUYBXrQ8iaZu6gjws0wBkT40ks6+DxUEo7i6c+mnb/N8QdjF6i+pBALXaYSppA
         6HTMrLEVg8a+eRNoiu7GAO/+owGZIO/Z00o0aZjBG6lkXV7L769rM7LPkXm80SD0V6FU
         8eZQu5CtJLPpcgbYQnyVnBUZ2IH+fggXqbj+wcTAnS3t7/4MSQjVgogR+9D0K2rOkva9
         uZXw==
X-Gm-Message-State: AA+aEWbeAN85BYB4P0Q7aNMr2jfPiKKkGwKrCDl0yGhS1pGA508pq9x8
        ZpGVyu0OMsL4fQficXHgEBWnoNIu/Sg=
X-Google-Smtp-Source: AFSGD/WM78fViTC5j/HmrACMFSa1t5rOGZNkpqlSTKgg7gQ0Z+4FvtOdC2CNLBY6xjY2JWJGi6uNZw==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr9332514wmb.28.1544413646432;
        Sun, 09 Dec 2018 19:47:26 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e19sm21659879wrc.25.2018.12.09.19.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 19:47:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/8] introduce no-overlay and cached mode in git checkout
References: <20181209200449.16342-1-t.gummerer@gmail.com>
Date:   Mon, 10 Dec 2018 12:47:25 +0900
In-Reply-To: <20181209200449.16342-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 9 Dec 2018 20:04:41 +0000")
Message-ID: <xmqqa7le2gc2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Basically the idea is to also delete files when the match <pathspec>
> in 'git checkout <tree-ish> -- <pathspec>' in the current tree, but
> don't match <pathspec> in <tree-ish>.

I cannot quite parse it, but perhaps.

	"git checkout --no-overlay <tree-ish> -- <pathspec>" can
	remove paths in the index and in the working tree that match
	<pathspec>, if they do not appear in <tree-ish>.

If a new file D/F is in the index and in the working tree but not in
HEAD, "git checkout HEAD D/" or "git checkout HEAD D/F" would not
remove D/F from the index or the working tree.

With the --no-overlay option, it would, and that is often closer to
the wish of the user who wanted to say "restore the working tree
state of D/ (or D/F) from the state recorded in HEAD".

> The final step in the series is to actually make use of this in 'git
> stash', which simplifies the code there a bit.  I am however happy to
> hold off on this step until the stash-in-C series is merged, so we
> don't delay that further.

I think that is probably a good idea, for now.

> In addition to the no-overlay mode, we also add a --cached mode, which
> works only on the index, thus similar to 'git reset <tree-ish> -- <pathspec>'.
>
> Actually deprecating 'git reset <tree-ish> -- <pathspec>' should come
> later,...

Or we may not even need to deprecate it.  IIRC, what "stash" wished
to exist was "git reset --hard <tree-ish> -- <pathspec>", which, if
the command followed "--cached/--index" convention, would have been
called "git reset --index ...".  Did we actually have the need for
"--cached" mode?

> probably not before Duy's restore-files command lands, as 'git
> checkout --no-overlay <tree-ish> -- <pathspec>' is a bit cumbersome to
> type compared to 'git reset <tree-ish> -- <pathspec>'.

Yes, between "checkout --cached" and "checkout --no-overlay", the
latter is much more important, as the latter is what a missing "git
reset --hard <tree-ish> -- <pathspec>" would have been, but the
former can be written with an existing command.

> My hope is also that the no-overlay mode could become the new default
> in the restore-files command Duy is currently working on.

Yup, that is my hope, too ;-).
