Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6C5220357
	for <e@80x24.org>; Mon, 10 Jul 2017 16:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754567AbdGJQbz (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 12:31:55 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33700 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbdGJQby (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 12:31:54 -0400
Received: by mail-pg0-f68.google.com with SMTP id u62so13345139pgb.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZmhmqxiBnQrn45kXYs6hC6DFuikcs2ew5c+EBgcQiiw=;
        b=Wa4mthnaZ7m3k3rbKsJOg9pn8DpSAPCQc0PGP6mFItaAuQHOkduDg5vLamVK5OczXh
         8YG+zyxqysEaaYOMZPTt2LT+Hc8/39RDlvlO/uZC89RtbidVpQcbU2lX4gmvDdlpAtmQ
         zCeCmfQq/IKJZdm6Bolz6Rs5d253neJ3brjycxdpRW/NLwdQKreadbbW/vbwHG2DUhEb
         RPCc0JgNjixbEUmmWWMjrIZbBwg5zisO3k18onZXPrhrUp1Nns19FL3LJHPzfslliJ+g
         uBp4w+tAI7VmwfKQYKoVwBGtfWMpTqM4Y4tkof6x/Tph0z7UuzLBcTW6BVwIz0abq6ce
         Gr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZmhmqxiBnQrn45kXYs6hC6DFuikcs2ew5c+EBgcQiiw=;
        b=VUefxfbPdycIsKqzZ/kn6Wjmua3VGbw7d/LT/a1Fc3QU2H7XnFocvKdqKdBGaLRTgc
         brT6Ho/C3p+Mbs9oWCIQ9mLefhjAKG7WQXV7XE0S8WSZKK5ONNyy3PsYUjBPss4aCUB8
         UFTQDVUaxoZ3oULLWOQ508e+jU31NMT514UgwTEqPTHtzFWxqJtBjgHv35HV1/1YifmX
         yfY+GNRdyDYS4GTFM5ksAMhun1I/aXBFD5lVH82s2OnxKmIaime8t53zP69F5O7w/uDl
         s/+VBnjxjeO/Jn4UWARf0XhpF+ba199rfPXcWDcA9Fr5fbYmK1IvNjHTO+TEd3zZj0Nz
         /T6Q==
X-Gm-Message-State: AIVw111f5HJNNExMalkPMA/vyDC5D+2k6Hs9kfNSMFF5Ijl77eK/gWAj
        TS5qNQIC3QjkDQ==
X-Received: by 10.84.232.5 with SMTP id h5mr18702603plk.261.1499704313687;
        Mon, 10 Jul 2017 09:31:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id 70sm26878343pft.104.2017.07.10.09.31.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 09:31:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Duclot <william.duclot@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] rebase: make resolve message clearer for inexperienced users
References: <20170709202520.21739-1-william.duclot@gmail.com>
Date:   Mon, 10 Jul 2017 09:31:51 -0700
In-Reply-To: <20170709202520.21739-1-william.duclot@gmail.com> (William
        Duclot's message of "Sun, 9 Jul 2017 22:25:20 +0200")
Message-ID: <xmqqvan06yo8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Duclot <william.duclot@gmail.com> writes:

> diff --git a/git-rebase.sh b/git-rebase.sh
> index 2cf73b88e..50457f687 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -55,9 +55,10 @@ LF='
>  '
>  ok_to_skip_pre_rebase=
>  resolvemsg="
> -$(gettext 'When you have resolved this problem, run "git rebase --continue".
> -If you prefer to skip this patch, run "git rebase --skip" instead.
> -To check out the original branch and stop rebasing, run "git rebase --abort".')
> +$(gettext 'Resolve this conflict manually, mark it as resolved with "git add <conflicted_file>",
> +then run "git rebase --continue".
> +You can instead skip this commit: run "git rebase --skip".
> +To stop the whole rebasing and get back to your pre-rebase state, run "git rebase --abort".')
>  "

I find the updated one easier to follow in general.
Disecting the phrases in the above:

 - The original said "When you have resolved this problem", without
   giving a guidance how to resolve, and without saying what the
   problem is.  The updated one says "conflict" to clarify the
   "problem", and suggests "git add" as the tool to use after a
   manual resolition.  

   Modulo that there are cases where "git rm" is the right tool, the
   updated one is strict improvement.

 - The original said "If you prefer to skip" and the updated one
   says "You can instead skip".  Neither gives any guidance to
   decide when it is the right thing to skip, but probably that is
   not needed.  The updated one is shorter, which is a plus ;-)

 - The original said "to check out the original branch and stop
   rebasing", and the updated one says "to stop and get back to",
   which is in a more logical order.  

   "the whole rebasing" used as a noun feels something is missing
   there, though.  I wonder if "To get back to the state before you
   started 'rebase -i', run 'git rebase --abort'" is sufficient,
   without saying anything further about abandoning the rebase in
   progress (i.e. "and stop rebasing" or "stop the whole rebasing").

Thanks.
