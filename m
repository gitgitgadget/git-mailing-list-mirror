Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6C120248
	for <e@80x24.org>; Mon, 18 Mar 2019 05:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbfCRFbC (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 01:31:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33089 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfCRFbC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 01:31:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so1288536wmi.0
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 22:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ril+zsmbtZl9c377LAhMbRSYZoaywUz/3MzwKSohvnI=;
        b=NGUq840h/I3vm+BeTpDN+ATJFLMKiXCyTFsTDtAzhGJTVuCpOpoHnycf2wvg+k/PnK
         Fyovb/RWlCzQ/aFeblF6MMk7NyotXxh5Z4LDxXQTQIyyt0baAyIwAskBXti4FtkNSZJ0
         t0OQ/TSlHxjgor6P9LGs9JqANkvfKXH1A12K58z0wCU301gFACZgn6nhcJyBj5I3sS/C
         m3zWN1nG1X0xpfcm4GTY1zCUynY7xKskv0GFrB0IjL+NlGg67bf+buNYw0FkcmtOdDRS
         9+P4fFwXjCvvyi9A9lmOgvXi3vsk25An5pyE6IP66lDiZYy4qS5LBJ+Y+QdZ1WWqrH9O
         DBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ril+zsmbtZl9c377LAhMbRSYZoaywUz/3MzwKSohvnI=;
        b=e7hX+6YDPRuMZTG3IqHAydmKefsuZ3bgFW46/IO7PlI+r8SO3MFTBA7xxwUYBk3CGW
         kVvHXvlzjJIiMos1kRJNkebHqYqdlHoiv74nNuwDeMz/OQxREo0l24TsTAlHC9zFbsYe
         1POPyDiB1ZMJPb9N9P/JzUiOiN+kQVWGeSIAoqQCTX4CVDJuUYBfpaaJJhZgfk+IIdTN
         Csdlr8MM+NO4OMcX6tD/n0I9KvhQqpbuAvpeXI9DsoyUC5QOufqpLbs2u1fpMhlwIKJO
         bXLdzJDeLqUDfmArfbgtvg0/qsOW/LMIlhJvqLRFVQksNZSt6yCecIz3FfY98zKmOQyn
         A8bQ==
X-Gm-Message-State: APjAAAWpk426IbM/nIIPQUgNh1PpGgLJRDffu33aYjNBF37VNrnRnI6w
        rB2HUfV2CdWiHK3fUdWBcMY=
X-Google-Smtp-Source: APXvYqwQrQYml2bYMj31UaNbFalKHPL+Om6P4NNklbvhFyk7GKMQKM1/kNw+UgEgiwRceK6FfZdbVg==
X-Received: by 2002:a1c:387:: with SMTP id 129mr10151581wmd.45.1552887060599;
        Sun, 17 Mar 2019 22:31:00 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id k14sm9605355wmj.26.2019.03.17.22.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 22:30:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, rafa.almas@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v9 0/3]
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190316013807.38756-1-nbelakovski@gmail.com>
Date:   Mon, 18 Mar 2019 14:30:59 +0900
In-Reply-To: <20190316013807.38756-1-nbelakovski@gmail.com> (nbelakovski's
        message of "Fri, 15 Mar 2019 18:38:04 -0700")
Message-ID: <xmqqo9684ulo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nbelakovski@gmail.com writes:

> From: Nickolai Belakovski <nbelakovski@gmail.com>
>
> Cleanup on 2/3 and 3/3

I'll have to re-read the test part myself to see what you meant by
the "strategy for updating tests" and if it makes sense, but what
you wrote as the goal and approach in the cover letter all sounded
sensible.

Thanks, will requeue.  
