Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7036D1FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 08:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753901AbdDKIwK (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 04:52:10 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33889 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdDKIwI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 04:52:08 -0400
Received: by mail-io0-f175.google.com with SMTP id a103so62773669ioj.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 01:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZTpUbdppIRAmhUSSEz0wEY9rNClXZiYsJOai+xclW+g=;
        b=DtwLpUB5OzH8LPBYgD4dEIZmeI+xNHBXEmH9AisNMke7PJ97rPFPL64Tj7hb1uLzGm
         1px02XK/J2Ev18QYNnO3HjaemASz0h02YDElkPXLjNhIBuP75vFg3+B+w/03pSXhMGDi
         cAnx6EwTQGCJhBHJ6d0NQj3JPHBNP8G3eh3OtANAEA6+mLe5OBl6WZkvloosqBu9gMqM
         eD+PL4dePeM83LE591N0GU91aEboTsqY7UQAt96/vi+eRauMYaPAGbcxDUXMzuTzrZH4
         ISaKPN15N4ge1vrxI/emk9jvEfkGp1KZiKJEcpjhLgGYjeC7FzPDaYP//vh++coZUz98
         YD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZTpUbdppIRAmhUSSEz0wEY9rNClXZiYsJOai+xclW+g=;
        b=JyJgT2vRrnJnxpML46O8YYUYVxeBZa9uyKyLXNxPPpZKSWXHCFQj8LGmRIjM2EPFhD
         bGNgtqLYyE7UheSmP7iArD53ZuRr/npJBw9F1hXqbeXfeWhlY0SZBOpBvRYIlLoeLAXH
         BdfF9uzgwRHP4AEw3enufY1cmNdNwUW2bDB+HyvW/nDfj9Vsd9xdhKh2ha+pkdlr4H/5
         b2thgT443LkEun/06A+V9cJBODp3C2sEnx8CuHA9M3FYhYSJg/hpwkvp/Kj3aSxHsRz4
         KSpnaOqx+k5sQoX9dUOyGJg5XirT9pYviidF8wPf4/CnSN4H6SafNnB3s/4qWwynW/JC
         ddfA==
X-Gm-Message-State: AN3rC/4ylXIqQPk3UNR+vuwqNj/1153CE0zLiKo21Jvd9M8RgBpqInH1meMb2CcnXTrji2CK7LCYhKeYNBPa3A==
X-Received: by 10.107.141.203 with SMTP id p194mr14774909iod.71.1491900727783;
 Tue, 11 Apr 2017 01:52:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.34 with HTTP; Tue, 11 Apr 2017 01:51:47 -0700 (PDT)
In-Reply-To: <CA+P7+xowo+qXZ+Vr5vYg8wSpNzF44X9RsV34s_fKhBtVcddBvw@mail.gmail.com>
References: <CA+P7+xqS1Fh0aDV=QYbVMdRa=M4e-mBtjvknR=U_RShDoccNjQ@mail.gmail.com>
 <1n47so5.9e6qvf1bbqww4M%haller@ableton.com> <CA+P7+xq6MJa-J5cj2Om20d+g7KBretShpxH=13HWV7vFR9be8g@mail.gmail.com>
 <CACBZZX48RanjHsv1UsnxkbxRtqKRGgMcgmtVqQmR84H5j8awqQ@mail.gmail.com> <CA+P7+xowo+qXZ+Vr5vYg8wSpNzF44X9RsV34s_fKhBtVcddBvw@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Tue, 11 Apr 2017 17:51:47 +0900
X-Google-Sender-Auth: KIl3ICpE8q2sYcbTP1YFI96z_n0
Message-ID: <CAPc5daXVYA8MsseJxge6Qo6ASc=CL6ySt2K61LpOtZ=3H3gWuw@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Haller <haller@ableton.com>, Jeff King <peff@peff.net>,
        Matt McCutchen <matt@mattmccutchen.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 8:33 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>
> If you're already copying sha1s around you could use those as the
> --force-with-lease=branch:<commit>, no?
>
> That's better guarantee than just using --force-with-lease alone.

Absolutely. That was the _only_ way the feature was originally designed
to be used sensibly. We really shouldn't have added that "lazy" option that
assumed that most people used remote tracking branches only when they
need to fetch to see what's there, without making sure the assumption is
actually true. The "lazy" side of the feature ended up not being something
that would work for most people; it instead has become something that
only works for those with specific workflow (and a worse part is that those
who step outside the assumed workflow won't even get a warning).

Perhaps we should deprecate that "lazy" feature and remove it over
time, making sure that everybody feeds the explicit commit object name
that was recorded by the user somewhere (e.g. the approach to tag the
commit to record the expected remote tip, which Peff illustrated).
