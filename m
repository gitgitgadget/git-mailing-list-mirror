Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316C2C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 19:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbhKVTcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 14:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhKVTcx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 14:32:53 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EC2C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 11:29:46 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 132so19308934qkj.11
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 11:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=lBYU0J3+TE0fFONj0AdjJU4AXG//u37scFDLQl5A+Hk=;
        b=ROeRNI/Dlxo/08rsoFLSm3hbnPfs+j2iz46BEgMoV3u7pOn4Fcz4O9FyvnC8Jy13SX
         1q5k8j+xIO3bQOvaPlvuEbDGwPrvgznc8BEJT6A474Gu/VUKoEMISv509HwVGfs34ba9
         Mye6rwHbMUNuqB1Jbv5lusrTrT99I4CfhJDJtkdMzwJTg5WDjYZ4LRZOI7z1ukn5KTJM
         r2eH6IHzJb9V+9RevU0Y9hy6pwZILXXt6rBR93oWOLpOw30XzjFBdS3gVJNoo4x7Vtbr
         YpI4xZKtJOmNLkFNyIURgcXxvnR9lVLQArmJtDWCmn12zJFo7qMI8iNo79DESIeDX+4n
         FLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lBYU0J3+TE0fFONj0AdjJU4AXG//u37scFDLQl5A+Hk=;
        b=HP4d0dVeewHg0BPyswAHTkWAAuiBWR94pmeVOx/1+I0EC5j0LjwTnNziGsrAvwrHSD
         +PAekqpnGQ7dBdnVepYVK/huUx5HC6DTTYEHXmlelvlNHaBn9FKJAJeJQMJCiCSSqHdz
         h/7b72MxtIGhdNbpudLyC/z8rmQPIJmQYyse1DAjRTJIjsfWkaLOK7Nqa0FFzsySFmQx
         9EmQ1L7YcPF+VgadRuJ0TEQstwFdyd4Ng7Kfz+yyUzcCEqCeBMkdx4uK1IhZ2p7YtLW8
         DuClQvB3c1J1lI87XU/sKXIF44iR5LqbsSMXiP6RtXZt3eb9fET9/eUxxM21Cwn+gRAb
         tBtA==
X-Gm-Message-State: AOAM530crl5O+XeG7RTZTyFUFWeG85ba8p/JCQrThZ4JwJax4n3L9x0u
        VbCKXGA059wW8LtCvdYM+wo=
X-Google-Smtp-Source: ABdhPJzvKzYdmCk4cPQz1XWUNnlgQekMkZDZ6USntk6MzXCWURcYRKMB2Bw+cl6FyXggOEC57PVY7w==
X-Received: by 2002:a05:620a:22f5:: with SMTP id p21mr52527448qki.498.1637609385343;
        Mon, 22 Nov 2021 11:29:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:2589:dd13:53fe:46f9? ([2600:1700:e72:80a0:2589:dd13:53fe:46f9])
        by smtp.gmail.com with ESMTPSA id u27sm5260209qtc.58.2021.11.22.11.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 11:29:44 -0800 (PST)
Message-ID: <69e71cf4-ddab-4791-79e1-51ed990a0273@gmail.com>
Date:   Mon, 22 Nov 2021 14:29:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] Doc: no midx and partial clone relation
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20211122184114.3328662-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20211122184114.3328662-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/22/2021 1:41 PM, Jonathan Tan wrote:
> The multi-pack index treats promisor packfiles (that is, packfiles that
> have an accompanying .promisor file) the same as other packfiles. Remove
> a section in the documentation that seems to indicate otherwise.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Stolee, can you check if my understanding is correct?
> 
> To my recollection, midx does not treat promisor packfiles specially,
> and searching for "promisor" in midx.c seems to support that (the only
> results are relating to selection of commits for midx bitmap creation).

Yes, you are correct that the promisor packfiles are included in
the multi-pack-index.

> -- The partial clone feature records special "promisor" packs that
> -  may point to objects that are not stored locally, but available
> -  on request to a server. The multi-pack-index does not currently
> -  track these promisor packs.
> -

The intention of this paragraph was probably that the multi-pack-index
file does not track the properties of a pack-file such as whether a
.promisor or .keep file exists. I think one thought was to eventually
let the multi-pack-index track those properties, but there wasn't much
value in it.

Deleting this paragraph is a suitable clarification.

Thanks,
-Stolee
