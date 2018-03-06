Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B41811F404
	for <e@80x24.org>; Tue,  6 Mar 2018 01:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeCFB1e (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 20:27:34 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42967 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeCFB1d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 20:27:33 -0500
Received: by mail-wr0-f193.google.com with SMTP id k9so19227650wre.9
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 17:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=adupo1NSnfFj3AQ2NC7skXzs0Ju8b1tmAkuIFLaNXrA=;
        b=rFX2l3Is/CfShCLkxEoy7odDhB5udXZHssynaH/f1UnZsBiudYljdB0QzLAMz4GvRU
         rr66K9tpU9ufxy+Uin9QqUCEyCvR5P86CBlgO9id/ejUvbRhuYTPkdEhzYo+lsZApPUf
         Tf+x5RGrkJbJIuKqfhfM6EPD5IC0UMltlCqjh8xaPXhCKkLU1FrGM6IXi9zRZ+9/2lqo
         FvKot8hawwKZsE6OyNtNwv+iFZBvTaxYFsfuChgEt14oLxFnQZuDSXmXhvMdqMeelwuY
         Er0Vch2t7GeLj+7pd8M9zRxmO638jIxp5sEcn6u6wUMJXD0Y464IvnJPBd2g6ptCVYr7
         QXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=adupo1NSnfFj3AQ2NC7skXzs0Ju8b1tmAkuIFLaNXrA=;
        b=gwxlMevaWb9qeDfhoZQUg57GLL+IH3sz2xLjot6wM4aXz2hkQoXhGqESNKu2ZJ49l1
         Wcs6P3esw+Im4vZxy4CnD0K8RUG9ofLqX7jCsUpJu0crTjF9xq+r7AjY9eEM86VYdont
         xrYQH5WNRiOv9JY9GxsL7fcnSOGgtaKYUn+LiJp2btcklgC+ZzDrrdSGlHtREbkT1e0M
         EVbxup1Fqryodj7qlJUDR4pO+FFgROI+gs1OTFVwyf5DS2+6E5RDSjh7j+BRU6JeEw9J
         efxMNoxOzeo2XcP1JkllV9HD+B+pYOxwi4sVewJJXmGJioHbzJ75833lU3+Tv7Kiv0JM
         S4ng==
X-Gm-Message-State: APf1xPA/dsD2JtONJ/VX0RS1Q671fabBMrwfxeioU7UN3FPF8ORKjY60
        HSCGzyVkmakdQRAmY7GCy24=
X-Google-Smtp-Source: AG47ELs3eUNFVemKkRsEggKsgUjKj3Qd7xRheW0BXo7oqOMczUDLq4iQYDwwKsnrbGu939jQlGHRoA==
X-Received: by 10.223.149.68 with SMTP id 62mr15038972wrs.249.1520299652306;
        Mon, 05 Mar 2018 17:27:32 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y64sm32720436wrb.56.2018.03.05.17.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 17:27:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SiddharthaMishra <sidm1999@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC] [PATCH] travis-ci: added clang static analysis
References: <20180305200400.3769-1-sidm1999@gmail.com>
Date:   Mon, 05 Mar 2018 17:27:31 -0800
In-Reply-To: <20180305200400.3769-1-sidm1999@gmail.com> (SiddharthaMishra's
        message of "Tue, 6 Mar 2018 01:34:00 +0530")
Message-ID: <xmqqpo4i6lj0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SiddharthaMishra <sidm1999@gmail.com> writes:

> Added a job to run clang static code analysis on the master and maint branch
>
> Signed-off-by: SiddharthaMishra <sidm1999@gmail.com>
> ---

Why on 'master' and 'maint' and not others?  Quite frankly, I find
this choice of branches rather odd, as these two branches are not
where the real development happens.  If we do not want to increase
the number of jobs and limit the test only to a single branch, I
would probably pick 'next', and if we can afford two, probably
'pu' and 'next'.

