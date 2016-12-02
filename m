Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99AF41FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 21:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbcLBVbl (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 16:31:41 -0500
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35277 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbcLBVbk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 16:31:40 -0500
Received: by mail-yb0-f196.google.com with SMTP id d59so5531583ybi.2
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 13:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hXhQ8ND4kArr75vYJ0CwMqlHL5jSHJIWkcTCM6IlWQM=;
        b=HsQToJI+QPRH17tDTJpie/au9NO1XV8nbZwb8esegD74G1h2jK6NLfnKLF+nvHYPe6
         R+n4UGelWHGBKDNyoqMrAcdc7vAsUQ7c56t1nnZngGS9zFlwAiO3Cr3/xQ4JID4I+Dox
         xcFbrxj264+9K4QxGP7PJ/PzaXp9zMuVF3DhxDidvanSksWXv3KxCrXg2WjLl19nUTuM
         Dza34wYCIuYds8mhurWKchMcGwycMpjowtqDz4gUdYzLJrm9nhm7jbGEchm2qaSqDhvz
         FfyvHzoOkTbnQQgbHBxCsYm0P4D3I/z6Yh/e9FYVoZfWw/uSHtHRKheUI4XMmWOZP0pG
         X13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hXhQ8ND4kArr75vYJ0CwMqlHL5jSHJIWkcTCM6IlWQM=;
        b=aeVmXavzpGvyeG2sJDrGv7dFDrGwL5Ps9uAUaiLzriwrEEUAKs1niFKXuT6y48AQ70
         T9+qDnqa1xsck1lrcM6U0QsdI7vPEODRM847PNxAA8VGgSS8Q24t5gVlJg63Ehtw7HUa
         SSRf8YBn99/BdYfw/GoJJ6XaHjwKC9ckXS05riIMPDuEtX7YF3oKWL9NlT/l7NT+gKID
         2Bo/tphI3/IRJ619+egCO6ghYJfOWzny4ogO6AGLxzQkVeBB0V95+gj0ufg+n+nHBeJJ
         rtxCfGt7UNlp4aXHPxXnf340aD3SxVo3Ft5WtrY/fjaCMy+B7qw0KlR597Gv3Fk6VFjV
         m7DQ==
X-Gm-Message-State: AKaTC02RxmqOwwlBEufU0L6jFvGSdEz1rtCKCvdz0UeX1tyRvIEunYXf9s9L9jHHh/SRjalteCBsX6H2Pj/ydg==
X-Received: by 10.37.170.169 with SMTP id t38mr4301567ybi.194.1480714299554;
 Fri, 02 Dec 2016 13:31:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.118.87 with HTTP; Fri, 2 Dec 2016 13:31:19 -0800 (PST)
In-Reply-To: <CAGZ79kYPpc0=NAJaNPW+8faszOPAkq=b3m-EopY5A8oFwh+9=g@mail.gmail.com>
References: <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net>
 <xmqqwpfja3nk.fsf@gitster.mtv.corp.google.com> <20161201190925.xi2z7vauxyf3yxyc@sigill.intra.peff.net>
 <20161201191603.GB54082@google.com> <20161201205444.GG54082@google.com>
 <20161201205944.2py2ijranq4g2wap@sigill.intra.peff.net> <CAGZ79kaqzssfN_bRQYpqC9HsKmyQZNCQcs+T5ke95Sf-C5PaRQ@mail.gmail.com>
 <20161201215934.g7dt5ioekmx6ssii@sigill.intra.peff.net> <20161202183622.GB117792@google.com>
 <CA+P7+xpoO=ieRyQb8r8Xz12nN10f53LKeVMgAO8XPdSwvG7fuA@mail.gmail.com>
 <20161202184944.GC117792@google.com> <CA+P7+xoi_UNSv-dKVFWf7T4o3uBtGa0wR6=nnYX+kjzLAmw6ug@mail.gmail.com>
 <CAGZ79kYPpc0=NAJaNPW+8faszOPAkq=b3m-EopY5A8oFwh+9=g@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 2 Dec 2016 13:31:19 -0800
Message-ID: <CA+P7+xpJ1=TiWq60wO4ftA-Y6SHAkdbLk=srbTQQsB=D1ZGkrw@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2016 at 11:28 AM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Dec 2, 2016 at 11:20 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>>
>>> So is there a reason why the library function realpath() can't be used?
>>> From a cursory look at its man page it seems to do the symlink
>>> resolution.
>>>
>>> --
>>> Brandon Williams
>>
>> I believe it uses the same method and thus wouldn't actually resolve
>> the issue. But I'm not really 100% sure on this.
>>
>> Thanks,
>> Jake
>
> I just reviewed 2 libc implementations (glibc and an Android libc) and
> both of them
> do not use chdir internally, but use readlink and compose the path 'manually'
> c.f. http://osxr.org:8080/glibc/source/stdlib/canonicalize.c?v=glibc-2.13

Interesting. Would this be portable to Windows, though?

Thanks,
Jake
