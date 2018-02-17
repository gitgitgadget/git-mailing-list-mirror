Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DEA11F404
	for <e@80x24.org>; Sat, 17 Feb 2018 21:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeBQV1Q (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Feb 2018 16:27:16 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40486 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeBQV1P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Feb 2018 16:27:15 -0500
Received: by mail-wr0-f195.google.com with SMTP id o76so6056427wrb.7
        for <git@vger.kernel.org>; Sat, 17 Feb 2018 13:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0QAJ9YTr3jhKSAbJ4uNWsY5Y7sWg523TowwDVcGzPs0=;
        b=QuKmdlexB5FehPXg6A1H9E0ouVoT8wTPTiOwNb6WVuJ9cdNeEW6xsjuAdnTjZO1bD5
         vqNjGrJ6VrEmO+tXxpFGal6lIAZZhJDCFSAXQHpo14QVuy0JZDQXpk+84wdTjhlnSkpm
         D09W1BeLc2YFCO7MrY0vhHDObEeGZnNZUPHvA4kZvsZf4eY4E7HRe25fxizbZatfn2qp
         giF8nNzRLmZlI5ew3MobTdPn3d8FGm7+2UW/SzGXPVzWxnpUDBTm0BYIdRdEvAqsUGte
         yCjfXXcYef71VdAjzHLNHqtjEKdQxvs8s0AAL04j54BVbN9I4eqPn4oKpiOZ6qX6qBwg
         a1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0QAJ9YTr3jhKSAbJ4uNWsY5Y7sWg523TowwDVcGzPs0=;
        b=S6miHYBzuG5IJCwnG3QeAIMG3UGPHCCIrh4byKNpnQUlMCU+4WEJOwTyxM2fIo4G7w
         6vhcjDsaXCfKPJ3ohFJmQcmhCdvd59Y2WKRxCkfErrX9sWm8ub4ZFWo+g5EkQIktwZEF
         kFoTkZvgPxaeCuqG6RrGciPszTaqtsZce40U8Zopyl2eG/LVHqfIePl0qT2DNWX/jFYt
         6+D0fbGpDCBCjOfJYGvU58w0xrbPDUk6Cll/34VegtHwVvsk0RxV0DCO63lqhTfv2wsK
         FnIQLlK24O6+a6mXRn4y7ajOHfKTK02DRGZ9zHvjdx0qmTFSGq6n0YYKymfCXbJxLjIF
         QJIA==
X-Gm-Message-State: APf1xPBgx4l3orgU+d77d+fLPRl8m/h5gYfuNhvbr7kl1BkBt1/XtWtd
        73J6ROqxFluXRfMunRK2oE8=
X-Google-Smtp-Source: AH8x225W2O+k/KwYxKPxBLtJm0kTjf8TZUxq1/RRh/M7W5m/OMyCtNyMkJW9nCobRZraMVFftrKCdQ==
X-Received: by 10.223.144.198 with SMTP id i64mr9599181wri.6.1518902834192;
        Sat, 17 Feb 2018 13:27:14 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 137sm7086909wml.3.2018.02.17.13.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Feb 2018 13:27:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: remove *.spec from clean target
References: <20180217030623.GT27038@zaya.teonanacatl.net>
Date:   Sat, 17 Feb 2018 13:27:12 -0800
In-Reply-To: <20180217030623.GT27038@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Fri, 16 Feb 2018 22:06:24 -0500")
Message-ID: <xmqqvaev489b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Support for generating an rpm was dropped in ab214331cf ("Makefile: stop
> pretending to support rpmbuild", 2016-04-04).  We don't generate any
> *.spec files so there is no need to clean them up.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>
> I noticed this minor cruft today.  Since we don't generate a
> spec file, this is at best unneeded.  At worst we could
> wrongly delete a users spec file if they happened to be
> working on it in their git clone and called make clean.

Makes perfect sense.  Thanks.


>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index c56fdc14ca..d135f8baa1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2734,7 +2734,7 @@ clean: profile-clean coverage-clean
>  	$(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
>  	$(RM) -r bin-wrappers $(dep_dirs)
>  	$(RM) -r po/build/
> -	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
> +	$(RM) *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
>  	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
>  	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
>  	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
> -- 
> 2.16.2
