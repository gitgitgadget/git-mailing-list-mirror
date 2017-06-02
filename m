Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16E4620D11
	for <e@80x24.org>; Fri,  2 Jun 2017 01:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdFBBbK (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 21:31:10 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:32914 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdFBBbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 21:31:09 -0400
Received: by mail-pf0-f179.google.com with SMTP id e193so42232094pfh.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 18:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z2vCduFd+EmAm0QLhdQNH4VbPfC828ri637RFWw6/I0=;
        b=K7uuXUp+KjVV9zq2l9sIbdQBD8blBrGTIAWyfpY+FO34wwkuDWjPp+dh1jpDHkpKQS
         XoefC0dPWdyI0DmVPcUI5CTiU0SY2Axe3BhvLZ1DhmbkpCa/kHySf2fYNo0j0vXzY52d
         qmclxvAi5CF3ZH/dbhkUTp7CwGPJYoCN6Sb/YEIJlZDG6wiwCwcbs+MaMj/dPA/g1eAq
         pg5+gn0s7z6aOy9qdNqAwQTwrTTVGRKrJ8NH6dzuOy6JILB/ztuThxOPWXiU9/NRsWHT
         5+wtuPQJkNyj/GuUVtRrOHlkN6pP2Y7dXmZLbMk/GJINuxvqC8UTheSQtSsJ+ToL122c
         w59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z2vCduFd+EmAm0QLhdQNH4VbPfC828ri637RFWw6/I0=;
        b=ryYzN75TnBCD6JAA5stFDzt8qZDwzTPemsKvAQygaaaPJPM/3y/95x5MHy9ZscIF0c
         9PiBZLj4jyCV7+ojKLiOhvNN3ayqKHGQOzHY1Ih0uRiviL1/bkHkEoeiYMKVWtWck/I1
         +CAxHIXzW+0FvvUaesv4EMngf/i1hqV8pfV2HRWPeje6akzZLYptYBkAx9iw95UvjPgE
         A42usk0HTcU1smAkodCyKEos1U68RKMPbfS8z3f4d/1FIjZUVzABLWBdJYdpkBXTj6Dd
         pVUJQMAqJlAvnWDBcJlHnvavU4LbG+aSbc19Vz/5fE+qUE4DhzsD+T4eABF/vlpMeGfC
         zfpQ==
X-Gm-Message-State: AODbwcCVMjQm6jV1FkGlHNad0fUfxR26PPBALMrCnZJQuZoS22sy+f1J
        thPEUKyC7/K8JA==
X-Received: by 10.84.232.71 with SMTP id f7mr100657803pln.168.1496367069039;
        Thu, 01 Jun 2017 18:31:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id 74sm31524341pga.58.2017.06.01.18.31.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 18:31:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 30/33] tree-diff: convert diff_tree_paths to struct object_id
References: <20170530173109.54904-1-bmwill@google.com>
        <20170530173109.54904-31-bmwill@google.com>
Date:   Fri, 02 Jun 2017 10:31:07 +0900
In-Reply-To: <20170530173109.54904-31-bmwill@google.com> (Brandon Williams's
        message of "Tue, 30 May 2017 10:31:06 -0700")
Message-ID: <xmqq8tlb2n1g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> @@ -220,7 +221,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
>  	if (emitthis) {
>  		int keep;
>  		struct combine_diff_path *pprev = p;
> -		p = path_appendnew(p, nparent, base, path, pathlen, mode, sha1);
> +		p = path_appendnew(p, nparent, base, path, pathlen, mode, oid ? oid->hash : NULL);

This is a correct conversion, but it shows that "struct oid" that
has "hash" sometimes makes things a bit cumbersome.  Perhaps
path_appendnew() and friends need to learn to take a pointer to
"struct oid" next.

