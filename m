Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E00C20133
	for <e@80x24.org>; Mon,  6 Mar 2017 20:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932317AbdCFUpG (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 15:45:06 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36590 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753106AbdCFUpE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 15:45:04 -0500
Received: by mail-pf0-f174.google.com with SMTP id o126so17707028pfb.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 12:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nEEnnINn1/JNPxEBjHOWOc3EH9m/A2C0QeF5HgkmJc8=;
        b=OzX//brNLdhAqsXohSkc0uP2/CiubK+MV//l14H4Nb9p/KQ+wHFdPUNucN6v9HPcK1
         0+ODI4Tdgl6ZJBfgndcJoL0cv+fEUTjA56RFvTP3izi/PzgcnehAziqtsE9REg9EYnOB
         pGB01f1xvg7ZXf8IwUOgvnD/xU8SkHuAPW0bHcEhtKXz1APQyCG8xw/lZ/fhWY9XuceG
         3E3cnlTQE47LZM0tOUO5LgQC6Rq1gLDkSQ9shFdJVyXi7c1SD4+ffOxLqa8D2JFa6s8h
         M2+aATrmYNDpXGxp52+jyyGqxMPkOR2TdZtRAJPkl9LGT75ZqRy9jrr8gugoOdUFCH9M
         NCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nEEnnINn1/JNPxEBjHOWOc3EH9m/A2C0QeF5HgkmJc8=;
        b=QXvMI/4BHWPh7QNbT4cDPqaVJj/arVHO/eVtY6acEehGxfcdZWta7XSggVmEv5k3IE
         XqemVsE6MrAAp+xII6E8mTJ+12AlnoCW7DW4JUeru14I0nvuNyvlv2Kw/m72QnqpefWt
         9Q0sJaf3CMak4vFGeBgckQcyjXjfBu3IGnChSzuPMSsQnihZ7hc+2lhy4Ta8I/LS9844
         YTLv6ZrEMOeN03AheVMsrtC/pXSjHE/OQDRUOAmpRKFnFrFgo7NYJxVUUfg4hIxRHZjA
         3mApL/ATOC1VxFYlp9gURPehXt1NxZomNbH5baWXI5Ffbq+0qImwYTSyjDrJRqfKF67c
         kvAQ==
X-Gm-Message-State: AMke39l2yoiB7gebz3N5XfXvS6P9ah4Pv8WApzEJUuZuc9jijh97JtELKzxlCU4GuqoTjt+SyFKSxjx21ZERtFF7
X-Received: by 10.99.247.83 with SMTP id f19mr22645248pgk.158.1488832548614;
 Mon, 06 Mar 2017 12:35:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 6 Mar 2017 12:35:48 -0800 (PST)
In-Reply-To: <CAGZ79kbffqxq-D_PBGLYQqz9M1jgighutp8WPYmeTBhdfkuKnw@mail.gmail.com>
References: <20170223225735.10994-1-sbeller@google.com/> <20170302004759.27852-1-sbeller@google.com>
 <20170302004759.27852-4-sbeller@google.com> <20170302021135.GA26453@starla> <CAGZ79kbffqxq-D_PBGLYQqz9M1jgighutp8WPYmeTBhdfkuKnw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 6 Mar 2017 12:35:48 -0800
Message-ID: <CAGZ79kZ_yuT+O84dRuJRtec+87PH6vmSA4gqeg6hzJyLT4_N2Q@mail.gmail.com>
Subject: Re: [PATCH 03/18] lib-submodule-update: teach test_submodule_content
 the -C <dir> flag
To:     Eric Wong <e@80x24.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        David Turner <novalis@novalis.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 6, 2017 at 12:30 PM, Stefan Beller <sbeller@google.com> wrote:
>
> as well as another fix in git-submodule.sh
>

I spoke too early, that seems like a false positive.
