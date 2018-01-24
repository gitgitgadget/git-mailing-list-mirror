Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404111F404
	for <e@80x24.org>; Wed, 24 Jan 2018 21:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933007AbeAXVlL (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 16:41:11 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46737 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932474AbeAXVlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 16:41:09 -0500
Received: by mail-pg0-f65.google.com with SMTP id s9so3624936pgq.13
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 13:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=64SXIFxA4wa0VZSuvqgdO2BGLdyY/YhU/XH4BKlUPdQ=;
        b=BVDoFZUlkAhKtnGUEZEXJUPbT5MjeER4odMLu/hhLwryVJjGIkEhPN0QrpCQR13Tnn
         sy+TnSr95QexaBEIBRPAR1USBDjReOfpSIzd7lTJKlVN+UXwSxT0Ta9S6JI5j83++43G
         0yVcaTA0pVUxWA833v+h0pbAhO1D1t3DYsPksl/C5HC/3bnhRqbvMSQP2lNzE+X2wEXy
         sW9l8mJlHFoHlWOFmqTmxuEdWlvS/w4u939vG/wM7n0h5h02joa5QjF/kJrWznyItncq
         n/CdhFE0jAET+pGmewmzq0XGiYto5sOq7Nn042K7RdkLeZNCVC8DHtKXRAe8o/AIHY8K
         0rDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=64SXIFxA4wa0VZSuvqgdO2BGLdyY/YhU/XH4BKlUPdQ=;
        b=EAEF1B76R/ffpZ8mv0CGhf/pM76Y2odj+qB6joJmeIFTF+RnLyiWEfsK1vwkbYUVyP
         TLBjaAhixDMfvBfB2DCqG+lfMBNo1dO9Sh6UBXtmyeAk40WNPvrSLp0LhzWNIX1mhiA1
         CXQuOQBNVHCClEUj34QsRzKI5wz4oXl1qJnu8t4V74ZKmc2opI9WsoxK2fyTXvZhJYrM
         3L04Nb1qNWJ+ENSCuAJkqfoPchDITdnF34yY5upqqho0FVst1Ts1jhrDegbTMKcNsjuh
         2ON3XR22bPPkzNGPySNVOIotYyY+LvfFKEQRC9QNKyESl6jcyuDGykhhjAAQsJSu94Eh
         cEnA==
X-Gm-Message-State: AKwxytfqO73zGncnuFfom0AJuIafmaw/b0sGbkMdu6Qm0Ny8LehcQdRq
        19LgPKDk/wAY9goExzgLDag=
X-Google-Smtp-Source: AH8x2256ggkKjElrpyEK+qCPM5BlHsiOHtG08qdwDIWwxKUhZ8Eu+cKs4D9ueRx2JvGThWPIgSALhw==
X-Received: by 10.98.33.82 with SMTP id h79mr13901528pfh.139.1516830068947;
        Wed, 24 Jan 2018 13:41:08 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id p69sm11476423pfk.7.2018.01.24.13.41.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 13:41:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 00/14] Some fixes and bunch of object_id conversions
References: <cover.1516617960.git.patryk.obara@gmail.com>
        <cover.1516790478.git.patryk.obara@gmail.com>
Date:   Wed, 24 Jan 2018 13:41:07 -0800
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com> (Patryk Obara's
        message of "Wed, 24 Jan 2018 12:11:52 +0100")
Message-ID: <xmqqinbraqa4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patryk Obara <patryk.obara@gmail.com> writes:

> Patryk Obara (14):
>   http-push: improve error log
>   clang-format: adjust penalty for return type line break
>   sha1_file: convert pretend_sha1_file to object_id
>   dir: convert struct sha1_stat to use object_id
>   sha1_file: convert hash_sha1_file to object_id
>   cache: clear whole hash buffer with oidclr
>   match-trees: convert splice_tree to object_id
>   commit: convert commit_tree* to object_id
>   notes: convert combine_notes_* to object_id
>   notes: convert write_notes_tree to object_id
>   sha1_file: convert write_sha1_file to object_id
>   sha1_file: convert force_object_loose to object_id
>   sha1_file: convert write_loose_object to object_id
>   sha1_file: rename hash_sha1_file_literally

These were mostly pleasant read.  I'll queue these on two topic
branches and wait to see what others say.

Thanks.
