Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 864FF202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 20:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751181AbdKSUUC (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 15:20:02 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39323 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdKSUUB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 15:20:01 -0500
Received: by mail-qk0-f193.google.com with SMTP id w125so5212804qkb.6
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 12:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cKknisE1IpQYvMXXuJox1Hd1jTCR/KVeKLK08x5Fj8k=;
        b=QbtywOS+LVc+bZQYvO6E0kqbOxCSNXUl+iLnRQCCxePTCYh6lf70/ejFZcoADkAdGf
         GOplC5gnGY9jhGUIfQ3XMGBunHOwf3izjNkpwUG5lvVTUdbOu3jXUwZ+kXbRd8el++38
         n832jpGQqiVm6WHq+flxD/g4ANy+SQJrjrjOhhdVWsA9pBWBLYVBY5igTqbgC7tZrx9/
         wiogyfksHB6xghi2xs3+bcTiSmZR79EKSnZm3smwb0qFYBH0pMFq+VAZFFGNOd+LRU7e
         W3CvhwrRl2vobl8MxI8G/HWHmgPeE6O5az4z74sAmLF/gYezdzgSJvTBUb8AGIAqxOFi
         vtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cKknisE1IpQYvMXXuJox1Hd1jTCR/KVeKLK08x5Fj8k=;
        b=cGjAJwd+8peav3X/td2xG5BANU4UplSp4uWEYT4KVCJdhd6GXCypbjyIhSXZw41hHa
         NjuRYxd53mTBGVXoObGs6B3J9L2/qJXZEA7CyIFgCGxGxzrWlOpXseHOIG3pWWwTYnln
         onFbE66aysu63UG6TKhoAkMXo4bXtJJOTXDdtDqeI8zSk1TwVbtrgl5sN/Sa7roc8e9I
         4R+BWxDiQecpU0rTLG3yMPcUpKYWNhGLrY5IqD73R+j8gsua2gNCetVEjyAFNB3COjiU
         luWhkrZwmof5okeKJIj3kFLFmQ/FeZBpHjlj+H1Vn8vDAoB8Th6lQynxgcFlEjNEJ2fC
         0FMA==
X-Gm-Message-State: AJaThX4l5bkuhhnsPlWgL1y+Yj7Qx7PV+9Wp+ySXkowSUqyQR/trrss1
        pEfJOp63fIW/5WmIGwR1eWrypZvQA7sJGkFnbkQ=
X-Google-Smtp-Source: AGs4zMab4+e5heuCqyWqtpNQcqc6DvNwMtPCN5BpKlzncdeY6oGbA9oLWOAw2yxSaTjt2HO3we6e2q1E5z0Q77CyxGk=
X-Received: by 10.55.141.3 with SMTP id p3mr18103635qkd.210.1511122800623;
 Sun, 19 Nov 2017 12:20:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Sun, 19 Nov 2017 12:20:00 -0800 (PST)
In-Reply-To: <CAPig+cQqbvuZg0Y8ZMObZc7mYXzohooVBFj0-o+CGGXrgGLp5w@mail.gmail.com>
References: <20171118181103.28354-1-t.gummerer@gmail.com> <20171118224706.13810-1-t.gummerer@gmail.com>
 <20171118224706.13810-4-t.gummerer@gmail.com> <CAPig+cQqbvuZg0Y8ZMObZc7mYXzohooVBFj0-o+CGGXrgGLp5w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Nov 2017 15:20:00 -0500
X-Google-Sender-Auth: HK25KfxrzD8sMqCNUoV_cENnFac
Message-ID: <CAPig+cTmqHt5s+C1vTFA7S4ZBwjqnzkn-2wA6i3jVeLw7i1_Lg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] worktree: make add <path> dwim
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 19, 2017 at 2:04 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Nov 18, 2017 at 5:47 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +To disable the behaviour of trying to match the basename of <path> to
>> +a remote, and always create a new branch from HEAD, the `--no-track`
>
> Does --[no-]track deserve to be documented in the OPTIONS section like
> the other options are?

One other question: Since this is re-using the well-known option name
--no-track, should it also get applied to the "git worktree add -b foo
dir origin/foo" case, as well, which you pointed out (in the patch 2/3
thread) already DWIMs tracking automatically? (I can easily see
someone reporting it as a bug if "git worktree add --no-track -b foo
dir origin/foo" does not suppress tracking.)
