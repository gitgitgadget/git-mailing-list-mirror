Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E38201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 17:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750857AbdKLRWO (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 12:22:14 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:50965 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdKLRWN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 12:22:13 -0500
Received: by mail-yw0-f182.google.com with SMTP id i198so11722201ywe.7
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 09:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WnyMlxKqFQngtiXLjmz59rV8CWR8E6AUSBqvgbh9PQw=;
        b=jaFsf4trLU19PXK10elP5inmONtyhsf0ndnsBE6qCBnyBjWSSjHoOuEAjHYkyfp1qq
         YTzyb1cHY88H2qV+s+Wx7a6w+1caO4phZJ/KMDLiysMbyuU/pvCc56nzOXdXJ0MFw9yS
         RlZJYKu9EyBUzgE7P6fE7dw76E5VXIQ8Burx7aUxKz9iBPlC0IpkrQxss8nc8pj26uaf
         5QpoLn8c2uW8lo2VFG64bx3+qTkFHSRhcxwAGu7le1HEi18t5RhaM8Tl1PREP+t3Ef90
         1FZdGsYIcsKU+QR43Y/VUgI388ut7ZW9VRTZ3XMBfSCectl8RsC7hyWrhDXR2pVkPukl
         8x3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WnyMlxKqFQngtiXLjmz59rV8CWR8E6AUSBqvgbh9PQw=;
        b=m2SnxwTRIZjPDWlhAzRlILFSoiYD2Bb/6dr5LgJBSjBb64SH+PuXEr+bYdmGXI6+fx
         ZOowbos+BgjNTsffmbna6I2Tvt3lVZhs/ragUMw4dw/8ERIbpniZdKqcKDm4LdhUT+xO
         laJYxetu6zUzKnuIG2KI4x5Ca3wsaDXH24atcULnyaQ4rBwSyU4wLHd2UdVdPkgt1fC3
         DwE7Kvgx6gUUaHAmfdNSZws9FVaZLKwMMy0+NCbFkhtVZn7LPBKF3fveEIw0/CYWBtL1
         h/hjec0dmqcE3T8evcSwJZT8A6BPNiqJZ2PbKMiEtrZE1lkNgaI72VAkUYuLVAh9ViK6
         fRlA==
X-Gm-Message-State: AJaThX44oivZ8cNCIlBbpHVRa3MFGKRLhgPg04bE03euqT79y5QOLdLf
        BwQh1YXsTwTomjHL4Ys8lRN5fCVMtYqh05NscYc=
X-Google-Smtp-Source: AGs4zMZ+tyDSzsQ7vxtRSODp2RoEtcnqx+raLO4nc7Wt2OqnYINhT7nEyT8TwIKITWMDYwYahguEVjcqNqSiH9wMGro=
X-Received: by 10.37.56.211 with SMTP id f202mr4055523yba.135.1510507332692;
 Sun, 12 Nov 2017 09:22:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.196.68 with HTTP; Sun, 12 Nov 2017 09:21:52 -0800 (PST)
In-Reply-To: <20171112152741.GA15767@hank.wfi.bloomberg.com>
References: <20171110231314.30711-1-joel@teichroeb.net> <20171110231314.30711-3-joel@teichroeb.net>
 <20171112152741.GA15767@hank.wfi.bloomberg.com>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Sun, 12 Nov 2017 09:21:52 -0800
X-Google-Sender-Auth: q1T4DM_vlk0EIontCzBrNb7A9ic
Message-ID: <CA+CzEk_0XQoncz6sW3dQPCdxRCgo=BFHxJWr-MQSLxkVPJz8eg@mail.gmail.com>
Subject: Re: [PATCH 2/2] stash: implement builtin stash helper
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your comments! I've incorporated them all for the next patch set.
