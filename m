Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BC4D1FDEA
	for <e@80x24.org>; Mon,  8 May 2017 07:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbdEHHKo (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 03:10:44 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34119 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbdEHHKn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 03:10:43 -0400
Received: by mail-pf0-f178.google.com with SMTP id e64so28901439pfd.1
        for <git@vger.kernel.org>; Mon, 08 May 2017 00:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3DT6hXnbqsj6C9f4ItNI+ULV7f+mIB7IJUb8ldUNJcg=;
        b=PKGdsdrkDzUl0Bjmxd5f1frcMRYyj1QKQ7+VECdEcPSw8JkEW+FWyW/266huh/ixOt
         boNy0Ro3hx09u4C++YKAH5+rRp3FmmRK2O/9fIRTRP2348htEx6Zg2Zqcd+WmCvSxPty
         0hBYfcZjoWasZaHcGuYm1sATuTlLnH/p9hrw5jvrxr8BDnVe8TcVgNyOb5qUGMLrX3Wp
         rce2N/R8l3XXX44E3bL3onQicUEasK0BhlQX7BGHvo6K+/b6VYXsv70qD3wNL8Sx5Pmi
         8gb7PX2MGvHjz7TJzY2CDyRIXYtUfWzDGx2/pmgf5h1XYDjSMAeYnKM26tSokthuAi6R
         gdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3DT6hXnbqsj6C9f4ItNI+ULV7f+mIB7IJUb8ldUNJcg=;
        b=AqK23fjQbV0tZP3VFfy1CodLbpTF/OdpbJKNQ85OE/EaB61v6YOFcjGGVPGIbmEfWi
         nSXQVd552M6Wdyjf6QXZsiZNWZ9syyt9yBDBPMlN0zIzCwOzyWBt0/O0Vw0q6nDGMcYS
         AiFomR1crUcN0qVumMDMKL61hrKEKK86nCn7gYwfeBYGDyXfUsnDuMmEc2HC+ZyaaOWW
         cksJ7vQSeUm1smRskf4XZ2NzFXaOUKLyAVSFGv+PfKm11q3QfwpLpVdnZIMZCXcAmyjZ
         ZQl4oOqY7rZE2g9Tvzq4VuwvlV5Q9VOkpjeEEFz+qX8RckCU5l+yhvPYYcPMLG78Bkr8
         8/Pw==
X-Gm-Message-State: AN3rC/7l2VDc+IlNfz/QL5XUjjB0rSognf2AEDFiFx51xgfadpYuxqGE
        nbdZb/H25r+TQg==
X-Received: by 10.84.232.71 with SMTP id f7mr49451947pln.168.1494227442440;
        Mon, 08 May 2017 00:10:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id l3sm23056342pfj.130.2017.05.08.00.10.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 00:10:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May 2017, #01; Mon, 1)
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1705021406510.3480@virtualbox>
        <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com>
        <alpine.DEB.2.20.1705021756530.3480@virtualbox>
        <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
        <alpine.DEB.2.20.1705031139090.3480@virtualbox>
        <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com>
        <alpine.DEB.2.21.1.1705041104070.4905@virtualbox>
        <CACBZZX5bPN3vZhE=0TSQNdRvKYuV3635=VCQAppAfcZ_tuGpvg@mail.gmail.com>
        <alpine.DEB.2.21.1.1705041328190.4905@virtualbox>
        <CACBZZX75nvfQft-gjUG+YP0Y-e-=Knm3bMeDWHSUF=Juz9Ua5Q@mail.gmail.com>
Date:   Mon, 08 May 2017 16:10:41 +0900
In-Reply-To: <CACBZZX75nvfQft-gjUG+YP0Y-e-=Knm3bMeDWHSUF=Juz9Ua5Q@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 8 May
 2017 08:30:56
        +0200")
Message-ID: <xmqqpofj7rim.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> This won't be in my next PCRE submission, but I have a path locally to
> simply import PCRE into git.git as compat/pcre2, so it can be compiled
> with NO_PCRE=Y similar to how NO_REGEX=Y works.
>
> This will hopefully address your concerns partially, i.e. when you do
> want to try it out it'll be easier.

Eek, please don't.  

Until pcre2 becomes _so_ stable that all reasonable distros give
choice to the end-users to install it easily in a packaged form,
such a "not a fork, but a copy" will be a moving target that I'd
rather not to have in compat/.  IOW, our compat/$pkg should be a
last resort to help those on distros that are so hard to convince to
carry the version/variant of $pkg we would like to use.




