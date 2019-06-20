Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B8F31F462
	for <e@80x24.org>; Thu, 20 Jun 2019 09:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfFTJsq (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 05:48:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32860 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFTJsq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 05:48:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so1379667pfq.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQJ2fIPfF1vc6PK3WYVAP3A0KtWitvZkdpMLiLLOBwY=;
        b=i3u0cDt9saB+rjIqBZfqE1yYav9IdjYMQtlG/+inpWcaoRw6+6zLI9So0fD6RPppiz
         QTuavNnXoQW9o6L1yfSCaNcBHpSVJ+gJW/KrCugwwMFfRyhVtT19U3ezhHmEoOU+UC1A
         MekQHvm1jYefNsvXFi+HGGv/NNLYAB9oLkhSYTECzr+yxnpupgex14EGn96C3Po+R5e7
         Aj1gznq7pSFIB5YVHXHg4tIRKIIk8e2TLVETofZhsZaWRCjCLShQqUMrbEqeyUE5n99A
         sps00mQeBWPcxIXu9MXC2us9Lxzf2ow8WYcOi29h9qK/Jb2Z34qoQ7Z7aaYA/UOLSsc9
         lgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQJ2fIPfF1vc6PK3WYVAP3A0KtWitvZkdpMLiLLOBwY=;
        b=HEP6WxCGNDONjjrxDW3sKSzeWiNpDltGBgaNLQdv5L6NXc4/Oh+IRTxad+lB+ez4rV
         oGoKwp3stp0aIrbrukYIicET//PVO0rZXNkWYYlw+4QdDDejg3F7fA0RIYNl/pZ9XdGN
         IsUNGxhpmXKm04QcJi0WdV6tp17phlbXwvupRwnrAOOIxhz2EJluMwja18C2rNy1ryqg
         GiKs23Y7ZJKAMWfi+I19tDr4Q2URajTzmcCiFGFYK7Fy9KpzepSaczQn4FmsqPPZ7X6O
         9O0Jq26vD30N7onvBv4OUNPvuaoAaLbk+TxG3xdo2lI/7TYEMumhaNdhXeIwJWJSrs/5
         /JLQ==
X-Gm-Message-State: APjAAAW7UdgR1GE0gcnrJlutjkcA4kLcLoG8BgFXmehrx/OckWMysnXy
        2AFq6d0Bx4i3lOQ69Ewol98=
X-Google-Smtp-Source: APXvYqzMs3mtLhpRG8AoBwV6cBmdDeYs+OQCGXtKrdbVMB5YMg0qVfjkFPpmN4wQF5YR/6WReVo73g==
X-Received: by 2002:a63:c94f:: with SMTP id y15mr12193011pgg.159.1561024125340;
        Thu, 20 Jun 2019 02:48:45 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.214])
        by smtp.gmail.com with ESMTPSA id p65sm23464306pfp.58.2019.06.20.02.48.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 02:48:44 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        rohit.ashiwal265@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v5 4/5] cherry-pick/revert: add --skip option
Date:   Thu, 20 Jun 2019 15:16:27 +0530
Message-Id: <20190620094627.22401-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <xmqqr27oq5z1.fsf@gitster-ct.c.googlers.com>
References: <xmqqr27oq5z1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Wed, 19 Jun 2019 20:40:50 -0700 Junio C Hamano <gitster@pobox.com> wrote:
>
> Two comments.
>
> The places touched by patch 1/5 emitted the error followed by an
> advice message; this new one breaks the pattern by giving the "hint:"
> first and then error.  Be consistent by swapping these two (and
> return -1, as "error() that returns -1" will no longer be the last
> thing executed in this function.

Yes, it also makes sense otherwise, but this will be more consistent.

> This one, and the in_progress_advice emitted from the patch 1/5, are
> both bad in that they make calls to advise() without guarding it
> with an advice.* configuration variable. This does not allow the
> user to say say "I've learned this part of Git enough; do not tell
> me verbosely."

Oh~ I was missing this point from the start. I'll make proper changes
to my patch.

> Pick a random global variable that is defined near the top of
> advice.c, and learn how they are set (to true by default, allowing
> configuration to flip it off) and how they are used in order to
> prevent a call to advise() getting made.  Then mimick that to guard
> these calls to advise().

Ok, I'll look into it and change accordingly.

> Thanks.

Thanks
Rohit

