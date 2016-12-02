Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54DBC1FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 19:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755505AbcLBT2x (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 14:28:53 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36457 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbcLBT2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 14:28:51 -0500
Received: by mail-qk0-f172.google.com with SMTP id n21so289313014qka.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 11:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hCvFoT2vK10t4O5x+WdB+ok7zA043NiLUq9XzlPsw1E=;
        b=je9+aDP+8oK7rsTbpJRQ5DfxZOR76g6NigWai5lKmDXV6yEnfF0Xp4XuhBd/Pc3iXy
         TgiM413J0VirzluMClyyZaARylQNrpbhZkJ1Ks3HhKKvCkKO+eQGVdFcnuz4RoiJvaHK
         XnDJAtpGO3MYZtF4qkfkOypKeNcr0Yq5lHAQwbBxweMRfwi2usjyOBwngf4+BN4OBXgd
         L6FzW94aXgpmS0Mp/fABj8HWedP7aPjCHLwnIRbgtnitpPZZtY7BlJxI7jwK3WnpGfQD
         5s6uNh4rUmKNiMKxX67i5Rv/B64lHw9QDoMoPZG9cSAukgv5wDKWMAyXQZ4RGZa3HdN5
         IsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hCvFoT2vK10t4O5x+WdB+ok7zA043NiLUq9XzlPsw1E=;
        b=GApoXphERdv+zW98EjVV6+zTv4pm1Cb9a2k6tln1sDOoScw8xEQzr1ErF+aI/iZ7oO
         qGZmBB1nTTgOZaSObjJrs8QNYxfhbNuR6tTC3Kep43i2sThd6cVaVtxsl8jnd+EDKjGW
         DE5LeJCgWQQJWwqiOj66Rx+XONboojxYNqJI8+zQytXoUBUOgMjjNq1KbHoWwBGIiYMV
         wcwwsKYyuRSuyLlJokHLOd6kwbhT88yIhlF2JXDWX1uGJxO+Fl/vXV3ZbKZRt/hyS9cx
         nU1fijV1ldESf334Cx0sKJVhJXGyN7RTOA0S3DD8kUx8kcb1sa7vFAsXV+aagiC3xBJN
         7VmA==
X-Gm-Message-State: AKaTC010M9MtlV6PTAFP+pGx1AJ20F3aph53WZnr3CNPL16wSVqglq355vapre29h1UkWLaOb6PmicIm+oZtEEDm
X-Received: by 10.55.67.81 with SMTP id q78mr39591683qka.53.1480706930229;
 Fri, 02 Dec 2016 11:28:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Fri, 2 Dec 2016 11:28:49 -0800 (PST)
In-Reply-To: <CA+P7+xoi_UNSv-dKVFWf7T4o3uBtGa0wR6=nnYX+kjzLAmw6ug@mail.gmail.com>
References: <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net>
 <xmqqwpfja3nk.fsf@gitster.mtv.corp.google.com> <20161201190925.xi2z7vauxyf3yxyc@sigill.intra.peff.net>
 <20161201191603.GB54082@google.com> <20161201205444.GG54082@google.com>
 <20161201205944.2py2ijranq4g2wap@sigill.intra.peff.net> <CAGZ79kaqzssfN_bRQYpqC9HsKmyQZNCQcs+T5ke95Sf-C5PaRQ@mail.gmail.com>
 <20161201215934.g7dt5ioekmx6ssii@sigill.intra.peff.net> <20161202183622.GB117792@google.com>
 <CA+P7+xpoO=ieRyQb8r8Xz12nN10f53LKeVMgAO8XPdSwvG7fuA@mail.gmail.com>
 <20161202184944.GC117792@google.com> <CA+P7+xoi_UNSv-dKVFWf7T4o3uBtGa0wR6=nnYX+kjzLAmw6ug@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Dec 2016 11:28:49 -0800
Message-ID: <CAGZ79kYPpc0=NAJaNPW+8faszOPAkq=b3m-EopY5A8oFwh+9=g@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2016 at 11:20 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>
>> So is there a reason why the library function realpath() can't be used?
>> From a cursory look at its man page it seems to do the symlink
>> resolution.
>>
>> --
>> Brandon Williams
>
> I believe it uses the same method and thus wouldn't actually resolve
> the issue. But I'm not really 100% sure on this.
>
> Thanks,
> Jake

I just reviewed 2 libc implementations (glibc and an Android libc) and
both of them
do not use chdir internally, but use readlink and compose the path 'manually'
c.f. http://osxr.org:8080/glibc/source/stdlib/canonicalize.c?v=glibc-2.13
