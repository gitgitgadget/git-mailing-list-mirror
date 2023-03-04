Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1B4C678D5
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 21:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCDVub (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 16:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDVua (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 16:50:30 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE37CE39D
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 13:50:28 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id i20so5791695lja.11
        for <git@vger.kernel.org>; Sat, 04 Mar 2023 13:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677966627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnwRP1ULKbdJp9HGDGwBmXvpXZQwggb3uXr7nmQR4FA=;
        b=Uk2/p9sajiyvtZLNl4onQLGVn4mMwHiYPRN4ppLDBFtFNyASovx/bTuTUv5SvhgogX
         ZGF8zKvAnV+aDwWqntpCzHCtRsihcYqYfdFAfXgE6gEPRGWIQaRpk0olBg4JctL4hrQu
         6GZ4T9DXw9L8vV6qRiQGNj5WKOJY3vSReVGa2XBAs6I9jEveVvGp9P8lqr+/+snS4JaX
         BKh3cU/vDGh2RvLaVBVsti3VeGZSpP2ViZSH++iK5Cn/apoZZlMiiMHJwgkDBpZNnwSe
         3e+LaPsO102fgWowC+dSPggRGVpJkHre1F/5iLG62nUKPYX8e7YrfSwUWm+BFzdNiVEk
         DWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677966627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnwRP1ULKbdJp9HGDGwBmXvpXZQwggb3uXr7nmQR4FA=;
        b=lENtUAHj3P34Qij6+ff4ScjYtsqNmS8kagX6SOPkIj2jGDTH2Xr3s2P4IEJyWjGJnD
         PSmX7hWkddOcw80xR+IY3yoyEmmh66pljz5HrumY+Hg0cSnd/PQAJAPnUG/8remt7WMQ
         JQJXK67mEZHyXes6xrZ3ArFQIbnfoDPbRcqZd2cfZ6L6JBWLwiKuMHdZvYP0kib5voz4
         YOoxgy5xgANzzPwZu1NVA29VDARm4bUU2jggZ36Lq4VG4P5v5tYqSD7xJGom2stNqMNB
         2DKISh3dc5I0oRE8uiD6hGVMHTwI6+659J/plyLTSc2HN7PR6RzcoHxeNkZ+JGY9MAZ9
         EkCw==
X-Gm-Message-State: AO0yUKWcV1d3D1GGxpQkTLl/++CutoNMMtz09iu7aSlRR6K/G8DEbKao
        6gg6KbpEuZsjXMfH9K31RTIxMCt4TBjEIrZoSU/TAswyoPs=
X-Google-Smtp-Source: AK7set9LGYM6dA0ztyi3+dVpKM8BodlV4P5qOyqsXBv30+8oHkrPTcvQcuCMOPwK3gYMCq0ekfWYmzfR52slZRm+RAc=
X-Received: by 2002:a05:651c:329:b0:295:af0c:33ba with SMTP id
 b9-20020a05651c032900b00295af0c33bamr1838154ljp.6.1677966626844; Sat, 04 Mar
 2023 13:50:26 -0800 (PST)
MIME-Version: 1.0
References: <87y1oco3i9.fsf@igel.home>
In-Reply-To: <87y1oco3i9.fsf@igel.home>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 4 Mar 2023 13:50:14 -0800
Message-ID: <CABPp-BEEDS=v7ouOKts83OFMxDq=F0TKO1XvHEbnmXJ+Z1WELA@mail.gmail.com>
Subject: Re: [PATCH] git-merge-tree.txt: replace spurious HTML entity
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 4, 2023 at 9:48=E2=80=AFAM Andreas Schwab <schwab@linux-m68k.or=
g> wrote:
>
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  Documentation/git-merge-tree.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-t=
ree.txt
> index 88ee942101..ffc4fbf7e8 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -108,7 +108,7 @@ This is an integer status followed by a NUL character=
.  The integer status is:
>
>       0: merge had conflicts
>       1: merge was clean
> -     &lt;0: something prevented the merge from running (e.g. access to r=
epository
> +     <0: something prevented the merge from running (e.g. access to repo=
sitory
>          objects denied by filesystem)

I'm sure I'm the one who put it there, but I don't remember any
details.  I think it unlikely I would have jumped to '&lt;' without
trying '<' and hitting an error first, though maybe I really did.
Also, there could have been other edits since then; perhaps this was
only needed when other characters appeared later on the line?  Or
maybe the '&lt;' is only needed by asciidoc and not asciidoctor (or
vice versa; I have no clue which I was using)?  Should we add a
"lessthan" field in Documentation/asciidoc.conf under "[attributes]"
and use "{lessthan}"?

Or, if this one really is spurious, should the same html entity in
Documentation/git-rev-list.txt be expunged as well?

Cc'ing brian who knows way more about asciidoc than I...
