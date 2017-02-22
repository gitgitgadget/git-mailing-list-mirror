Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EE51201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 17:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932985AbdBVR1w (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 12:27:52 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35146 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932568AbdBVR1v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 12:27:51 -0500
Received: by mail-pg0-f68.google.com with SMTP id 1so1302439pgz.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 09:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=P+GrUU1kGTnnaweFghMJNE7r3trHMVGUVOFWPSDcvdQ=;
        b=GA3uXuKeTJe8sc6LoDFdZ2LTxs6L5NdWxbVJu39Hj+wksmk4Hkh5MklpzHsO37h8hc
         QtKY36IQDHNpHQb5jvfjIgaymUUyYV/fkBE8LgF2dVE3DG3O3fwHIrKiqWd/jCVnlgo7
         qFmCQLU4hwlgp4zlhOxpLrk+qjoSSgswYeMN7xuvFjZIWGwo6WBrz5yPm3PSZoKykiI/
         XvSxG+KPHDGV+f/AFn3bebDlX1PDdPC0zLQPQxBCvOD7Nnya2gOPuex+efcVq4xbM0Q6
         EtZ80fg5qHbH5QFZx9qvHFGC/roGKxhFG+GEcusa5EweD2pGUuvncVXVUGZOPBfcbTJp
         mOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=P+GrUU1kGTnnaweFghMJNE7r3trHMVGUVOFWPSDcvdQ=;
        b=uGLkswjN+Qq6KtaCZxfbRWor3lZEaO0cjRC9JNdS2Ll/3WiiGkbxvPhyXZyh3wGG0Q
         TlStICsvoVjhyesUKCqG7KSavSknDTvKQV+SRSWxv66k5KnuBeHqKeCdgbU1TssTW2jx
         mHojtRH1kVFmTVcOCkIaScDzDKUr6RKnwgVA3WWZ/b4W+gg/vlpw4n6gkzQ06xIiPhSy
         O67JqH8OAQOgI/5sytKUhh6hLfvIiDkcdA/CKby5RhcFoo0vXzykSUPswbkBuzsQwrBD
         YDHLXeAGrFPdW1yQK4jFTmGk3Zauu1jQTnk43u+cq8Mu7pFB70rHxMS0KpMtoN3lcWZA
         clHg==
X-Gm-Message-State: AMke39k6Q/EEuKKYxp32yGFQYjwcBCdmlk94O4lmLRlTBMpFUCdMlaLTgWvt8d8bmmvckA==
X-Received: by 10.98.7.21 with SMTP id b21mr9239035pfd.66.1487783930720;
        Wed, 22 Feb 2017 09:18:50 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id g28sm4884387pgn.3.2017.02.22.09.18.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 09:18:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
Subject: Re: [PATCH v5 00/24] Remove submodule from files-backend.c
References: <20170218133303.3682-1-pclouds@gmail.com>
        <20170222140450.30886-1-pclouds@gmail.com>
Date:   Wed, 22 Feb 2017 09:18:49 -0800
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 22 Feb 2017 21:04:26 +0700")
Message-ID: <xmqqlgsycfeu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> v5 goes a bit longer than v4, basically:
>
>  - files_path() is broken down into three smaller functions,
>    files_{packed_refs,reflog,refname}_path().
>
>  - most of store-based api is added because..
>
>  - test-ref-store.c is added with t1405 and t1406 for some basic tests
>    I'm not aimimg for complete ref store coverage. But we can continue
>    to improve from there.
>
>  - refs_store_init() now takes a "permission" flag, like open().
>    Operations are allowed or forbidden based on this flag. The
>    submodule_allowed flag is killed. files_assert_main.. remains.
>
>  - get_*_ref_store() remain public api because it's used by
>    test-ref-store.c and pack-refs.c.
>
>  - files-backend.c should now make no function calls that implicitly
>    target the main store. But this will have to be tested more to be
>    sure. I'm tempted to add a tracing backend just for this purpose.

OK.

> Junio, if you take this on 'pu', you'll have to kick my other two
> series out (they should not even compile). I'm not resending them
> until I get a "looks mostly ok" from Michael. No point in updating
> them when this series keeps moving.

Thanks for a note.

