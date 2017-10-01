Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FF3C20A2D
	for <e@80x24.org>; Sun,  1 Oct 2017 00:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbdJAAGw (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 20:06:52 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:49481 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdJAAGv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 20:06:51 -0400
Received: by mail-pg0-f49.google.com with SMTP id v13so1410530pgq.6
        for <git@vger.kernel.org>; Sat, 30 Sep 2017 17:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XX+fytSTDqnBwW+eINUwNUC3bco7JwHeWxD+t2TZnnw=;
        b=SWgzG6dDrXsZUQfHq1QlfDLJZThJOLhngYged6tDOsW53JkfKXBeIdyYXBaEH9lluA
         MmnalQmVThgKXYOVptZRUhqsRXs3hmWL6bYY/KeA3dNNhXTSoruqO7NRXVwRtM+VkL/j
         IzNcKTb4CcO2xPTu/3mM1OXWgNbPJuIaHFQuT0ndxTFoyxzec2giRUnjfwa78wyqk0wl
         r4uIi8MiBLTirK7fu4sNK6IpLjgCAcoaPt2Xzvrf9EwvwhwKG62SZGcwNf7qIIsexssi
         zvQb/a9UCw0Cclk2p+M95gs6ElmHd69TmY+aWfgX/32OMn25Xy1VStNg1FCDv3yi6uet
         rG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XX+fytSTDqnBwW+eINUwNUC3bco7JwHeWxD+t2TZnnw=;
        b=IwS9VEgOeBg5GyBqVo6KvvQmhmfzBfiZecqXpdkWtVxaVE8TF0vf2tPApspcCWYEyo
         WgtRspbVRR7JUfC1JyQKC9p726rmkT9jD8h+y50dVRc/zngy1Z49aabq9txzBKsxoHIc
         CtGGaFoxsPvoMgD0VpQcE9ejG1oFbSsobWdZUHG6xMVrhyi7rlt16kIxOB3ckFk587r2
         yfPBj4Qs3DLp8AdM+jpC2xQRtBN6bSpiYaNXi2nyvmX5dEKCkNM3Tx+7yYf/A6c0HUtO
         NehN5h3+g4fzi3tZfhYzuQxY0z6M43OeOBjb6wg/ea0W68JsDP2ddRiZHN1r5tX3ipiz
         asWA==
X-Gm-Message-State: AHPjjUhkm9zk2zeOMxr+ET5lhlr2fU+r9TpEu5j/cbW5PRzx1hYXd4zy
        xkwzs1rQY0cc+zoee0CJiZBHqjW7PrQ=
X-Google-Smtp-Source: AOwi7QDtyf8ZGEm9Av8+Nia8Ty6snFr2nI9yQew61CeHih/3DAUBBrCzoWq/lKG7rAUBBH1gRiwjkw==
X-Received: by 10.98.194.20 with SMTP id l20mr10958557pfg.50.1506816410670;
        Sat, 30 Sep 2017 17:06:50 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id z9sm11766833pgc.85.2017.09.30.17.06.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 17:06:48 -0700 (PDT)
Date:   Sat, 30 Sep 2017 17:06:47 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Support %(trailers) arguments in for-each-ref(1)
Message-ID: <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
References: <20170930062238.87077-1-me@ttaylorr.com>
 <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is v3 of my patch-set "Support %(trailers) arguments in
for-each-ref(1)".

It includes all of the changes in V2:
>   * Accept "empty-sub-argument" lists, like %(contents:trailers:).
>
>   * Fix incorrect tabs/spaces formatting in t6300.
>
>   * Modern-ize code fencing in Documentation/git-for-each-ref.txt
>
>   * Squash commit adding trailer_opts to used_atom structure.

As well as fixing:

  * Incorrect indentation in pretty.c (specifically: "pretty.c: delimit
    "%(trailers)" arguments with ","")

  * Issues with --format="%(contents:trailers:)", where
    trailers_atom_parser did not correctly handle empty string ("") and
    NULL's the same way.

Thanks in advance :-).

--
- Taylor
