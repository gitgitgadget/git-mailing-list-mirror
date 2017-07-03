Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 596F1201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 20:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbdGCULs (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 16:11:48 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34513 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbdGCULs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 16:11:48 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so24060217pge.1
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=09ofhXTBWKPqg0BsjkzTgs+kwGW7tD5PQf3scpvkrBU=;
        b=hpWYvn01q3hwPmTrg2tzt700Y/Atneiv7KgvUZnJTrqko7VPJ4WntNorcR9BKFaJFq
         IoutAbsUyTlgzlybRKX2ITDBQ8m6XIw2lKu63t+O/2fYLaczLQGcJ31jEpa33Vw+nyQ4
         AaBcnq2oCAESr4xxEpdv14MNzc/wTIdLAZikRpNTklxpzNmHHs+Q9S+686TiMIyE0OiU
         4MQ/wKtbx8lRFx89MT4YVERi2jEYTlfRGWEA2Zgor6PgDrN75Ps+LjLyliRgHsSRNT+1
         8Fo210jaZthKRyd75rPXXHtkB+uWFLRayqHXZ0304bQGwbASzODPRypBFbx3soL8OUfg
         SGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=09ofhXTBWKPqg0BsjkzTgs+kwGW7tD5PQf3scpvkrBU=;
        b=BDOjZUswUgAd7ZmdIxlX62s8PV9lmxO/GsGUSZ7MGQLjyaNu+IygaYCtPNOvpMN3Iq
         QbLHLGrqkY+/B6IeToBcvp6W8+qBGUWMubL21leoSN3oj1Dt0vVFNV7tmmLeZLaQPnPU
         xk0Efpj1ppE4C6tOURktQ/nqm97O2ByFJvQWrH8Q2Wp9F5Imt4A66fB/Mzfvy2sZQMbe
         R5H3JqY60bAwAs0/Y6sk2g58taHbd0Yb1BY5FvFPRDNPeU5yIePdl4FBPPWXCTSzbpsS
         7cSwuR7s6WxZXKlRa3zokkyc1QQF9V0DKfwoZdjAQW7oSBkZvC8HOToLy28fgOzcOPnP
         Ikkw==
X-Gm-Message-State: AIVw111hVUSSqrUb2aX5A3dGF9PLewA07kz5Ut+K9aCQiXct8jvh2esz
        lq4veHCvDBGXFw==
X-Received: by 10.98.106.6 with SMTP id f6mr11681773pfc.53.1499112707194;
        Mon, 03 Jul 2017 13:11:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:30:4739:ca21:b5b4])
        by smtp.gmail.com with ESMTPSA id x25sm39930029pfi.58.2017.07.03.13.11.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 13:11:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Help needed for solving a few issues with building git
References: <1499087898.4156.6.camel@gmail.com>
        <xmqqshidl76n.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 03 Jul 2017 13:11:43 -0700
In-Reply-To: <xmqqshidl76n.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 03 Jul 2017 11:13:52 -0700")
Message-ID: <xmqqk23pl1q8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> While trying to build (without the 'gettext' library that's required
>> for localization) I get the following error,
>>
>>     Manifying 8 pod documents
>>         SUBDIR templates
>>         MSGFMT po/build/locale/pt_PT/LC_MESSAGES/git.mo
>>     /bin/sh: 1: msgfmt: not found
>>     Makefile:2179: recipe for target
>>     'po/build/locale/pt_PT/LC_MESSAGES/git.mo' failed
>>     make: *** [po/build/locale/pt_PT/LC_MESSAGES/git.mo] Error 127
>>
>>     What could I be missing?
>
> There is
>
>     ifndef NO_GETTEXT
>     all:: $(MOFILES)
>     endif
>
> which attempts to avoid generating *.mo files, but that does not
> seem to be working.

The above comes from one of the Tcl things (probably gitk-git)
For now

    $ make NO_GETTEXT=1 NO_MSGFMT=1

may help.

NO_GETTEXT is "My build environment may or may not be capable of
doing the gettext things, but I choose not to use it in my build
result" but NO_MSGFMT is simply "I do not have the msgfmt tool".

Having to specify both is rather unfortunate and we may want to
streamline this.
