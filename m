Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DBD8208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 18:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbdHUSwR (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 14:52:17 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35213 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753479AbdHUSwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 14:52:16 -0400
Received: by mail-yw0-f171.google.com with SMTP id s187so11010275ywf.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qMpW2KB9sfuNhbr5sbvsU/d5lZ7QP+csIxHRFUClb2M=;
        b=rKbSbpJkrCpPk2NbigFJbfbDAf+Pyvwnb4lcfFGA6HmUtrqYM05ai/9QLOKWsxZRxM
         x7Krid8Uv6Hc/lRM2De6lRiQZUjQ0D8HFUw3rTfdJh6podH1M9Q6vhDNjxIbvbKbZ+0O
         OmBoDJuRP6qoro2GG3yPQPQ5tqVm0uK2NF73ommEkEcM3Tb6N2Ss6JEsTDOa7dLKGuvZ
         SXF2Rj+KYh6MlhN7rCwddng0s7nRuSNZ53TbqrLRqMM5Z/3R2tduN2LiBMs/ooMt2l7T
         VZQAYkLhVrlub0qdDH4bhNZROaNTZApewZreApVXB2yYN2PICnwvlSXNPIb8CUn/nmY5
         5QgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qMpW2KB9sfuNhbr5sbvsU/d5lZ7QP+csIxHRFUClb2M=;
        b=btRh9WI798P/5ssBSN4/QEPH9wGMDIyjJGe9eLy5bUzz3jrrT/VfGZNXdfrWZvnK3F
         TVzVVhvkKEh1cQ9Z3m0G3EqAulXIMpqytjBjMSfslM75kIuVhX2tL9ZPh0KuTvLaHNgZ
         BVtXSUF5uZYrqR9gBbwbFYds61N/mmrpQP0OxbMADPNUCqv01LdXdJRukGjoYTUoB/6P
         C/WNIQ2brxmc0z1vvhNDWA6v6tgChg3E0yRuwAPQwdZb6XMUv0Gor9yw7oUt4ScELa0w
         5qAZx5LnPJcbfM3TM6z5glanAsUzn/p1ex2oJF4Wg7uPBiDp435VqDO2jNsG3Sn79xYm
         ptPA==
X-Gm-Message-State: AHYfb5jhcQTie3NXkyYz3qXASbqHjBG3TCq5UlS/x3JmBvnYVKD2G9Sj
        f76Z+RgRtby+i7HnUefb7FZe/dMM0U4u
X-Received: by 10.13.229.3 with SMTP id o3mr14909415ywe.137.1503341533474;
 Mon, 21 Aug 2017 11:52:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Mon, 21 Aug 2017 11:52:12 -0700 (PDT)
In-Reply-To: <20170821115313.11879-1-l.stelmach@samsung.com>
References: <CGME20170821115329eucas1p1c550891b502863669ca351de028f2b80@eucas1p1.samsung.com>
 <20170821115313.11879-1-l.stelmach@samsung.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Aug 2017 11:52:12 -0700
Message-ID: <CAGZ79kZ7s8Y0M=5g8skhcONo=r9Y+MiHp3=+E1JTL4zNE_4v+g@mail.gmail.com>
Subject: Re: [PATCH] git-gui: Prevent double UTF-8 conversion
To:     =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc git gui maintainer

On Mon, Aug 21, 2017 at 4:53 AM, =C5=81ukasz Stelmach <l.stelmach@samsung.c=
om> wrote:
> With encoding on the file descriptor set to "binary" Tcl (8.6 in my case)
> does double conversion which breaks e.g. author name in amended commits.
>
> For example "\305\201ukasz" (as written by git cat-file) becomes
> "\303\205\302\201ukasz".
>
> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> ---
>  git-gui/lib/commit.tcl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
> index 83620b7cb..bcb6499a0 100644
> --- a/git-gui/lib/commit.tcl
> +++ b/git-gui/lib/commit.tcl
> @@ -26,7 +26,7 @@ You are currently in the middle of a merge that has not=
 been fully completed.  Y
>         set parents [list]
>         if {[catch {
>                         set fd [git_read cat-file commit $curHEAD]
> -                       fconfigure $fd -encoding binary -translation lf
> +                       fconfigure $fd -encoding utf-8 -translation lf
>                         # By default commits are assumed to be in utf-8
>                         set enc utf-8
>                         while {[gets $fd line] > 0} {
> --
> 2.11.0
>
