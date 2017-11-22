Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D5822036D
	for <e@80x24.org>; Wed, 22 Nov 2017 01:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbdKVBh5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 20:37:57 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:45727 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbdKVBh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 20:37:56 -0500
Received: by mail-it0-f46.google.com with SMTP id x13so4344706iti.4
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 17:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qp6SR6Pb9BWjYdIZ2xlpDQaBUD7fH69SESzwNK0ayxA=;
        b=OFO09SNU2FGpryNsDgiukSTNAXMUK/gMtQ68pS5LSBOafvWA8HoKntir0IPIKIbQ0S
         k/EHwDWRar/sG5ZHiu7jeHyKnJVHjghe3yv9VsblV1wdMvoIo+4JqJNSdydRpcMshgau
         E5K8Rikd7ctASc6O0vpLApYR4aEPfEE0OT+4n+P7ZMrOCAMM39Ny+Ih4ADiTZ2rTjup7
         UpueJM+1NyqVWE9rXtJD8YjYZ/PEDzv3XbIwi3oFO0f+WbC5LRK43j9QVmOwJ8eElaGb
         uoHGETMsPL4Rt75R702TwyThEsz9tQhOF5IkgpuRLYy3hqY/LnEJuHpUAtCjUYRSlgHG
         HONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qp6SR6Pb9BWjYdIZ2xlpDQaBUD7fH69SESzwNK0ayxA=;
        b=g8Rg/rvPCY1X5ficYZrorkcJxulGRlidfR559rM6zMY7VGWgS37SmnsARMWOqik25D
         ddUESxt1aANpQyCaG/+YbEHEb/nP9aP/nS3X1P/wHEe4WBG9eCEitfVMwsfoNLWwmR0c
         bgvwCy06wwmEH/Lepq9O1P6cqE4GuMz6IBEhqnUAla+8ixQk5xl1G8lf02HVrR41gGPE
         fliDnN/V+/bVLHmVqCSbXPfKKT0/63PBdNsD+rQKAbjOttTmbCCYE0gukwkk8A5+/RrB
         K6h9077Q4tn9nzVemgN9QBeJd02PVgA+NGKhJCAlCRqog/QQ7REG4NjCON72I0ouxsZ6
         g7aw==
X-Gm-Message-State: AJaThX5lZfhEcSlwjipJ8DlNsp2fB7fId3gv5o6a89oplR1FbAzlEWfm
        cLvl5q6iY/0FNwPBrz3g85cXag==
X-Google-Smtp-Source: AGs4zMZi3E579zXQ772+EPPWjALHShTM5UorxAcy+cbnQZ+H7ftg3dVgDN8S3fHZZIuYxFeGW6l9FA==
X-Received: by 10.36.130.131 with SMTP id t125mr4717956itd.104.1511314675847;
        Tue, 21 Nov 2017 17:37:55 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:4fa:d4be:6ce:3f8b])
        by smtp.gmail.com with ESMTPSA id c36sm3913092iod.11.2017.11.21.17.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 17:37:55 -0800 (PST)
Date:   Tue, 21 Nov 2017 17:37:54 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 0/6] Partial clone part 1: object filtering
Message-Id: <20171121173754.12ae87e8bfdd773efada98e3@google.com>
In-Reply-To: <20171121205852.15731-1-git@jeffhostetler.com>
References: <20171121205852.15731-1-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 21 Nov 2017 20:58:46 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Here is V5 of the list-object filtering, rev-list, and pack-objects.
> 
> This version addresses comments on the V4 series.  I removed the
> questionable character encoding scheme.  And I removed or clarified
> use of the term "partial clone" to refer to a future feature.
> 
> Jeff Hostetler (6):
>   dir: allow exclusions from blob in addition to file
>   oidmap: add oidmap iterator methods
>   oidset: add iterator methods to oidset
>   list-objects: filter objects in traverse_commit_list
>   rev-list: add list-objects filtering support
>   pack-objects: add list-objects filtering

I checked the diff against v4 and this looks good.

I'm still unsure if pre-parsing the --filter argument into a struct
list_objects_filter_options is the best approach API-wise in the case
that we plan to send it to the server, but it does have the benefit of
failing (and informing the user) early if the filter is in the wrong
format, so I'm fine with this patch set as-is.
