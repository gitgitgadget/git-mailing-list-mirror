Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D236B20288
	for <e@80x24.org>; Wed, 19 Jul 2017 23:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754817AbdGSX42 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 19:56:28 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33721 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753702AbdGSX41 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 19:56:27 -0400
Received: by mail-pg0-f52.google.com with SMTP id k14so6784313pgr.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 16:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4lu4+D06Jq3K3xUSbICPCwcAkVMHg+kebacwGvL7FA=;
        b=mS6C73tfclK9H2J/iapxTdo7A78pEcQ8QwSVnYw+KDcHQJ0poRl9Fd0HA036W314b7
         A9MHLTvoLB1w3O4TCWm5vzeOyawD1H41hQomRqczlzh7c86gRSDxwBghnyPBLKNWSDie
         b3JhWplQkKO5gV7Yw20ih8X/clpq5MBu4oYPk0lLYCiF1wS4tGdJU4StJ10XBiRtL2zQ
         m8ZYDxJ6fccf3oyaBaVS0OeVCPrO6/rJndtr4Z3kMGBcAwF4/cvntFXyTb+oGTgmsO/U
         gFmv+EsWT5TEWRUVYzTmlFXqzM2zqV0vdBpYuKt9mOnrUa3fY41PrSC55LRKaY9FNzcj
         nZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c4lu4+D06Jq3K3xUSbICPCwcAkVMHg+kebacwGvL7FA=;
        b=rnJ71CWloVZb5b/lHekW2PYs4vhsURKU8nQYdFeyXmqgATwWhZWnodaYe3l8085xJK
         XyadCPrr6/sBMyP6uZpQLh7AP0EXGMUS6p1EDqwW0wF91MC2aMs/1KUK/9dLppvG4R0h
         sWevKEOBI8W5pyb1snqlgW0+48gegyhX+e/zAOlLx6sX0m1LZRu2Z/bVuvR3Upi5tl2e
         toMnmS0fxm4nDyiRSRfK9HWbiWONcKspFPf0Q36AlB/K2lGX/6nogrKM6fhL3LmAZtEn
         5/uCm0TFW3me4jtyngGCYcJT/XYm9/1clNJw4ETJ3IT/HbNHxJ3oa+wSNnQJiVCqvW9Z
         IbNQ==
X-Gm-Message-State: AIVw111KNXm7ByY6ha3ybQFRtwHrT6izWEz9ck0LibYel6VOLp1ysynd
        AIaJ6Zo+zwGu5ktalGMyJw==
X-Received: by 10.84.131.6 with SMTP id 6mr1890249pld.413.1500508587122;
        Wed, 19 Jul 2017 16:56:27 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:f109:8044:bbc9:49ff])
        by smtp.gmail.com with ESMTPSA id g79sm1448220pfd.163.2017.07.19.16.56.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 19 Jul 2017 16:56:26 -0700 (PDT)
Date:   Wed, 19 Jul 2017 16:56:22 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] sha1-array: support appending unsigned char
 hash
Message-ID: <20170719165622.78e463fd@twelve2.svl.corp.google.com>
In-Reply-To: <CAGZ79kZ9Ewxv=8fnRZZaQjpyAdv8df81a9aLRkJzEt5ZU0VcTA@mail.gmail.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
        <523f64e1395124a02316071329bedf9884757479.1499800530.git.jonathantanmy@google.com>
        <CAGZ79kZ9Ewxv=8fnRZZaQjpyAdv8df81a9aLRkJzEt5ZU0VcTA@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 11 Jul 2017 15:06:11 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Tue, Jul 11, 2017 at 12:48 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> > In a subsequent patch, sha1_file will need to append object names in the
> > form of "unsigned char *" to oid arrays. Teach sha1-array support for
> > that.
> >
> > Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> 
> This breaks the oid/sha1 barrier?

Not sure what you mean by this. This patch is meant to be a change to
make "unsigned char *"-using code able to create/modify oid arrays,
while we migrate away from "unsigned char *" - I don't know of any
barrier.

> I would have expected the caller to do a
> 
>   oid_array_append_oid(&array, sha1_to_oid(sha1));
> 
> with sha1_to_oid working off some static memory, such that the
> call to oid_array_append_oid (which we have as oid_array_append)
> is just as cheap?

The solution you present would need 2 copies (one in sha1_to_oid, and
another in oid_array_append), but the solution in this patch only
requires one.

> Could you say more in the commit message on why we collude
> sha1 and oids here?

I also don't understand this, but the answer to this is probably the
same as the answer to your first question.
