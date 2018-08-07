Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4082208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 22:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeHHA2U (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 20:28:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38224 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeHHA2U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 20:28:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14-v6so184037wro.5
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 15:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PMUJS7QDcJKRD3egl7GLqA5NZSNU4g0jvzgDAzEBLrc=;
        b=fLZZreym7XzgtX9aLOfiArig6W5PsS5rH1/9pHsZw69ouK1ZhmofCKpKnCfFJCLWWM
         ilp5vAKxFgmpoyclAyMzf2MQEjYt/Jb9fCSWnqP+MDQ8cI3E9cbjvpJNccGhsq6V3FcD
         YGoF/c6k5kxI6hV22bgejMxm/e9WvNvgzxr8LkSEkfCQkhyTUyDxYSMdHwtz1LbhPUf4
         P7080k9i5Wfd8sOmix4qunPIWfsQVoxkOzHKbzC6PU3l/0oCUdtgR4c7WWhFO7k+ghIF
         DREaE0So8VRBuYY92Hj0zG3nb3DqmmSgvQ6bMAfVrSRvouMR5GItwV7mEEu28FwoFujr
         WbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PMUJS7QDcJKRD3egl7GLqA5NZSNU4g0jvzgDAzEBLrc=;
        b=lM9pR6tF2smqmAW9QzCctDfkK8ZocJNGF3Mt6a5Dqrioq40hhuQU0wc1KGf0BFka2k
         ESUohzpPtUGDh6ZmwFseaKw6Ex7u/bADt4udyhDxiUlzvK/J3q9LuFJ/2Y+texCKBoWX
         ZPp6d5euxjB84esIvAhVY6SSzcIR20uaYr/FUmJKqMnn55mF0I71W1ooKluSiW27/gGf
         GrUtQRORKnXhpBqmM+jkgg7E4BI0IXeDAeOMqpf/eBjMi1PXZe8Dpr1o+WPeloC7z71q
         28m2Sf8XJZjxbKSz5jnBPLool/50O6t6dC0U/GmUSOjc7bwwcoHLtRrx2Rk1Y8h41o++
         S29A==
X-Gm-Message-State: AOUpUlHhQk3nVbhaurHYAfm4W++KWAdWi4piP7N3wNudJQ027sFDaYvF
        S+U9JEXCg0gnkoFHGDVR75E=
X-Google-Smtp-Source: AA+uWPzUOS7LjUvm1sXAuD9YIboHUveIp5TFOQWaE7cSYkb4HmCkta4Fa96oVt3izVa4gE0pqoT0MA==
X-Received: by 2002:adf:83c6:: with SMTP id 64-v6mr142540wre.5.1533679909523;
        Tue, 07 Aug 2018 15:11:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l15-v6sm2165229wrt.67.2018.08.07.15.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 15:11:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sebastian Kisela <skisela@redhat.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH 1/2] git-instaweb: support Fedora/Red Hat apache module path
References: <20180807072548.12764-1-skisela@redhat.com>
        <xmqqk1p1kgwq.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 07 Aug 2018 15:11:48 -0700
In-Reply-To: <xmqqk1p1kgwq.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 07 Aug 2018 14:25:57 -0700")
Message-ID: <xmqqftzpkesb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> 	if test -z "$module_path"
> 	then
> 		for candidate in \
> 			/etc/httpd \
> 			/usr/lib/apache2 \
> 			/usr/lib/httpd \

I obviously missed semicolon here...

> 		do
> 			if test -d "$candidate/modules"
> 			then
> 				module_path="$candidate/modules"
> 				break
> 			fi

One more thing to note is that the fourth candidate might not end
with "/modules" and force us to update these existing three to have
"/modules" at the end and lose appending "/modules" from these two
lines to compensate.  That is sort of deliberate (i.e. as long as we
can share "/modules" as a common substring at the end, it is OK to
take advantage of that).

> 		done
> 	fi
>
> is when you go from 2 to 3.  Two points to note are:
>
>  - It would be easier to add the fourth one this way
>
>  - The explicit "break" makes it clear that the paths are listed in
>    decreasing order of precedence (i.e. /etc/httpd if exists makes
>    /usr/lib/httpd ignored even if the latter exists); the original
>    "test -d X && M=X ; test -d Y && M=Y" gives higher precedence to
>    the later items but readers need to wonder if it is intended or
>    the code is simply being sloppy.
>
> Hope this helps.
