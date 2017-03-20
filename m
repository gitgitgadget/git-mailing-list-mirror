Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64422095D
	for <e@80x24.org>; Mon, 20 Mar 2017 08:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753186AbdCTIF2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 04:05:28 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34472 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753184AbdCTIFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 04:05:25 -0400
Received: by mail-lf0-f48.google.com with SMTP id z15so52091356lfd.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 01:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZYNLWEGkCvRfj8ByatR5PDzvI04V6wmSB57wPH2PcB4=;
        b=TaBjKiCCA/o49qzDmzrdZb1Fk3vBBMPJXTYAXpHjodDgLnetRBbSlc32Aj4fTFBm8O
         Qiu29zs3i9/o/OqfB/JFw8F5IXrrJuFOyD28GDFXrDFHJj0nzgmt1krXDiBW1sTOZlnF
         ouCrsUJjnfdO11pq1ZZ4jQIRxEXoY/KXRwnkR0O2AZQYM1GKC8aI9KGbRRTmftrMasHX
         6nS+AdNs8T04CGTiY6BubK52GeLREdv3JOx7ODelR4Rr8aNNLejoDTwC5bjIYcIKN+c9
         PVQEGvlSRxhl2zBS39isgfaThnYZHR0DfVRWj3Xj4g8ZAzsEOySy/dEKk8lFRIKRDvP2
         sLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZYNLWEGkCvRfj8ByatR5PDzvI04V6wmSB57wPH2PcB4=;
        b=Dt+ayUhY/sQrTu8lUxDii7tPE1CWarMnoj03Klu1Bu8k4YD/YOUE8/o4RH+5m4/D+y
         h20Wo8a7mIgaTwe2qs9tHDl1TeOwy5wcorEox3r7aA1rF7qgkzqV9FcwURtoR5z1jh8Y
         7hALtaTZnJx5EPbi4QVDUstYih0CLlfs8zGTs1Qh/sHD7JEhT5yHP/qSYTXT5t+IsLSM
         QfvkUVOpv//mUdiZiPoEYJsHyJgEC26yJ0aaUem1ssQeHnGc3KrOX4xz0nPKeD/aQbXV
         T5CGChLJRINBs/w+PvidiK3XA6MRAAEI3Ej7QnF5QtyLQ5vWXKftkRzboCS9Cn9YbHSw
         UmoA==
X-Gm-Message-State: AFeK/H3Z30Q19RhhJ4L3B5+UDSQld5R0m4FCCY2Te/OnahZVlJm1L2OgYQ5lRBH8tU0YeS06HRlv82R7qBcHgQ==
X-Received: by 10.46.5.2 with SMTP id 2mr9154087ljf.34.1489997123212; Mon, 20
 Mar 2017 01:05:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Mon, 20 Mar 2017 01:05:02 -0700 (PDT)
In-Reply-To: <1c213acb-1deb-8959-b1f8-28f99974640f@constrainttec.com>
References: <alpine.DEB.2.20.1703081638010.3767@virtualbox>
 <27077870-76d9-b45a-5727-c339a3d0ffc8@bu.edu> <1c213acb-1deb-8959-b1f8-28f99974640f@constrainttec.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 20 Mar 2017 01:05:02 -0700
Message-ID: <CA+P7+xoCsO=LFw1aSQugmvZz+kjhNXT+Ffwa3DjDUPOdpobzAg@mail.gmail.com>
Subject: Re: Use base32?
To:     Michael Steuer <Michael.Steuer@constrainttec.com>
Cc:     Jason Hennessey <henn@bu.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Git mailing list <git@vger.kernel.org>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 10:58 PM, Michael Steuer
<Michael.Steuer@constrainttec.com> wrote:
>
> On 20/03/2017 16:21, Jason Hennessey wrote:
>>
>> On Wed, 8 Mar 2017, Johannes Schindelin wrote:
>>>>
>>>> Linus Torvalds writes ("Re: RFC: Another proposed hash function
>>>> transition plan"): > > Of course, having written that, I now realize how it
>>>> would cause
>>>>>
>>>>> problems for the usual shit-for-brains case-insensitive
>>>
>>> filesystems. > > So I guess base64 encoding doesn't work well for that
>>> reason.
>>> Given that the idea was to encode the new hash in base64 or base85, we
>>> *are* talking about an encoding. In that respect, yes, it can be whatever
>>> encoding we like, and Linus just made a good point (with unnecessary foul
>>> language) of explaining why base64/base85 is not that encoding.
>>
>> Since the hash format is switching anyway, how about using base32
>> instead of hex?
>>
>> Still get a 20% space savings over hex (minus a little for padding), and
>> it's guaranteed to be a single case.
>> Jason
>>
>
> If base32 is being considered, I'd suggest the "base32hex" variant, which
> uses the same amount of space.

I don't see the benefit of adding characters like 0 and 1 which
conflict with some of the letters? Since there's no need for a human
to decode the base32 output, it's easier to use the one that's less
likely to get screwed up when typing if that ever happens. It's not
like we actually need to know what value each character represents.
(sure the program does, but the human does not).

Thanks,
Jake
