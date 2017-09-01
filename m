Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 695241F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 22:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbdIAWCi (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 18:02:38 -0400
Received: from mail-ua0-f179.google.com ([209.85.217.179]:35002 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbdIAWCi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 18:02:38 -0400
Received: by mail-ua0-f179.google.com with SMTP id c27so3982452uah.2
        for <git@vger.kernel.org>; Fri, 01 Sep 2017 15:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g1veL8TeUf4wIKPbFNTnB9kuoOzmD+3mc9s5zFO2+SM=;
        b=HKUDGlzlFDscPaDA2yGbbm6JBZRV0x/VAO2oQ1hriGnO1KGcMANGA1FPG2SbeWImfn
         vmX6a7sQBQAwOyBZ09PrSIqV8iToO5c7+UvAZ8+8zU8adEYH8zOk9H5dyEkPp+T2i/CJ
         FxXlSiZxtiK0Vmg/0cpO2I8QgmaWhUwWqW7k3eFfSCP/IMHJq3zn/Vx27dW3yLGaWYTo
         pSuEjX69zgXIhZxhOlsNy9nZEtKsro2BgugQCBPcB1n90CI2cAN/ikFo/BnGgvv7e/jl
         ivtZqm1XPaQKW4MbgtDPU+W3ZqU0heRJT3DoltoZ+WWikyKRv2lKDkPzAZ6VMUxBNYes
         N6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g1veL8TeUf4wIKPbFNTnB9kuoOzmD+3mc9s5zFO2+SM=;
        b=EbgEOxf1YWmyQGmssPosahVVkvArR5AqtNAiQLcwCDwl7Tt5CINjpulwBnQ+fXppmK
         hEtSZU2fO5FZ5pWoO6uJ+WeARLw+MogoOwMta96b4CkHvCXlLTPvzDouIMgfQ6GuHFYd
         AokBEUJs3R+diMlo3JRTGKeAImTLnAzobwWboCFb82+eq1QEiV4T35g6i5Cgts6G8GGW
         MHVkwI/ZiuG2qm1yAWvUCrcaxfWlbb7Q2cMgj/wAtMHxSLvexqaKCh0HJMn+F596b2UY
         8dJhdclRROSl77cSFumllE8E9P6Ph7ENOMdShEf6TJa3KY2M7161ImNs1oM5DbP7yQoq
         BFZQ==
X-Gm-Message-State: AHPjjUiqp/Smx0jkFp3fqOTQHtepBoetWX/ETDjKt6urgc6tH3zdfYGt
        RNxOVWipWsg23IHfYbHJDiCxEVRrc66k
X-Google-Smtp-Source: ADKCNb7R837+UHRS88k7DU2PV9pnA/uoMKriBjeiyLdgBA+Ov2Ytg6tig4ChYtEjf4WN7b1d5dO5eEiZ13XNw9RmQ4o=
X-Received: by 10.176.89.8 with SMTP id n8mr2132832uad.10.1504303356767; Fri,
 01 Sep 2017 15:02:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.92.212 with HTTP; Fri, 1 Sep 2017 15:02:36 -0700 (PDT)
In-Reply-To: <20170824225328.8174-8-bmwill@google.com>
References: <20170824225328.8174-1-bmwill@google.com> <20170824225328.8174-8-bmwill@google.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 1 Sep 2017 15:02:36 -0700
Message-ID: <CAGyf7-GKAW3Dn_rPKxtidKoXh7a6NmDFYzGrb9tGOszhsMignA@mail.gmail.com>
Subject: Re: [RFC 7/7] upload-pack: ack version 2
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2017 at 3:53 PM, Brandon Williams <bmwill@google.com> wrote:
> +
> +       version = getenv("GIT_PROTOCOL");
> +       if (!strcmp(version, "2"))
> +               upload_pack_v2();
> +

I think the "if" check here needs some type of NULL check for
"version" before calling "strcmp". Without that, if the "GIT_PROTOCOL"
environment variable isn't set, git-upload-pack SEGVs.

This came up when I was testing the "protocol-v2" branch with
Bitbucket Server. For performance reasons, we sometimes run ref
advertisements as a separate process, when serving fetches, to allow
throttling the ref advertisement separately from actually generating
and sending a packfile. Since CI servers continuously poll for
changes, but usually don't find any, we want to be able to serve ref
advertisements, which have minimal overhead, with much higher
parallelism than serving packs. To do that, we run "git-upload-pack
--advertize-refs" directly, and that command has never *required*
"GIT_PROTOCOL" before this change.
