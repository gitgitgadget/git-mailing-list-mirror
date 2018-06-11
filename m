Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A3191F403
	for <e@80x24.org>; Mon, 11 Jun 2018 19:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754049AbeFKT3q (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 15:29:46 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44581 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbeFKT3p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 15:29:45 -0400
Received: by mail-pl0-f67.google.com with SMTP id z9-v6so12891476plk.11
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 12:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uPcTFhW+BmEcTh4tvWXimeYLVhjFFvRSRNxNkaFr9/I=;
        b=RtA8mQ8KoOEL8Ggl3OHw0pNhAvRvSOAXNXD09zm9mwlgIr4hGtW1UlFhr/99nBahn4
         2+YGlhMkz3thgNyj6K1xnnq1Bi+TlhNSvI19anJAJl3KA6wOV4tumY/l5NzQ9602iXP2
         ZgR7oYfDV5fvW8gvLHzWplhiFy3b08CcGqeXWkWldoV7XRSKmvr06f3T2cdeX9ayH8Zr
         8IAhzZC42uwxc83tkEBSsrbxkqLqrLBxFU+AVi75+Tit6accIj+U3c9q6DqcRQY8pafE
         Nh4hPbNuuMCOc8w+N97lInO8ES+cZUZnhi6teIy1r6V+WrHTGsF/Ducpwiz2hgBxIyfB
         ZkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uPcTFhW+BmEcTh4tvWXimeYLVhjFFvRSRNxNkaFr9/I=;
        b=Jl13QDOLx/qiG4NE8seND/fu+CmOsVECLbKwi60UNNrXkCd7+USo5pjdk5vosD2pnV
         5dz2g4tfu2I0+5iRnkhQOKtVG+lNpjA6qVV6QuWj3hsYZFz6LXprLSk06RlGh9zMrtZ1
         6/PFtfg/qKdA2lC8jWxmPq2v/OTYbWqZVOUwZ12IkySWy/KBDtjzhOdIh1n1f5EJdxFz
         Fpa5ob4K0dKtY0QB8nAjplnbr9RAinvsYq7YwX2IS7HCx8j7nCANfsOnhlu692p2M/g2
         0UTWYpDg5l6jSO2pHwWUitSDhnLMdoTMZvpjqA+wM61+8tC2n1KB0qXB8KN2MPZIYR1D
         zk3A==
X-Gm-Message-State: APt69E3XUZMO0AZUPlj5J/bj7/qTPQw+oWHkl/cojIEUR08TOATnU3F6
        7Ewt1Y3jeizfF+GDIeAgP9s=
X-Google-Smtp-Source: ADUXVKIqaubEN136LzqOAUfLZFxzBn+JpOxTO/nwy4IgthlQ9/ylRnjxFJuKTh72rdEQV7QWgmg21g==
X-Received: by 2002:a17:902:5ac8:: with SMTP id g8-v6mr469602plm.221.1528745384703;
        Mon, 11 Jun 2018 12:29:44 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h12-v6sm13568428pfi.114.2018.06.11.12.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 12:29:43 -0700 (PDT)
Date:   Mon, 11 Jun 2018 12:29:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>,
        The Keccak Team <keccak@noekeon.org>
Subject: Re: Hash algorithm analysis
Message-ID: <20180611192942.GC20665@aiede.svl.corp.google.com>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180609224913.GC38834@genre.crustytoothpaste.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:

> == Discussion of Candidates
>
> I've implemented and tested the following algorithms, all of which are
> 256-bit (in alphabetical order):

Thanks for this.  Where can I read your code?

[...]
> I also rejected some other candidates.  I couldn't find any reference or
> implementation of SHA256×16, so I didn't implement it.

Reference: https://eprint.iacr.org/2012/476.pdf

If consensus turns toward it being the right hash function to use,
then we can pursue finding or writing a good high-quality
implementation.  But I tend to suspect that the lack of wide
implementation availability is a reason to avoid it unless we find
SHA-256 to be too slow.

[...]
> * BLAKE2bp, as implemented in libb2, uses OpenMP (and therefore
>   multithreading) by default.  It was no longer possible to run the
>   testsuite with -j3 on my laptop in this configuration.

My understanding is that BLAKE2bp is better able to make use of simd
instructions than BLAKE2b.  Is there a way to configure libb2 to take
advantage of that without multithreading?

E.g. https://github.com/sneves/blake2-avx2 looks promising for that.

[...]
> |===
> | Implementation             | 256 B  | 1 KiB  | 8 KiB  | 16 KiB |
> | SHA-1 (OpenSSL)            | 513963 | 685966 | 748993 | 754270 |
> | BLAKE2b (libb2)            | 488123 | 552839 | 576246 | 579292 |
> | SHA-512/256 (OpenSSL)      | 181177 | 349002 | 499113 | 495169 |
> | BLAKE2bp (libb2)           | 139891 | 344786 | 488390 | 522575 |
> | SHA-256 (OpenSSL)          | 264276 | 333560 | 357830 | 355761 |
> | KangarooTwelve             | 239305 | 307300 | 355257 | 364261 |
> | SHAKE128 (OpenSSL)         | 154775 | 253344 | 337811 | 346732 |
> | SHA3-256 (OpenSSL)         | 128597 | 185381 | 198931 | 207365 |
> | BLAKE2bp (libb2; threaded) |  12223 |  49306 | 132833 | 179616 |
> |===

That's a bit surprising, since my impression (e.g. in the SUPERCOP
benchmarks you cite) is that there are secure hash functions that
allow comparable or even faster performance than SHA-1 with large
inputs on a single core.  In Git we also care about performance with
small inputs, creating a bit of a trade-off.

More on the subject of blake2b vs blake2bp:

- blake2b is faster for small inputs (under 1k, say). If this is
  important then we could set a threshold, e.g. 512 bytes, for
  swtiching to blake2bp.

- blake2b is supported in OpenSSL and likely to get x86-optimized
  versions in the future. blake2bp is not in OpenSSL.

[...]
> == Summary
>
> The algorithms with the greatest implementation availability are
> SHA-256, SHA3-256, BLAKE2b, and SHAKE128.
>
> In terms of command-line availability, BLAKE2b, SHA-256, SHA-512/256,
> and SHA3-256 should be available in the near future on a reasonably
> small Debian, Ubuntu, or Fedora install.
>
> As far as security, the most conservative choices appear to be SHA-256,
> SHA-512/256, and SHA3-256.

SHA-256x16 has the same security properties as SHA-256.  Picking
between those two is a tradeoff between performance and implementation
availability.

My understanding is that all the algorithms we're discussing are
believed to be approximately equivalent in security.  That's a strange
thing to say when e.g. K12 uses fewer rounds than SHA3 of the same
permutation, but it is my understanding nonetheless.  We don't know
yet how these hash algorithms will ultimately break.

My understanding of the discussion so far:

Keccak team encourages us[1] to consider a variant like K12 instead of
SHA3.

AGL explains[2] that the algorithms considered all seem like
reasonable choices and we should decide using factors like
implementation ease and performance.

If we choose a Keccak-based function, AGL also[3] encourages using a
variant like K12 instead of SHA3.

Dscho strongly prefers[4] SHA-256, because of
- wide implementation availability, including in future hardware
- has been widely analyzed
- is fast

Yves Orton and Linus Torvalds prefer[5] SHA3 over SHA2 because of how
it is constructed.

Thanks,
Jonathan

[1] https://public-inbox.org/git/91a34c5b-7844-3db2-cf29-411df5bcf886@noekeon.org/
[2] https://public-inbox.org/git/CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com/
[3] https://www.imperialviolet.org/2017/05/31/skipsha3.html
[4] https://public-inbox.org/git/alpine.DEB.2.21.1.1706151122180.4200@virtualbox/
[5] https://public-inbox.org/git/CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com/
