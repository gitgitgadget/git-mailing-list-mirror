Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C129920401
	for <e@80x24.org>; Thu, 15 Jun 2017 21:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbdFOVDL (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 17:03:11 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:32795 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbdFOVDK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 17:03:10 -0400
Received: by mail-pg0-f49.google.com with SMTP id f185so11641630pgc.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 14:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KEV4zUmKSPGkV05hql2+9tYER1PvMZeswcq8gwTxRs0=;
        b=AiLF6Wp8MMiLGXRTo4OrkQBUMnZXi/q6WFefyEtIYvbm3WumX6+Wqt205Ysvo0ucpo
         3V/DRokOfW3WWe3767m42wg2kaxSPXObwoN7eA8v11QC0h8y29oomrA2jDxdlBd5zQNK
         58Czu+F/BMyrD/+V7IbVNBmd7nuohDJqXBs9cCMJMtBEKb1kHHU5n6uGcWEBjn/h12zu
         jJh1MHY7Ppmxr4vQvMikfJv8RYs6McTDBYdIFm0eaFbzG5a8zK8iAu8fnUS/zVaO/4yA
         1zUmP3jpZzbXjNT+/D+xeZE/4ql+ulZmFsbCE43HMPlzuZrt1jHIwl26q3Fz9mbVqdAE
         lbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KEV4zUmKSPGkV05hql2+9tYER1PvMZeswcq8gwTxRs0=;
        b=ENgcbFEoqXUxSO2uPia5OvpX73AtprEbL/JVNz1LbemOvypvCGC2u7IhieC6iEZbBg
         +kzBYWsLwmQY3TGXzMQafCNXpfEtvMTmBJ9+DY1xa436t+K6j4Cu6QyYEDsvqG+tXlrw
         +oSs3PgNo5veAXnng62Y+huxTXEhGzZtwm3i2XGb7rhe8JDjRCiTQEFNa4Xg8WIPF8ua
         /hBPcakIHvKHjNdl2GnxNMJZ8vFqr95VUh6uvHDWrkNxwgiQy/8qc2sxfMS/qdq0B2zF
         YH0gOyFZkhwfKzFRHjVLfYDg0kL3N0bteevE0mIxJalGhai9X7rMUOnekvKTP43kbSrB
         acig==
X-Gm-Message-State: AKS2vOwTKidMr26NCDEdpJ1wTPXgBUwemqdxghRlGgfYVBunq1zpZhn6
        tP1AsKs6pgv6srDP5k/p0w==
X-Received: by 10.84.214.150 with SMTP id j22mr8373059pli.137.1497560589649;
        Thu, 15 Jun 2017 14:03:09 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a05c:fb80:1fb9:b013])
        by smtp.gmail.com with ESMTPSA id e18sm315465pfk.118.2017.06.15.14.03.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 14:03:09 -0700 (PDT)
Date:   Thu, 15 Jun 2017 14:03:05 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [WIP v2 2/2] pack-objects: support --blob-max-bytes
Message-ID: <20170615140305.4f79f5f0@twelve2.svl.corp.google.com>
In-Reply-To: <14b1fbb0-d4fb-1dd3-936c-deea6d20a99b@jeffhostetler.com>
References: <cover.1496361873.git.jonathantanmy@google.com>
        <cover.1496432147.git.jonathantanmy@google.com>
        <6f7934621717141ce3bb6bc05cf1d59c7900ccc5.1496432147.git.jonathantanmy@google.com>
        <20170602222640.u6vni5tdpjp3sayt@sigill.intra.peff.net>
        <14b1fbb0-d4fb-1dd3-936c-deea6d20a99b@jeffhostetler.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 15 Jun 2017 16:28:24 -0400
Jeff Hostetler <git@jeffhostetler.com> wrote:

> I agree with Peff here.  I've been working on my partial/narrow/sparse
> clone/fetch ideas since my original RFC and have come to the conclusion
> that the server can do the size limiting efficiently, but we should
> leave the pathname filtering to the client.  That is, let the client
> get the commits and trees and then locally apply pattern matching,
> whether that be a sparse-checkout definition or simple ".git*"
> matching and then make a later request for the "blobs of interest".

This means that the client would need to inflate all the trees it
received, but that might not be that bad.

> Whether we "fault-in" the missing blobs or have a "fetch-blobs"
> command (like fetch-pack) to get them is open to debate.
> 
> There are concerns about the size of the requested blob-id list in a
> fetch-blobs approach, but I think there are ways to say I need all
> of the blobs referenced by the directory /foo in commit xxxx (and
> optionally, that aren't present in directory /foo in commit yyyy
> or in the range yyyy..xxxx).  (handwave)

Unless the server no longer has the relevant commit (e.g. because a
branch was rewound), but even then, even if we only sent blob hashes,
the list would be probably much smaller than the downloaded pack anyway,
so things might still be OK.
