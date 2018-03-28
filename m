Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFF551F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753568AbeC1WYL (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:24:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52188 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeC1WYI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:24:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id v21so7565244wmc.1
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 15:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8zcZcR+q+sJObbT9Nyd5wgzwOMSgFuqBvs1JjXTBgeQ=;
        b=beaK9nF2BjmUgqur9syxzc23XaThJUZVuh7gdCWdkQ3Q5dFu/uz7ifxQiTSPHUydd6
         cxE8EGjB6nCzdSr9ASfN3sdImdKTm6xtF/EUwrhrFVm3nQPqOGph6Zw/KHV76FqlsZzI
         KJAim6e++qZX/IS9sLp71JTJsji7f9Dnfi5yCJXlYSxkMJtbMkPgyVwo6+9z5ICV17zW
         0bQciaTPdoPoqyoU7bW9wREO9k24ofKGbV6bIrziWO0W1KxZf6NqlzhNnXD1bTEwSWD1
         Nj+So+8S3AUYoAb06+fzenj4OLym9bv+DsVCqyz9l/R7GuDUVA85KvYtm8+mQEN93EIe
         8k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8zcZcR+q+sJObbT9Nyd5wgzwOMSgFuqBvs1JjXTBgeQ=;
        b=UcYEHK6/pHl4QqBrR6eg/LpuSt5wWDXXA11R4R5zsG44UI1MEGvkJx8YNf2HGa5m4L
         IGfKkMYJU6nl20/zuQ89jdx3TX1m9YBu5k8Dm/F61N2LlZMWz1MMkg9w1LApIL2ona3B
         9Bi4n3NZDXqkOTujVfvHEy1CHRkZquq3jTyYl1zDsjPEhx1XC7mg0cKYxDhxKwypV3E7
         JKVg5fKqD653HGEgv9XQELvty5tR0WU0WV4pnOHxa+vHl2w1JxtPTxSzu/NT2fQtCyET
         RMTvH+ej7teVPZ3N6xyOIUKcI2LaPxyyPMaGlEzWbDJDWm9gVfFQz6DOZeq8Hnhy2r26
         uS3w==
X-Gm-Message-State: AElRT7G8jW0q5kirk6FpstqH8RIIACDoHRaYeyETW+X3NirRl3JBHKKz
        BqzkMzAYiCM2VmM5dYA2j8raPfDE
X-Google-Smtp-Source: AIpwx48uFqOrzyPvTs4j7JO0rt4wcTwzo/ReK9Zc4wxOns/34rvGYa3ofjTSNiKiio9tBii7CGh9jw==
X-Received: by 10.28.35.76 with SMTP id j73mr3699140wmj.103.1522275847218;
        Wed, 28 Mar 2018 15:24:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l11sm4088893wrg.71.2018.03.28.15.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 15:24:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Rafael Ascensao <rafa.almas@gmail.com>
Subject: Re: [PATCH 0/8] Re: git complains packed-refs is not a directory when used with GIT_DIR and GIT_WORK_TREE envvars.
References: <20180328094733.GA1523@sigill.intra.peff.net>
        <20180328175537.17450-1-pclouds@gmail.com>
Date:   Wed, 28 Mar 2018 15:24:05 -0700
In-Reply-To: <20180328175537.17450-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 28 Mar 2018 19:55:29 +0200")
Message-ID: <xmqqh8oz7sai.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This is what I got, which is slightly different from your series
> because I want to call set_git_dir() just one time (by
> setup_git_directory) and never again. I think the API looks close
> enough.
>
> I will probably rework on top of your chdir-notify instead (and let
> yours to be merged earlier)

I was occupied with the current cycle and did not have a chance to
read this one over before seeing this exchange.  After reading
Peff's chdir-notify thing, I agree with its general direction and
the idea to refine on top of it, which you two seem to have agreed.

Thanks for working well together.
