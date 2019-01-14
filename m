Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA11211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 18:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfANSrs (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 13:47:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54203 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbfANSrs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 13:47:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so680413wmb.3
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 10:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zEWw2uzqjMOUmefWyo9quKZ0hvHKmjnlrxatv5kMJL4=;
        b=BbQIplzwZd1gpfwCC8M5i93gSxSKK6v+wF1ZuffOuh6K5MsiXHYKW/dlkgcGrJW6bh
         ZpRmMUIOam/yV8txu/QTFjLMV6wKQLk7oMo2uXVqhJp0Ju18WxPAuql1SjCgsgZygRl8
         vrcnc/3Sfx5k8PHdD4H7kn2dIZuq2yrDN35nr/o4XAzeXXd8zBfvjYAZdyiyu6Yi5bjC
         EYG3PU8VcH5lVRElxtSZIRx5kPjMDkhpjPwwQbvvvZ/qxmE1POnioI44/LCCYa6i/4d0
         kJ4peQ1pOOKEnP1/buI6Ns3vpNbQG9K7FyO7KJMRDRA+awM6yjLwia/8LQXrApValpsA
         DwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zEWw2uzqjMOUmefWyo9quKZ0hvHKmjnlrxatv5kMJL4=;
        b=QCefYq7umH6afhZSwTWBt5JKQoURG4X/NpPUIdV5O51FXhoww6v7qBHTyYw3BkzygP
         OJMN57ipg0joTDUt0C5BTbS+iJui7OhKDV/De009QnKURMbkQLp22PWbuxYKOqzUPVUj
         dnPVKNpfwmThjLm6ZU/HREHdTAfoIdh3GI5oNcXqHmrbMA8X4+l3cszON/TbqDurcK/i
         Q5W8RMP+qFAL/s+8Z9sWd38nbd2WPAfoqJoGHv+W2ttpyBVts91uwt+LeCqbZdYZ7bJT
         B6dt/ocsjaXG952Xbh06BwHzxisGJDr+mP+0kcrNk1K7mVWftpwG0G8bD5Oy0EyMuvFb
         JFTA==
X-Gm-Message-State: AJcUukccsqyjNfn+Cy4Qk7OK4PR/KAO0GBBDdCvv2GYRZ7jNrZc1hbWt
        gu7+xE9UDNDv5Qtkhv2zW7E=
X-Google-Smtp-Source: ALg8bN72w/mzzVl52BVddijS9B5Z1MCY5hzzyBQIwM/89DbPcKtkF/iZUtCFWmBeeeq/vHxcVlrheg==
X-Received: by 2002:a1c:a548:: with SMTP id o69mr403836wme.118.1547491665675;
        Mon, 14 Jan 2019 10:47:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q3sm74639070wrn.84.2019.01.14.10.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 10:47:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Maris Razvan <razvan.alex.maris@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Gitignore documentation
References: <CALZbgSQti+t2dA4nm+DCDGxQjsvNJy3UDdqAya16v+Mv5O4Xdw@mail.gmail.com>
Date:   Mon, 14 Jan 2019 10:47:44 -0800
In-Reply-To: <CALZbgSQti+t2dA4nm+DCDGxQjsvNJy3UDdqAya16v+Mv5O4Xdw@mail.gmail.com>
        (Maris Razvan's message of "Sat, 12 Jan 2019 22:16:07 +0200")
Message-ID: <xmqqzhs3uldb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maris Razvan <razvan.alex.maris@gmail.com> writes:

> I was reading the gitignore documentation
> (https://git-scm.com/docs/gitignore), especially the following
> paragraph:
>
>          "If the pattern does not contain a slash /, Git treats it as
> a shell glob pattern and checks for a match against the pathname
> relative to the location of the .gitignore file (relative to the
> toplevel of the work tree if not from a .gitignore file)."
>
> From that paragraph I understand that if I have the following
> directory structure:
>
>         .gitignore
>         a
>             f
>
> (the root of the repository contains the file .gitignore and the
> folder a, while the file f is inside folder a)
> where the file .gitignore contains only the pattern f, when file "f"
> is tested whether it should be ignored or not, the pattern f in
> .gitignore is matched against the "pathname relative to the location
> of the .gitignore file" (which is a/f). Because "f" (the pattern) does
> not match "a/f" (the pathname relative to the location of .gitignore),
> the file "f" should not be ignored. However, if I test this scenario,
> git ignores the file (this behaviour is consistent with the examples
> from the rest of the documentation and other explanations on the
> internet).
>
> I looked at the history of the "Documentation/gitignore.txt" file on
> the github repository and I saw that initially the paragraph looked
> like this:
>
>         "If the pattern does not contain a slash '/', git treats it as
> a shell glob pattern and checks for a match against the pathname
> without leading directories."
>
> This old version of the paragraph is consistent with git's current behaviour.
>
> Then I saw the following commit
> https://github.com/git/git/commit/81c13fde379c46cad6b6e4a03ed7ee4f686c030f#diff-7fea460d44f92f185e7add8aa5620305,
> which changed that paragraph to the current version.
> However, I cannot see how the two wordings (the original one and the
> current one) are the same.

Thanks.

Jonathan, after re-reading 81c13fde ("gitignore.5: Clarify matching
rules", 2010-03-05), I do not recall why we thought this part of the
change was a good idea, either.  Patterns with slash is anchored at
one directory, and that directory is the one that has per-directory
.gitignore file.  Patterns without slash (including a pattern that
ends with but otherwise has no other slash) are supposed to match at
every level below the directory that the pattern is defined in.








 Documentation/gitignore.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 1c94f08ff4..bf1182169e 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -98,9 +98,7 @@ PATTERN FORMAT
 
  - If the pattern does not contain a slash '/', Git treats it as
    a shell glob pattern and checks for a match against the
-   pathname relative to the location of the `.gitignore` file
-   (relative to the toplevel of the work tree if not from a
-   `.gitignore` file).
+   pathname without leading directories.
 
  - Otherwise, Git treats the pattern as a shell glob: "`*`" matches
    anything except "`/`", "`?`" matches any one character except "`/`"
