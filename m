Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9DE1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 22:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbeBUWLj (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 17:11:39 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35198 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUWLi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 17:11:38 -0500
Received: by mail-pf0-f194.google.com with SMTP id y186so561702pfb.2
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 14:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLS/KiuGh3XWiLwryrtkDaKLu5EHS3Mo/6cKtS4gAFM=;
        b=f17tX91OHv/YqRfnfzTJoyI/iZWDnW/ecR+CeR87EL1wK8FbT792NCXD7OpBKndmAI
         YbI9lWa6ccqYxrmUXEuSdEzdQNcdL7O1TP+AQ0MXy9YD5FWkJgB2vew1C30UhjnmkFqB
         pOrimh1hctpE46EB3/4oX2grBrbgzW91KvoiVKyR5UlaBqA8iJIH+DaR/vinkGQl63Co
         +uEdtz6ymFF2F71jZEYwhLQwlVISWMOrhd6X0ZVyYgrNavmwPks9r4SiTJymq5Qv1kUF
         3hNOvsyj21IPctiCEAwXzwW+lkbXtRYBvSU67gD8yUZwMc6eQwfpbcb1qarRJO0NqLwP
         SxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLS/KiuGh3XWiLwryrtkDaKLu5EHS3Mo/6cKtS4gAFM=;
        b=jrFje32yB3ZcKWmEywZOPBGINWdZTZl4PpuUna2jii2SMIS6WcyxWaVNEa+v0UbVxB
         nXy+XSdiLUqdjebQvi1gHY7LjuQLdYkz5wY9RjpZspDmN0gPj4WLXwW2jLxQXu9MIsUs
         AifAu4Mg9+vQONYvuZgjJS2mWRsDnJFefvCROpMQxQfzIbENsVBvvf79q8GeHXORaR+C
         xfi5b0jaZLTMlm4WTxQMotseQDuo3cnXDtNihpluHyiQZuWc9riPee0jdQBZ/G1z5280
         qtliWKVbCiWpdy5FmFCa+eEAcWNFhABXXuw9kM30n4blm/zSj5O74augnjy73a/N5xd3
         fOXw==
X-Gm-Message-State: APf1xPBr6bRuRI5HygAQzc6LkxdxwPvZCdDdHoDfsnOprtE4eBJBB5Gs
        i83sctuVIAcIA329XLh524SucA==
X-Google-Smtp-Source: AH8x226GwcmcnVlaUFwVSxjnJPbdGcgsuWxltHQkBucxl8i+y1UHrs1bSCxBepITtLiPrZv90D8+BQ==
X-Received: by 10.99.95.81 with SMTP id t78mr3830975pgb.380.1519251097770;
        Wed, 21 Feb 2018 14:11:37 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id q65sm4846579pfd.140.2018.02.21.14.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 14:11:36 -0800 (PST)
Date:   Wed, 21 Feb 2018 14:11:35 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 08/35] connect: discover protocol version outside of
 get_remote_heads
Message-Id: <20180221141135.c78d72b422f985aae5375bca@google.com>
In-Reply-To: <20180207011312.189834-9-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-9-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  6 Feb 2018 17:12:45 -0800
Brandon Williams <bmwill@google.com> wrote:

> -	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
> +
> +	packet_reader_init(&reader, fd[0], NULL, 0,
> +			   PACKET_READ_CHOMP_NEWLINE |
> +			   PACKET_READ_GENTLE_ON_EOF);
> +
> +	switch (discover_version(&reader)) {
> +	case protocol_v1:
> +	case protocol_v0:
> +		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
> +		break;
> +	case protocol_unknown_version:
> +		BUG("unknown protocol version");
> +	}

This inlining is repeated a few times, which raises the question: if the
intention is to keep the v0/1 logic separately from v2, why not have a
single function that wraps them all? Looking at the end result (after
all the patches in this patch set are applied), it seems that the v2
version does not have extra_have or shallow parameters, which is a good
enough reason for me (I don't think functions that take in many
arguments and then selectively use them is a good idea). I think that
other reviewers will have this question too, so maybe discuss this in
the commit message.

> diff --git a/remote.h b/remote.h
> index 1f6611be2..2016461df 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -150,10 +150,11 @@ int check_ref_type(const struct ref *ref, int flags);
>  void free_refs(struct ref *ref);
>  
>  struct oid_array;
> -extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
> +struct packet_reader;
> +extern struct ref **get_remote_heads(struct packet_reader *reader,
>  				     struct ref **list, unsigned int flags,
>  				     struct oid_array *extra_have,
> -				     struct oid_array *shallow);
> +				     struct oid_array *shallow_points);

This change probably does not belong in this patch, especially since
remote.c is unchanged.
