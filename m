Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90E5820899
	for <e@80x24.org>; Sun, 20 Aug 2017 21:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753398AbdHTV5i (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 17:57:38 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36832 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbdHTV5h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 17:57:37 -0400
Received: by mail-oi0-f51.google.com with SMTP id g131so138431068oic.3
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=bAtifuNnwiIfROTcks28LeN9Q65Fw1gy9O3x/fWc7Bk=;
        b=TjspB4NPYddFrQAsiKtsDqUAcGNPw4ObVf2Pi2BuTyJxvT1y5d07XFffXTNhvQnfh7
         yRdQPyb1EsJVn5YUJWHMWpjDxW0/geBIfIfHUuVIxInjRvzrjTNaRHIYizVQKnKltwDI
         824A2gB2WQN/Q52cM5HPyUXRHq3+0/zFRbGdK8EWVwuF0hRb61zqgAzEPb92kdnZDzXa
         9Y23+xb4MpOGYvA2cySf/713YKAom7JQAUEx7qB7tiuebQ8jHmef7WSJUhArJKTg+LK+
         iBvSDQXMpQ6KOUaOXpkQxcL2s1SkAAQqbQrtMC/XG6oUqcwBCnZVmuYhqVIse8SxaKsm
         tcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=bAtifuNnwiIfROTcks28LeN9Q65Fw1gy9O3x/fWc7Bk=;
        b=ppJXOF4PCWbWmuNnpEhikSsgwNoo6ZNrWPTvniDDqkXpDyxYs+se+1+2whpb4OBai3
         uqQkxD47+6X93QlOMrVk8cMuMcVGM7ALJ+ahMgJgDCseU94lSflNphczgSSHYVoRbYCZ
         IfoZDOigp61FpOPRn+MGkSq7/Jj6QhyogqiuBDWLnc1lVYmPoU2DHquGUMrYjrK470gN
         ASQ1oz3xRxKWQMJ+WNERCMnLq6PCMiEppwLG57mTuhjwazrdovQBBaP+SYgAtvhbDXJj
         o9WbpJ15fneuA1i/vX7sj1vMJJ2F8IY8PsPNbpjXsvijT2ZTgD2Hk5jZptQ5OPDYVQfZ
         ap5A==
X-Gm-Message-State: AHYfb5jxC6sqjGQ+lTy1kcyY3KN7xfxnavAE00BendjUwEMcbpxWHIaK
        AnyeFC4pN2il1ILp9KpwPt3yWM00AQ==
X-Received: by 10.202.95.139 with SMTP id t133mr21139546oib.207.1503266257423;
 Sun, 20 Aug 2017 14:57:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.5.107 with HTTP; Sun, 20 Aug 2017 14:57:17 -0700 (PDT)
In-Reply-To: <CAH5451m58n8mYvt=BC_t2=EAv0HOOdAWrCHCNEPQ3NVjT174nQ@mail.gmail.com>
References: <CAH8yC8=i33rtopVt=sgg0k+P4JQO+1EVpPJ+u5CPGEXKvZ+PBA@mail.gmail.com>
 <xmqqbmnba50e.fsf@gitster.mtv.corp.google.com> <CAH8yC8mpPRN2y1k07_Jk9QP88=gpLKNWfV3W0QQwXTWxyL5STQ@mail.gmail.com>
 <20170820091807.l23h44gnjajfv5bn@sigill.intra.peff.net> <CAH5451m58n8mYvt=BC_t2=EAv0HOOdAWrCHCNEPQ3NVjT174nQ@mail.gmail.com>
From:   Anatolii Borodin <anatoly.borodin@gmail.com>
Date:   Sun, 20 Aug 2017 23:57:17 +0200
X-Google-Sender-Auth: rJzowIGZmBsAG9mRJYb5JeyujCk
Message-ID: <CACNzp2kao+hu6a2nO=gVaLctzoDauB+xyj=cfQLUdNOXTNKQfQ@mail.gmail.com>
Subject: Re: Please fix the useless email prompts
To:     Andrew Ardill <andrew.ardill@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrew,

On Sun, Aug 20, 2017 at 2:40 PM, Andrew Ardill <andrew.ardill@gmail.com> wr=
ote:
> Maybe I am missing something obvious, but if that's the case then
> can't we just do the identity check when trying to make new commits,
> in which case you should be able to pull without setting your
> identity?

`git pull` is `git fetch + git merge / git rebase` in disguise, so we
should be ready if git will want to create a merge commit or do a
rebase automatically (and potentially create new commits with
`Committer` set to the current user). `git fetch` and `git clone`
alone, `git branch`, `git checkout` etc don't care about the email (as
of 2.14.1), even if `user.useConfigOnly` is set to `true`.


--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Anatolii Borodin
