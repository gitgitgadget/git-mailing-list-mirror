Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A4C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 08:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356080AbiCYJAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 05:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCYJAt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 05:00:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7699848305
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 01:59:15 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p4-20020a17090ad30400b001c7ca87c05bso3066659pju.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 01:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=abmyqJndsETiQzWw38YiqeoYipH370K5K9dWFitIP50=;
        b=OKyAYEavWUiKyDsNM7FSSqW4tpHWkvbd93ezR7lc2eo4G5JhT9myK4Qxaw0+lFhLHZ
         jtsnIoasrkR4YpgjRojZL4lD9eq/lwmrvrpmY8noqhCC4IZUD7Pz47ZsMpOK9O75RB2K
         TNyUZ8mBcjty1HLxXxrrnnMU6pjg3mC+SATXmUr4kGyonleWdkeY51c/ENgS5f9+dEhs
         IQnS3rZ6lKzFWJyc4BR5CY8AKetZGto0LDXxRUTG7WD2QJavCCHvedqop3JkDc98FFwG
         Ba6PPmjalBKxvP/KVMcEyXQtDxwHKI6mV26zlLVmsnmw6NZQtmiiwmzavMtgITGLAqBR
         Surw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=abmyqJndsETiQzWw38YiqeoYipH370K5K9dWFitIP50=;
        b=K+dVj8QfQ+boeiaTPs69tf7Sd2FU5NUR+/Gd6cXFE1yVyK4Z5yGYmNjybE6OI9+Qcr
         86g0TnCeCXQo4Q8V1pj0EjrktDbIJQ/hrw3f+DmEO0cgcBTwN6/ZdpEQhfkVD6428pv4
         vVssSAkflScbtYl1C1iaLzjsygTaB1ERCeZL/vGhjIpEww93NvoWnSbrscuhXwChFFS6
         rJ8ATHeI4ASAezB8SA9m2kf/ObCA2Nm1LbJp4EkR1YAatjrIvGPMUf7bui62YSdrug4O
         xlEFhtzrLTJkCmZ9bayxylNZEJOKhMDSFNBzLPgMuQLklD5CU09HniSu9P9fvhe9WImK
         a75w==
X-Gm-Message-State: AOAM533uz4WPQoANguqR0ucznDsxAemwUow65h9/J4hLVe2jqB3ssiA9
        zbnlZp8sNDBOLZeCwq4l2a0=
X-Google-Smtp-Source: ABdhPJwQ82f96EaIsAKhz9Oc8VBZ3SXXNo6DBW8mMn46TFsaa1XklOkIYFo7y//1M+GnZNXUAHvGjQ==
X-Received: by 2002:a17:902:ea09:b0:154:4af3:bb77 with SMTP id s9-20020a170902ea0900b001544af3bb77mr10643343plg.4.1648198754832;
        Fri, 25 Mar 2022 01:59:14 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-78.three.co.id. [223.255.225.78])
        by smtp.gmail.com with ESMTPSA id f4-20020aa782c4000000b004f6f0334a51sm5611788pfn.126.2022.03.25.01.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 01:59:14 -0700 (PDT)
Message-ID: <9c584888-2dd2-139a-cf41-b2974386d1f8@gmail.com>
Date:   Fri, 25 Mar 2022 15:59:09 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 26/27] t/lib-unicode-nfc-nfd: helper prereqs for
 testing unicode nfc/nfd
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
 <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
 <bc2d5a7a9306c895f4a1105c08d86f24e5ea542c.1648140680.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <bc2d5a7a9306c895f4a1105c08d86f24e5ea542c.1648140680.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/03/22 23.51, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Create a set of prereqs to help understand how file names
> are handled by the filesystem when they contain NFC and NFD
> Unicode characters.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>   t/lib-unicode-nfc-nfd.sh | 167 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 167 insertions(+)
>   create mode 100755 t/lib-unicode-nfc-nfd.sh
> 
> diff --git a/t/lib-unicode-nfc-nfd.sh b/t/lib-unicode-nfc-nfd.sh
> new file mode 100755
> index 00000000000..cf9c26d1e22
> --- /dev/null
> +++ b/t/lib-unicode-nfc-nfd.sh
> @@ -0,0 +1,167 @@
> +# Help detect how Unicode NFC and NFD are handled on the filesystem.
> +
> +# A simple character that has a NFD form.
> +#
> +# NFC:       U+00e9 LATIN SMALL LETTER E WITH ACUTE
> +# UTF8(NFC): \xc3 \xa9
> +#
> +# NFD:       U+0065 LATIN SMALL LETTER E
> +#            U+0301 COMBINING ACUTE ACCENT
> +# UTF8(NFD): \x65  +  \xcc \x81
> +#
> +utf8_nfc=$(printf "\xc3\xa9")
> +utf8_nfd=$(printf "\x65\xcc\x81")
> +

The first nfc-nfd test subject (É) is simple case, right?

> +# Is the OS or the filesystem "Unicode composition sensitive"?
> +#
> +# That is, does the OS or the filesystem allow files to exist with
> +# both the NFC and NFD spellings?  Or, does the OS/FS lie to us and
> +# tell us that the NFC and NFD forms are equivalent.
> +#
> +# This is or may be independent of what type of filesystem we have,
> +# since it might be handled by the OS at a layer above the FS.
> +# Testing shows on MacOS using APFS, HFS+, and FAT32 reports a
> +# collision, for example.
> +#
> +# This does not tell us how the Unicode pathname will be spelled
> +# on disk, but rather only that the two spelling "collide".  We
> +# will examine the actual on disk spelling in a later prereq.
> +#
> +test_lazy_prereq UNICODE_COMPOSITION_SENSITIVE '
> +	mkdir trial_${utf8_nfc} &&
> +	mkdir trial_${utf8_nfd}
> +'
> +
> +# Is the spelling of an NFC pathname preserved on disk?
> +#
> +# On MacOS with HFS+ and FAT32, NFC paths are converted into NFD
> +# and on APFS, NFC paths are preserved.  As we have established
> +# above, this is independent of "composition sensitivity".
> +#
> +# 0000000 63 5f c3 a9
> +#
> +# (/usr/bin/od output contains different amount of whitespace
> +# on different platforms, so we need the wildcards here.)
> +#
> +test_lazy_prereq UNICODE_NFC_PRESERVED '
> +	mkdir c_${utf8_nfc} &&
> +	ls | od -t x1 | grep "63 *5f *c3 *a9"
> +'
> +
> +# Is the spelling of an NFD pathname preserved on disk?
> +#
> +# 0000000 64 5f 65 cc 81
> +#
> +test_lazy_prereq UNICODE_NFD_PRESERVED '
> +	mkdir d_${utf8_nfd} &&
> +	ls | od -t x1 | grep "64 *5f *65 *cc *81"
> +'
> +	mkdir c_${utf8_nfc} &&
> +	mkdir d_${utf8_nfd} &&
> +
> +# The following _DOUBLE_ forms are more for my curiosity,
> +# but there may be quirks lurking when there are multiple
> +# combining characters in non-canonical order.
> +
> +# Unicode also allows multiple combining characters
> +# that can be decomposed in pieces.
> +#
> +# NFC:        U+1f67 GREEK SMALL LETTER OMEGA WITH DASIA AND PERISPOMENI
> +# UTF8(NFC):  \xe1 \xbd \xa7
> +#
> +# NFD1:       U+1f61 GREEK SMALL LETTER OMEGA WITH DASIA
> +#             U+0342 COMBINING GREEK PERISPOMENI
> +# UTF8(NFD1): \xe1 \xbd \xa1  +  \xcd \x82
> +#
> +# But U+1f61 decomposes into
> +# NFD2:       U+03c9 GREEK SMALL LETTER OMEGA
> +#             U+0314 COMBINING REVERSED COMMA ABOVE
> +# UTF8(NFD2): \xcf \x89  +  \xcc \x94
> +#
> +# Yielding:   \xcf \x89  +  \xcc \x94  +  \xcd \x82
> +#
> +# Note that I've used the canonical ordering of the
> +# combinining characters.  It is also possible to
> +# swap them.  My testing shows that that non-standard
> +# ordering also causes a collision in mkdir.  However,
> +# the resulting names don't draw correctly on the
> +# terminal (implying that the on-disk format also has
> +# them out of order).
> +#
> +greek_nfc=$(printf "\xe1\xbd\xa7")
> +greek_nfd1=$(printf "\xe1\xbd\xa1\xcd\x82")
> +greek_nfd2=$(printf "\xcf\x89\xcc\x94\xcd\x82")
> +

The second test subject (greek) is more complex, right?

> +# See if a double decomposition also collides.
> +#
> +test_lazy_prereq UNICODE_DOUBLE_COMPOSITION_SENSITIVE '
> +	mkdir trial_${greek_nfc} &&
> +	mkdir trial_${greek_nfd2}
> +'
> +
> +# See if the NFC spelling appears on the disk.
> +#
> +test_lazy_prereq UNICODE_DOUBLE_NFC_PRESERVED '
> +	mkdir c_${greek_nfc} &&
> +	ls | od -t x1 | grep "63 *5f *e1 *bd *a7"
> +'
> +
> +# See if the NFD spelling appears on the disk.
> +#
> +test_lazy_prereq UNICODE_DOUBLE_NFD_PRESERVED '
> +	mkdir d_${greek_nfd2} &&
> +	ls | od -t x1 | grep "64 *5f *cf *89 *cc *94 *cd *82"
> +'
> +
> +# The following is for debugging. I found it useful when
> +# trying to understand the various (OS, FS) quirks WRT
> +# Unicode and how composition/decomposition is handled.
> +# For example, when trying to understand how (macOS, APFS)
> +# and (macOS, HFS) and (macOS, FAT32) compare.
> +#
> +# It is rather noisy, so it is disabled by default.
> +#
> +if test "$unicode_debug" = "true"
> +then
> +	if test_have_prereq UNICODE_COMPOSITION_SENSITIVE
> +	then
> +		echo NFC and NFD are distinct on this OS/filesystem.
> +	else
> +		echo NFC and NFD are aliases on this OS/filesystem.
> +	fi
> +
> +	if test_have_prereq UNICODE_NFC_PRESERVED
> +	then
> +		echo NFC maintains original spelling.
> +	else
> +		echo NFC is modified.
> +	fi
> +
> +	if test_have_prereq UNICODE_NFD_PRESERVED
> +	then
> +		echo NFD maintains original spelling.
> +	else
> +		echo NFD is modified.
> +	fi
> +
> +	if test_have_prereq UNICODE_DOUBLE_COMPOSITION_SENSITIVE
> +	then
> +		echo DOUBLE NFC and NFD are distinct on this OS/filesystem.
> +	else
> +		echo DOUBLE NFC and NFD are aliases on this OS/filesystem.
> +	fi
> +
> +	if test_have_prereq UNICODE_DOUBLE_NFC_PRESERVED
> +	then
> +		echo Double NFC maintains original spelling.
> +	else
> +		echo Double NFC is modified.
> +	fi
> +
> +	if test_have_prereq UNICODE_DOUBLE_NFD_PRESERVED
> +	then
> +		echo Double NFD maintains original spelling.
> +	else
> +		echo Double NFD is modified.
> +	fi
> +fi

In general, this test is written from Mac OS perspective, but since we have
Git users also from Linux, Windows, and other OSes, I'd like to see from these
other perspective.

-- 
An old man doll... just what I always wanted! - Clara
