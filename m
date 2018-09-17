Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EAD51F404
	for <e@80x24.org>; Mon, 17 Sep 2018 16:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeIQVx3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 17:53:29 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46631 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbeIQVx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 17:53:29 -0400
Received: by mail-wr1-f42.google.com with SMTP id a108-v6so17954942wrc.13
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Lyh639jF0+1T7bMWZqcHx1++yZxLuJeEr1LfrBg7itg=;
        b=pYDQjkNS/gsqgsrv+tFcHmXNV87UyDRpA3PSp715R9kmwy6V4nkVXb6j3DMmPyEstN
         b8h5XQqJzzfWhNZkrqx9hPBHymW0D3ZF31NpqSbLILKQQZgHJIG8A1RRSxWXUPW3gWbj
         gL6pDLoOLrTxrCgLql2nzO3CQEhbQBXVUgkmx3GW8SGgx03PSTIhaucT3YdYm1DIs8nd
         Nz+d/xUeNWAXrXRzrgzztmNhDcNxn/m7GQ4WIlDCPjG2xjPHOYxbnR6+ePssRTmtRVl4
         wCLlFROddpDuzXfveT4/T5VZrI+IyJpLuXV4z8ciVuTDSj9eelz3DWem6JuZQ+gg/WaX
         ammA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Lyh639jF0+1T7bMWZqcHx1++yZxLuJeEr1LfrBg7itg=;
        b=TmWHCxhA6FE786s2v4uwarRdoSvI3mCMBVPcy5TG8fJ9HO6wvyftCZ3psza0QCIpaY
         EeAYerOsw9i0WZBfW2gVx5iZqHaj+rmqUiYYnCepcNvL2RjtFnaMdvkZ/AJzWFiJcZCd
         f4adVPlezGougbhdNbFQdyMXs/hDsTsSvvjmPcNjdb74XhoSKldEQWleS9PPtkZKqgij
         iRTjxeshfl8RuHTir/ZQHx5dMZyftFV0RjeRugFZ9N5+XIuAD2d+UWPf1btWnzi+m4st
         O1GeBf89+slt4AIy/ISWdnsNhFHXT70eIVs5wLfZ4oNU6T4Q4JfaMbEhqJqMjQ9DD+n4
         UFzg==
X-Gm-Message-State: APzg51DREV1Cfx07Rpb/+I9DX2ZKXdDmFsDYL11QrCbqVsjPpKuDHU7/
        tkXx87DdQFrymxtOVVaUACvrvsRz
X-Google-Smtp-Source: ANB0VdZLRck14QPY1DyXsjD0+zEHrDEhqoyRfGGZRHTsUhHEMadsWJdivDXN2jTLLfHoSIq/iYiPGg==
X-Received: by 2002:adf:b7c9:: with SMTP id t9-v6mr18799145wre.274.1537201522724;
        Mon, 17 Sep 2018 09:25:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y10-v6sm13772249wrl.87.2018.09.17.09.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 09:25:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 02/23] read-cache.c: remove 'const' from index_has_changes()
References: <20180909085418.31531-1-pclouds@gmail.com>
        <20180915161759.8272-1-pclouds@gmail.com>
        <20180915161759.8272-3-pclouds@gmail.com>
Date:   Mon, 17 Sep 2018 09:25:21 -0700
In-Reply-To: <20180915161759.8272-3-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sat, 15 Sep 2018 18:17:38 +0200")
Message-ID: <xmqqo9cw851q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This function calls do_diff_cache() which eventually needs to set this
> "istate" to unpack_options->src_index (*). This is an unfortunate fact
> that unpack_trees() _will_ destroy src_index so we can't really pass a

Wasn't the whole point of introducing src_index and dst_index to
unpack-trees API so that we can keep the src_index read-only by
writing the result of merge to a separate in-core dst_index?

What does the above exactly mean by "will destroy src_index"?  Is it
now fundamental that src_index needs to lack constness, or is it
something easy to fix?
