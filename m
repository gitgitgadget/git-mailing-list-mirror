Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0C5A1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 07:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfHUHGN (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 03:06:13 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34282 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfHUHGN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 03:06:13 -0400
Received: by mail-vs1-f66.google.com with SMTP id b20so718453vso.1
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 00:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S74Q6WSwMXtOqMKuQ08hLM+BRXcP+WdSkzm35dJvmZc=;
        b=OR7iFBXQQxbktq4bM6AVOaBTW/0gjjLndOs2e3EfcUhbPVylRlBbKBsPo3BVz4hTHf
         8DwLAT9bc7LihKO9tTDFA7e3VIO8YMhh3Jc/+q9E+UfCX1EdDsMUewOMrA0BrrO9oWJN
         4VHb/Q2xbYV6Buc37X2c1ngriPxda/Fm4NyvJTkknEUaCmWf+zfOPKtrfCIseddr6jB/
         /4dJzeVTLwp6ltsWoZnggDoZ2wcHq/8eNWHb4pd887mnK7bhpOoYZTC5KKhcN35Dm+oi
         WrSu/YpsOq0eiUDWoEJyn6vKxiFN5pzYfaHMdXhtQCwSdM6Ev/csYuu4sCSvd2YpIa0A
         TK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S74Q6WSwMXtOqMKuQ08hLM+BRXcP+WdSkzm35dJvmZc=;
        b=pRIGrMQOjeBRdY2w8nfxso6qJW+37MvyalIT9OwAKxZNx3N4u22ID4Mplr/82R5zKb
         w9T9VxUQdYQTxLWN6l7MRwacJ/cSDGMXOVkiKD1B/kfV/YngGhCj6uNogpWXj7uAPy+U
         vU/QnKRMuQCgCklKS5tNMb/g4V7frQB3cjRD15NMMkAWdb4aevI7Iijwra3ceF3BvORR
         Vm2LCoGdtBxscoL/QiPquVyqstZUTKmblov4ILzsuyXpZU+2euIRY+S649glBDzUJtun
         CzjpYjPiav2feXGV0ClOF8Orx5O25oGi1cnM/a73NIBjt61qSCvuN4Wlp6yeUDwFAAO/
         5awQ==
X-Gm-Message-State: APjAAAVSIcITUZkSA+AFhPzQ5vcsVHLvuVXgZyveNa1z9uPP2knlYrvm
        TqjfOJV2NC1YSN9GpT5ArPC222Inz2vvOR65d6c=
X-Google-Smtp-Source: APXvYqx3zqEl/4eatPoatG9Lz4/Qi6DhPULET2mXBNpUNe5ucuGTVnoqiKyC1psfPNjEmqqL2L5C2IyQPSIfJp8hi+A=
X-Received: by 2002:a67:e45:: with SMTP id 66mr11820956vso.197.1566371172211;
 Wed, 21 Aug 2019 00:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190819214110.26461-1-me@yadavpratyush.com>
In-Reply-To: <20190819214110.26461-1-me@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 21 Aug 2019 09:06:00 +0200
Message-ID: <CAKPyHN1M+8WNJXc15xQz4zCb70mW+Pomi6NzscSnvyDod2Z=Pg@mail.gmail.com>
Subject: Re: [PATCH 0/3] git-gui: Add ability to revert selected hunks and lines
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Pratyush,

putting me in Cc would have been nice :(

I will look into your patches in the comming hours.

Bert

On Mon, Aug 19, 2019 at 11:41 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Hi,
>
> This series adds the ability to revert selected lines and hunks in
> git-gui. Partially based on the patch by Bert Wesarg [0].
>
> The commits can be found in the topic branch 'py/git-gui-revert-lines'
> at https://github.com/prati0100/git/tree/py/git-gui-revert-lines
>
> Once reviewed, pull the commits from
> 832064f93d3ad432616e96ca70f682a7cfdcc3e0 till
> 72eed27a29f1e71cbefefa6b19f96c89793ac74d.
>
> Let me know if there is some other way I'm supposed to ask for a pull.
>
> [0]
> https://public-inbox.org/git/a9ba4550a29d7f3c653561e7029f0920bf8eb008.1326116492.git.bert.wesarg@googlemail.com/
>
> Pratyush Yadav (3):
>   git-gui: Move revert confirmation dialog creation to separate function
>   git-gui: Add the ability to revert selected lines
>   git-gui: Add the ability to revert selected hunk
>
>  git-gui/git-gui.sh    | 39 ++++++++++++++++++++++++--
>  git-gui/lib/diff.tcl  | 65 ++++++++++++++++++++++++++++++++++++-------
>  git-gui/lib/index.tcl | 27 +++++++++++-------
>  3 files changed, 109 insertions(+), 22 deletions(-)
>
> --
> 2.21.0
>
