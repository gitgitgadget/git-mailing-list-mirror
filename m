Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE97200B9
	for <e@80x24.org>; Tue,  8 May 2018 17:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755366AbeEHRpz (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 13:45:55 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40933 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755223AbeEHRpy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 13:45:54 -0400
Received: by mail-pg0-f68.google.com with SMTP id l2-v6so21474575pgc.7
        for <git@vger.kernel.org>; Tue, 08 May 2018 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bPY3xUKUW5gx1c7OY6gSNVOHwfwaK45sEyniobZo0Ro=;
        b=KeconiZLjJgCYwW3lwbRzePIkUwO2yFX6yPhgUNapWD2Z0oob7g+80bRPlZGut9D6f
         viDqbgo6zSGoxoVTqHdlywsfwYcQYyNE4FV5qa8xxXT7MPk2ot7hcG1ue5y9wEpqBQlo
         j5CYBYtVT/FNGCUTTWuttM2TO47FqsfX6lHMwFH33xjfDCmxH5PNMBWwpmWbPW9NVba/
         ugcHK67t6p16OpvRGRDNgrrPGD0Ofc67rcE5aZBqYDkbbwyvCkO5s3AEa96yw2wFa/q9
         TWSkOe6ia+5w1ZXXTvCVGWP3ryiN8UY9UqQwXOwZpMpUMavOKj9sDJKjA0jkyR8sk1kx
         L1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bPY3xUKUW5gx1c7OY6gSNVOHwfwaK45sEyniobZo0Ro=;
        b=YAHHI1OQnJa7ysbk3BHz5QBm23RdKEJRrT0s2MnOtcj9nompLOAX2bcR7rL4SlpxuC
         bffvZ2TqNHGPpttlMaoYYVIcU3Z6hx7KkrsRMtg+67UTz7pLyXu7vQpBVKrctD4VPeyu
         bvxT0Z2Y7BdsgCoOVNr/4rucrLVf755mpBGfrTfF/B4nEgra8VZrAuYB8ZJskDF0mCyl
         NAQ0XN6MahVTcs49+VRG9YMPwaBGDIlQP53j8INPrUX5tRFq498w8+9mGvZTY8e42jQB
         ccQ1PvCiMXxPIPnGSpLAgRg6xUIhPVA6gUGOX8xJf83pQS2GUCqxQL4xWSwdSY3qoY7O
         lb7g==
X-Gm-Message-State: ALQs6tAl8cAxNGuOc9yDixSSyhXPUIMXbQ7HB5WjuhFH/d0B8db8D5y9
        vj9Ew1j8I87UkYE7diK9yAUhlg==
X-Google-Smtp-Source: AB8JxZppBOP+5G+xe8Emu4yMUtHZSu8TLeLGZ1qlbduSSE8Sep4zfMRGzJyAB6j3aP6UNfMqe8KvlQ==
X-Received: by 2002:a65:6604:: with SMTP id w4-v6mr2982426pgv.102.1525801553908;
        Tue, 08 May 2018 10:45:53 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id h75sm46833883pfh.148.2018.05.08.10.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 10:45:52 -0700 (PDT)
Date:   Tue, 8 May 2018 10:45:51 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        jamill@microsoft.com
Subject: Re: [PATCH v2 13/13] alloc: allow arbitrary repositories for alloc
 functions
Message-Id: <20180508104551.8af4e13823a26680f07611be@google.com>
In-Reply-To: <20180507225916.155236-14-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
        <20180507225916.155236-1-sbeller@google.com>
        <20180507225916.155236-14-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon,  7 May 2018 15:59:16 -0700
Stefan Beller <sbeller@google.com> wrote:

> +	for (i = 0; i < o->obj_hash_size; i++) {
> +		struct object *obj = o->obj_hash[i];
> +
> +		if (!obj)
> +			continue;
> +
> +		if (obj->type == OBJ_TREE) {
> +			free(((struct tree*)obj)->buffer);
> +		} else if (obj->type == OBJ_COMMIT) {
> +			free_commit_list(((struct commit*)obj)->parents);
> +			free(&((struct commit*)obj)->util);
> +		}

Besides the other comments by Peff and Duy, should the "tag" field of a
tag object be freed too? It is allocated by xmemdupz in tag.c, and is
not assigned to by any other code (verified by renaming it and then
fixing the compile errors one by one).

Other than that, and other than my small comment on patch 1, this patch
set looks good to me.
