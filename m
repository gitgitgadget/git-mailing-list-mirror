Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EFC820401
	for <e@80x24.org>; Tue, 27 Jun 2017 17:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbdF0Rin (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 13:38:43 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34692 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdF0Ril (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 13:38:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id d5so5620013pfe.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FH6oT8CiLclYvt6VIoSN/q42v3TQfAy5aNePuzaylw0=;
        b=qeqw2cLpueRfP7N/emYQly/JsTQTBtoyNtR4bfyEcrw6K2kG0PJKW+0EJvkx5uWaKB
         BjfR79BnFE1ZuH2HAy32T/kOe4ddPz1OUS4/V4wIwA3YNwWweBdqqXDj0XlBoqHwfs7h
         Kttg+Dbo/wHc9k6+v5HJeJVeN8pQbNVso66dkxDolexFMQQufsHmkOsAusRTr85xb0zu
         YyuiDKRaplanDivDPWwXmTSAZWLafoIT51YYk2N7ZsqaBcGpObnRpYxLM63Outo7SEyN
         RrVwrX26620cWgddy7RpC02gtn0vpKYSEdoAlgAw3RbOS405ZIj2L14G7jOwvvsxv6JJ
         qtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FH6oT8CiLclYvt6VIoSN/q42v3TQfAy5aNePuzaylw0=;
        b=ku5UkJCWbfsUFg+EVWsUGNdYEduyXim/N1Al99V+7z50WpMEXgUz95ojQ5/kbhQ8TX
         PGz4SR3D8lG7RkACaeEWR1Hd4cO1ZJqkovXc6URGgxNjXB2rE8nLY9qH0CgrfIxKDoln
         gpnX6abh/8nA7Fo0XcymViIdq4jf5cvop7GlNrXYdMYfdbix43SRsRr0Adz2f/9U6uya
         24pwM8Am+WSraLjyCiDlRkueUQCInHVj+2eVR3dTR9JhHwoWZZEqNDPgbfsC1XdlCurM
         NO5AcVzgViagg0e7gCkJa2CAXqv40yF7V/o/orRYNsNYgw3Pfn0rOvoaGiU3AXWQxeCo
         CD0A==
X-Gm-Message-State: AKS2vOz8hv+aezDdudhqy5L8yafAb6RgsG3RrL2O2TD5Kg73RyFnE0Wk
        1NXT/XvomKBY3w==
X-Received: by 10.84.218.71 with SMTP id f7mr6871436plm.282.1498585101526;
        Tue, 27 Jun 2017 10:38:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id 70sm7259927pft.104.2017.06.27.10.38.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 10:38:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     Michael Kebe <michael.kebe@gmail.com>,
        ?var Arnfj?r? Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: Compile Error v2.13.2 on Solaris SPARC
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
        <87fuem7aw2.fsf@gmail.com>
        <CAKKM46vr2Y_Zs+EJX-nxw7XH0nbpmTyubR1jibYoiieNCDns4Q@mail.gmail.com>
        <CAKKM46sBVyTMGNwU6E9s7gq8wiBfAxrKzBFVgU=zfwj+YdAjcQ@mail.gmail.com>
        <20170627162808.p7sj3jpwum7n3hq2@oracle.com>
Date:   Tue, 27 Jun 2017 10:38:20 -0700
In-Reply-To: <20170627162808.p7sj3jpwum7n3hq2@oracle.com> (Liam R. Howlett's
        message of "Tue, 27 Jun 2017 12:28:09 -0400")
Message-ID: <xmqq1sq52uwj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Liam R. Howlett" <Liam.Howlett@Oracle.com> writes:

> How about:
>
> ---- 8< ----
> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> index facea1bb5..ed8c63f2d 100644
> --- a/sha1dc/sha1.c
> +++ b/sha1dc/sha1.c
> @@ -38,9 +38,18 @@
>  
>  #if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))
>  
> +#define EMPTY_VAL(x) x ## 1
> +#define EMPTY(x) EMPTY_VAL(x)
> +
> +#if (defined(_BIG_ENDIAN) && (EMPTY(_BIG_ENDIAN) == 1))
> +#undef _BIG_ENDIAN
> +#define _BIG_ENDIAN 4321
> +#endif

I'd say it is a bad idea to define a symbol that you _know_ a
platform header file defines.  Any header you may include from the
platform after these lines still expects the symbol to be defined in
a way it defines without getting molested and will misbehave.
