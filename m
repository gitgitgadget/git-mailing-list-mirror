Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B171F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 05:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392987AbfJYFgl (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 01:36:41 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:38273 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732032AbfJYFgl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 01:36:41 -0400
Received: by mail-lj1-f176.google.com with SMTP id q78so1234089lje.5
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 22:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJGNpP6lM0j7skNexFbpRg0bfYVIVB9F0i0NUDGsbIA=;
        b=rNPg8HWvlZ2DfUA6+HfxEkGgYrBaBidJ7Wv9ekq+kTCgBTr+LEnGRFTGQXXjVZgv1V
         WTlLDWSjyW/S1pAYlNfd5fNyqPDt5R0MKg0Mmg16FMEv2Mel5f69KJkPzWJBOGREGLZM
         sIXQk3ob0Q3A3En5YFw/rYGXa14fBvKZfQHV2wUkdQUsPravRk7pXoBWUQEbgVpik6f2
         2M0F69x376/pKdXAFqkK80oNVgxocwnK7BCdC1zvvZqqT0Ig5HOv/108my+Fh26tgruH
         WV/kGdikEiv9cSJO7MIItbmZvZh6uiBBu5tfZhxjH+kZp0cN3tMCBx0abBeRMC6lBznS
         zFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJGNpP6lM0j7skNexFbpRg0bfYVIVB9F0i0NUDGsbIA=;
        b=Ib+LnDj2EXBg4f3A24CaoW/EGZUezfoXjoc3njKHi20dNTKORZVF5dA8xohzpmF12g
         SFWBPwKlf2bIkwZWXK8AN/BcEKWgtS0TGq3eHzivS0z/G2hrDEa694gmINO9YXiTmu1/
         ZnZ6Jm7Gk++wzLAZuDMSoSvyKF7ZJFhGwWRwEl6tJGZQcFnzMRrXV9acdkPVwqwW5ZS3
         Yhufyqfjs/65qPFxpEbbzcp60QYSV5ciZA5YjKVeL2lb/bELsxrX1ypUi3GsgtSLTUKL
         MW1iOcmquchwK7LpeCm6pnSMUuhEqq3jcy5mSZhVg8QiF/XEA/DxiTCLCTNAH+Ib2Qaz
         gxFA==
X-Gm-Message-State: APjAAAWnNaS21YV1XoOHAyD0bIbFLK+fuP3b5eIk/jwHdol2A10z2rhU
        h8H66Fx16j1CblOVMvawahYQ7Zo273kG83pmNx7O/Od62GySFg==
X-Google-Smtp-Source: APXvYqwKuFa31At+0l0iosl5xnRbXA3lYLir1EmeKap+UYdUAWOJ+tlDw5nvOcm55HZP83Pla4W1pw2BYZVcDr5r9GU=
X-Received: by 2002:a2e:58d:: with SMTP id 135mr866514ljf.57.1571981798532;
 Thu, 24 Oct 2019 22:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
 <xmqqimoehp7u.fsf@gitster-ct.c.googlers.com> <CAGr--=JQXfbJaxvYo1ue__eRHyEgKDd3mjTgxXxT=7seTU_oYA@mail.gmail.com>
 <20191024171616.GA40755@generichostname> <20191024212913.z7jkdzibp3aodpgp@yadavpratyush.com>
In-Reply-To: <20191024212913.z7jkdzibp3aodpgp@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Fri, 25 Oct 2019 07:33:21 +0200
Message-ID: <CAGr--=KXUedDtX3Dtx8jRm1Ge6sgk0v+CPq36tbOAnhnVDYQTw@mail.gmail.com>
Subject: Re: RFC: Moving git-gui development to GitHub
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Thu, Oct 24, 2019 at 11:29 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> Update: the list can be now be found at [0].
>
> [0] https://github.com/prati0100/git-gui/issues

Is that the full list? If so I'll add my issue [1] about automatically
selecting a staged file (avoid an empty diff) when focusing the commit
message widget.

[1] https://public-inbox.org/git/CAGr--=KMJmYtVaATFkOPcboAdkLvpZFbWAo4QAE0-uC6RL4Lqg@mail.gmail.com/

Birger
