Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83A831F462
	for <e@80x24.org>; Wed, 12 Jun 2019 09:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437655AbfFLJlO (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 05:41:14 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:47038 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437465AbfFLJlN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 05:41:13 -0400
Received: by mail-ed1-f48.google.com with SMTP id d4so1380016edr.13
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 02:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=4D4OCnrJ3vRQkW1zuGTw5WKLelsnsM0fTOkIGnkXXyM=;
        b=nquXAjZMjNvg9ZZKP+f7SKUJzXE9HpHMixA8HuxNE2komcaOpxqj+wTu4jIF0w2Wv1
         3UbambzuLVJEVXsjQOTeKPCAI0VCzHoq3tp+305F1GM5GiowlrSIXC9AigZPVloyP4MB
         Pk8ZggdKiQHV/oCeKYZJ2/CA6eRtGeSUV3mzAsEntuibikj/4qHapPvrIUOe3Yyy1M84
         t3pg3W62/IdTmkwe3g80g75yCEYliG8qEQLu9bon+nYv+wDWCIz1n/OB+CZjWjRRboQf
         pe1fSsw3MQyNXr7o581WSt2MjQtETxN6xIM1rkZzkj6HzIHYMGC/sQR2dMxPwkZAyT5K
         cmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=4D4OCnrJ3vRQkW1zuGTw5WKLelsnsM0fTOkIGnkXXyM=;
        b=aY3aFsVPUCCz3dZwm5Fp/FG3zNAn1XBT9YAroV1nqVnRwWHckgThv21Wt8KX+LMv6L
         894pMpjImMiIZbsfCf3558qL5duAtsOLblHXJNvdK6APoZ6JJmJ6cbnWNqGFeUaGMjTp
         tVC2riuajsfNS49MFQ8eLwmeLVoxSnXRdLRFcIaCF1YDNZ5wnaCTo/WNKNCIgWS+bL6m
         uJX0c39u8Q3KBgOzL+ZBrIxWinmNTF2z9NHOIGqwBZLX/fVpfcBBH36qvizlKfDpSC9O
         Q8IyHssgWKPPBZekpjWDyvghR5JZI/bppNhWl7oH8Fxoe+lDp/MrVLqDHSmEiTiYTa/Z
         3Otw==
X-Gm-Message-State: APjAAAWcoiLMCg3yysPAg8RLVg2YiNYWOgW2SY/TIupOMBL9CCCPfBm1
        LqHwsclqGIxdYZBIl+G1MZ0=
X-Google-Smtp-Source: APXvYqx4tIzdULGnQoQWva73aiTwe/aMY+HV9sszC6hXgWRKSiA0+x3x7JdaLAckfkh0TfbiTW/i5g==
X-Received: by 2002:a17:906:3708:: with SMTP id d8mr19377097ejc.65.1560332471631;
        Wed, 12 Jun 2019 02:41:11 -0700 (PDT)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id o22sm3158242edc.37.2019.06.12.02.41.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 02:41:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elmar Pruesse <p@ucdenver.edu>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Reducing git size by building libgit.so
References: <21f1f334-755e-3283-d0da-ec0ab9231cfc@ucdenver.edu>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <21f1f334-755e-3283-d0da-ec0ab9231cfc@ucdenver.edu>
Date:   Wed, 12 Jun 2019 11:41:10 +0200
Message-ID: <87y32787k9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 11 2019, Elmar Pruesse wrote:

> Hi!
>
> The total compiled size of libexec/git-core is currently somewhere
> around 30 MB. This is largely due to a number of binaries linking
> statically against libgit.a. For some folks, every byte counts. I
> meddled with the Makefile briefly to make it build and use a libgit.so
> instead, which dropped package size down to 5MB.
>
> Are there, beyond the ~20 ms in extra startup time and the slightly
> bigger hassle with DSO locations, reasons for the choice to link statically?

brian mentioned API stability. I'd be fine with having a *.so shipped
with git. We'd document the API non-stability, and of course it's GPL so
you can only link other GPL programs to it, but if people would be fine
with still using it and very closely following git development as we
break their API/ABI why not.

Have you looked at INSTALL_SYMLINKS & friends? I.e. maybe you're
measuring size without accounting for most of the binaries being
hardlinks to the same thing.

We still have some stand-alone binaries, but IIRC there's under 5 of
those with INSTALL_SYMLINKS. We could probably also just make those
built-ins to get the rest of the size benefits.

I.e. we'd just have one git binary, everything else symlinking to that,
and we'd route to the right program by inspecting argv, which we mostly
do already.
