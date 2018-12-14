Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C8220A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 17:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbeLNRWv (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 12:22:51 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46098 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbeLNRWv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 12:22:51 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so5525253edt.13
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 09:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENK4+qHXUEpneOa3wfmO/PlDj4aeO3OwP7WNlnbOFxY=;
        b=r/qsu85oAmMNJCWxZqkvuqjdlqqwcZUMqzJ21TDQAkfmLU6XdFbZvid8ZHuafTq0lb
         x1dV5lnh3qicGGRUgaVKCjOY6TqiudQlk7AKh0ZUnVvcmXfkczKXtAjol81MAA/cQwjI
         u6Zqg0jkBpmslN0LBs6NBkeoa1uhCKq4WyFUY8cBYLn+fIenRZcJKBcVH3uhypo8ZBSU
         bsr12tiYumoGt7cpDTvjOX9Lsm+X+RLIWsCpDRx2vctul8H2DQ3JQ5d9foAlUttB739w
         r1SBHnYoPHR+QmT3g2cKLuXTWuAV0B0MIn9IYrtEMAuna6n2y2iKSsliFW3i7DCWqJvW
         iCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENK4+qHXUEpneOa3wfmO/PlDj4aeO3OwP7WNlnbOFxY=;
        b=lya/9E5o9zqYNtDkJNEr/PeSw1vXX9B5uD9FYILP0Uvq3SQvgOH7RV6iAQpakn6wv0
         Rx0QsskRD+fDRj3X0XfFfSIRSTCdJ+qi4NMuCTZTPAExNMXB4yJR65wNL7OCrK6bZzHv
         TqioSwCHYB+5vodwj/HfO7fjb3XAqUigiUJpaA9JBgbjVZQyI06QeGFycYtMhlARRI+s
         lAFkJr/QdESsn0WFo+7C8XUjP2CXd0NDeKdKNK3BzGN7erRxWVvmP99mke+xsT/Lcqin
         RTCFvbnufaFRmy5T12nSDs2n1J5EIqVm6pRd2NSM3GPDrNyE5PIyL6n8wYfIQ6nzFz8d
         YqWQ==
X-Gm-Message-State: AA+aEWbr2nF2UQ/ihJMYnVJWZgbhG4XIXKPTLUezTUkSkiCkWgkY06vr
        8ut+9PE/4JwNPRLcKXoAqIpwrL+QBfD4D2AfcCE=
X-Google-Smtp-Source: AFSGD/V1YkxE1qFVNnzifcsMH7m4vqYAU3ua4xBOeQfKRxgLS91HTWfnvpPfmj0YCTGgQScIzEPBDRWKVjwZVIdK6Vo=
X-Received: by 2002:a50:cf41:: with SMTP id d1mr3843270edk.242.1544808169126;
 Fri, 14 Dec 2018 09:22:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.100.git.gitgitgadget@gmail.com> <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
 <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com>
 <CANoM8SVMYBRg-nL4r=JJDFU_qZ=grzSmRs-B2nLYUnv5kFc00Q@mail.gmail.com>
 <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com>
 <CAGZ79kYnQPhGMStmKSFb5_4Ku-nv54nHwta==jE82ZR4NOPETA@mail.gmail.com>
 <CANoM8SWQTAEYGiUC9PnWi8u9oAJYPcyiE5+5usoRvR7Vw2z0JA@mail.gmail.com>
 <CA+P7+xonxvfuhw4W+FUL87We8CaOwxsndFkN5bcgBhdsnZ5QAg@mail.gmail.com> <CACsJy8D9qfBLOUCyca+ws66uHx_tgoFZSTbTBxxW2fRQmyr_Nw@mail.gmail.com>
In-Reply-To: <CACsJy8D9qfBLOUCyca+ws66uHx_tgoFZSTbTBxxW2fRQmyr_Nw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 14 Dec 2018 09:22:37 -0800
Message-ID: <CA+P7+xoxE0o=5fMQrDoyCgWMQ-By2t1LdApecRDWmoXXCfnFuw@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree refs: fix case sensitivity for 'head'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Mike Rappazzo <rappazzo@gmail.com>,
        Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 11:38 PM Duy Nguyen <pclouds@gmail.com> wrote:
> Even with a new ref storage, I'm pretty sure pseudo refs like HEAD,
> FETCH_HEAD... will forever be backed by filesystem. HEAD for example
> is part of the repository signature and must exist as a file. We could
> also lookup pseudo refs with readdir() instead of lstat(). On
> case-preserving-and-insensitive filesystems, we can reject "head" this
> way. But that comes with a high cost.
> --
> Duy

Once other refs are backed by something that doesn't depend on
filesystem case sensitivity, you could enforce that we only accept
call-caps HEAD as a psuedo ref, and always look up other spellings in
the other refs backend, though, right? So, yea the actual file may not
be case sensitive, but we would never create refs/head anymore for any
reason, so there would be no ambiguity if reading the refs/head vs
refs/HEAD on a case insensitive file system, since refs/head would no
longer be a legitimate ref stored as a file if you used a different
refs backend.

Basically, we'd be looking up HEAD by checking the file, but we'd stop
looking up head, hEAd, etc in the files, and instead use whatever
other refs backend for non-pseudo refs. Thus, it wouldn't matter,
since we'd never actually lookup the other spellings of HEAD as a
file. Wouldn't that solve the ambiguity, at least once a repository
has fully switched to some alternative refs backend for non-pseudo
refs? (Unless I mis-understand and refs/head could be an added pseudo
ref?)

Jake
