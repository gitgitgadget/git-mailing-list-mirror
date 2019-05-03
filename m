Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87AE51F453
	for <e@80x24.org>; Fri,  3 May 2019 15:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfECPDI (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 11:03:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46508 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfECPDI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 11:03:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so8221964wrr.13
        for <git@vger.kernel.org>; Fri, 03 May 2019 08:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=woHRzf4zT5SqQTrptJKzoFJLG8FJOSWOlyX2fw0QqsI=;
        b=Cg+74A5v8nqEgD7UH8bQqFn4X1Btu8zTUnR07ucT2BuJmuxLnYikH0V5YT0wzxitT2
         gHfA/Ou3bIPT4q+DFKfULi5K5G1ODzAA3zjhsuodI3SbU/JYemYMu5SieeWJ3Wxbbc0L
         9dI3ZmxFS61/6ctqVB22/8m5XFCnDJgWnSo/eTgZToi4B7jGlREqlUISbQE7UzT2Gs0i
         XsY1M5mFBxISXTBfzoV1js7aSz+ATd29QKGGrjUtSoawCy7dY9VuoJBuXSOZ+01kl9Z2
         3H23TyrUjDZRGsHfGEl7R5h5GkzUXKk7xPyySTVLZdrUxYlqmMRTPf7vGGJ3dr0MoY/P
         EwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=woHRzf4zT5SqQTrptJKzoFJLG8FJOSWOlyX2fw0QqsI=;
        b=sES8ypKguH2Fn9OMR/Arg0j7LPwVul27B7izfeWrbDi+NOANsK3G3ZZMb81O4w8Wr1
         phvdpf6L4oxgBpsSAewt/9UsPdBPkq3GRPFyoq9bMOw5e/GvnWz85azRZeOZnSSezaFi
         +cFCGtrHqm9xNDgfxteQZEf0t6TNyVp9x2EvgVRPNzJIyZbvx1y326mpknqp/+GAep+f
         3sJmzkQRnMHQZ2xjH6WUrp+s9mYvOzu8RAimRoY02NC8jtH3YPA3ZZjuYGCkBeQTnZJ4
         QQPL2cmrgZCxFCqWY+AHipW/0pSUYD18skwBiMS44YXOtQlfEbMe79LWzaWMaDrBZIey
         1IkQ==
X-Gm-Message-State: APjAAAVXelahErrWYCwyR0X0duoPEPtuKFpngcZkwiq8khCkHyrNveIv
        BPTYaKpfY6/PfktsQ7HwyLA=
X-Google-Smtp-Source: APXvYqwf2FfxyRQhwH4vIJ9ZEo0dBpV9qOwGVUXCr9VgKiKlTNfHSWU5y7Q6jI1VGYyupTspRkhDYA==
X-Received: by 2002:adf:e703:: with SMTP id c3mr6804539wrm.98.1556895482643;
        Fri, 03 May 2019 07:58:02 -0700 (PDT)
Received: from szeder.dev (x4db507c5.dyn.telefonica.de. [77.181.7.197])
        by smtp.gmail.com with ESMTPSA id b10sm4179179wme.25.2019.05.03.07.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 07:58:02 -0700 (PDT)
Date:   Fri, 3 May 2019 16:58:00 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
Message-ID: <20190503145800.GI14763@szeder.dev>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1555487380.git.liu.denton@gmail.com>
 <20190422214901.GA14528@sigill.intra.peff.net>
 <20190425120758.GD8695@szeder.dev>
 <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
 <20190501100108.GA8954@archbookpro.localdomain>
 <20190502000422.GF14763@szeder.dev>
 <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
 <20190503144211.GH14763@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190503144211.GH14763@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 03, 2019 at 04:42:11PM +0200, SZEDER Gábor wrote:
> > Since you *could* include it, I now assume that Coccinelle does not need
> > to follow the `#include`s (otherwise, it would have complained about not
> > finding the `windows.h` header in your setup).

> I don't really know what can cause 'spatch' to error out (besides
> unknown command line option or non-existing file specified on the
> command line), and this is all that 'man spatch' has to say:
> 
>        --all-includes
>               causes all available include files to be used
> 
> Since it explicitly mentions _available_ include files, I would
> venture to guess that non-available include files are not used, and
> since it doesn't explicitly mention that such a file causes an error,
> it doesn't.

Actually, we record Coccinelle's output to stderr in a logfile, and
with the Windows-specific source files included it contains thing
like:

  HANDLING: compat/mingw.c
  (ONCE) TYPE: header conio.h not found
  (ONCE) TYPE: header wchar.h not found
  diff =
  init_defs_builtins: /usr/lib/coccinelle/standard.h
  HANDLING: compat/winansi.c
  (ONCE) TYPE: header wingdi.h not found
  (ONCE) TYPE: header winreg.h not found
  (ONCE) TYPE: header winternl.h not found
  (ONCE) TYPE: header ntstatus.h not found

So it seems that these missing headers are just ignored, only their
absence is noted on stderr.


(And just for the record, that log also contained these:

  HANDLING: http-push.c
  (ONCE) TYPE: header xmlparse.h not found
  (ONCE) TYPE: header expat.h not found

  HANDLING: xdiff/xutils.c
  (ONCE) TYPE: header limits.h not found
  (ONCE) TYPE: header assert.h not found

which means that even on an avarage Linux box there might be missing
include files.  This also raises the question whether Coccinelle looks
for things to transform in system headers as well (and what if it
finds something there)).

