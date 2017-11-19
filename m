Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05C5202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 17:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751043AbdKSRbq (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 12:31:46 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35432 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdKSRbq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 12:31:46 -0500
Received: by mail-wm0-f54.google.com with SMTP id y80so14541771wmd.0
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 09:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vttJD4imo/mIl0ocTtMXUGi+zBRwbQhv4beQb1tuzDM=;
        b=Tnv9P3PrX9kNUGVR/5JD44gICbMYlTqJ8zjB4CXx1sOdfk1OswhXZPq8k/SGzXvvoM
         UkiAUL12dBSwyyKAprtnQkUO/JPvPkFQUI7XVKcsO3RmMepBMT63huL8tpQ9Bm4kSWFr
         xI0tYTWiOmkD4aMze9K8ppkXfwQXhZDFp8IFLyuRX7JkW6SVBvXZ+ivqTXUz/mUdM7I7
         rp3I/7gzj9JH6X+aGw0NgkuhEv8IwjuLYZV6KQS3uwK2Q+6FiF176kOUzfvGveYG3Bnb
         U6/Zmw4uwPyCNNDQte/vTHZiO+okp6k6J6Zc5DrlGZmxKjqvQcmHNrQp3Nz0pxM3c6RF
         sMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vttJD4imo/mIl0ocTtMXUGi+zBRwbQhv4beQb1tuzDM=;
        b=naLeApRA7nK3wjWh+ck1QhqonTErqWxIYHwgqR4ar1oIrL5bvdS7Y1D+pRt6zkbedE
         OntdFEYzj3jddLJZDqJwjh0JwrwFCjUJOFsNc3iIkUAmOhWOPBozl2UjS5ftD8mlQ+/K
         os3IueSmE9Mwjr5ZVHtxGoXM7fK/l91ZI87K9hxc9M/rMw78ABqc/u0ETOB4EJ5qkCBc
         z+ADR5a/cd7vokyyvFLs7AQwoYVWRfldUZmPo/tQxYSNbI1e8Iz7N3Wd504d7RehIaMC
         N2rTFM//DzjAfRuyMn+qcGyo1+mh3xMfSV+lSzXJMJGbNoB4Z2M49MjIdqjz+qR4jMeI
         PQuw==
X-Gm-Message-State: AJaThX5gInZ83ZPRdJfTMpopIHnQVEiNPCtmFVyZCAY0OWaU6w6e/IFh
        JjNXnP2rUFT6+rprtITEgmP3u4Xh
X-Google-Smtp-Source: AGs4zMZ5QchHHP4e1T5U4gSngFTykIwHvkjYK0w/hjUMrl9A7Mva9fleur50FGFi67bdQeo6oALMaA==
X-Received: by 10.80.148.199 with SMTP id t7mr16112754eda.124.1511112704801;
        Sun, 19 Nov 2017 09:31:44 -0800 (PST)
Received: from ?IPv6:2a02:8071:3185:fe00:8422:e311:5963:4b31? ([2a02:8071:3185:fe00:8422:e311:5963:4b31])
        by smtp.googlemail.com with ESMTPSA id d9sm6675558edb.18.2017.11.19.09.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2017 09:31:44 -0800 (PST)
Message-ID: <1511112703.8109.5.camel@gmail.com>
Subject: Re: Documentation of post-receive hook
From:   Christoph Michelbach <michelbach94@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Sun, 19 Nov 2017 18:31:43 +0100
In-Reply-To: <xmqq375dtwnr.fsf@gitster.mtv.corp.google.com>
References: <1510872031.23230.7.camel@gmail.com>
         <xmqqpo8hu1fi.fsf@gitster.mtv.corp.google.com>
         <xmqq375dtwnr.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-11-17 at 12:24 +0900, Junio C Hamano wrote:
> So an updated suggestion for the text would be:
> 
>      This hook is invoked by 'git-receive-pack' on the remote repository,
>      which happens when a 'git push' is done on a local repository.
> 
> Oh, wait.  That is what we already have ;-).

But this text suggests that the hook is always invoked when a git push to that
repo is done, which is not the case. How about adding "and updates are reference
in the remote repository"?
