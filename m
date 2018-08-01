Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD537208E9
	for <e@80x24.org>; Wed,  1 Aug 2018 01:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbeHADUo (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 23:20:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35932 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732855AbeHADUo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 23:20:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id b22-v6so12101424lfa.3
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 18:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rp1poXQJRn7wt/czMyEvJno2Qpg3AYgaIjdT1nxeX68=;
        b=pNPEXYTEBmYEB4quIZosCCQnbom8wsTXpRzlqvEnu3tTBTf4gZ8dbpvDFujwBNz6Bh
         CwFpm3xdvvl2iKBkef9xmqpOPFXq5Id9Pe53WRk9NMgKaAYAnWIBhYP2MBPkUXR0/CSA
         TPm5vIJTGt4ZmGu7fz+DySDPaQzUUmZ0hIJZM4iWNJj2nKcK+N3BPG9OotApZW+6XFFA
         sBJ9b2l+rVkqUjo47Q62sxYEwRLG/YEUgH3/262eFjIza+Rzof2C0Zm2ED+lUJVXCC7o
         FondJ/WYSfJYZNZLUKlhS+IDwlxfYV7qTo1gb9C0w83Vu+uAfgx5+UTlALGdLsXGVHpJ
         GaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rp1poXQJRn7wt/czMyEvJno2Qpg3AYgaIjdT1nxeX68=;
        b=GGlLrwEMmWDXAFXxw+ucS1QkWc+G04eOReQafdVFDkpDdviPO1RH39FF8gVN1mdXge
         +4i6HcTaIYU4exr6kvg2jcmRjSgMMHrTgvQ/qCwXYH2oyKvbnjmvIkFqtxrnBujwXImX
         JykKsaQm+qOWpQaOC4P8bHEf2B5i/MglvAv3hnNF1/5pcKYJJnr9ISzYXG1O8RCeh0DT
         SXB82o0UQ16XWwPVYP3Q/jqaM/2yIeKsllXhYplizJPyv0sQvtFLugfgktz0tFiPe2VZ
         fWob75Qo8RLUntfjtJ0/NeOwcvKXMhaxU/fy1hNv45hW/AfbKWA534D991rvDF+gV1DF
         oM9Q==
X-Gm-Message-State: AOUpUlFAyAOhn8/1MYe/lLD3A45EyZY9aFDJT3oMx2GVoFtX/QePyzS8
        W3o+mZC/zFaEOvjaQWLvpWAvqo9BK3+FHtFrtHQ=
X-Google-Smtp-Source: AAOMgpcqKr4nDgihlXEN71OwPbXPrpzJFXRnWLQKFTSW7nMqgrT+9xBEY33nQJfzEZCk86p0iaP6DvpyEAy7VFl9vm8=
X-Received: by 2002:a19:501e:: with SMTP id e30-v6mr14086859lfb.71.1533087459471;
 Tue, 31 Jul 2018 18:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180731233248.25482-1-szeder.dev@gmail.com> <20180731233906.GB113554@aiede.svl.corp.google.com>
In-Reply-To: <20180731233906.GB113554@aiede.svl.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 1 Aug 2018 03:37:27 +0200
Message-ID: <CAM0VKj=aQ1kO_i2OkkcMRJZ0a8PHVQH-oKQ1_qZ5UpxEPEK5kQ@mail.gmail.com>
Subject: Re: [PATCH] t1404: increase core.packedRefsTimeout to avoid
 occasional test failure
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 1, 2018 at 1:39 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
> SZEDER G=C3=A1bor wrote:
>
> > While 3secs timeout seems plenty, and indeed is sufficient in most
> > cases, on rare occasions it's just not quite enough: I saw this test
> > fail in Travis CI build jobs two, maybe three times because 'git
> > update-ref' timed out.
>
> I suspect these tests will fail with valgrind (just because valgrind
> makes things super slow).  Would it be safe to use timeout=3D-1?

I don't know.
Travis CI has a time limit of about 45mins for the whole build job
(including installing dependencies and compilation), and any sensible
automated build system must have a similar time limit, so it would be
fine to wait indefinitely in such an environment, though in case of a
timeout we'd lose failure reports of failed tests, if there are any.

OTOH, my (and I guess most devs') test runs don't have such a time
limit, so I'm reluctant to change it to wait indefinitely.  But then
again, waiting indefinitely for a lock file is not all that different
from messing up something and creating an endless loop or a
deadlock...
