Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A1B1F424
	for <e@80x24.org>; Sat, 31 Mar 2018 08:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeCaIuk (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 04:50:40 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:32893 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbeCaIuj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 04:50:39 -0400
Received: by mail-wr0-f182.google.com with SMTP id z73so9607290wrb.0
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 01:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinogroup-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2zHYQ0gDvIprnLbt5aQhYlKDdHanpVuGv/lRzhUozJQ=;
        b=I0BHKOL8UItGDp1oYdaq5A3qSDXq9u4iybVsx2kq1h1LyNoPm+YQsvSbNgbgjKxGLR
         UYQaC0Q9o7LT0H7ducn0MSMuqkL8mCQqaexvXnqyHxMXoDL4SE5/LY63ALzu7yqDxTb5
         kM64vKj25fdVGDsRYe+LqTbSUYW9gQYFviWtLwqj7K8W8BKZhO4UwABn0tn4xCcTccjP
         HvObmr1/DR1iK1SuEAzOzXci9Jz2WLOHIK/WPw3mxQSj13Hm58Ggd2T4UGLG1j1U1Yoe
         gDs2rruCt7x2MoTFgjb/qpJKgHeQ7689t/dOu0UTlfI2hzS6A0n6H7qrJJA4eMn5TwrP
         6ZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2zHYQ0gDvIprnLbt5aQhYlKDdHanpVuGv/lRzhUozJQ=;
        b=PBIe4B6umAtRDGogw63bX5QFPcTWrRMNCkSo3kF/dCNsBrQ6JWgzA/d+DG8NxDmbwS
         iDYubdvFw7BVlxU/gQ5oLmaP9GIFCSDsoRQRnmLElgDHfvle24z9hlYzkilpYWiBmRMJ
         DgwuurYK1qHOjr53p4gnqY/x1szzhG+sNMNXlKrTIeA73M/vVlUIsCb667uvVte2gZcX
         7x3bq8mzP9PhlhsFbCl6hFKIXMIBZRT+4hW2wKS05hEzrIuzmNuSsdhnrS8QlY1p8mDU
         8X1U49uBJI99qhfN9uqSUOjbGHL4v0ZFXK61mGWgDn8LVSHIOIjqX4UcowBqD1UkkY2Q
         Lp0w==
X-Gm-Message-State: AElRT7F8leizisCpkZEacpx+189TlK4b+pldmJyitBc55p/XQPXmmAde
        4cXIBYofWQ14CWirGSGVWzYoUU+tqFWsWhbmXq27rpxLw8VudOWeQQI/3bbqnuFSGnknJAcnYpi
        Ib1D+vdcJ0ipy0Mfa0KCu5Nzsb7+pGqy+hw9I2V53ed1U8Ub2F/DDnyN1ReSclcDOmxTJ3HYZ8d
        7+nbkzUSzsz8S6XSNyh8D8yTSbs4VPuAFkBtsu
X-Google-Smtp-Source: AIpwx49TGn5e0U/QTJs0gLN3wDdtcXxVFJGPEyYKiCDHKrLsvPQxyD8Frtpmd5N3KAwaQMZ/6aRAgZTdhPPtLqcI6y4=
X-Received: by 10.223.209.143 with SMTP id h15mr1333352wri.208.1522486237971;
 Sat, 31 Mar 2018 01:50:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.177.220 with HTTP; Sat, 31 Mar 2018 01:50:17 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1803301102430.5026@qfpub.tvgsbejvaqbjf.bet>
References: <CAO+-ZX_-COVpzqoAZLRGu4mvLMkLYiR3y7rkCtwmnvJ8kA7txQ@mail.gmail.com>
 <xmqq370wvugk.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803301102430.5026@qfpub.tvgsbejvaqbjf.bet>
From:   Luciano Joublanc <ljoublanc@dinogroup.eu>
Date:   Sat, 31 Mar 2018 09:50:17 +0100
Message-ID: <CAO+-ZX-DvjsOnpvfPuLkx2w2cR5FDb6Ww8xEyuZHMmC57=b2yQ@mail.gmail.com>
Subject: Re: Bad refspec messes up bundle.
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

With such a comprehensive reply, I would feel guilty not making a
contribution now :) Be forewarned though, It's been about ten years
since I wrote anything in `C`!

I've cloned the `maint` branch, built the project, and added the test
as you suggested - it's failing as expected.

I'm somewhat confused though. I think it's m limited understanding of
'ref' and 'commit'.

On 30 March 2018 at 11:20, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
>
>   However, this would be incorrect, as the flags are stored with the
>   *commit*, not with the ref. So if two refs point to the same commit,
>   that new code would skip the second one by mistake!


Isn't that the point here? to deduplicate commits?  My limited
understanding is that at a 'ref' is like an alias or pointer to a
commit.

>
>   By the way, this makes me think that there is another very real bug in
>   the bundle code, in the part I showed above. Suppose you have a `master`
>   and a `next` ref, and both point at the same commit, then you would want
>   `git bundle create next.bundle master..next` to list `next`, don't you
>   think?


Doesn't this contradict what you just said, that we don't want to skip
refs with the same commit #?

In fact, if you look in the calling function, there is a
`    object_array_remove_duplicates(&revs.pending);`
Which to the best of my understanding removes duplicate refs (not
commits). However, I suspect this doesn't cover the `--all` case as
it's a switch rather than a revspec? Would that be right?

>
>
> - most likely, the best way to avoid duplicate refs entries is to use the
>   actual ref name and put it into a hash set. Luckily, we do have code
>   for this, and examples how to use it, too. See e.g. fc65b00da7e
>   (merge-recursive: change current file dir string_lists to hashmap,
>   2017-09-07). So you would define something like
>

Separately, if I do end up including the hashmap code, it should be
refactored out into it's own file, right?

Thanks again,

Luciano

-- 
This message is intended only for the personal and confidential use of the 
designated recipient(s) named above.  If you are not the intended recipient 
of this message you are hereby notified that any review, dissemination, 
distribution or copying of this message is strictly prohibited.  This 
communication is for information purposes only and should not be regarded 
as an offer to sell or as a solicitation of an offer to buy any financial 
product, an official confirmation of any transaction, or as an official 
statement of the Dinosaur Group.  Email transmission cannot be guaranteed 
to be secure or error-free.  Therefore, we do not represent that this 
information is complete or accurate and it should not be relied upon as 
such.  All information is subject to change without notice.
