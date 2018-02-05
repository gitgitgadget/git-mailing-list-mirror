Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6AF61F404
	for <e@80x24.org>; Mon,  5 Feb 2018 18:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeBESqH (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 13:46:07 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34521 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753652AbeBESqD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 13:46:03 -0500
Received: by mail-wr0-f195.google.com with SMTP id z6so10056823wrb.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 10:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nFtRS1Ku3aRRfZCHAXsHclN/EVoku/bVTNVczZYHxBI=;
        b=Uamf0YQ9nD143oYC+tyJzHq8MBNGSGZQIEZAb7EZC9X22woAZ/ujS6dbnajRNY09ic
         O5i5EBFVKRbNpeIa8oohaabVAJ9ayk12GdHXv1DxNycr8bcvIWfGpZbRMy+blrqP4USb
         kHYwDpjZfrUdtd9F/vxEQ5dWb1zuYmAnLvxICNE+Ck51qpjrFD3KEGYhcwITDCM0W7lY
         e8panP8w9C8JbHvdHO463sSdXT51UGFTgSRj6d6Si17mOOOP7vZilz+EohA4hYDnSBMt
         eQKJnZ8+jXMlaMTgqHehw5Ty1gBOhnSOftYl2fWGbuXMCMJ7SvgEF6ykubbsdD/jlmo0
         mTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nFtRS1Ku3aRRfZCHAXsHclN/EVoku/bVTNVczZYHxBI=;
        b=RFl+QyB/BCusLZsH92dXF1WgNAvwcrQUqRExU+Em67753PFcihV9qL9bLl0RSiwp1s
         ipLU3n0O1VVt1cfpvW8wdhZ5XTioRHNbS+lcVDmWtkDOplxBXglPz9ZJSQ/mjm2givWe
         /Y28lP+kpnxyJ6irPS9Lgh0NxczO6TgeywOfm40FqgHKUzlNLD9N3M5kfogS/roo0GiI
         g7NSE2zb4WXwsvJCmqvGU6ipYrzFztbARkdi+t6Nu322UR1vMA8ROgAx7QZV8tnuOR85
         40udyuNo6ER+56TZGM2N7JqC8kmMmMgUVE6xwEkJBnzm66jhNyglfDlUtKr6xf5SCZe6
         ivWQ==
X-Gm-Message-State: APf1xPCSSjROpbXSXCVoWwihO1YyGGVeLNWCpSxsqFevqIll4HB8AvKO
        yQ9bvzScDtGH6qGXiV7Ir+j8V3Tn
X-Google-Smtp-Source: AH8x224dAieQKwG3kgVilmECnlvDBXjpkpDCdB8QXFgfP/n+HTsvKErToi59bF5+Mwf8lt5pQt9FsQ==
X-Received: by 10.223.163.16 with SMTP id c16mr48168wrb.21.1517856361333;
        Mon, 05 Feb 2018 10:46:01 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 78sm7641711wmm.22.2018.02.05.10.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 10:46:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen R Guglielmo <srguglielmo@gmail.com>
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: Bug Report: Subtrees and GPG Signed Commits
References: <CADfK3RWXDuE=hYD==4sHXO1iJeOiVDOp7hBqhBtSn7gnQ+x7Qg@mail.gmail.com>
        <CADfK3RU4WJLV9EtieWYQzzRBoJkpyE+w178WQk+wj6soFwKW7g@mail.gmail.com>
        <CADfK3RVJdk3zK7+eE45-PSkb=_v86wrC0TzY+hUmAkfO0Dea=w@mail.gmail.com>
        <CAGZ79kafgyOujDM4BsXdDUnP+iFk5mp2bYnX-Q65khW-weEhUg@mail.gmail.com>
        <xmqqy3kfq6a9.fsf@gitster-ct.c.googlers.com>
        <CAHqTa-0kdkDUjH1nw=4JPAivtyL84zfZ5t8Dj1UYXPrMd7Poqw@mail.gmail.com>
        <CADfK3RXOqB7wKnXCWxgyDeov-Y7rVQiWFUa_hKZk=j9ReY9JDQ@mail.gmail.com>
        <CADfK3RWAcb0m+m_U51JLA9tNyru_7XEsfy55i5EUsKh98jGFtA@mail.gmail.com>
Date:   Mon, 05 Feb 2018 10:45:59 -0800
In-Reply-To: <CADfK3RWAcb0m+m_U51JLA9tNyru_7XEsfy55i5EUsKh98jGFtA@mail.gmail.com>
        (Stephen R. Guglielmo's message of "Mon, 5 Feb 2018 09:30:18 -0500")
Message-ID: <xmqqh8qvb7h4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen R Guglielmo <srguglielmo@gmail.com> writes:

> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index cc033af73..dec085a23 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -475,7 +475,7 @@ squash_msg () {
>
>  toptree_for_commit () {
>         commit="$1"
> -       git log -1 --pretty=format:'%T' "$commit" -- || exit $?
> +       git log --no-show-signature -1 --pretty=format:'%T' "$commit"
> -- || exit $?
>  }

Given that all references to this shell function seem to do

	sometree=$(toptree_for_commit $something)

and then $sometree is used as if it were a tree object name, I can
understand why the lack of --no-show-signature in the original
breaks it when the user has show-signature configured.

It probably makes more sense to replace the "git log" with something
more appropirate for the job, like

	git rev-parse --verify "$commit^{tree}"

though.
