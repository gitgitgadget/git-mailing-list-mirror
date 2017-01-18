Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82FB21F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 18:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753584AbdARS5O (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 13:57:14 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33503 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753278AbdARS5N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 13:57:13 -0500
Received: by mail-qt0-f196.google.com with SMTP id n13so3269304qtc.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 10:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=n6Kz2wRvv8DCP72Uzq1dzrvvvjrwF9WJ+A7YdKE0kE0=;
        b=hHv2IIn2k/2J8Jf5yPEaOJYrl4ymi2VRovujp7n7D0g/nK7jsJb2LXnR2HiF1xfsdl
         gMkb4fL6Gj+VkgTHZU3/dC9G3vj/5J8xH1ZrjQ1LijEHJIyCefY/oubUXnw6BHBOYSJT
         /vs9SQT4OuJc53g/xXT3fqid0PIgqIjxEf2eLoqAnetSAUTkd6OO+sQKNXJ9iJCsWB8P
         LerotklE6svXmp2ZEnq+A4skq6iLd7dC7aMy5Qs89vad3JNFbId4zkUqlcMs+NjrPDR1
         q+9XyHrCRypjn1cT2pGx9Oo+RiZhQQWkY/oHYfv6dvBumoIycUx2qkQjvbKyUhLPkSMi
         bNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=n6Kz2wRvv8DCP72Uzq1dzrvvvjrwF9WJ+A7YdKE0kE0=;
        b=akzDBzXEgragAa5gvHpK/SyVY3EPnEHkEbDzV624u/TYfj1wqqct4PETqvUgYJ2niD
         d+qT4x4peVf/JM+kkYvnpK3D4EznEBomo4SXHE1+I0QpZWpPSar/vIWleTT4zEaLIRcZ
         ojO+ST1xrCwfyyNcJ9E629iqHBX7GzV9BmcyfDjWUaVuCFnUrLeJtrygZybrYn4JNV77
         drLmWuLOLtZcq76EASVnhX4iep6SfztPEWU0iZT7HUA2HWflyM5WugKYm+Ai+8Aoo3KF
         SHxAcIaaphjnyF45w2G3YKepv6EnRKHoTO60jy1mxiKdPOzGDGd/Coke8hP1K/WNDely
         ucnw==
X-Gm-Message-State: AIkVDXJUrasFQqbnH6mAmtXKELDsZ+ZPUXt4X3vwrxHvuoKu8UBu1nSxXQD2/Dp7KbLMSA==
X-Received: by 10.200.49.249 with SMTP id i54mr4466806qte.3.1484764030348;
        Wed, 18 Jan 2017 10:27:10 -0800 (PST)
Received: from BenPeartHP ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id w138sm854940qka.27.2017.01.18.10.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jan 2017 10:27:09 -0800 (PST)
From:   "Ben Peart" <peartben@gmail.com>
To:     "'Stefan Beller'" <sbeller@google.com>,
        "'Martin Fick'" <mfick@codeaurora.org>
Cc:     "'Shawn Pearce'" <spearce@spearce.org>,
        "'git'" <git@vger.kernel.org>, <benpeart@microsoft.com>
References: <20170113155253.1644-1-benpeart@microsoft.com> <CAJo=hJumYXTRN_B3iZdmcpomp7wJ+UPcikxGb6rn9W=uJeYmfw@mail.gmail.com> <002501d2710b$af74c4d0$0e5e4e70$@gmail.com> <2381666.1DSVtKRIH5@mfick1-lnx> <CAGZ79kbWHHOj5x=SqSvUPdXtyYZUqDBnPG+erfZHsUkA8Cv-NA@mail.gmail.com>
In-Reply-To: <CAGZ79kbWHHOj5x=SqSvUPdXtyYZUqDBnPG+erfZHsUkA8Cv-NA@mail.gmail.com>
Subject: RE: [RFC] Add support for downloading blobs on demand
Date:   Wed, 18 Jan 2017 13:27:09 -0500
Message-ID: <002801d271b8$7b909600$72b1c200$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHeqv64Rhj1j9YcMHkE7nrdCUWdigLJzk+jAzYlG9ECeeBIYAF4jBC4oNaGK4A=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We actually pursued trying to make submodules work for some time and 
even built tooling around trying to work around some of the issues we 
ran into (not repo.py but along a similar line) before determining that 
we would be better served by having a single repo and solving the scale 
issues.  I don't want to rehash the arguments for/against a single repo 
- suffice it to say, we have opted for a single large repo. :)

Thanks,

Ben
> -----Original Message-----
> From: Stefan Beller [mailto:sbeller@google.com]
> Sent: Tuesday, January 17, 2017 5:24 PM
> To: Martin Fick <mfick@codeaurora.org>
> Cc: Ben Peart <peartben@gmail.com>; Shawn Pearce
> <spearce@spearce.org>; git <git@vger.kernel.org>;
> benpeart@microsoft.com
> Subject: Re: [RFC] Add support for downloading blobs on demand
> 
> On Tue, Jan 17, 2017 at 2:05 PM, Martin Fick <mfick@codeaurora.org>
> wrote:
> > On Tuesday, January 17, 2017 04:50:13 PM Ben Peart wrote:
> >> While large files can be a real problem, our biggest issue today is
> >> having a lot (millions!) of source files when any individual
> >> developer only needs a small percentage of them.  Git with 3+ million
> >> local files just doesn't perform well.
> >
> > Honestly, this sounds like a problem better dealt with by using git
> > subtree or git submodules, have you considered that?
> >
> > -Martin
> >
> 
> I cannot speak for subtrees as I have very little knowledge on them.
> But there you also have the problem that *someone* has to have a whole
> tree? (e.g. the build bot)
> 
> submodules however comes with a couple of things attached, both positive
> as well as negative points:
> 
> * it offers ACLs along the way. ($user may not be allowed to
>   clone all submodules, but only those related to the work)
> * The conceptual understanding of git just got a lot harder.
>   ("Yo dawg, I heard you like git, so I put git repos inside
>   other git repos"), it is not easy to come up with reasonable
>   defaults for all usecases, so the everyday user still has to
>   have some understanding of submodules.
> * typical cheap in-tree operations may become very expensive:
>   -> moving a file from one location to another (in another
>      submodule) adds overhead, no rename detection.
> * We are actively working on submodules, so there is
>   some momentum going already.
> * our experiments with Android show that e.g. fetching (even
>   if you have all of Android) becomes a lot faster for everyday
>   usage as only a few repositories change each day). This
>   comparision was against the repo tool, that we currently
>   use for Android. I do not know how it would compare against
>   single repo Git, as having such a large repository seemed
>   complicated.
> * the support for submodules in Git is already there, though
>   not polished. The positive side is to have already a good base,
>   the negative side is to have support current use cases.
> 
> Stefan

