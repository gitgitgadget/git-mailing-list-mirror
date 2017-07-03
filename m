Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A63E201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 18:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755297AbdGCSNz (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 14:13:55 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33575 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752233AbdGCSNy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 14:13:54 -0400
Received: by mail-pf0-f178.google.com with SMTP id e7so103602898pfk.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=eu+uT4i+hKWPiEo7Rbyula2kgZM+kuoZ0sHslI/VB7o=;
        b=AhVRuoz+7GYogALsaBOHQAb3vSVZyKrBlUsWrH29XYSvO+dA67Pq8ffKteRO8NfrWq
         IUEtbYRCO7SsvqDbP+IJ6pKrRH0jlyXEPlFiBvQTUMv0N/3LpU/uqASeVh4SHttazTl7
         8mRqmxJI7bIrXDrOPwFn3T1UZjBg6irOWdGc8hvTxEp74CGIPJY7rYCr7GCNGFWu9LGR
         YaJMzo2/5arFDr+kcXHUWV0UfFtOsN/C9+C4fCXsPOoHnB+tiO7aGBOx3z+DVML7RnMg
         y96uDWS00e71UDQ/8qo5DM0RXj02wILVnTyNjdStfasjJm3kuTtIVRO1JNcsFyolr2in
         sk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eu+uT4i+hKWPiEo7Rbyula2kgZM+kuoZ0sHslI/VB7o=;
        b=Ay274M4fN3x/RBc17IkCN+qM/lgR1y9iO4U6kSjM4QTDJprw0TdcS90JkbIFZJzDwy
         UxqBT4kNIvFOKsrww03sUmOpd576aH44fPYBlprIeDmIraL834CXf0ZkEzNwib6nYVlH
         R547kAHitrx1UBehE5QVUJUSVziKB6QO4E91zScZjRTrO3D1loJEjg7+JEqDyuwWZDRl
         bNic+Cr8famWtziUlHFF11X4rBG0Go7UZNCo5bnC6vMunL6kBYXiHWh2W0b3sH21X6D/
         O9rcp4KewyPGN3R0Yp7MzzsH76jgvYuC8d4w04m46+TJ/qQmOgJmWBRgpf6LQSY384c6
         z9VA==
X-Gm-Message-State: AIVw110dm7aA4mHeEQWc2iSLIrv6BphrBtUfsaKY0SkYLS2rUaCVkwuB
        EVJ96jLAcXNzUg==
X-Received: by 10.99.114.73 with SMTP id c9mr11288933pgn.267.1499105633914;
        Mon, 03 Jul 2017 11:13:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:30:4739:ca21:b5b4])
        by smtp.gmail.com with ESMTPSA id t67sm34016309pfj.98.2017.07.03.11.13.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 11:13:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Help needed for solving a few issues with building git
References: <1499087898.4156.6.camel@gmail.com>
Date:   Mon, 03 Jul 2017 11:13:52 -0700
In-Reply-To: <1499087898.4156.6.camel@gmail.com> (Kaartic Sivaraam's message
        of "Mon, 03 Jul 2017 18:48:18 +0530")
Message-ID: <xmqqshidl76n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Hello all,
>
> Building without localization support
> ------------------------------------
> I tried to build git from source without localization support by adding
> the following line to the Makefile,
>
>     NO_GETTEXT=1
>
> It doesn't seem to be working for reasons I'm unable to find. I used
> the following commands to build git.
>
>     make prefix=$CUSTOM_BUILD_LOCATION
>     make install prefix=$CUSTOM_BUILD_LOCATION
>
> While trying to build (without the 'gettext' library that's required
> for localization) I get the following error,
>
>     Manifying 8 pod documents
>         SUBDIR templates
>         MSGFMT po/build/locale/pt_PT/LC_MESSAGES/git.mo
>     /bin/sh: 1: msgfmt: not found
>     Makefile:2179: recipe for target
>     'po/build/locale/pt_PT/LC_MESSAGES/git.mo' failed
>     make: *** [po/build/locale/pt_PT/LC_MESSAGES/git.mo] Error 127
>
>     What could I be missing?

There is

    ifndef NO_GETTEXT
    all:: $(MOFILES)
    endif

which attempts to avoid generating *.mo files, but that does not
seem to be working.

>
>
>     Adding HTTPS support
>     --------------------
>     I tried to add HTTP/HTTPS support to the custom built version for which
>     AFAIK 'git' depends on 'curl'. I tried providing the location of the
>     curl source in the Makefile using the following line after reading the
>     instructions in the Makefile.
>
>     CURLDIR=/path/to/curl/source

Shouldn't this point at an installed location (iow, we do not build
curl from the source while building Git)?

    # Define CURLDIR=/foo/bar if your curl header and library files are in
    # /foo/bar/include and /foo/bar/lib directories.


>     Even after doing this the custom built git errors with the following
>     message when I try to use the 'git fetch' command,
>
>     fatal: Unable to find remote helper for 'https'

This is probably because you are trying to run without installing?
Ask the "git" you built what its --exec-path is, and run "ls" on
that directory to see if you have git-remote-https installed?

Trying a freshly built Git binaries without installing is done by
setting GIT_EXEC_PATH to point at bin-wrappers/ directory at the
top-level of your build tree (that is how our tests can run on an
otherwise virgin box with no Git installed).
