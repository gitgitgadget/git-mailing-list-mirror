Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C611F404
	for <e@80x24.org>; Fri, 26 Jan 2018 17:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeAZRrp (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 12:47:45 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43261 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeAZRrn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 12:47:43 -0500
Received: by mail-pg0-f66.google.com with SMTP id n17so691349pgf.10
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 09:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8i34GY8FAFH/ZSyCFvKlHx0VnmmmzezEaLswz0aVoS4=;
        b=vIHy6A/llsR9x6bWhM/zU0lC2EXqGfz/fYSQ9Lt+0gyCgC0Hy7Fyyfjx7KrDRphT+i
         F0Df4hRlas0yenKQN1CtuDTLaF6isRBkX/aaOAORafj9AJoSGHAMW4YZNwaYBZlA8nCO
         6CxTQ1Yzsk/+P1CsT/jc/n5XKJobhysKsQ0ZqRCWIJ4KjRqGKy930+IFvKWqeabvHF7b
         6Wkd6WaRQiEn29jhaLlF5wiXtSGLL7T6UKV07izPjlR8njba+vnXAfp1WWW1cPLq+Ye4
         UiGBtTrVXgbQiXfu28+Xf1u6VcXfiENvwdb3dI4fnxHZ1C8LoR6/8eqEpWn/g1Drl6pZ
         ajVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8i34GY8FAFH/ZSyCFvKlHx0VnmmmzezEaLswz0aVoS4=;
        b=Npy0r9m7dQbfER+vyVwM30hb+iINk9s0cgZx5h+apYk5CsldXNr9cX/kBLKuS+JVoD
         /Ze/ZnSG6Axy1tJQMXuIM/YD7XGLl3guqRlryWyApYWvI76nGRr8bHC9sp7PCv7OEjNg
         vpYYlQqi851+5tT1gxRY8s3PFev8kGklH7pDBnl8uc7uCcA7svPqWck8e17qMXD33YIb
         KYrESRzGqoDh1ztELFLIVlLMqg1HfsQeSa6p0NiFh+Gk+X6/IBRFkOYdc7Dz9Hn6q96l
         h9JrI/NVp8XluaKnaYgvhHO4clbZRK5jZckzHvqNWAznCo9EiQKYqPLXviVAeE4vb7kd
         2Xjw==
X-Gm-Message-State: AKwxyteRn6z56Zo6xuXpLPRdb8HuFq8NEnWGWU1I1w8TMhMrNTN6qUTQ
        /ApZiO0KBVUgcJZ4PFl4sOQ=
X-Google-Smtp-Source: AH8x224eUxP7qXXK4Cj4YqaLHpjCj8558UkQHlskI394sgbNUVkzSGFnYiOXCFik6Zr8j7cH3ytk2w==
X-Received: by 10.99.190.76 with SMTP id g12mr16598481pgo.235.1516988862192;
        Fri, 26 Jan 2018 09:47:42 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3d49:4bb2:1738:a537])
        by smtp.gmail.com with ESMTPSA id s80sm20772147pfj.179.2018.01.26.09.47.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 09:47:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] merge: support --strategy '?' for git-completion.bash
References: <20180125094031.6584-1-pclouds@gmail.com>
        <xmqqo9lhai46.fsf@gitster.mtv.corp.google.com>
        <20180126013142.GA11346@duynguyen.dek-tpc.internal>
Date:   Fri, 26 Jan 2018 09:47:40 -0800
In-Reply-To: <20180126013142.GA11346@duynguyen.dek-tpc.internal> (Duy Nguyen's
        message of "Fri, 26 Jan 2018 08:31:42 +0700")
Message-ID: <xmqqefmc8qbn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I didn't look carefully at those sed magic. But it looks like it
> correctly handles this case too. So v2 follows below. It still feels
> dirty to do this kind of text manipulation though. But that can wait.

I do like "introduce and use helper feature to produce machine
parseable text" when it is appropriate.  But this alternative looks
more in line with the current design of completion script and can
easily be a maint material as pure bugfix for non C locale folks.

Will queue.

> -- 8< --
> Subject: [PATCH] completion: fix completing merge strategies on non-C locales
>
> The anchor string "Available strategies are:" is translatable so
> __git_list_merge_strategies may fail to collect available strategies
> from 'git merge' on non-C locales. Force C locale on this command.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---


>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 3683c772c5..88813e9124 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -594,7 +594,7 @@ __git_is_configured_remote ()
>  
>  __git_list_merge_strategies ()
>  {
> -	git merge -s help 2>&1 |
> +	LANG=C LC_ALL=C git merge -s help 2>&1 |
>  	sed -n -e '/[Aa]vailable strategies are: /,/^$/{
>  		s/\.$//
>  		s/.*://
