Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78E6E1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 14:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeBEO4O (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 09:56:14 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40918 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeBEO4M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 09:56:12 -0500
Received: by mail-ua0-f193.google.com with SMTP id t6so18836803ual.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 06:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IwEd4szpnmibdepDRPTG9xJvxnvPHUPMRT+6s/mws8Q=;
        b=t0y/4CBnWDAPVlnxRh0wn99FnzEZnGk310c4NlwBOevc7LGTJcnep0tExWphngFsYG
         lA0L/cJwrfjf4pPTs+aUFEr/Xk38O27HHAQUbPoR9X5OiZMd7xtbG27uo7slp8UmAxL1
         PO56nJvW/o9jg6i7YPbk7LwF29rmLnEiXO6W5zkaLhSUP5InAi7+IW+dm1kLersJFiv9
         B9gdzWaaiLXUPJqZXroQvVEWRuSXofwgmg8fijx2v9Sgh+U2E0wQBr5/vS7R+vUwtc5q
         sD1ai7oDRV7xijgrDmj5L3I/OrQA+nC8yPQofSXp59G8K2THqH8OYoRwmD+lHA89TjSb
         M1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IwEd4szpnmibdepDRPTG9xJvxnvPHUPMRT+6s/mws8Q=;
        b=BWLrYkbO33A/4SNMegq01mRmQbw8jU6oAuSEvlMdMLwSaLnj9dsUYd2R1joOwsbQhJ
         ZkZKmQTyu/NF453diZsK1vlFJWLE8AjmCYqeDcKImPp1Rfv5GOt5MRP3iVrSS4Rd193L
         M78Os0t2jF65ia7tzJb3YK6DEUd2WbNmJzrFyoKRYlMtoRMijufYyn+Jwm+W+CnrdF4B
         RobTzIqJ1KlHgqMahgWOyb6EiOnJydEDAS2Paym2vsrK9mVfyRQYBRv/GGewBgM36Gr7
         wCrNoJKBGxY8fTxg6wdEF+HNHA+2raoo6I1D5t1xPSIbr/Up8rV7lvVE4BFGtqhvVmet
         Xnxw==
X-Gm-Message-State: AKwxytc0Dpsr2rlrFOCkEDq6qhd9vGnTEqoo3hQuLMtESYn064SlAep1
        I0IPCL8vqAjMmZKfEycs3EKcyfGr29Yev7BVKQbdfg==
X-Google-Smtp-Source: AH8x225sYTQtVO42W0FxlznK2rSIkKfY+Wvvxs7T65W82XP6y3PT0rhf3O+TCZR34ptUHeLsnXGZaQqZt0oi0N/ur3E=
X-Received: by 10.159.38.33 with SMTP id 30mr41101115uag.9.1517842571504; Mon,
 05 Feb 2018 06:56:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.33 with HTTP; Mon, 5 Feb 2018 06:56:11 -0800 (PST)
In-Reply-To: <911da66d-d6f3-2366-b2ae-4741ec9ff6d6@kdbg.org>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-18-newren@gmail.com>
 <CAGZ79kYcmq9JyD4smH1Vdm5YOFXRXjhYhhHYjNV=Z7mxz2UVGw@mail.gmail.com>
 <CABPp-BGc0F5023yY1wRb3Gy+oXdbHAibkHYr35+zE=OnT2bQmQ@mail.gmail.com> <911da66d-d6f3-2366-b2ae-4741ec9ff6d6@kdbg.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 5 Feb 2018 06:56:11 -0800
Message-ID: <CABPp-BEJ5Ops0L2prJjLk9iNkMkVOOGtEOtUHevzXFCWgUAaeA@mail.gmail.com>
Subject: Re: [PATCH v7 17/31] merge-recursive: add a new hashmap for storing
 directory renames
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

// Re-sending because of bounce

On Sun, Feb 4, 2018 at 12:54 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 03.02.2018 um 22:34 schrieb Elijah Newren:
>>  If anyone can find an
>> example of a real world open source repository (linux, webkit, git,
>> etc.) with a merge where n is greater than about 10, I'll be
>> surprised.
>
> git rev-list --parents --merges master |
>  grep " .* .* .* .* .* .* .* .* .* .* "
>
> returns quite a few hits in the Linux repository. Most notable is
> fa623d1b0222adbe8f822e53c08003b9679a410c; spoiler: it has 30 parents.
>
> -- Hannes

Sorry, I didn't make it very clear what n represented. This is in the
context of detecting directory renames, and in this discussion n
represents the number of distinct directories that files were renamed
into from a single original directory on a given side of the merge. So
your example of number of parents of a commit isn't directly relevant
to this case (also, even along your tangent, merge-recursive is only
invoked when the number of parents is precisely two). However, I find
your nugget rather interesting, even if unrelated. I had known of
merges with more than 10 parents, but somehow was unaware that the
limit of 16 parents had been lifted. And digging through the history,
it was apparently removed quite a while ago. I love the commit message
that lifted the limit too:

"There is no really good reason to have a merge with more than 16
parents, but we have a history of giving our users rope."

:-)
