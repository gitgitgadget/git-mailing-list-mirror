Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874381F403
	for <e@80x24.org>; Mon, 11 Jun 2018 17:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934077AbeFKREz (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 13:04:55 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34956 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbeFKREy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 13:04:54 -0400
Received: by mail-wm0-f47.google.com with SMTP id j15-v6so18002412wme.0
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=O4trJFiPYsIgVThvXrn57uRSa0NroQQm3dCjSFlM4pg=;
        b=HjTaa+TFyruODU3R+TAuB1YMIaTY7eEIYETXvm0hABz6QxZ+orRL/eMTn963+Th4eJ
         9CyvRtJgdYstHwyu1BNNOmbr9Y38X8RzbpSkCB8j12kgaKK4oJ2gWvWziPqaN0pKQcCC
         8nOmrBTRT9NqC9xI5p4gdiMvwW7TOfRNHPL5sTsvTu9fT688+qLBXs2RFCiJTauWrKcJ
         0NGCuzgsBugRdwRSEwSfHyP+HKI4c4JCpusmXegPHhEyUXHCRNLQ63pLW3C53tKcSbq6
         Tu0kq+mYbqy7eMprti9+QmqRMDuh5RLCL+bfx6KHukZseODR3IxwPmRkAGHfFvd4ea7v
         TnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=O4trJFiPYsIgVThvXrn57uRSa0NroQQm3dCjSFlM4pg=;
        b=Pzyus18LdAvcxzbXYkjaOkoYteOcx3gC3AeKn6qg3YHCfaygGD4GT02u23Hif5NpOJ
         EuYQgNJv3aCw40rRNlpNkYrGy3zEdFDtWttaFCZ6rGvftFVBvZ86CCeTUac4cWf3EGCR
         NEw5ScKQNyo7wYYCpskX+frJc0/ZSG5xBa2cFbslRXPKqW9hnjEPPqliZf4d39KooSXm
         6MA9zRXvfKDUS1TX56Uyr3RL2VfJIW52Bdy3wQpyUFxKIVxq71vSxQh3qy4wu79F5YIs
         6UMFJa8jvMlT+gyeKMA0XyxWK8Z27BBwqrVbXTBrrImBkUW6OGxhl32IAVQY5egUceLx
         +/hg==
X-Gm-Message-State: APt69E2xk4Fku3xlzwcLSjY5TWg5uG2pFMaLt4cFYAzOWT70RzHBvf3w
        +bEUZ81baKWS5Rg+I06fJjYsCHxB
X-Google-Smtp-Source: ADUXVKIyFsCQhZSJMVOeNjHsFDtDRQsBDxj7J7v/4A+CVEyz1E94p5aJsmxzUEAFT8zuwMNtm4FjUg==
X-Received: by 2002:a1c:5585:: with SMTP id j127-v6mr11743wmb.102.1528736693287;
        Mon, 11 Jun 2018 10:04:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 201-v6sm9252015wmm.18.2018.06.11.10.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 10:04:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rick van Hattem <wolph@wol.ph>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Use ZSH_NAME instead of ZSH_VERSION because it's redefined by git-completion.zsh
References: <01020163c683e753-04629405-15f8-4a30-9dc3-e4e3f2a5aa26-000000@eu-west-1.amazonses.com>
        <xmqqr2ln5ide.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 11 Jun 2018 10:04:50 -0700
In-Reply-To: <xmqqr2ln5ide.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 04 Jun 2018 12:40:45 +0900")
Message-ID: <xmqqefhdckzx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Rick van Hattem <wolph@wol.ph> writes:
>
>> The `git-completion.zsh` unsets the `$ZSH_VERSION` which makes this check moot. The result (at least for me) is that zsh segfaults because of all the variables it's unsetting.
>> ---
>
> Overlong line, lack of sign-off.
>
>>  # Clear the variables caching builtins' options when (re-)sourcing
>>  # the completion script.
>> -if [[ -n ${ZSH_VERSION-} ]]; then
>> +if [[ -n ${ZSH_NAME-} ]]; then
>
>       ...
>         ZSH_VERSION='' . "$script"
> 	...
>
> If your ZSH_VERSION is empty, doesn't it indicate that the script
> did not find a usable git-completion.bash script (to which it
> outsources the bulk of the completion work)?

Ah, I was totally mis-reading the script (and partly was confused by
your use of "unset").  ZSH_VERSION is reset to an empty string,
which breaks the check later done in the bash completion script.

