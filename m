Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 115341F406
	for <e@80x24.org>; Fri, 12 Jan 2018 17:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934109AbeALRTb (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 12:19:31 -0500
Received: from mail-yw0-f178.google.com ([209.85.161.178]:40892 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964926AbeALRTH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 12:19:07 -0500
Received: by mail-yw0-f178.google.com with SMTP id g191so2795290ywe.7
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 09:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v5pYlwQBgv8wi4WzZQK6Oz2yzJXDnV6t7uU0xIAbywY=;
        b=KvexodXkTIB3Spz6rrKtQE93+X1qs/7m4r7RUhzt6xwvDXeoxcWYYuzozgX0BlDhjL
         dMUhtEXayIDGiY0jJYJ9t9P4E87BrABvzrELSQw9tbwFNiAv/SX8m9gTXQgbA94fJoZd
         7UOyuYMCb6vuK8qYmy/BzRSmJegVTwwwqtSUjIfZl1EasjfaXppJ1sx8nrz0q/43CQ3y
         2+VQ+nHE2f+xKEj75ziAm1bHyK0pVLquIrhDnYBxuMvIUXazLlc4J0rz9keEaXmzzk6W
         I4YJzSU1fusbne6hqkPBDii4tHrKuiQYbhposYj6RYAmVutgFP0s2DFJSaq5yFPasWeY
         xrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v5pYlwQBgv8wi4WzZQK6Oz2yzJXDnV6t7uU0xIAbywY=;
        b=X4rOIWeclDMzw6BKEiKh3VUEPhI8CuP6FCXDR2kuMTQz57q7bB5EHBaP8i7OaCRama
         bCl7wCCyy61OTeOusiVewCLABZERlSS19COF7NkNF+nw2Kn7i2aGsvnKwiem8QMr2kjT
         zuhppuE92+9dkjj+R1YXlCbfg8yBXqDX7pz3IEfRhAVb8FVlsbXUDE8qfLiT1CnWgMn9
         Tx/bX8CyMcEcB/ToBI6irXiOP0HtCDSx++KXkbZFFBYg1QrCO5chR/p0YgQjkI+5cAvH
         Bz8H5xBoeOM2Wvta5Wp6rHK72R0ITWNPQ89pCe7qztPC32UaL1thV8UCVlF8ndoT1ybA
         96cg==
X-Gm-Message-State: AKGB3mIK1ebkuz9+OV4bi7kDd1S6CGi7GJ/AALRwPaRppYa6BVJ6n1YJ
        jxSdw2O59SIXrF2naMekF78hg5wm7kwMnhwa0Sv3+g==
X-Google-Smtp-Source: ACJfBouiKWOz/7FNvFhhMSMeRTELz17iCk/rbC3NXBwmQ5NTTlQ80IGjh3XyG2YJfhaGEjf01uWDb66IOP4H5QzXCa8=
X-Received: by 10.129.156.134 with SMTP id t128mr17044985ywg.108.1515777546334;
 Fri, 12 Jan 2018 09:19:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.134.197 with HTTP; Fri, 12 Jan 2018 09:19:05 -0800 (PST)
In-Reply-To: <20180112095607.18293-1-pclouds@gmail.com>
References: <20180111094712.2551-1-pclouds@gmail.com> <20180112095607.18293-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 12 Jan 2018 09:19:05 -0800
Message-ID: <CAGZ79kYUyugA_BhMgr_k1aWfxg9+cNbOcVO+LOZkZ1YAAu7_mQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] run-command.c: print env vars when GIT_TRACE is set
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 1:56 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> v3 turns a single patch into a series. Changes from v2
>
> - env var quoting is now done correctly (from shell syntax perspective)
> - the program name is prepended in git_cmd mode
> - cwd is now printed too (because I have too, see 4/4)
> - we don't blindly print the env delta anymore but print the actual
>   differences compared to parent env
> - which means we also print "unset XXX" statements in $GIT_TRACE
>
> The new output on git.git looks like this
>
>     trace: run_command: cd 'sha1collisiondetection'; unset GIT_PREFIX; GI=
T_DIR=3D'.git' git 'status' '--porcelain=3D2'
>
> a bit longer than I would like, but that's because of
> sha1collisiondetection and it's not long enough for me to invent
> $GIT_TRACE_EXEC.
>
> I'm not adding "sh -c" back though because that looks like it should
> be done in run_command.c itself, not just output tracing output.

Wow! This is really cool. Thanks for your effort.
(Also I learned today that I can just copy the command, up to now I always
dequoted the commands when rerunning it for debugging as I assumed I had to=
)

>
> Oh.. before anybody asks, I'm not adding git prefix to the "cd" part.
> You're supposed to know that git moves back to worktree top dir when
> you read $GIT_TRACE (or are welcome to improve the print out).

Heh. Would appending  "; cd -" solve the issue? (Though I would argue
we don't need or want to add that actually, as you'd want to copy and run
the command and surely want to run more tests in that directory afterwards.
I mean you're debugging, right?)
