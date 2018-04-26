Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3D4D1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 17:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755871AbeDZR47 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 13:56:59 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:39941 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754014AbeDZR46 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 13:56:58 -0400
Received: by mail-yw0-f170.google.com with SMTP id p144-v6so2154380ywg.7
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qBKKNKfoyQgfA76KTN6W8BrYIxRnVNIvyX5kUcupq2g=;
        b=NI0k4tCCJL69qqhT8JEA6+RElqMa/wb4I/aTu3AfJwfG1dLoIGkE/Ep2z+GqZc4/D+
         RVFj7+hpJxgDQt/k1J9xljRPEB/lZZ+Ljl0CX8uQfDKH5Y7Xv/aTnD2aWvJiMitzDL9j
         PTF0kK48PFueGOahJ6QTVlTEOWpeFZM4LueUoe2Isv7XXyVOGcGaMqsQ8aBD9A9toGeE
         dLqww7N+LpbDzzVNoVdivCtHN+T+AAgS4Lj+1YTHOpCWPr1QgWx20x2Mbya1l8WxcFAj
         vDgVYoTyGQvv2HLLEX5LZZ1ko0kbTGjdnxnJ4EsIjLcz//LhLNs8MWJ4UvBnlb6jbVGf
         Nozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qBKKNKfoyQgfA76KTN6W8BrYIxRnVNIvyX5kUcupq2g=;
        b=dgm3gB5B7nsWdMRN44ehDTQsDXLyvhmS554xjPxPBPQh75QZbQiCDzkiYkkZuUy9u/
         ZYcMrxGsN4i5QbnSO0qvkEJfvJk7ae8XXBnq0nL1yO4pqGRHoSqjfL4ZcsYDYopkTc2D
         ypevWVVy8SXV4usdDWfZ62XIN3hBECiLPxyxFkZKkbN1X4JWt/KzVX46dIPAQzqn00KY
         pir7BDxJK4vmdUMBl35Ukb9f9RdZtJcACm7U1QqctzJKIWjvUtgIY9k551TXIin13tKA
         U5y53EG2vszL+lpkVIyIXjQ6M/0I3eLLql5Gcdkz2QhQ7yR5b86oAjRvEl6aqSqAuaKF
         fPcw==
X-Gm-Message-State: ALQs6tAhVJJS8FVsfd7Bg3KPKwcHaY/TA/SbPFseH43lp3A1oGExDmra
        jX9u+LCkie0cmkQnXnvlXMIa6r0WPqVnfbRqiEKMzA==
X-Google-Smtp-Source: AIpwx49e6vHoEZ5Fta3MdcuHsAnB+L6jLE2Ym6xzNbFexJn0iC23qIoFQAIHEX+h5F5zDsiIbmVsrylPSUOEXaZZt+8=
X-Received: by 2002:a81:2cc3:: with SMTP id s186-v6mr17765421yws.414.1524765417452;
 Thu, 26 Apr 2018 10:56:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 26 Apr 2018 10:56:56
 -0700 (PDT)
In-Reply-To: <1524739599.20251.17.camel@klsmartin.com>
References: <1524739599.20251.17.camel@klsmartin.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 26 Apr 2018 10:56:56 -0700
Message-ID: <CAGZ79kZA_R-5bA6mPdoHkVW-C21pNn_0x6FayhuuXqnOTrmjWw@mail.gmail.com>
Subject: Re: git merge banch w/ different submodule revision
To:     "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 3:49 AM, Middelschulte, Leif
<Leif.Middelschulte@klsmartin.com> wrote:
> Hi,
>
> we're using git-flow as a basic development workflow. However, doing so revealed unexpected merge-behavior by git.
>
> Assume the following setup:
>
> - Repository `S` is sourced by repository `p` as submodule `s`
> - Repository `p` has two branches: `feature_x` and `develop`
> - The revisions sourced via the submodule have a linear history
>
>
> * 1c1d38f (feature_x) update submodule revision to b17e9d9
> | * 3290e69 (HEAD -> develop) update submodule revision to 0598394
> |/
> * cd5e1a5 initial submodule revision
>
>
> Problem case: Merge either branch into the other
>
> Expected behavior: Merge conflict.
>
> Actual behavior: Auto merge without conflicts.
>
> Note 1: A merge conflict does occur, if the sourced revisions do *not* have a linear history
>
> Did I get something wrong about how git resolves merges?

We often treating a submodule as a file from the superproject, but not always.
And in case of a merge, git seems to be a bit smarter than treating it
as a textfile
with two different lines.

See https://github.com/git/git/commit/68d03e4a6e448aa557f52adef92595ac4d6cd4bd
(68d03e4a6e (Implement automatic fast-forward merge for submodules, 2010-07-07)
to explain the situation you encounter. (specifically merge_submodule
at the end of the diff)

> Shouldn't git be like: "hey, you're trying to merge two different contents for the same line" (the submodule's revision)

As we have a history in the submodule we can do more than that and
resolve the conflict.

For two lines, you usually need manual intervention (which line to
pick, or craft a complete
new line out of parts of each line?), whereas for submodule commits
you can reason
about their dependencies due to their history and not just look at the
textual conflict.

Stefan
