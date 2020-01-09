Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D53EC282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 23:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4AD205F4
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 23:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/HY0EJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgAIX3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:29:38 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46530 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIX3i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 18:29:38 -0500
Received: by mail-vs1-f67.google.com with SMTP id t12so123452vso.13
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 15:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84sYD9o0q9qYjTNbNKN2OsKOcB9FNQA3H4I0TmOrs+E=;
        b=E/HY0EJtN7spV2hn+1kdirWk7cOKzvqMjGw4trxKM1gZyPaahOyDQyB2yGAWqkAt4a
         CmOH3wW8Zgr3YFuUq7LELdQiCE6ToVBSGTrSqjX1iLVF9T+/uQUJlX+BxG/bQxYeHBBe
         ZM89vrHWRoEsPWG8Ez2x0k57RqOIxRrixW4dmdhKF65EYGi9bQt+NNcVL15uiDACHxJG
         38GB0vD9IS9Afzlq9SfqOHYqUuEa9ztQcmRzlDgERLG8YH/gHlcb2dwcP4PdX6crKmnv
         tBoc1vWgP9BpghcyoTIGgfW5ZCQhNMlpGrW+A3NsCzV6qJWUo1fINivHx3uww90JYPyI
         7oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84sYD9o0q9qYjTNbNKN2OsKOcB9FNQA3H4I0TmOrs+E=;
        b=eFN+o0Robn+DEs+6GVt9IJT94bP91LSkhMkcR4NIjjswnoh+7eoEC3QHD8tJzIXO6Y
         zWmoDrThso6onBQKv2kuV34B80VjFu3Jp70YJyMNII9dov8ggIN45c8z2yXYdFMfwivy
         nNU7hf+b3LnafKlimNxYD9dH/ioDUORuxiaQ6YfNnyOnXMY5MDac9fkS1S7W3EV8Nw3t
         0pzv2Oyd0Tk2rvHmiiSHf/KBIPXRw4sTfYSHXEYnTxew5rfiqoNktwAnxLrJjDAVZkWN
         4FPHnB+WSU0S0mWjw7r6rfsPvCytYyyF9IxZ80pD6l/cyxtCWv+e9Fe/AeYixTrfZnJq
         tv6Q==
X-Gm-Message-State: APjAAAVXDaG8A7Wkx/rlN14N0+3SNG8VM8hdA9XB2A98Ov7rPMugHyFj
        sJtHJOY/S9labXCQRwTyJ3gk/+nxyG+IfxJUt2Q=
X-Google-Smtp-Source: APXvYqwQ62E1OEcDdvEmdDCXAOMSq4bO3UTopRAUPrGA2uaOoE89S91hhzhQQSwkjgNlqXKwLnP0uUi44DLg5HZdOUw=
X-Received: by 2002:a67:f847:: with SMTP id b7mr141589vsp.40.1578612576995;
 Thu, 09 Jan 2020 15:29:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
 <pull.478.v2.git.1578565001.gitgitgadget@gmail.com> <e8e05f39407365a1bf5008820267d362e0cbffd6.1578565001.git.gitgitgadget@gmail.com>
 <xmqqpnfszbyh.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnfszbyh.fsf@gitster-ct.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Thu, 9 Jan 2020 18:29:25 -0500
Message-ID: <CAOjrSZu4PRR17fjqJNK6r61OKJHchR7nkgcX3VBzLEZHb+BUBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] config: fix config scope enum
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 9, 2020 at 2:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Matthew Rogers <mattr94@gmail.com>
> >
> > Previously when iterating through git config variables, worktree config
> > and local config were both considered "CONFIG_SCOPE_REPO".  This was
> > never a problem before as no one had needed to differentiate between the
> > two cases.
>
> Hmph, then "fix" on the title is a bit misleading, no?
>
> The enum may not have been as fine grained as you would have liked,
> but if there was nothing broken, then we are doing this not to "fix"
> anything.
>

I see where you're coming from, but I would definitely consider this a "fix"
in that it's something that (as explained in the deleted comment) should
have been this way from the start but was unnecessary as no one had a
need for it yet.  But I definitely wouldn't be against changing the phrasing
to something like "clean up" or whatever your preferred wording would be.

> A more important thing to explain would probably be why we
> (i.e. those who propose this change, those who give favoriable
> reviews to it, and those who accept it change to the system) would
> want to see finer-grained classification.  What do we expect to be
> able to do with the resulting finer-grained set that we wouldn't be
> able to with the original, and why is it a good thing?  That is what
> readers of the proposed log message of this change would want to
> see, I would think.
>

This is really more prep for patch 4 later on in this series, as a user who
ran the proposed '--show-scope' later on in the series would care what
was "worktree" vs "local".

Regardless, I think the two options I have would be to amend the commit
message with that extra information or roll it together with patch 4
