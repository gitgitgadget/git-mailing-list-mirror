Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8971F453
	for <e@80x24.org>; Wed, 19 Sep 2018 22:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeITEjb (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 00:39:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46313 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeITEjb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 00:39:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id a108-v6so7392808wrc.13
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=O57zC+0fc5yp4gtekKT5r/WgPitmTi09oB3+gGJhK8A=;
        b=EvKchG+j7klWamW3FPLJi2NJu3NN2mkAQgXGw8FDNC4jB8E7hWala9U20vNhr69nQ3
         BE097rpmyaj/bng5nGmh5/Cq6uPOszevqFBJpXJIHfqS6ZHmQR+L46HYiUoRR8fBT30o
         YdcHdvutya1AtBN9E4tlCv/EpSZG72joEvvu9NjAu5fKQjnlMHA4baylJMbwEZQYUGzZ
         B7GKzAJIw/3DfFNgRKZXpkWz+CzcFqmYcpwV14QOLyiPpe12Kljnc+TACLfuIdtCqbIM
         oqZ+ZSe3HIW9fc1d/QrTtIcQvsKKfvFKk1TVzSz7bqKvzCKThmoJo1li+C7HYJG3BlAs
         pv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=O57zC+0fc5yp4gtekKT5r/WgPitmTi09oB3+gGJhK8A=;
        b=Xp58V8c8rLeTIKWZvwKZhEmFg8lF/TgjRfm3jm32OmK+SMrZG/n6LtwxtcFUviX11S
         qNpiOvnewek9+gCwp0O9hQsTLKQDagI12jmp3AOsUhT5XXWp55KH6xK1LmFJGHnFliLy
         gb6uuapLF+lW8L5lEDKs0o2g7HhZI9biQBCdWDHyRlyvzkU0/LVkk3o76uUByNE6yw8o
         yWL1yxVvTG9qTltpUlMvuY0FwxwkDvO3GO1aL3Vt75gSgbqXLES3nsgSSA8zQbk2aPUp
         8ep40SKzyIBMqlWYn3DuimT6+Mdye0izP35mRdpoZ8/orFMVDhHZ1mkM9qFctJrfyfdF
         q+VQ==
X-Gm-Message-State: APzg51AMKiRrGZ/uag2KxNRelthCd1HgNg47Dho5ITxEsW3EXOiRcV6E
        +N0MuIw9+pKHlDbXQ5QcZJE=
X-Google-Smtp-Source: ANB0VdZPqI6r0xuZ8KAjduyVcF03Nl0GNGPPmMihghqbmUf/ewyxLCzX6kHOSwcw/HqFwl62Cj3lSA==
X-Received: by 2002:adf:f391:: with SMTP id m17-v6mr31376225wro.279.1537397959328;
        Wed, 19 Sep 2018 15:59:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h7-v6sm21689237wrs.3.2018.09.19.15.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:59:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Frederick Eaton <frederik@ofb.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] git-archimport.1: specify what kind of Arch we're talking about
References: <20180919201231.609-1-frederik@ofb.net>
        <20180919201231.609-2-frederik@ofb.net>
Date:   Wed, 19 Sep 2018 15:59:18 -0700
In-Reply-To: <20180919201231.609-2-frederik@ofb.net> (Frederick Eaton's
        message of "Wed, 19 Sep 2018 13:12:29 -0700")
Message-ID: <xmqqsh252iwp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Frederick Eaton <frederik@ofb.net> writes:

> Is it a CPU architecture? Is it Arch Linux? If you search for "arch
> repository", nothing relevant comes up. Let's call it GNU Arch so
> people can find it with search engines.
>
> Signed-off-by: Frederick Eaton <frederik@ofb.net>
> ---
>  Documentation/git-archimport.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I think "Is it a CPU archtecture?" is a red-herring, but between
"What is an Arch Repository?" and "What is GNU Arch?" there indeed
is a vast difference in the quality of information readers would
get; with the proposed commit log message that ends with "so people
can find it with search engines", I am reasonably sure this is an
improvement worth having.

Thanks.

>
> diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
> index ea7065336..a595a0ffe 100644
> --- a/Documentation/git-archimport.txt
> +++ b/Documentation/git-archimport.txt
> @@ -3,7 +3,7 @@ git-archimport(1)
>  
>  NAME
>  ----
> -git-archimport - Import an Arch repository into Git
> +git-archimport - Import a GNU Arch repository into Git
>  
>  
>  SYNOPSIS
> @@ -14,7 +14,8 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -Imports a project from one or more Arch repositories. It will follow branches
> +Imports a project from one or more GNU Arch repositories.
> +It will follow branches
>  and repositories within the namespaces defined by the <archive/branch>
>  parameters supplied. If it cannot find the remote branch a merge comes from
>  it will just import it as a regular commit. If it can find it, it will mark it
