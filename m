Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A57A20D09
	for <e@80x24.org>; Tue,  6 Jun 2017 10:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbdFFKEA (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 06:04:00 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35752 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbdFFKD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 06:03:59 -0400
Received: by mail-wm0-f51.google.com with SMTP id x70so33367195wme.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 03:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lGb+Jo/BiLrSf48U+Ts5m2dRkJaAxzYNZ5vAe95Kd1Q=;
        b=Q/L0LY6IFsIyB9NPzWkH1lT5vXXCslS7+ZEtHWt+P6m6WxWfP2YDgHAeZMKyeht6Lt
         U5KP3cj8t08lFKr/6w+zRoNHKJHR3lsHuJPtznUDAvw1XoQ/5vRL61YaVqkRvXgdQVFy
         mK3OA0/wr3VYScOg0YS/SfMYyDDX3UtpTQlXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lGb+Jo/BiLrSf48U+Ts5m2dRkJaAxzYNZ5vAe95Kd1Q=;
        b=Vg/+u45N2dxFAV6XWW4mIlmIVY5SeW9QxrksY+8tg7jSbktOI43Zdz62wHmPplrkKk
         OH8H9vmB0LcHPplIxSZteqoEQB4yNKNNGxb+gsYv9rNSgbiXXvGxjA1BDUu4up9O2jSd
         TDQDQCLwOw/kFVo/6Mm3vbEUlD4JBu1bL+4ep4eCmi28bO/nJvCQi51OZLIoKVjhTpIv
         0D/Nqrj61o60OeZGAr18gb/DkHsZED0hLu8We14s5rsz3mhWPHsTQ1u+aCkHuMf/ULRv
         aQbGwj5zCdX8PGc9nxICEQo+hnzQ0WTCodHhdcNlVA35dIMrBmMbeBS5xSTjmjQVXzV6
         igMQ==
X-Gm-Message-State: AKS2vOwmt3Ql3AzJtCBejJp7jKULaD274x4drigqBONxdWrSqk9oS1vK
        hY8FoCLjFwDnrfQ8
X-Received: by 10.28.232.67 with SMTP id f64mr771744wmh.54.1496743438412;
        Tue, 06 Jun 2017 03:03:58 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id b131sm13049359wma.11.2017.06.06.03.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jun 2017 03:03:57 -0700 (PDT)
Date:   Tue, 6 Jun 2017 11:03:55 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Git v2.13.1 SHA1 very broken
Message-ID: <20170606100355.GC25777@dinwoodie.org>
References: <20170605203409.GB25777@dinwoodie.org>
 <CACBZZX6vOr+ZjUaAf8i1xdjEFfY_Exj+_Xn2-1u0RcWoLy+X1g@mail.gmail.com>
 <xmqq4lvtap3m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4lvtap3m.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 06, 2017 at 10:20:45AM +0900, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > That looks scary, can you please comment out this:
> >
> >     #define SHA1DC_ALLOW_UNALIGNED_ACCESS
> >
> > In sha1dc/sha1.c and see if that helps, alternatively comment out the
> > ifdefs guarded by "#ifdef _MSC_VER" calls in sha1dc/sha1.c
> 
> That is merely a performance (and theoretical correctness) thing,
> no?

Confirmed rebuilding with either of these suggested changes has t0000.46
still failing.

> > The functional differences between 2.13.0 and 2.13.1 on that platform
> > should be none aside from possibly those changes, unless I've missed
> > something.
> 
> If it does not hash correctly, the cause is more likely that the
> endianness detection is going haywire.
> 
>     make CFLAGS="-DSHA1DC_FORCE_LITTLEENDIAN -g -O2 -Wall"

Confirmed rebuilding with this option has t0000 passing.  I can also get
the test to pass with Ramsay Jones' suggestion of using OpenSSL's SHA1.

Digging briefly into the endianness detection, it appears Cygwin has
both _LITTLE_ENDIAN and _BIG_ENDIAN defined.  Git's detection works by
assuming it's in a little endian environment and switching to big endian
if it detects any of the defines that indicate such, and a010391 adds
_BIG_ENDIAN to the set of defines that indicate big endianness.

The obvious quick fix would be one of the two below patches.  I'll also
take the discussion to the Cygwin mailing list in the hope that someone
can explain why Cygwin defines both _LITTLE_ENDIAN and _BIG_ENDIAN (and
indeed _PDP_ENDIAN).

Patch 1 (probably safer?):

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 3dff80ac7..e47d004b1 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -36,6 +36,7 @@
 #undef SHA1DC_BIGENDIAN
 #endif
 #if (!defined SHA1DC_FORCE_LITTLEENDIAN) && \
+    (!defined _LITTLE_ENDIAN) && \
     ((defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) || \
     defined(_BIG_ENDIAN) || defined(__BIG_ENDIAN__) || defined(__ARMEB__) || defined(__THUMBEB__) ||  defined(__AARCH64EB__) || \

Patch 2:

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 3dff80ac7..8d7b1ee7d 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -38,7 +38,7 @@
 #if (!defined SHA1DC_FORCE_LITTLEENDIAN) && \
     ((defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) || \
-    defined(_BIG_ENDIAN) || defined(__BIG_ENDIAN__) || defined(__ARMEB__) || defined(__THUMBEB__) ||  defined(__AARCH64EB__) || \
+    defined(__BIG_ENDIAN__) || defined(__ARMEB__) || defined(__THUMBEB__) ||  defined(__AARCH64EB__) || \
     defined(_MIPSEB) || defined(__MIPSEB) || defined(__MIPSEB__) || defined(SHA1DC_FORCE_BIGENDIAN))

 #define SHA1DC_BIGENDIAN
