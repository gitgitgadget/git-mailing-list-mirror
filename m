Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4541F404
	for <e@80x24.org>; Thu, 16 Aug 2018 17:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbeHPUyk (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 16:54:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54666 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeHPUyk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 16:54:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so5257748wmb.4
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 10:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LXx1TP0Wn/qCULyeW3FMJGMhMd/ck4ylYyGDX/mltRI=;
        b=Z8cYUT3Gi0PwfoyanLjPrKLtPw55YoEEVerRTesN0ytFq6Zr1DDxPjZo/h8aEPJ39l
         DJaYlG0t32gGf+3RcXLTgtjMHxeS8ffO7o8goBQIlx7GugjH5004tXYpjON6dSYFr58x
         H86dpTqw16pEjP0uV940uMqDSfz7vcAPiNDj3oqGpZIlnDscHqVFllL3kHOZQs6iUXJx
         OgyqCYNEzR9Jj55zolHpccUW5FojOKQGAqRsLIZYyIPM9S9scByjN1d5wdf8VQzClkhJ
         K3+wmcM/8gNgZZ4qtmckXrhmJO/+tS3qRGR3IDnbi+kHTp/mITT2n9LvtJkVIhsp+8yb
         8lKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LXx1TP0Wn/qCULyeW3FMJGMhMd/ck4ylYyGDX/mltRI=;
        b=dtxY124kgq/2D0XMOYSHhiluJ1qoiQB7g+qlD4PrwLA6el/BJUkCXsEQ7g1cyv5Cdl
         oDyDysbeiRd4zl4wZLNyTb2A8unv7QWo9QpoE+/4uuTPkvRzXcWHKlsLZgg/Iy50G84U
         rA7bSdQMvkpwltIAC7cz8GZq90dWKQDNiZ/yCGSXz1EPf/thPr2shUOl9UmwVKO5h3JF
         D5Poy1tE4GDVUWLrqAZwwfF2G0L8JZyJW0VzyloEWQblUb7F9VAPBQOgl00L2kP65yoY
         fcQIAv/OgF8rB/R+kEF8fdI6DrOYNr5SuZ2fMSl1LSVX+ei/tm2bgK9l/QYEV1ZCQkzb
         MXOQ==
X-Gm-Message-State: AOUpUlFT5AAi2R9vHZZp01Z9UA4gXsOMxYZRdBQiRf85WuNj9qzcaJGP
        VG5RM6y49rrAaMQqomfk2Fp0PsDd
X-Google-Smtp-Source: AA+uWPz9G3MK+IjhO9stJdV/2SZlKkZhWuQh8sDObt7uKLXMfBHV1lPNfBsZUnqiQ1QLbYvFA4vfAQ==
X-Received: by 2002:a1c:c507:: with SMTP id v7-v6mr16282807wmf.151.1534442084552;
        Thu, 16 Aug 2018 10:54:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q188-v6sm3186248wmd.36.2018.08.16.10.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 10:54:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER Gabor <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 5/7] t: add t5319-delta-islands.sh
References: <20180816061313.19298-1-chriscool@tuxfamily.org>
        <20180816061313.19298-6-chriscool@tuxfamily.org>
Date:   Thu, 16 Aug 2018 10:54:43 -0700
In-Reply-To: <20180816061313.19298-6-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 16 Aug 2018 08:13:11 +0200")
Message-ID: <xmqq1sayfb8c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t5319-delta-islands.sh | 143 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100755 t/t5319-delta-islands.sh

I should have told you what I had to do (or rather, I should have
told you to pay attention to what I had to do ;-) to avoid this
exchange earlier, but there already is another topic that wants to
use 5319 which means this topic breaks the test-lint, so I've been
renaming it to 5320 in my integration.

I'll locally rename it again, but if there is a need for further
update (I do not offhand know if there is), please do not forget to
rename it on your end before sending it.

Thanks.
