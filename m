Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6651F454
	for <e@80x24.org>; Sun, 10 Nov 2019 09:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfKJJLK (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 04:11:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36759 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfKJJLK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 04:11:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id k13so7089332pgh.3
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 01:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cY+7deKQi/hOJM9vfuZtKAAN7jfr3mU7/Z0v6mHddJw=;
        b=L3ecnvDw8QpaoT3Cd2niOHye3zKKxyQ1NZNN/edlyPHPETdl1vYtwPFNO/wkJoSrpC
         E846fiOuUKO+fR7eA1QUBPe4C3uTZlP7xME9UHQ/313jPG5NEQ/JTxkoOf5gB5ZE0Irq
         ZG3wcnO1J7FVi+jngt9l9b54WmVe8VOVFpK5bsnjuLusZw1Y2px4Er508WbgXkl0eYy7
         kvjTCTjjgCWPI1zo1PjggSSTjMJymN26YdGD+ZpN27lAEkoM8uJI04mazc1l2bdf/SRs
         9nMLd3X0qGmR1eGPdL7DjecfjCC+9TMdWgaepPKTAC2sek209uvZnRkqi3RDPs5ugOGa
         daNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cY+7deKQi/hOJM9vfuZtKAAN7jfr3mU7/Z0v6mHddJw=;
        b=tLLRRwAEebPAxWk4/4NxZMt2W9e1grtXa9hSsC3EAbMBJJj3cfsryGrRmWQdw7cTHd
         WaY9eg7mMWzkfDa3Je7ZefCBggBtj8mM5LC3Ij78+da5wmsT2gh0QzepAZmbxY95AkB9
         OHPhx18XFZmMaKXUhKbemQuczidoNsV/EtKAtdbQqN/5iU6fwbHugipUhKzzs+ozI3Mh
         HABjS9HSoAlcElsB3AXLjF5dvKMi65LAvb2NlTT25um2lJJla2bRUxytowiij13b/nko
         LwnQniCYfUrDrDI8qZ66xAQIa6oc5ZHU7s9Pcal3E3Bnm6kpGTotxlXg3lZUmPZ2Altm
         t5LQ==
X-Gm-Message-State: APjAAAXl8+2zUuWqp1gs+syKm1u3OdR0UHPSFXPtuOb1rnfwdzK+pKbn
        lfhKktMvhIYEUuLieWwtiF1yPe3sqAw+Ik6g2zI=
X-Google-Smtp-Source: APXvYqw6yXVrSCxkpyXnfUi+JVhdAmDOR4PC2XtDpl/wHHayqKk7zuELYj/vI8WNE0WK5Z99e92rnsOoT5lqKEJ/+o8=
X-Received: by 2002:a63:8249:: with SMTP id w70mr22195051pgd.54.1573377069111;
 Sun, 10 Nov 2019 01:11:09 -0800 (PST)
MIME-Version: 1.0
References: <CAE0unxyojHVWP4aM3C+DdMYORmcoCuq-0wwLGjE8ok6dLj_E8w@mail.gmail.com>
 <xmqqpni0jioq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpni0jioq.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?R=C3=A9da_Housni_Alaoui?= <reda.housnialaoui@gmail.com>
Date:   Sun, 10 Nov 2019 10:10:57 +0100
Message-ID: <CAE0unxxzBpTr1afmKfQm_nJYo5oFOftih+vE+wQbFW809rXdaA@mail.gmail.com>
Subject: Re: Sometimes unable to lock the index during pre-commit hook
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?R=C3=A9da_Housni_Alaoui?= <reda.housnialaoui@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your answer Junio.

As you probably know, many projects (not only mine) format the code
during pre-commit hook.

Could git project consider this widespread usecase?
I guess unlocking the index (after
https://github.com/git/git/blob/master/builtin/commit.c#L419) before
running the hooks is not an option here?
Could a new kind of hook be added to cover this usecase? If I am not
mistaken, this would be similar to prepare-commit-msg which allows to
fail or edit the commit message in place.

Le dim. 10 nov. 2019 =C3=A0 08:26, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>
> R=C3=A9da Housni Alaoui <reda.housnialaoui@gmail.com> writes:
>
> > Are pre-commit hooks expected to be able to manipulate the index?
>
> Hooks are described in githooks(5) manual pages; we may want to
> clarify what is not allowed, but back when most of the entries were
> written, the stance was that anything that is not explicitly allowed
> there is forbidden.
>
> In general, a pre-<something> hook is a way to inspect (i.e. look
> but not touch) what is proposed to be done and veto it by exiting
> with non-zero.  It is not expected to change the state of the
> repository in any way.
>
> The code does not necessarily enforce it, because it is costly to
> take a snapshot of everything (including the index, the working tree
> files, the files that are untracked, the objects in the object
> database, etc.) before calling a hook and ensure that the hook did
> not touch anything.
>
> Thanks.
