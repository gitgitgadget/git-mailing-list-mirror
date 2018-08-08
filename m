Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FAA81F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbeHIBDr (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 21:03:47 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:51260 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729884AbeHIBDr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 21:03:47 -0400
Received: by mail-wm0-f53.google.com with SMTP id y2-v6so4367215wma.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=l1fr0FUfB2QEMBZKQJRZP9vM3S1v3pBAF22uPpSwlbI=;
        b=t8EbBZIEvvfOwRE1pxhiswPY+2sGAPLYyf0NGpxlogAoYolFQw1Dg9er9Kj4tMWEnt
         U/sj8jRxDF8YAwaL8ewAMzkvsUFMtUTjXEw1JTP5LJKZOrSwl6PFf2qeEPrq4+NPQfqR
         hqVoyeh3cSsdoBs9W6c4hYzYmd+vNGXFt/5CS8Iab8BtTl6z94culQ9KxsjhhbZGr6De
         Oskv2aYtAwvJYbjD/bEsrmlFO7VC0GD8Rp+DPjGPQu//aEJJlme6EBfeIZcMWTtN4kbm
         GNpWaPhrMiVuIt0VlcOZoXYesldjhC/IkLojU2/f4j/XjkCb/Caq1KqoZx3Bwht0vFrm
         dymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=l1fr0FUfB2QEMBZKQJRZP9vM3S1v3pBAF22uPpSwlbI=;
        b=pk8XhENeyr03YTrWNCqGsxrzPYY4hZ6/vn2cXBgEx0hBlueDqVjLds148gi4pTHPLv
         rqyhVzaZjpDZD5P6/37jiP40fcpfm+fPqzX5/fwMES+lcWF5b794qzH3ybLjIziY2iCR
         YJK/BO0Hz2EN2un53Q4mZBsD9b/qnNrXnwRxhW2KK4o9RIbp8sT/N2ClZl5S8dGstRY0
         ZyMiY4pISczFrigYcwDxFm/Cnj/NaSFgI8yJneYS3Lf8pegYgmziDMadiJw0t3+465fs
         4E3dfNtEaBE2clHx5PVpw9Pwt8c3/MRMQz7XSRj/n7mZQBN+ohdNFtZE8D/plVm8Qq80
         HPdA==
X-Gm-Message-State: AOUpUlGm/XewkT0frVYhRIDoVMR71OdgkS2dxTh+4vo3cTABEfx0Bjwa
        rOK4L8uoxIuqFamADUglc10=
X-Google-Smtp-Source: AA+uWPwPYlqMdX5HBEddEPejqZipdRMC+A4evJyjbocMYlzo9vplS3BD7wRE/tGetPyCUMvw1grK5A==
X-Received: by 2002:a1c:8c08:: with SMTP id o8-v6mr32179wmd.60.1533768119253;
        Wed, 08 Aug 2018 15:41:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 9-v6sm8036573wrb.48.2018.08.08.15.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 15:41:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #02; Mon, 6)
References: <xmqqtvo7m8c0.fsf@gitster-ct.c.googlers.com>
        <87tvo6snll.fsf@evledraar.gmail.com>
        <xmqqa7pymdks.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 08 Aug 2018 15:41:57 -0700
In-Reply-To: <xmqqa7pymdks.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 07 Aug 2018 07:54:59 -0700")
Message-ID: <xmqqftzoeb0q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Hmph, it came from this message (most headers omitted)
>
>     To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
>     Message-ID: <20180804085247.GE55869@aiede.svl.corp.google.com>
>     Content-Type: text/plain; charset=iso-8859-1
>     Content-Disposition: inline
>     Content-Transfer-Encoding: 8bit
>
>     Subject: doc hash-function-transition: pick SHA-256 as NewHash
>
>     ...
>
>     Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>
> and the body seems to be correct iso-8859-1.  "od -cx" tells me that
> the file stores 0xf0 for that D looking thing, for example.  Could it
> be mailinfo that screws up, I wonder.  A quick check with "git mailinfo"
> does not give me anything suspicous---the info contents emitted to
> its standard output is correctly converted to UTF-8.  Puzzled...
>
> I read from public-inbox/git over nntp, if that matters.

Just to close the loop, this turned out to be caused by my use of
Gnus/Emacs.

You can stop reading if you are not interested in reading and applying
patches from inside Gnus.

I am used to type '|' (gnus-summary-pipe-output) to pipe the current
article into "git am -s[c3]", and it works fine when the payload is
UTF-8.  But the command decodes, and strips certain e-mail headers,
before feeding it to the command.

While the payload is converted to UTF-8 (presumably because that is
what I use by default), "Content-type" is *not* among the e-mail
headers that are stripped, so "am" ends up seeing UTF-8 bytestream
that (still) claims to be "iso-8859-1" when processing the above
message.

I need to get used to typing M-i r | (that is, to use the 'r'
"symbolic prefix") to force the message piped as-is to the command.

Again, thanks for noticing and giving me a chance to correct the
result before it got too late.
