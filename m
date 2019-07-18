Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB56B1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 00:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfGRAlt (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 20:41:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37483 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfGRAls (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 20:41:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so1239221pgd.4
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 17:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zW7MYAf8MHUeJLbr8E3gIuKchlNqlEmKkuEYIAqanvs=;
        b=OZe++a0X+AAjrA8Tl6UGjzNMbffRZ/PtVwaJMgvGUxm7loGRdg+Nr1RE3DgBIV2JDb
         40sDkFyIIlsWw/fdIIurvMdVSBtpdXGhi8OWoJ5L8s46yqG0fAoPgklHTOmCENVv2N7X
         LJWlJH2Tn+pSc4VZeZaoFSv1kdpQxDlJj5AMUrEjyZ5+uUeQh+ZI9n/8UE8lMA+46lxe
         LeNxksHLyLWh2i5Yb9R90iyHsdvkFY2aFbPMySfpFendNLjkv1LwNC/PQvpeNXRq+aH1
         m5fA912UrDB3OT0+NPfDCbx848vWhcAxgGcTnd0SWGaFOUIMugaBsGLMC3lbtcnLBHU7
         O1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zW7MYAf8MHUeJLbr8E3gIuKchlNqlEmKkuEYIAqanvs=;
        b=FucnQIHBDqP7+mwyfCm1pGOsQz8NseYToB3MxBtRRoOfEtB4JPNP6+yU/LZJNoUDTV
         9IhUQ2deMwADaUHKEchcAOM9teSBnqdnxjkIxJLqk7fHKRHwTdtX654pntrxzYzOvZyA
         t0LS40PufTTcfoZA0Y62nC83Riwkrp/0kWtvjtmBDtd8W3QfhrEA0dT6FKe7113gSpvp
         JaaFNZ4u2yXsPZ6YBpnJGPAT+mTK2qwy2uq7KWP/yQZqU/1e/pd4davC5KRhc1FwmBqd
         wWC692CtBl4/cRcKtVYc7O/QktHZleDn2cijNe+yEDVLUv+N/xw8rr3XWXMYGLQbnATS
         4H6g==
X-Gm-Message-State: APjAAAXJ3RIH9Z6m8SCsOrQpa2CV0Q/whNUJhMXO+Mdgs1gycG+IqxOM
        s0ku35t7lYgssAh/o4dI0LK+hxO2/qA9IOEVuap0P/+5
X-Google-Smtp-Source: APXvYqynXhjOJFCBwbek9hu7tEhfugL+8CEyDFFBsdgpoha4xaJ7V7XolF6/cZyXOEzMo/NBfJqyNzDMkO1JWhHLrPQ=
X-Received: by 2002:a63:2252:: with SMTP id t18mr44704821pgm.5.1563410507995;
 Wed, 17 Jul 2019 17:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190713051804.12893-1-eantoranz@gmail.com> <CAOc6eta-jX93k6twcrJOeRt+JHtLk4mUs7YD_bG=Ggvw4thAZQ@mail.gmail.com>
 <xmqq5zo01qnv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zo01qnv.fsf@gitster-ct.c.googlers.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 17 Jul 2019 18:41:36 -0600
Message-ID: <CAOc6etYM6DSDQ_H=eJs1xuGU9a83kTe2-vEy9+FEgHobT77_Eg@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/merge: allow --squash to commit if there are
 no conflicts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 17, 2019 at 12:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Sure.  I started skimming and then gave up after seeing that quite a
> lot of code has been shuffled around without much explanation (e.g.
> printing of "Squash commit -- not updating HEAD" is gone from the
> callee and now it is a responsibility of the caller), making it
> harder than necessary to see if there is any unintended behaviour
> change when the new feature is not in use.  Whatever you are trying,
> it does look like the change deserves to be split into a smaller
> pieces to become more manageable.
>
> Thanks.
>

yw!

I'm focusing on the squash --commit part only. I think I'm close to
getting the desired result and now I'm taking a close look at the unit
tests and a question came up on two tests of t7600-merge.sh:

merge c0 with c1 (squash)
merge c0 with c1 (squash, ff-only)

In both cases it's a FF (right?) so no new revision is created. The
unit tests are requiring that $GIT_DIR/squash_msg have some content:

not ok 20 - merge c0 with c1 (squash, ff-only)
#
#               git reset --hard c0 &&
#               git merge --squash --ff-only c1 &&
#               verify_merge file result.1 &&
#               verify_head $c0 &&
#               verify_no_mergehead &&
#               test_cmp squash.1 .git/SQUASH_MSG


not ok 18 - merge c0 with c1 (squash)
#
#               git reset --hard c0 &&
#               git merge --squash c1 &&
#               verify_merge file result.1 &&
#               verify_head $c0 &&
#               verify_no_mergehead &&
#               test_cmp squash.1 .git/SQUASH_MSG


Does it make sense to keep this file in those two situations?
