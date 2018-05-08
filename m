Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE3DF200B9
	for <e@80x24.org>; Tue,  8 May 2018 17:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755491AbeEHRX4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 13:23:56 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:45787 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755430AbeEHRXz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 13:23:55 -0400
Received: by mail-pl0-f42.google.com with SMTP id bi12-v6so2617410plb.12
        for <git@vger.kernel.org>; Tue, 08 May 2018 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vTilHmbe6DRO00a8H/3p1lCXltgvtwfKrXF0Fp6yOwI=;
        b=KgfGzcmP37Vij2tI4GzEt/5cCFOnuAV06T/ohQkVgHLeyQHxobH4fbZ4LpmnXpoow7
         qQ3IuvVFbhCiFMPIhh3UV+JMkh7jvD/7DYr36Juxpo8lQNzvGmL+ZyHDxi9o09Z45Yar
         bya2RwiSbW8eekDPlhZZnK44S6T94oqA2tSvtSOyKqYa2r+IRgyqy+IJ0L9W0ICaHtMA
         pdCyZ6nUMInYs14t1Y/08IefG3eVHuaDZwha5gEPwe95ZN1vQj5XriIWOsuQbfYOlJ8p
         0uqHRgqH42nRbOfsMkVzL3rGwQOBHW/QIjso+mCQSNic5mW+mAbhRXw9dYAvH+pTi0RH
         zY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vTilHmbe6DRO00a8H/3p1lCXltgvtwfKrXF0Fp6yOwI=;
        b=rXFsTn/uyQP+hTm/+lGFxZJj727FFBpAoxlFt/x+djxu1qBK+1DFTA36SU8Z6cpoix
         9dZCB3tC9LYsabH9wmAKgjbuNNGrZpmuV74tKYtG6uAwRoCSX0vrUn+s1QOtxHj6Ktpb
         tSX3e+UMsnWlPDTEgT0bG/7yesEGgZom0KrBX26ZJJoU+qhCKW2L1ghLoHUVzLILLA9M
         uWvm3pI2HB+GVsnPbrYWcYivK0Mi5h75dZ7d2UiWVs1toOrC9Z3LFAyAPecdq3yQS/Yd
         4AwRAOHbzyzlsaBIQBzSrHmil7DzJTEwGKYKK8VAh07VZNXmV3mbdjnvI+8Ov+aHUcCj
         8MwA==
X-Gm-Message-State: ALQs6tAx4df3wRotU1rBrpE1JcuXmnYAa/Ij54DRnN8CXcU5ACTI1LfP
        4J4lXuAv1c6VHvvFwxfjRSjTjAY+WJc=
X-Google-Smtp-Source: AB8JxZrnyopdZAs+WGQd6gGAQorwc8hImcP4BFiqM3K/gBe/fMdvyJh1QjUC1J8UsM1vQ4gYwTO6tQ==
X-Received: by 2002:a17:902:2006:: with SMTP id n6-v6mr42857218pla.125.1525800234670;
        Tue, 08 May 2018 10:23:54 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id a23sm44372269pfi.176.2018.05.08.10.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 10:23:53 -0700 (PDT)
Date:   Tue, 8 May 2018 10:23:52 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        jamill@microsoft.com
Subject: Re: [PATCH v2 01/13] repository: introduce parsed objects field
Message-Id: <20180508102352.2d6d77fb07c60fc788debc33@google.com>
In-Reply-To: <20180507225916.155236-2-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
        <20180507225916.155236-1-sbeller@google.com>
        <20180507225916.155236-2-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon,  7 May 2018 15:59:04 -0700
Stefan Beller <sbeller@google.com> wrote:

>  	/*
> -	 * Holds any information related to accessing the raw object content.
> +	 * Holds any information needed to retrieve the raw content
> +	 * of objects. The object_parser uses this to get object
> +	 * content which it then parses.

Update this comment - there is no more object_parser. (Maybe just delete
the last sentence, or specifically name some of the functions that
access this field.)

>  	 */
>  	struct raw_object_store *objects;

Other than that, this patch looks good.
