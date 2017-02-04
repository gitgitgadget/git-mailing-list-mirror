Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A4851FAF4
	for <e@80x24.org>; Sat,  4 Feb 2017 11:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754050AbdBDLtr (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 06:49:47 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:34050 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753923AbdBDLtq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 06:49:46 -0500
Received: by mail-ot0-f170.google.com with SMTP id f9so32780371otd.1
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 03:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d0jVFyv88Mr6zSCX8G2S0b6EHOoBbsdi/4xxVzEfrKw=;
        b=jbQM4RMCTxZ/UfWTz0mQTSJjT1ZPzv5yh7QhH9aQxUe47FE5PAaHxG8aNZbzh3xLP2
         xXOykKYvkGFqLlzxqTCFdgwC83EfjSdhaTbpFUyYW++yW3pCIF9QJhO1X3K6AJGCNHqB
         bVe7h+7Hplvuv/BblmuGMVm5XdNqKH59cvkBCr6n0r6P8cXRZZDWOiTOwMeGT2MlT4yr
         OyLL9yU4dZesshM/rjcp+323evHZxmBFrTMQKjA7T54ax0l7NagEzfFQjc0Knb+FMew8
         GMhwZqgUIq201DRjG/QAx9xA3rxNrM3TijjBBnoMzWvoNLbGDY7RMLGuy3iQU3Id+6Fr
         xw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d0jVFyv88Mr6zSCX8G2S0b6EHOoBbsdi/4xxVzEfrKw=;
        b=QRZsqDVmOTRjZFwGc2xvsIPqyNeGbCigOX5odhHiLQhYP2lwGdjIqWZ4Qq13EAfrjg
         8+MtHSI8qXfjHLgI4zj/SO9wnt+i+WY0QrFHHXGgxhhrTGH4TM52YGHTDyFl9eQar3Kd
         A5xbcE6VQ4HVeezD65Zv20cyXEen/corjpcWsNwtKCm/Q0JFnitsURPiFvNwUF59cCsb
         dkeiyQR4ZRC5uph41oALz8EIsDeyL4Fnt7zdEWZ2/LjRC5MNto3gphXfihF4dDKMXF4/
         RJm/TKSEUh8LPaAl+wWVh7fSa5FCfqB0APjZiedsUqikKH7CvtPEZ6nVf5/y95VfiSz8
         kgaA==
X-Gm-Message-State: AIkVDXIUB/j4GHu2e9/HEsYVs+McjFTA3jNvChSOyvFLw5/nXKUMdRiSskmoBr332aPN2Apiqe/ucDdMM+/zww==
X-Received: by 10.157.37.54 with SMTP id k51mr712491otb.271.1486208985794;
 Sat, 04 Feb 2017 03:49:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Sat, 4 Feb 2017 03:49:15 -0800 (PST)
In-Reply-To: <CAE1pOi3ThTLSp_0ZJHto4p75Ds5NMGymHrD0ju9axCqA1+NkMA@mail.gmail.com>
References: <CAE1pOi0-8JnnZbdm9vu1RwTU1mXr7dboLC3ito3LcvK9gkNi_A@mail.gmail.com>
 <CACsJy8DjqrEZ=VaZo6bn4i2r=Wr8k4ExYv48N-rDvfPO=hqpLA@mail.gmail.com> <CAE1pOi3ThTLSp_0ZJHto4p75Ds5NMGymHrD0ju9axCqA1+NkMA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 4 Feb 2017 18:49:15 +0700
Message-ID: <CACsJy8B3VULFCLyRf9Poeu7UnnZggGyV05-_4LiOO6pHjA++BA@mail.gmail.com>
Subject: Re: How to use git show's "%<(<N>[,trunc|ltrunc|mtrunc])"?
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 4, 2017 at 12:10 AM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
>>> How do I get "2017-01-31T17:02:13 | Hilco Wijbenga" to be output?
>>
>> You'll get an ellipsis at the end though.. (i.e. 02:13... | Hilco)
>
> Indeed, that's not very nice. I suppose I can understand the reason
> for it but it mostly defeats the purpose of "trunc", doesn't it?

It depends. When you truncate a commit subject line, you may want an
indicator that you're not seeing the whole line. For fixed fields like
dates when you expect every string to be truncated, then yes there's
not much point to show the ellipsis.
-- 
Duy
