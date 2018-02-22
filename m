Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D1801F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbeBVAGK (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:06:10 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39692 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbeBVAGI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:06:08 -0500
Received: by mail-pf0-f193.google.com with SMTP id c143so1364536pfb.6
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sn30SSGpWW+//Zp4f1PLlg7TU2lGkCQKbqNxR0q+Q/I=;
        b=GJtyFAgb9eOm8vf25HL79x7xTUtTieu7YCiMNz51R2gvrV5rao83UgQ49cTvxf6B2M
         IX7QdJ7qkttFjNmy4F/zcygey5SRvhx/qlkQgVFQjb5D3BJ9Euc5VbrrHD6i95OiWVeh
         l3HQ0XBzIXeoqy0wKJTyZsHogGGbhmDwL7jpRrTjJHnjq+/iGhkqJVNdojsPSUyhh7CL
         M2bMoiIPRVO8VKZCH3/TsH5Gcp5fhLK3QlLVJDUxI/ZT/55OmXhLf0KsX7iewju1dvNL
         ObsPKF6+Fy3qICqUGBgARjHaW7vZ0Jfg084s2Tngc0oLUihJJ6Z0+9mm7iHQ8QRyVu87
         WbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sn30SSGpWW+//Zp4f1PLlg7TU2lGkCQKbqNxR0q+Q/I=;
        b=nWoVziYVi1U7moUtY+q95MeZgHupeAZTTNFJs1x16h7UZ0FQ7YxF7L4sSCqV9lwptj
         JpMkWYrd1oZ/UGkjifQ2iPIYEI32tZeFrmv/vHLhyIqb1WzWgQczNTJR7DXSk3rAt0aM
         v0FJwGNeH6Rx3XJF3Rqwn/rtKP94g02ANdeh+wO+q25mKh10EG+d15pJOv9mlgIRE6M5
         o6oQyBNnbwpLnuPYvc4QfR0Mq/YD90WegW8ARdcYabGQHNE73ioBSXHHQdmqZCysQXPe
         KsH4SGMFh4kCPsFiMx7g7eXQdtrQmRKGFDpAN/V97khexiPJGuPS1v3cDl0FGGxQ0/fb
         3Yug==
X-Gm-Message-State: APf1xPAzAuAqlppfOE+KROjbXDMnbKCST7JBoNCZTI1ft3FHDR7DEJVx
        nD0GWsbpBJa2/RPTUaYU0jMyekgdA+s=
X-Google-Smtp-Source: AH8x225vNnLlTxxiHVNmkpBHYyivG5IOlUcat6Bky3tou7FlinAOJcHigTi6XaSjD0etu4c2ik+Zrw==
X-Received: by 10.98.139.18 with SMTP id j18mr4956755pfe.179.1519257968193;
        Wed, 21 Feb 2018 16:06:08 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id e22sm32554585pgn.50.2018.02.21.16.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:06:07 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:06:06 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 30/35] remote-curl: create copy of the service name
Message-Id: <20180221160606.af3db12daeed08ba68bd37f8@google.com>
In-Reply-To: <20180207011312.189834-31-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-31-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  6 Feb 2018 17:13:07 -0800
Brandon Williams <bmwill@google.com> wrote:

> Make a copy of the service name being requested instead of relying on
> the buffer pointed to by the passed in 'const char *' to remain
> unchanged.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>

Probably worth mentioning in the commit message:

  Currently, all service names are string constants, but a subsequent
  patch will introduce service names from external sources.

Other than that,

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
