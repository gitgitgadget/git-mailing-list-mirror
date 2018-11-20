Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07A631F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 23:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeKUKRx (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 05:17:53 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55481 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUKRx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 05:17:53 -0500
Received: by mail-it1-f196.google.com with SMTP id o19so6148560itg.5
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 15:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=szLePNCCvk+361jUNCXKQDsLHDGWGmMOXscLub9K7MU=;
        b=OVoI3jIoRIm5ZrabCGL0+WIKEqYvakL9+OjPInHkUg3zZqUg1ZRHxBd2XZLiUV4MNv
         Dc5mLnS2vzXnVILjl9+n1FgsNC0cyBX1bi9lXmBwZFOdnpVVgOjt9xzYh9EYZ1w0pwsg
         z9Clys59inItcrcMaqk0smnQsvgWmVcQY+woL4vVogJYilqxFE7R3ae8kdhXRfZRPXgd
         0XtiXNYJ9RBiKXAPE4Vxq+xirzXotgn6b2s5+Qji4ZmVXy0LaIJmToa8VZrnVXxPZOht
         zt95Wx9tgJ990lli9cP7WqJkxQn7oFE1gQfkV3MV64BeOqgBnyDvq1vPZWTojbs8SiQ4
         WN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=szLePNCCvk+361jUNCXKQDsLHDGWGmMOXscLub9K7MU=;
        b=WzvSLC7TR7OYrzfZSXCT61HWFMa7oARbsQ84HNs5S8gwaDzwh6gfrKZpHsYax+ZTDg
         emkOPNfh6n480jVZnZrMmAOUqGAg2Figs5/I4mBPrtM/0VRtv4sD6HJMsUYLaPWq79va
         Eb335hXFzRUzBxncF4oWezeaka8Upca+n+ukBSj/Bf/f0Vq+ylrbABR5tHn/1wARZwbc
         K7A2A9UHZ5lhGoMCm5BH9orcQGkQX4yvuBH9lsv8KlBNBIXXEJ/dpHpBZr6X4J0ML3z0
         UmbAwPWQcR+PQBV781sgQBlLoT1jyJi9+rrfWxe9SJ16nnhBGLO09rg6nk14rEFNS/4c
         c0aQ==
X-Gm-Message-State: AA+aEWYDXigAsoUZYlfCqnM99FfKAUY7Qt6KLDKIByXiP2z1XbJhagIj
        xHo10b40x6MwzzkQM87kOm1ca3K3Ev1hoRQ47Sk=
X-Google-Smtp-Source: AJdET5dnT8oIm+4NtFPCpwknNXWFyDjGQs/OVb21Hw2Oucqx7JG1M8VaTVuzRhz8Hpm2uddJ8iqaiD5sqA8CWlN5J5M=
X-Received: by 2002:a02:4511:: with SMTP id y17mr3545579jaa.56.1542757566569;
 Tue, 20 Nov 2018 15:46:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.86.git.gitgitgadget@gmail.com> <84e65a4efb3d58ca777cd59c52fe86d63060ea9e.1542744118.git.gitgitgadget@gmail.com>
In-Reply-To: <84e65a4efb3d58ca777cd59c52fe86d63060ea9e.1542744118.git.gitgitgadget@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 20 Nov 2018 15:45:52 -0800
Message-ID: <CAPUEspgxNm9oEA-fuT7kBegEp5F2za5Nm6CSvFkMB+Kz_pNbrw@mail.gmail.com>
Subject: Re: [PATCH 1/1] legacy-rebase: backport -C<n> and --whitespace=<option>
 checks
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tested-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

the C version prepends: "fatal: " unlike the shell version for both
error messages

Carlo
