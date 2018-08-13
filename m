Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6771F404
	for <e@80x24.org>; Mon, 13 Aug 2018 21:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbeHNACR (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 20:02:17 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35527 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbeHNACR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 20:02:17 -0400
Received: by mail-wm0-f50.google.com with SMTP id o18-v6so10241448wmc.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 14:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=s7JQSv8ZdLNt8EdZpCiGYqY+VMDzmelZp3gOIUYvMUc=;
        b=sAduX9RWIbPHtxmXcd0m+jhqQHcWyUrzJVfk04ziKADncPQdcoJMaP4DTeP2m707af
         ZXhee19ABQrOHm2is5IKp7N74UaP10aNagqU3Q/s0SbVxjf+1pFwRGMyFIB6PVCmOegm
         zMzn9xZpinrrGX2+8v6eKBb6bl0St9MUo4u6NvDvIwAU5bCMRZglyaHlJTNfomTD3qhT
         ncgN1qT25Ujn+wNct5lZo+GhCBvlfprnRmXK4Lg5EsxW/AbUyDpsFN69LJaqbW1RVrwA
         nQrEXEw2azi8agqm0IN//uMTgCoSoq9Elbv+Bu97ez3agI9aKEjbQSM/LfQrGKNdDaUR
         idbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=s7JQSv8ZdLNt8EdZpCiGYqY+VMDzmelZp3gOIUYvMUc=;
        b=TKuWSh9/5QwEMnz3dylIOlY9VRomp6CC9xFT5AO5WsACvoCjLeCF9igA5r6EF3IJjc
         ZHXV0VZj3hNQgOyhR4tQa5ccHHSLV16vchlP+DcJVOAqLnGT7JosQ+RVuahHbtAHHMmP
         u8r+T1YWwJjXizcKgmZQ+dYzUgnm6hWLTnML1wgGB+MoNQAOKqHK4G3B+9A3DA5E0R2O
         caP+naVLk2X9++293v+t5tZ5XGQLRY3AGoVsqSX6ibnAav3x1qSqzTFlaHh0JHJ1Qp6P
         pr6lcRW5MRkH8OjaEB9amCePekiR5FxkqP0DxX4r//aMoL5g3GFq0hROcTosX9SMF7kY
         0wdg==
X-Gm-Message-State: AOUpUlFwSPAy+FwESI7gDwOqo58RNh4XvqQ09FgqD2N0WzuWuhVbEF/Y
        yoBiRj6h9qBkhzc9PS/DCEM=
X-Google-Smtp-Source: AA+uWPyu/F6jmHAZssPs+b/A4e5cJwxT4Beu8i2zEOkBazAj3Oq1d+m+wDp5h8FDqBJnqotGgvkzWg==
X-Received: by 2002:a1c:1f10:: with SMTP id f16-v6mr9647574wmf.112.1534195098385;
        Mon, 13 Aug 2018 14:18:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x7-v6sm14017654wrr.95.2018.08.13.14.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 14:18:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/24] cache-tree: wrap the_index based wrappers with #ifdef
References: <20180813161441.16824-1-pclouds@gmail.com>
        <20180813161441.16824-3-pclouds@gmail.com>
Date:   Mon, 13 Aug 2018 14:18:16 -0700
In-Reply-To: <20180813161441.16824-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 13 Aug 2018 18:14:19 +0200")
Message-ID: <xmqq8t5a3qzr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This puts update_main_cache_tree() and write_cache_as_tree() in the
> same group of "index compat" functions that assume the_index
> implicitly, which should only be used within builtin/ or t/helper.
>
> sequencer.c is also updated to not use these functions. As of now, no
> files outside builtin/ use these functions anymore.

Makes sense.
