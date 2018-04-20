Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAE251F404
	for <e@80x24.org>; Fri, 20 Apr 2018 05:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeDTFRp (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 01:17:45 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:36836 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbeDTFRp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 01:17:45 -0400
Received: by mail-ot0-f172.google.com with SMTP id p2-v6so8363146otf.3
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 22:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TfqrPYgJPyJTu9WkrG7dNXY2YGGzR1+elVLhORQnIWU=;
        b=Ft5Chzkz29C/7S7FA9LEjzOlmIZzZDVCvvtJzz7soZci1A8rfMHVQeCu+RCHdIJEs3
         Pc4qYkJd11DNlsr4JxnPiwKGn+IdXQhlZjBzdPsUGe7EzJgaBtsJ+kf0CG9Uws1zwMQF
         2nTrXkfB8pSFnmx6Q3658yt2Sso1EHNDJjDW2IM2DMHk5txtGrTWJ8vNsaQtVChrTqsC
         TprG1pvwu8umq4I7k9x9hAIF2mcidtG4MCZo2kQ5f18bT+l35+Rqt//3/Xbawm1E96Y/
         LGz2TeUv2hxiwnFS0TUVLC2sTuX85EykcRB5vEBdqQVooosb6MtkmfPh7wnAP7ufKxKb
         tqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TfqrPYgJPyJTu9WkrG7dNXY2YGGzR1+elVLhORQnIWU=;
        b=EkB5UsQXLYjzRC3IPCuh+dYUXdEBkzAHxwWa9RS9XsIaYedST80Y5fwgBOGVoJF6mM
         Sx8p9UgyW/IK1aJmquZEcxvar7HzLyvv9oeLG0jEurh5zeXz8MEakhVfSvARqGFRWRmh
         zNzKQpTfqMZ1Q0jXazWX6zaFjib7C9humCNfds24bwlvthxB7Ij0iar4lHi/BZ5iig3R
         T5mgwh0poldlWGIaDlb+o+K4aeVzyqkH4mCZNZkWfL07enO/4fFUhFLM31v6ujqN+PAS
         NgjbrMWeWndLZ2BqhsGFPX6B8a8b4OacjXgJ1zaOtzbivwuVgrq69qzSf+d8rnOiDmws
         wMpw==
X-Gm-Message-State: ALQs6tBzFOj33kxFBpZb1s6sJbP8TceMibd/hyLxMyjrx0VGuLn2xwj4
        e6cWmBKjiYnGiZAzC384Z+WHzeGPSuI061WCyoQ=
X-Google-Smtp-Source: AIpwx49ZRB0+hXK1kKseSupAbtPkQxW9qxYiDO3o+CCOq+f+GXv1PqLeouOlz8wf3tNFgrgQCS2m0nj2Zp8RrvnLKL0=
X-Received: by 2002:a9d:4197:: with SMTP id p23-v6mr784385ote.75.1524201464558;
 Thu, 19 Apr 2018 22:17:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Thu, 19 Apr 2018 22:17:13 -0700 (PDT)
In-Reply-To: <20180419232514.16572-2-t.gummerer@gmail.com>
References: <20180417212945.24002-1-t.gummerer@gmail.com> <20180419232514.16572-1-t.gummerer@gmail.com>
 <20180419232514.16572-2-t.gummerer@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 20 Apr 2018 07:17:13 +0200
Message-ID: <CACsJy8BByBCh_DuDu9otO4RLpCnQ+HY-vHi4EDC3_dNQHjM1dg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] completion: stop showing 'save' for stash by default
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 1:25 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> The 'save' subcommand in git stash has been deprecated in
> fd2ebf14db ("stash: mark "git stash save" deprecated in the man page",
> 2017-10-22).
>
> Stop showing it when the users enters 'git stash <tab>' or 'git stash
> s<tab>'.  Keep showing it however when the user enters 'git stash sa<tab>'
> or any more characters of the 'save' subcommand.

I don't think this is worth it. You only save two keystrokes for 've'
and already waste one on <tab>.
-- 
Duy
