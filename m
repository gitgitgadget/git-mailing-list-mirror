Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03ECD2022D
	for <e@80x24.org>; Sun, 26 Feb 2017 21:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdBZVjK (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 16:39:10 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:35041 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdBZVjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 16:39:09 -0500
Received: by mail-io0-f171.google.com with SMTP id j18so21086001ioe.2
        for <git@vger.kernel.org>; Sun, 26 Feb 2017 13:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MxXS5RoZ84EBKQ4HuT/Yxcvrd9g5rypqMQBdUsTiwYE=;
        b=UyRhPsOtFN4JtN62X2PvOJWRmUdzluQRQxjXCoHPBChDJJY3oHPy1cNuPdx5ULmUTP
         FAUeSlA524MsLkZAJolQpeAdlW7DlyRpDOk9PXLpwnbn58A3853v9GlPZlLGBPWwRiO2
         6A1ddZifDWmt4RNNkoMnmo/67QHKYCpYfUcwBvPiMUDGluVH5FV6qGznJrg/0dZmrhNy
         dZsuDA5Sf/+mlOCg+dsJosWDO0l19oFyewcofRR6X9baR2XrDTJDKafI/yiYKxx9qAPj
         aidJHTGleIMoSnakxJbIGUIicmRAuuGzxkpLrWnOzFsYVJz2Tqy6HWR7SJO7/RpmEhPt
         TnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MxXS5RoZ84EBKQ4HuT/Yxcvrd9g5rypqMQBdUsTiwYE=;
        b=ir9zr79zeVpIenm56vBMsBq8CwLkCOkuNreuw8VISrOZbCk/efmffmuv1tox/ONKhp
         BLWnRDadWpNcL40OvabmlcqB2EKUvU5M+Xx6i0kuTMfZFLt9kLF1VnYWs5G4cVLK8x+m
         2QuKsBpVxasLTGLeeK2MzbApyyMMzIPuNzAU1ooBpXBuHbHOscIwdWfT6CNklRi86AHJ
         YVAAabHJUWK8LEGUH0f7OZUrXSyfCc8EOD/kznboQd+KLbx5do34KGz1lBYo13YNnFyP
         4cTZgLcJB0zH0BXBtgdPLmPtW6m+Zf9HBBF8V0NmaRNB6LAl1LtY7nQ5ngI5hNBtkJHK
         oCZw==
X-Gm-Message-State: AMke39l9yFf9So84VQy/npj0u+oS5pM96ACy3NYwE7DxNm2I9xk7UtdcmUnoD0nhm1cbEUJWimR6J4n+eT76LA==
X-Received: by 10.107.57.2 with SMTP id g2mr13271954ioa.117.1488145136693;
 Sun, 26 Feb 2017 13:38:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sun, 26 Feb 2017 13:38:35 -0800 (PST)
In-Reply-To: <CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com>
References: <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <nycvar.QRO.7.75.62.1702240943540.6590@qynat-yncgbc>
 <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com> <CAGZ79kaZWe-8pMZnQv7uZtr8wXWawFeJjUa68-b0oa4yFo-HcA@mail.gmail.com>
 <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com> <CA+dhYEVOyACM9ARP2deKVLm1hHOVsTah1WfGoNzGGKO6CGrQpw@mail.gmail.com>
 <xmqqh93j1g9n.fsf@gitster.mtv.corp.google.com> <CA+dhYEVwLGNZh-hbcJm+kMR4W45VbwvSVY+7YKt0V9jg_b_M4g@mail.gmail.com>
 <20170226001607.GH11350@io.lakedaemon.net> <20170226173810.fp2tqikrm4nzu4uk@genre.crustytoothpaste.net>
 <CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 26 Feb 2017 22:38:35 +0100
Message-ID: <CACBZZX6fP_JpL+K3XUnke=4m4gZBLu-Afyz5yJkrRnGXHuhR8A@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Cooper <git@lakedaemon.net>,
        ankostis <ankostis@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, David Lang <david@lang.hm>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 26, 2017 at 8:11 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> But yes, SHA3-256 looks like the sane choice. Performance of hashing
> is important in the sense that it shouldn't _suck_, but is largely
> secondary. All my profiles on real loads (well, *my* real loads) have
> shown that zlib performance is actually much more important than SHA1.

What's the zlib v.s. hash ratio on those profiles? If git is switching
to another hashing function given the developments in faster
compression algorithms (gzip v.s. snappy v.s. zstd v.s. lz4)[1] we'll
probably switch to another compression algorithm sooner than later.

Would compression still be the bottleneck by far with zstd, how about with lz4?

1. https://code.facebook.com/posts/1658392934479273/smaller-and-faster-data-compression-with-zstandard/
