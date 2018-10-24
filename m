Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C88091F453
	for <e@80x24.org>; Wed, 24 Oct 2018 02:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeJXLON (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 07:14:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37241 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJXLOM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 07:14:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so459368wmc.2
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 19:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V0l8m8xqwgIC088uqPC+OSHUp/UHERrffJeyR+3ESvs=;
        b=cgKtYNK6qpiJPxK2czT3DCXP7InuBO1j65FuNGeYD3VcUW8zzEeFhDbfglmdUh62Iu
         qBMaQPMTxc/41buWWrGztCoI3vwssoYT3lO786v6U9sBNL62rlG1ey3phh+lrOUpVM3F
         x7OcnzDU0cYWbEt+7ZHtKUQE7klUeClZPk9w/sE1hLAdDT9mhMa4t9W9Gw8DC+JN676z
         B7TutEo5JFx3CIUQJTYFp2AHyu0xeOB8JF/CYLuiFDi4pizPCGWcJ1ttM92du3qauoNM
         lLCcl6coB9dRZYMrHDmp1GoFGd0aax0wGeBnYFRLmlCTamrxmyDHZLlLYTafllutCE3/
         DAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V0l8m8xqwgIC088uqPC+OSHUp/UHERrffJeyR+3ESvs=;
        b=lFCvNlLzkfj9ESTSGX+AoHA6YFXwxRzoKfcyfg0ObE1NmakQW1jvQ5QF5TOeH0d06a
         EzSF5RTrigI+bXMstUepzdwX+JKIQI/8ahDYKdQT6mNIJgbmwczjvM8/12s1IA3i89GZ
         pvQ5NtvlufbBjemewM8uj3r6umwf+Eb7jGzUMb/SFKGJfy547yters0HeiwXfmWXumf+
         NuaSWopyBeoor34knN2yUmk4t8bpwtwbyEqmXekXgzkb2tZoc4H4aqClsW9ijcbdIiN/
         rBrdqVzDO5CiB56scMY2jkf4mehpbNwc1UVzx2K6SgWINQH6hhfue3sKV5U5up+VK84u
         AJyg==
X-Gm-Message-State: AGRZ1gLPQcL1LxLA/Kwd3O3o4U2DY7oawYFY+E/xiTIqLeNKoOOrNAij
        XG4VcBtQAnNXyC3Jr+jWvIc=
X-Google-Smtp-Source: AJdET5e+eAoNrgdv7hb8NjiA2nY38Kb50ZXz6c3TbyRAX5BIw/wmBYLkLmyez4TWupE891BWIXB+Gw==
X-Received: by 2002:a1c:540d:: with SMTP id i13-v6mr597880wmb.149.1540349290603;
        Tue, 23 Oct 2018 19:48:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v129-v6sm1953990wme.45.2018.10.23.19.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 19:48:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Slavica <slavicadj.ip2018@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Slavica <slawica92@hotmail.com>
Subject: Re: [PATCH 1/3] [Outreachy] t3903-stash: test without configured user name
References: <20181023162941.3840-1-slawica92@hotmail.com>
Date:   Wed, 24 Oct 2018 11:48:08 +0900
In-Reply-To: <20181023162941.3840-1-slawica92@hotmail.com> (Slavica's message
        of "Tue, 23 Oct 2018 18:29:41 +0200")
Message-ID: <xmqqd0s0qcuv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Slavica <slavicadj.ip2018@gmail.com> writes:

> +test_expect_failure 'stash with HOME as non-existing directory' '
> +    test_commit 1 &&
> +    test_config user.useconfigonly true &&
> +    test_config stash.usebuiltin true &&
> +    (
> +        HOME=$(pwd)/none &&
> +        export HOME &&

What is the reason why this test needs to move HOME away from
TRASH_DIRECTORY (set in t/test-lib.sh)?

> +        unset GIT_AUTHOR_NAME &&
> +        unset GIT_AUTHOR_EMAIL &&
> +        unset GIT_COMMITTER_NAME &&
> +        unset GIT_COMMITTER_EMAIL &&
> +        test_must_fail git config user.email &&
> +        echo changed >1.t &&
> +		git stash
> +    )
> +'
> +
>  test_done
