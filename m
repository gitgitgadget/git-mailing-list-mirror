Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44AB6202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 20:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965074AbdKPUVi (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 15:21:38 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:39392 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964935AbdKPUVg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 15:21:36 -0500
Received: by mail-io0-f174.google.com with SMTP id x63so6506227ioe.6
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 12:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cG6silSadUxZVdJUxFk23/NIsCdLX+MqZED0FvE+qe0=;
        b=vXxT1Dk+woy6VKke6w05pHVkaQcJ+VHBpTPLbae8flkVCU3ovLlJNh9vLCcwkGlg75
         +gBmOgbxXvBUOQN13cwxf5mAzhwPAphcv282oAEPi6WpmDD5duWSR/UiMPn5j2Z1SYBo
         UYh/8T6dHYIBX9Zr60qFoO8lp3g39+EEewS2ufR450BVKxyYxtjE6nnsSoPTtI0HATgQ
         AZhGXntGg9BP0scpeL1bNm3qZVA4EjRHGlXhC7d9i37mqpRj9WMDnpczMj4OhrB4lE2J
         u6Co67Ly1BY8uog+T0URH3T5Pca5t5/9qkMKRJv/emTBJYkvNfuV9IC4zt9RzMVap7/3
         2WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cG6silSadUxZVdJUxFk23/NIsCdLX+MqZED0FvE+qe0=;
        b=DGJBYQP+QDWt4Hb8QH0F7NkxxCE1zYchZ8/myleBvDNOqGOEHSA6h3MgMvEWx2T5GX
         QkXCNgzfU/X5gOesWktoUldZpKdLDfYShyyh04HOky/sXFEGzjbH8987Y1uaHmW3WwHr
         MhcgcUeXcrAdUeCAIrviYZ6tWzs74sYrU8L+Z4evbqXqaUelbEv70wKh/hG73km5vtiq
         D9aOrbbKJIFDm9vl1O8Ap3J+WWsxwPlM5JrZ3KrfYlCPoxGvg4ZgQQakkY/VrxR2D9tW
         kg3W5wpdvCjhl11hg1IajCamBMrCPM5RP5XseXsnl7Qmj9vcKqewnFVAF+PtoXbax5Op
         fKcg==
X-Gm-Message-State: AJaThX7ZlYuQRdIf1bg1RzD/KiM4zVEQOay9rZ6KiuHroIXX2WZbdBM4
        KS0xnswXv3v7nHoKiF+9W+wq3o5XgQo=
X-Google-Smtp-Source: AGs4zMY14v0s49XZQX5jIMp2+Ev117e43B4uGkNm3zPNkH8utpcrKtEKJFehr06jjL3fMDYb10vUjg==
X-Received: by 10.107.7.75 with SMTP id 72mr132542ioh.14.1510863694903;
        Thu, 16 Nov 2017 12:21:34 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:28fc:a358:3592:211f])
        by smtp.gmail.com with ESMTPSA id v19sm1178091ite.4.2017.11.16.12.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 12:21:34 -0800 (PST)
Date:   Thu, 16 Nov 2017 12:21:33 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 4/6] list-objects: filter objects in
 traverse_commit_list
Message-Id: <20171116122133.4cc718414579c1a5a682174b@google.com>
In-Reply-To: <20171116180743.61353-5-git@jeffhostetler.com>
References: <20171116180743.61353-1-git@jeffhostetler.com>
        <20171116180743.61353-5-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 16 Nov 2017 18:07:41 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> +/*
> + * Return 1 if the given string needs armoring because of "special"
> + * characters that may cause injection problems when a command passes
> + * the argument to a subordinate command (such as when upload-pack
> + * launches pack-objects).
> + *
> + * The usual alphanumeric and key punctuation do not trigger it.
> + */ 
> +static int arg_needs_armor(const char *arg)

First of all, about the injection problem, replying to your previous e-mail
[1]:

https://public-inbox.org/git/61855872-221b-0e97-abaa-24a011ad899e@jeffhostetler.com/

> I couldn't use quote.[ch] because it is more concerned with
> quoting pathnames because of LF and CR characters within
> them -- rather than semicolons and quotes and the like which
> I was concerned about.

sq_quote_buf() (or one of the other similarly-named functions) should
solve this problem, right? The single quotes around the argument takes
care of LF, CR, and semicolons, and things like backslashes and quotes
are taken care of as documented.

I don't think we need to invent another encoding to solve this.

> +{
> +	const unsigned char *p;
> +
> +	for (p = (const unsigned char *)arg; *p; p++) {
> +		if (*p >= 'a' && *p <= 'z')
> +			continue;
> +		if (*p >= 'A' && *p <= 'Z')
> +			continue;
> +		if (*p >= '0' && *p <= '9')
> +			continue;
> +		if (*p == '-' || *p == '_' || *p == '.' || *p == '/')
> +			continue;

If we do take this approach, can ':' also be included?

> +	if (skip_prefix(arg, "sparse:oid=", &v0)) {
> +		struct object_context oc;
> +		struct object_id sparse_oid;
> +
> +		/*
> +		 * Try to parse <oid-expression> into an OID for the current
> +		 * command, but DO NOT complain if we don't have the blob or
> +		 * ref locally.
> +		 */
> +		if (!get_oid_with_context(v0, GET_OID_BLOB,
> +					  &sparse_oid, &oc))
> +			filter_options->sparse_oid_value = oiddup(&sparse_oid);
> +		filter_options->choice = LOFC_SPARSE_OID;
> +		if (arg_needs_armor(v0))
> +			filter_options->requires_armor = v0 - arg;
> +		return 0;
> +	}

In your previous e-mail, you mentioned:

> yes.  I always pass filter_options.raw_value over the wire.
> The code above tries to parse it and put it in an OID for
> private use by the current process -- just like the size limit
> value in the blob:limit filter.

So I think this function should complain if you don't have the blob or
ref locally. (I envision that if a filter string is to be directly sent
to a server, it should be stored as a string, not processed by this
function first.)
