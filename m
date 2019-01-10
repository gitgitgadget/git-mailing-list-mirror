Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90A321F803
	for <e@80x24.org>; Thu, 10 Jan 2019 17:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfAJRpI (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 12:45:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35659 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbfAJRpH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 12:45:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so13009144wmt.0
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 09:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=foSTwbYtCMS1dnCbD6a82OtP65E/sikQCTFJRLAy1Fk=;
        b=iMPJcRejS61P5L1R10zey8x2k3EHzpzliSJ5lipCvMU1lL4R2YJ7HLFvUUg26Ueyha
         xpFEggBHXlhpS8KcWpDrmDIA0l1JmvAvm62pWmvrROo1aUm8c9vWveybBrLITGwyNjO5
         KM0g3EZq70B1wZejFBJqPhYcnxnMSuzVp4L73AS/cGzn0M8lIwknYqWaUgKgcC5o5VON
         X+ySIQWM+blabpxQjNTYe5UCBpsNiP7kcDPGfjemv9R7SsuwSmr5wgfNKhVqkHYvqMe3
         XNTrAYwXlVq+TNF6kjh/a3yo3Uw/FiuieRnV0/xoO9VbTicZ9wmmwDaV1VrVCMVEinTj
         veIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=foSTwbYtCMS1dnCbD6a82OtP65E/sikQCTFJRLAy1Fk=;
        b=Q+y2Vddqi0ke4Cm6oRHwY1qW8fSFyw9zJ+BibHXtnmLqQaTfNAdMD+1IaZwK6g0hvv
         Stkw36WY9w38HnAwRgXlMopawInJ+JfZVBJHDccFSsBRUYXANiLdTquGhBizHf+jFR7T
         rdDhdCsuRbk9w6iNXYAzmUawAMG5Od0z5MIIOljnRDvBW2t4Dz1xddQIzKJUdKawYiMn
         YAGOP6BUTpE7hzhMdNbQX+MY1vniqtCtMcQinKp7M63CTrpuRm4RemqTUFXsfM11wnq3
         8qmrrsfukY9qTCPFsFxatnLwPqwow+ur5ROTSFR8Fs0jFIL1QlHVdbpktMlBMFlunJNt
         MUrA==
X-Gm-Message-State: AJcUukf8zK4/QBv4KxR6vltlt+1emOIB5TblML8GNDWESJlLKQZaH1+B
        5uoxppuAVxw8mXfp3LqlvOGTn0BE
X-Google-Smtp-Source: ALg8bN5vLDSNzvs6iQ+uZB2oOhF7hF49zSqPy9Rl73kH2o5D1H9DhoO/WDZvmsKkFKDbnAsBIlHF4g==
X-Received: by 2002:a1c:bd86:: with SMTP id n128mr10633537wmf.22.1547142305831;
        Thu, 10 Jan 2019 09:45:05 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c8sm51862661wrx.42.2019.01.10.09.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:45:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git add --intent-to-add + git stash "Cannot save the current worktree state"
References: <CA+dzEBmh4LdN-XFS9y9YKrDMzV_7+QpDzBA2uv9Xi80PgR5NTQ@mail.gmail.com>
Date:   Thu, 10 Jan 2019 09:45:04 -0800
Message-ID: <xmqqy37s2yqn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anthony Sottile <asottile@umich.edu> writes:

> Minimal reproduction
>
> ```
> git init t
> git -C t commit --allow-empty -m 'initial commit'
> touch t/a
> git -C t add --intent-to-add a
> git -C t stash
> ```
>
> ```
> + git init t
> Initialized empty Git repository in /private/tmp/t/t/.git/
> + git -C t commit --allow-empty -m 'initial commit'
> [master (root-commit) 858132e] initial commit
> + touch t/a
> + git -C t add --intent-to-add a
> + git -C t stash
> error: Entry 'a' not uptodate. Cannot merge.
> Cannot save the current worktree state
> ```

This is one of the well-known fundamental limitations of the design
of "git stash".

States in the index like "it is known that this path would be added
with some contents, but not quite added yet as the final contents
have not been decided (aka intent-to-add)" and "there are
conflicting wishes for the contents for this path and the final
decision has not bee made (aka unmerged)" cannot be left undecided
before getting written to a tree object (hence a commit object that
is used to represent a stash entry).
