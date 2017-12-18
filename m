Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532BA1F428
	for <e@80x24.org>; Mon, 18 Dec 2017 22:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935380AbdLRWTu (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 17:19:50 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:41180 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933147AbdLRWTs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 17:19:48 -0500
Received: by mail-it0-f66.google.com with SMTP id x28so529029ita.0
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 14:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XRCNkbE51wj8lx+I02RU7OCSaNRN/sKxIKFj7vUYR1c=;
        b=Nd9M5AUxh2KDYk/QHQ89B2s38yOpBiMBi7rEdUo95kHPb2V1RXlwVqoJ4VWc5OZ+fe
         2AgO0YzEth/oGpueqs8o/pgdrkY6lUX6PsJ4I/vS7C3IMfzSKWBxbGd5rEFYrvjyhQA8
         LyKu4ZLO+AImZdCQq6NkKZt28o4BoAjCxGI+Sa1dFhIbOV0BiSEpKq2nQ5NlZUkDTLu3
         nQMSXZhFFYdiAvYOORwkZELRCa/ySI0KnIKYUTSmMpZ1lXrmdCfIgu4xDN5vmuN4nwM9
         W2pRGu8DMt9xacLGPamSpqkJ6qX6FFCKxEAeKjP5ntO4oUcU9Rllaz0VWSweMik3k5T7
         eYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XRCNkbE51wj8lx+I02RU7OCSaNRN/sKxIKFj7vUYR1c=;
        b=E8o0gqVZ/5ezhZlJquMVz8OcSYZiyVFOoQ3E/0n1ru+5wtkosq9FtXNOxUootnPNjJ
         ix1jOrg7D8rZkPPoRSJ8gvi9g8SNw+pKQgP0O+/FGwOByvoKI4fJkkfb/dm0Kia5rOEU
         8d10VR16sp+adkVuqG8dWWp8ZVydFmYjTanhDZay0NyfhTZxH8bteIppwm0Yk+8zSAa0
         yxhlp/RxzHKX42Rzid2kuzWz9e6Lf7s6qH2gpC0/zIkvkJwBTNvtksbwMJddtPoRzFw7
         kxguxc3Xjy9GFjmWFCt+VLb4BHm/1sgrZ0+bOW4zSUcmkR56Tha9SLprMmaRnNF7rfhF
         +EzA==
X-Gm-Message-State: AKGB3mI8uC7N6Ua+zvsoFFNmDY3omJ43LlfrwWOY1S0oHZaWaZ6k1u9T
        mji6DFYIUBvr0U66IvRM25s=
X-Google-Smtp-Source: ACJfBoulVOXJZ7MzLKW4sahCkhZYfkXzCZYrpEXQtQ4TXRY57thJ5nrHqjw3z6hla69asBBIhbJ3yw==
X-Received: by 10.36.37.138 with SMTP id g132mr869056itg.72.1513635588157;
        Mon, 18 Dec 2017 14:19:48 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p17sm6863442iod.15.2017.12.18.14.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Dec 2017 14:19:47 -0800 (PST)
Date:   Mon, 18 Dec 2017 14:19:45 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Doron Behar <doron.behar@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
Subject: Re: [PATCH v3] imap-send: URI encode server folder
Message-ID: <20171218221945.GC7854@aiede.mtv.corp.google.com>
References: <CAPig+cSOn8PV52aL0Ky5uUwFfNMWye93UQGioRiXjj0ze9HX+g@mail.gmail.com>
 <20171218191113.18600-1-kaartic.sivaraam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171218191113.18600-1-kaartic.sivaraam@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam wrote:

> From: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
>
> When trying to send a patch using 'imap-send' with 'curl' and the
> following configuration:
>
> [imap]
> 	folder = "[Gmail]/Drafts"
> 	host = imaps://imap.gmail.com
> 	port = 993
> 	sslverify = false
>
> results in the following error,
>
>     curl_easy_perform() failed: URL using bad/illegal format or missing URL
>
> This is a consequence of not URI-encoding the folder portion of
> the URL which contains characters such as '[' which are not
> allowed in a URI. According to RFC3986, these characters should be
> URI-encoded.
>
> So, URI-encode the folder before adding it to the URI to ensure it doesn't
> contain characters that aren't allowed in a URI.
>
> Reported-by: Doron Behar <doron.behar@gmail.com>
> Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
>  imap-send.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Thanks!
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Is there a straightforward way to check that this behavior gets
preserved in tests?

Sincerely,
Jonathan
