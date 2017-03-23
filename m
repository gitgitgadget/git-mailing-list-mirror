Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E0820958
	for <e@80x24.org>; Thu, 23 Mar 2017 22:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934719AbdCWWWl (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:22:41 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35936 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934707AbdCWWWj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:22:39 -0400
Received: by mail-io0-f178.google.com with SMTP id l7so6661942ioe.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 15:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ofENuUpMtUwoBg94DFDrU2TA/YyqGNFlM9kPfSXsfaM=;
        b=TzHXN/QIwV4uGPHkf8NGPuMV22PdMPAhBnxOWEO65YXArMh4N2CretYX8OTXORd/b9
         NA7vxH0gbh/DJgb6V1SyvkT4GECv3OLmjpxDHzhrVgug876xTitfoKMj48N41Y4hGsvD
         SVLqGYj6j43WMGrvCqHvzIDY4UHSnY/uEuCt6/dzav2TAqQbzo4v3hLUuMT1CAosvqwP
         TIrdrYqL96Z6zVAHQ53r4J+EoORGN5QeAysO9c9AiOkzoLkOfzgg7m8HtvQOwmdYzaco
         YPN17R0qR1l3HXSi1z0eUwp05Oo8FB2kBfivgLXtFa8wMPCi9Vn+/DIPZ5OojaKC+mVf
         66/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ofENuUpMtUwoBg94DFDrU2TA/YyqGNFlM9kPfSXsfaM=;
        b=X1ZmVi7S1WjIdMpsuc63uWdn20AntP6X4WBF8/r1hSZ9CxOp/Duof6i4hYuSapaz8t
         gDG12tPlme+TMRw36xRW+UfBInaQbWfhQF+WgheqixnWyIoUW/i6NtuQcAaLWmQ30h3U
         rIjJ5VoFQNGsBLwLaSuIOIY4VUprZlNppaEeDkFpADKFuoNpBNQ1SUq0ARiTvndwDqWW
         DEBwIqI25p1l4ZHiUIAISvSDvKBgKBvzN/VTRClPKrvVtbtANFrCiZptez1VzYUGFe3w
         pOfKp6J31QymPLtt6n6XorxNfHWmWudP8KFJ9kIRSJSSZNpA/HX7K6HNfn/vyvNxzr8/
         o9SQ==
X-Gm-Message-State: AFeK/H3koAl+aC4NuPTp2VH+W98AeV2jgOHovSC2FUY/9YBJ9v2gBIWtj9Py/xD5UUINqw==
X-Received: by 10.107.131.156 with SMTP id n28mr5892870ioi.39.1490307752447;
        Thu, 23 Mar 2017 15:22:32 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:6c40:39b9:f9ab:ec6f])
        by smtp.gmail.com with ESMTPSA id i7sm243187ioe.48.2017.03.23.15.22.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 15:22:31 -0700 (PDT)
Date:   Thu, 23 Mar 2017 15:22:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: USE_SHA1DC is broken in pu
Message-ID: <20170323222229.GB20794@aiede.mtv.corp.google.com>
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com>
 <2B1DE627-11C8-4FA5-A354-76B6C475666A@gmail.com>
 <FFC0EFBD-C4D9-4FB8-A45D-7B10689724A1@gmail.com>
 <alpine.DEB.2.20.1703212105030.3767@virtualbox>
 <xmqqh92mo06a.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703221530040.3767@virtualbox>
 <20170322220246.GD26108@aiede.mtv.corp.google.com>
 <alpine.DEB.2.20.1703231724350.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703231724350.3767@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> On Wed, 22 Mar 2017, Jonathan Nieder wrote:
> > Johannes Schindelin wrote:

>>> As to the default of seriously slowing down all SHA-1 computations:
>>> since you made that the default, at compile time, with no way to turn
>>> on the faster computation, this will have a major, negative impact.
>>> Are you really, really sure you want to do that?
>>>
>>> I thought that it was obvious that we would have at least a runtime
>>> option to lessen the load.
>>
>> It's not obvious to me.  I agree that the DC_SHA1 case can be sped up,
>> e.g. by turning off the collision detection for sha1 calculations that
>> are not part of fetching, receiving a push, or running fsck.
>
> And in those cases, using OpenSSL instead is *even* faster.
[...]
> The index is 300MB. If you have to experience a sudden drop in performance
> of `git add`, even by "only" 30%, relative to OpenSSL, it is very
> noticeable. It is painful.
[...]
> It gets even worse when it comes to fetching, let alone cloning.
[...]
> And by "switching collision detection off", I of course refer to *not*
> using SHA1DC's routines at all, but what would have been used originally,
> in Git for Windows' case: (hardware-accelerated) OpenSSL.
>
> Did I manage to clarify the problem?

Yes.  Thank you for explaining.

Sincerely,
Jonathan
