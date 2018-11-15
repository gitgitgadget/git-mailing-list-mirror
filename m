Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0801F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 06:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeKOQLe (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 11:11:34 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33139 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbeKOQLe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 11:11:34 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so10283690oib.0
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 22:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LkCt+sJL44PhI9kd7OqkQOF2UlM0sLU2RStMHpVNqVQ=;
        b=GC8/K85wDmjS4ty15LhF+G/wNtZvk3G0ftZvTCQqoGxNvXb2aiBHdxOxaxYziyJzeA
         uLankydR2dDplgvshLbTB+K9PvUkbIrFXyTCA2QguNMJ+eLW9unOoE4je2qvBZksxWdX
         1cAM4/I76MZ7+nkXDxrZL0MkWXFERoc8nM1Ozd6XEp4VqGTK5lraFpaSeIZe5aB3ABxq
         eVs2F+ndEhKqwrCOcNTt5tPk/TEXz5g1loXF9pCX69w9KqcY5RJnAiJsMMPuRfWDH0Fa
         dAeFQfBigxcs1NmkQ/JuHnvChiKuOaYOPX6+s1B4pLtS6QsFcPI/tVjrdrhGlY+3utwv
         Ea9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LkCt+sJL44PhI9kd7OqkQOF2UlM0sLU2RStMHpVNqVQ=;
        b=liq0FsomnmFNQ8fo4P33eHgbsFmoJlkNxOzZs+t3NwvErTNhwi4eTRQSJUbyI8zb4t
         dghiqoRJoqvpOgLS0HrI1zfYOOXWgUEHoLhAR0l7VK0A7fmAfp4ouKPvloBZ4VnRZFip
         O5bSfcEMrToIxRxykudE3bFqHaqz3EL4f2g+ZKj1hUibN83QakNWigc8F1RuhxMBR+LP
         njAR8jDugB87PTvAN4009fsN/XGABf6co9PC3SuaGkFZCSjhNGml1nRGPd+vUTXSXHns
         ineWdfyMH7C+1cox3B9LMPa0XAR5ZS2f/v6wgPuAmkI4Eq8xCztgey1WUoR2gPizOXue
         1P7g==
X-Gm-Message-State: AGRZ1gLr5HtyuxgDTifRz4GwCzAOyAFb7+GAuWttH+JK8GkiKGBxj2AO
        vqazV1zNaW4+kyA69SePzlpFPfAXCeroACzX2OgWVg==
X-Google-Smtp-Source: AJdET5fGs5hw6Y0/rGIekjgWhh5aB+yptjYka6NaPRm1cNsjVd9dF68FtMs5ZVETiajIut8NCOatEhkPtjk2KetRe0c=
X-Received: by 2002:aca:ddc3:: with SMTP id u186-v6mr2764796oig.204.1542261906719;
 Wed, 14 Nov 2018 22:05:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:d182:0:0:0:0:0 with HTTP; Wed, 14 Nov 2018 22:05:05
 -0800 (PST)
X-Originating-IP: [2601:647:5180:35d7::860e]
In-Reply-To: <CAGw6cBvJSswpvrMwKU9b+ANEHO4tWjWVhLL54nUyod2NoHJe1w@mail.gmail.com>
References: <CAGw6cBvLDNtYT6vfHcxmX0S_SS1vmYVCEkSD_ixah6cGKJ4H9w@mail.gmail.com>
 <CAGw6cBvaC+TEOM9Tjdbs5zkz2hzW4649=4rsAo58cNOVHOQS=Q@mail.gmail.com>
 <CAGZ79ka=tkKYNkPmSjhomcfAPbEg6PQPSRtpe3uq2B45fNoyjg@mail.gmail.com> <CAGw6cBvJSswpvrMwKU9b+ANEHO4tWjWVhLL54nUyod2NoHJe1w@mail.gmail.com>
From:   Michael Forney <mforney@mforney.org>
Date:   Wed, 14 Nov 2018 22:05:05 -0800
Message-ID: <CAGw6cBth+j+vAjhrQutxBXAkuJrBfHKG4GdCu1jpvAAXOwudEA@mail.gmail.com>
Subject: Re: Confusing behavior with ignored submodules and `git commit -a`
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, bmwill@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+bmwill

On 2018-11-14, Michael Forney <mforney@mforney.org> wrote:
> On 2018-10-25, Stefan Beller <sbeller@google.com> wrote:
>> I guess reverting that commit is not a good idea now, as
>> I would expect something to break.
>>
>> Maybe looking through the series 614ea03a71
>> (Merge branch 'bw/submodule-config-cleanup', 2017-08-26)
>> to understand why it happened in the context would be a good start.
>
> Thanks, that's a good idea. I'll take a look through that series.

Interesting. If I build git from master after reverting 55568086, I do
indeed observe the issue it claims to fix (unable to add ignored
submodules). However, if I build from 9ef23f91fc (the immediate parent
of 55568086), I do not see the issue.

Investigating this further, it seems that 55568086 addresses an issue
that does not appear until later on in the series in ff6f1f564c
(submodule-config: lazy-load a repository's .gitmodules file). Perhaps
this was a result of reordering commits during a rebase. In other
words, I get correct behavior until 55568086, and in
55568086..ff6f1f564c^ if I revert 55568086.

Looking at ff6f1f564c, I don't really see anything that might be
related to git-add, git-reset, or git-diff, so I'm guessing that this
only worked before because the submodule config wasn't getting loaded
during `git add` or `git reset`. Now that the config is loaded
automatically, submodule.<name>.ignore started taking effect where it
shouldn't.

Unfortunately, this doesn't really get me much closer to finding a fix.
