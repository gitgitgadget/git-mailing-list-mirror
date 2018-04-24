Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BDC01F424
	for <e@80x24.org>; Tue, 24 Apr 2018 00:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932665AbeDXAx1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 20:53:27 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35202 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932635AbeDXAx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 20:53:26 -0400
Received: by mail-wr0-f193.google.com with SMTP id w3-v6so45942267wrg.2
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=c+L33e3mwl59wzaLyP3XB+lX1qGaJ3+qCTgqyiaApp4=;
        b=CR/fnWpJfuBIwhrXs7oG2I9n/YZjWZI+DNVqfOMeHEy9RwEtuZbUVWRODuECkrJz+g
         fkzRw5LdC43gsVj3eNUf7zbfI1wfJ5nwMXtxLbM0rqGGcaJ1ieJfZDrnjuOV/QmQ5ioT
         rxA3r5eYw5bbWb5igRcHHCHVgD5dmr2NLq6ca7KT3Fnf3LMVTc1PXJyVkY0tAuvGIXHw
         5BhLDxW0A1rNc4inxdHo/ELjQRhZxe/ie5Ta+2rpLx8QzmnuUC8ER8TDhzZTbmPpKF8Y
         IKEkpeAloRy3md3kwOZ0BD/Vu+l7fMfPZTbz1f8HKhvunfxKfPYgZ/YIRwtGOJwRcK4a
         Ypfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=c+L33e3mwl59wzaLyP3XB+lX1qGaJ3+qCTgqyiaApp4=;
        b=Ges2maQL30o8cl1Qji9Zx3EP/WPbuHr38jU4H1sVM+1kCcHOJe2vhagMP+FSqXd/ZO
         qs3zUP7gviR/XJQl1HMPdwIzYkA0Wj9sWPxHekz5zBJSYTM9ffOyfQD/EBLORsPJhpiO
         IFUsQEIW6N/L7Vl3jEZ6Ks/MCIg8RqAmCF0tq/wtaN4dmH/NTr2/k+nAvuay6EKsU1LD
         hVMhJfwfCUTzuAlLComWQri49TNB39o8xCk4TgSBc02KV+DZUpFNotdiMMf2Dnoeve9y
         ZCdiIuROf6lbfaWc1DOHCYtHYmFXNDBWM6tJfFzgnEqbVup+u1xqCclqYQmq5RffhR25
         2tfg==
X-Gm-Message-State: ALQs6tAKTc3zuJy/xcNxLERZ0j/MjepaLfIhd8v4XaxQl7hGCNthKKx8
        y1691DF9MnWyQ+Ngltbx69A=
X-Google-Smtp-Source: AB8JxZp0zRz18OJLbD/dX+f5FJrUyedbIev4XVauDrgkT6E7rNj0FPw/DLIVVlFshejRAdWZSIav9g==
X-Received: by 10.28.109.27 with SMTP id i27mr11156165wmc.109.1524531205406;
        Mon, 23 Apr 2018 17:53:25 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a139sm8616203wma.43.2018.04.23.17.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 17:53:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Dan Jacques <dnj@google.com>,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 2/2] Makefile: quote $INSTLIBDIR when passing it to sed
References: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
        <20171205212625.6616-1-dnj@google.com>
        <xmqq7eu0j1th.fsf@gitster.mtv.corp.google.com>
        <e0a22ee4-9503-760f-293c-be56fa46fa04@kdbg.org>
        <20180423232326.GB25128@aiede.svl.corp.google.com>
        <20180423232535.GD25128@aiede.svl.corp.google.com>
Date:   Tue, 24 Apr 2018 09:53:24 +0900
In-Reply-To: <20180423232535.GD25128@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 23 Apr 2018 16:25:35 -0700")
Message-ID: <xmqqin8h8lx7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index 8f4cb506ff..727eca5d0a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2108,7 +2108,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
>  	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
>  	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
>  	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
> -	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
> +	    -e 's=@@INSTLIBDIR@@='"$$INSTLIBDIR"'=g' \

Good find.  FWIW, I'd find it a lot easier to read if the whole
thing were enclosed inside a single pair of dq.

