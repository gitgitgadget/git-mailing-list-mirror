Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13AD61F424
	for <e@80x24.org>; Tue, 24 Apr 2018 18:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbeDXSXl (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 14:23:41 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:37504 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbeDXSXf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 14:23:35 -0400
Received: by mail-pf0-f173.google.com with SMTP id p6so12956036pfn.4
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 11:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GgUc5aXysJKqL8Tw3PkK/TQOv4HYJSCy77wImUJOddE=;
        b=vYWNCHsykF/vAJiZJ+DMFXkNSNqZwvVDaP01HCzYJDPKuObKEo5XNJig2Pz72GZHZC
         SCtITz33ZTFhIGn2Wk4jani4zwbCnsIDUC7qe+3vEhtABx7U8nadkTcPC37sQ6Ooy64c
         ED0UkP9XKhNJ4zvNQYTlzEQmpv3+yKghVkYKfJSb0oWZ0Banhkeofn5U7lhS/R6CO32L
         REsbutpl6Q8YDo7QOs9RbfpTeIJa1q64wV6W5+LzN0rqZBzzJGPcRLznfK1oldQPOphw
         e/glk8kZNKalr4PW5Kq1xeVEqRpmNr/fPZvCIKuJeIKVDtwp/lj5xLaGKC09Fkllt9GK
         2uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GgUc5aXysJKqL8Tw3PkK/TQOv4HYJSCy77wImUJOddE=;
        b=jhnLdZ3w0k9gnjtE8pd/H+SQ5E0a5IiNAtzI4RWUk1vLuHtrSf4EWAackVdCNxSTcq
         wbrSK7BxWMDChO4k8surRHkenpe6NiJ/4by+m8ravTzdUgS/s57Kp2/0LkksT+B/cIbQ
         9PoJm9xiDlqdwEdU+QAj60aJJ4Q0pAZDC6SkBjawA+9vKXO7EzQgfV9GIyx4yax9DtFm
         THzEgVMTE4U8rLNIpuGZ3ZExx06B3CHofxSMbQ4iUmzhinq0ROQA4+G8voO6Jc2vpXHB
         SyckhdMx87fRraY+rHOZmBxUXRg8/0s8UOJgqDZxw92TigmUpozBpfBhafDanuDxBP7P
         qP2g==
X-Gm-Message-State: ALQs6tBibtF1vXe7dC5ikVKW89qVCNt1RnmJjt5BxLwQC0FK49/XWae3
        nO4YDgAcbAmtmxFwfTejmUK/mg==
X-Google-Smtp-Source: AIpwx4+Km1PnWBN4Osvlh5G4jWo9GfrNmarAOs2AR+wGpsdX0uVY+lIoER58qbMuT7ieGqKHbVW3vA==
X-Received: by 2002:a17:902:5602:: with SMTP id h2-v6mr23188552pli.115.1524594214657;
        Tue, 24 Apr 2018 11:23:34 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id a12sm35842568pfe.78.2018.04.24.11.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 11:23:33 -0700 (PDT)
Date:   Tue, 24 Apr 2018 11:23:32 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 9/9] cache.h: allow sha1_object_info to handle arbitrary
 repositories
Message-Id: <20180424112332.38c0d04d96689f030e96825a@google.com>
In-Reply-To: <20180423234327.250484-10-sbeller@google.com>
References: <20180423234327.250484-1-sbeller@google.com>
        <20180423234327.250484-10-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 23 Apr 2018 16:43:27 -0700
Stefan Beller <sbeller@google.com> wrote:

> This involves also adapting sha1_object_info_extended and a some
> internal functions that are used to implement these. It all has to
> happen in one patch, because of a single recursive chain of calls visits
> all these functions.

In packfile.c, unpack_entry() invokes get_delta_base_cache_entry(),
which references a global (delta_base_cache). Does delta_base_cache need
to be moved to the repo object (or object store object) first, or is
this safe?

Also, in sha1_file.c, oid_object_info_extended() invokes fetch_object(),
which attempts to fetch a missing object. For this, I think that it's
best to guard with a "r == the_repository" check, or if there's a better
way to distinguish between the "default" repository and any repository
that we newly create (I vaguely remember some distinction when parsing
environment variables when determining repo paths - the envvars were
only used for the "default" repository, but not for the others).
