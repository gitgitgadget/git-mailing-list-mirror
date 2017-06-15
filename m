Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ABDC20401
	for <e@80x24.org>; Thu, 15 Jun 2017 22:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbdFOWAV (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 18:00:21 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:34670 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbdFOWAU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 18:00:20 -0400
Received: by mail-yb0-f175.google.com with SMTP id e201so3947177ybb.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jF1Mvk2b0Kma8ijpiRRr/UZvmncLz+4EuPX+k75P/IE=;
        b=pK3EcWvPntMNNQtt54YlsIvH7dDH3jqaV917Xv6aHGxFABW05BhFluVb/wmOhWcPMz
         N+6CUIGTY2I8RyD/hJy3PDF2qjFkl2IHMP8NpGtkLkVf2TkAgk3c6TXpWPgkJl2hvWyD
         Qwi/5WumqkL95PKJwBrVUoLk0B06pXirN/v+dyLs73Dh1SDnSgobECe+J9JtASc3jwvn
         6k3zZLso8vbRvd2wOOqXtSrmF4jIP3KNSi79fUb6WPxmlMvFl4IufT+WICo64ez7Gl9c
         57eADlMfEsneNQDkZLcY9U7Ghe1j353lBcrbg4wGi7NVlBC/GAeFiQ3fVf4AvLO/8rCR
         1Sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jF1Mvk2b0Kma8ijpiRRr/UZvmncLz+4EuPX+k75P/IE=;
        b=rY1FQ1SRGofX11hjuXUXYhQYFt5RBm86zpXKMnIxkh6wXPmUyI/QHaaG9eBGspO/Ay
         Ijzf61Wlec30ZeCZa5KbAem3vqS2BM2IUy+puTSV2U5V0gpfO9IUnQnx+e5fbI46xFZP
         nRrFBE9cZGFge042nlf2zS4T4l7aQ1QulsYoibZyQUZ+FY2GCV1VkVjyZtcQH6JhSl3I
         JJTMKaQOoOjECXmVW00DtX1L3QFkZ8qkZGlJGFXXfqvy9qQHK/XwYdgDSgM0JsAxIeyz
         70xPhur4oJnH+vGJMxB+sghx92B9piweTB3kLnWkhib5vYU3Tji2nKIm7Wrweru0BZN7
         7uMw==
X-Gm-Message-State: AKS2vOxAY1WipM7xuUdr3pC3+fTasXS9EtQlgkgf5K1e1vZSRpVI3P4d
        5NUD5K1pc6P9z8RKMB4rBKyZ9Sgx7AGZ
X-Received: by 10.37.188.68 with SMTP id d4mr5874002ybk.187.1497564018357;
 Thu, 15 Jun 2017 15:00:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.59.65 with HTTP; Thu, 15 Jun 2017 14:59:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1706152123060.4200@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
 <20170306182423.GB183239@google.com> <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
 <20170615110518.ordr43idf2jluips@glandium.org> <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net>
 <87shj1ciy8.fsf@gmail.com> <alpine.DEB.2.21.1.1706152123060.4200@virtualbox>
From:   Adam Langley <agl@google.com>
Date:   Thu, 15 Jun 2017 14:59:57 -0700
Message-ID: <CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(I was asked to comment a few points in public by Jonathan.)

I think this group can safely assume that SHA-256, SHA-512, BLAKE2,
K12, etc are all secure to the extent that I don't believe that making
comparisons between them on that axis is meaningful. Thus I think the
question is primarily concerned with performance and implementation
availability.

I think any of the above would be reasonable choices. I don't believe
that length-extension is a concern here.

SHA-512/256 will be faster than SHA-256 on 64-bit systems in software.
The graph at https://blake2.net/ suggests a 50% speedup on Skylake. On
my Ivy Bridge system, it's about 20%.

(SHA-512/256 does not enjoy the same availability in common libraries however.)

Both Intel and ARM have SHA-256 instructions defined. I've not seen
good benchmarks of them yet, but they will make SHA-256 faster than
SHA-512 when available. However, it's very possible that something
like BLAKE2bp will still be faster. Of course, BLAKE2bp does not enjoy
the ubiquity of SHA-256, but nor do you have to wait years for the CPU
population to advance for high performance.

So, overall, none of these choices should obviously be excluded. The
considerations at this point are not cryptographic and the tradeoff
between implementation ease and performance is one that the git
community would have to make.


Cheers

AGL
