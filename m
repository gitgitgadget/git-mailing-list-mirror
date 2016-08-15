Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA0E61F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 13:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbcHONaf (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 09:30:35 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:35882 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbcHONaf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 09:30:35 -0400
Received: by mail-it0-f44.google.com with SMTP id e63so6736882ith.1
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 06:30:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qnrePij99Dj4DH3llemC3dcAx1GA6AvcRbftLHM5QHg=;
        b=M1YcrvC7kQ1wN1Gz7PjbFZI0zFTs5XOaFjLckvKjLim4vdIe1zDKu3YIZOSdF12RaB
         /wKbQP6pjAJaoXUK2G+j7TgBUWZyrHT5Ld4+dxM18U8l81MRV1KvKwtVdE3UfgHWVG91
         MPcWrx7fdiF0O4wbbhlPW4trdMrPK6po9hqV4OKqsJhTBBjFsCjtiIG7Zh6FT0POVi0q
         3dN0B8y9WV1ZivDAIeCCXJuFwJ/0T76EouZFRYbnqtGXsSGKQnQ2A5bjlklPBompCIWw
         0Xlht0E7GHdKncT+87mO+I2EoYtIAZlrBrm68TwwAnGvAR0Qpa7L5DnYUWG65PfILqoB
         Kt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qnrePij99Dj4DH3llemC3dcAx1GA6AvcRbftLHM5QHg=;
        b=G9r6C5nzSFfC/NhqyqaxsLmXn2aip4U2d7WATyTYTl9FSzxoMypymjUWmQNMbsoo9Z
         lSNqtHiPlWkZ1NH5nRQWfDDLL7uBUM9km8in0UZciZa41+WldoXz6GoAal3EfO6jBUX3
         k594GbVq7OGDRvHLyC/6Spesa/WOkytN9/+86/a0v2ZhxaK5pSmZslM+r1HxSoHaWQDu
         MxA8AuUjrW4sgvoAROes/XNbnzQX5TWSupf/9Yfy9xrEWnmeDElzq6Ipr+RYwjZK2alY
         3qrAKJLiCMpdmDHc+RCtUbirf7T1EgdXLJvgJw3BP5+LszLavmuuXaMi1OTfIG4GA5PT
         Zvng==
X-Gm-Message-State: AEkooutWxaEK/1Hjm++XliAPB7TUetJrOI1XZjfNUMJZXAg5JHI/eBHIUH2MMSDgKWuUEvsZclCcQW/eP11TSQ==
X-Received: by 10.36.91.134 with SMTP id g128mr14214962itb.42.1471267834019;
 Mon, 15 Aug 2016 06:30:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Mon, 15 Aug 2016 06:30:03 -0700 (PDT)
In-Reply-To: <DD86BC6E2E3245BA991E4D65CE66E4A8@PhilipOakley>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
 <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
 <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com>
 <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com>
 <CACsJy8BdmR5USJvjJ6xbjj=bP787tdS72_oL+PDq0D+FPYmiPA@mail.gmail.com> <DD86BC6E2E3245BA991E4D65CE66E4A8@PhilipOakley>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 15 Aug 2016 20:30:03 +0700
Message-ID: <CACsJy8DWDEQOKLV+c1zCXhiHZbxF3iM9_rFWhju3hk=Ji1i3ZQ@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	Philip Oakley <philipoakley@iee.org>
Cc:	Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 7:37 PM, Philip Oakley <philipoakley@iee.org> wrote:
> I appreciate there has been a lot of discussion, but it mainly appears to be
> about an upstream / integration viewpoint.
>
> I'd hate it if there was a one size fits all solution that was only focused
> on one important use case, rather than having at least a simple fallback for
> simple folk.
>
> Personally I liked the idea that I could start my patch series branch with a
> simple 'empty' commit with a commit message that read "cover! <subject of
> the series>" and continue with the cover letter. It's essentially the same
> as the fixup! and squash! idea (more the latter - it's squash! without a
> predecessor). For moderate size series a simple 'git rebase master..' is
> sufficient to see the whole series and decide which need editing, rewording,
> swapping, checking the fixups, etc.

I think you hit the jackpot (or are getting very close). This removes
the special status of "the commit at the tip of the branch" cover
letter. Maybe I just like it so much I have a hard time finding
anything wrong with it :)

> Format-patch would then be taught to spot that the first commit in the
> series is "cover! <subject>" and create the usual 0/N cover letter. Git Gui
> may need to be taught to recognise cover! (haven't checked if it recognises
> an empty commit squash!). Possibly 'git commit' may want a --cover option to
> massage the commit message and add --allow-empty, but that's finesse.
>
> I've no problem with more extensive methods for those preparing very big
> patch series, or with those needing to merge together a lot of series and
> want to keep the cover letters, but ensuring that a simple flow is possible
> should still be there.
-- 
Duy
