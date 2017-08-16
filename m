Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D9A1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 18:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbdHPSvd (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 14:51:33 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35644 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbdHPSvc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 14:51:32 -0400
Received: by mail-yw0-f171.google.com with SMTP id n83so316467ywn.2
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 11:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R8NTFx7Q243S3cgG5ri8T6ALo+5ZCYQ3hE9G1mt5lis=;
        b=X2lODkbTKDDTSTSxJD46JkSP2Q6Yr4xROKzfbwO0SgaNfAogFhEwIPx0b2Cjbkd318
         WuT2uXDXadgraCp6S9dM/e27ldhmMCttDThgz6aPsFaKS6xRkJHeDnC9y73SU2llyvd2
         rVqziW7wLXPHdo5XVac3wYagRkH1oWPigii2WTxVjWSICwxLFvLDt52Td8bk/hyDpyXj
         8LeDvTC7Cyl3nChPw1T9eXst7jrwPNv42q4KgGOu5btN5nsyjzNnr5YCRWer6mgthFIP
         lxfPmPjarbNvMRCMw59bF5b5cOMAu/qGUNWCtNHza3o0nM5VJexQi76Etaq7bZ0wjdK3
         C1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R8NTFx7Q243S3cgG5ri8T6ALo+5ZCYQ3hE9G1mt5lis=;
        b=sy9WJu2VMu/E5opYx3JLQkosU1oNMETAA/fb5sn31CWSyMK4TnDxkVxVTlTW7y+j0v
         rTjhGFtNLe6lANnpyuUCbYN6sI2vlgGWGairH+gb5NTcioyUQBkJlyE5Ph+5hRLXxIQ4
         CM+oWIyVtQWLdVyJaY3f/x58N5jvMAgYi4dQmclFe6uCYGyfY3V4sg/DnihLRXuh1lgl
         ehcoB49ph2siIdtoQOPuxtFDRLTWkPju88dWU3R0X6WJAUc9pPwYmwATaJB3J4OACqaE
         KY0Ff7xm5wyhqQad+BW8vIvqhNC96+g8mpS6BpB7TdPEUT+NwM/PZBmY3AuhbVNXlNEa
         hgGw==
X-Gm-Message-State: AHYfb5gZtyLzVdmdK9gWRWJfOND0L02f/xAM4OLfqFbHXzM+gikw25M+
        onPDN3qGoj3RE8ai623bR7LeJ3n1PUss6Dxiwg==
X-Received: by 10.13.206.132 with SMTP id q126mr2076675ywd.337.1502909491238;
 Wed, 16 Aug 2017 11:51:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Wed, 16 Aug 2017 11:51:30 -0700 (PDT)
In-Reply-To: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 16 Aug 2017 11:51:30 -0700
Message-ID: <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
Subject: Re: Submodule regression in 2.14?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2017 at 11:35 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,
>
> I think we discovered a regression in Git 2.14.1 today.
> It looks like as if "git submodule update --init --recursive" removes
> the "skip submodules" config.
>
> Consider the following steps:
>
>     git clone https://server/repo.git
>     cd repo
>     git config --local submodule.some/other/repo.update none
>     git submodule update --init --recursive
>     git pull --recurse-submodules
>
> With Git 2.14 the last "git pull" will clone the "some/other/repo"
> submodule. This did not happen with Git 2.13.
>
> Bug or feature? I don't have anymore time for Git today. I am happy to
> provide a proper test case tomorrow, though.

$ git log --oneline v2.13.0..v2.14.1 -- git-submodule.sh
532139940c add: warn when adding an embedded repository
(I am confident this is not the suspect, let's keep searching.
Not a lot happened in submodule land apparently)

Looking through all commits v2.13..v2.14 doesn't have me
suspect any of them.

Any chance the "did not happen with 2.13" was not
freshly cloned but tested on an existing repo? If so a hot
candidate for suspicion is a93dcb0a56 (Merge branch
'bw/submodule-is-active', 2017-03-30), IMHO, just
gut feeling, though.

Oh, wait.
$ git log --oneline v2.13.0..v2.14.1 -- builtin/pull.c
c9c63ee558 Merge branch 'sb/pull-rebase-submodule'
a6d7eb2c7a pull: optionally rebase submodules (remote submodule changes only)
could also be a culprit. Do you have pull.rebase set?

>
> Cheers,
> Lars
