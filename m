Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A609201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 22:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbdGCWAz (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 18:00:55 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34276 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbdGCWAx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 18:00:53 -0400
Received: by mail-wr0-f172.google.com with SMTP id 77so240321932wrb.1
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 15:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:user-agent:date:message-id:mime-version;
        bh=foLlIqoJhZHbc6jBAdv1510839LJZHvkGKNVl8XeY9Y=;
        b=hpAbXw8M7u6I8yPPjKwgcgQSJp0ACA4qWYbzdPowA3yS31o/XMs0VzgFVPdK9iFTNQ
         CBXqpD2Wl/TmxMPMwWaIaMwx0aB9lE5DZeQ/y6RVTtHMjos6cc3bChQ20FYHS7ZBBwWO
         aLgVr0meLZPSB6h0XudeDwILMJyFPRBc3PRolg6Zg+EyRhwsIlKZq5Ba33pmPwK1l9cu
         sRt5G2X2Rm8IwFFFR/p3tWke4Y7v28a06LuXJXu/H5tAizjPVFE1JUlc6Fkq+sQsTVau
         SdRaSpX8OzRn1Yt8y/5Z9S3jMmSf/RlIl0MuQz5YPmdeF8ZAOrB4xcwE0MCOtV184T26
         fC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:user-agent:date:message-id
         :mime-version;
        bh=foLlIqoJhZHbc6jBAdv1510839LJZHvkGKNVl8XeY9Y=;
        b=cHmHYkAWy9P6dx8pe6j2UUuzinX2YUb3f24sQFnglUehrXfBMys2q5nECuyZ6YPlDt
         IylacALVXmQwMZb4qt2n0KhD+D6ibuyGCdZhjQ3hzRu7MoLZABqvsmtesh5czlIJ57Hj
         I5X4tfVhtreG3t6F8e6PiVM8gDPeFNvhaZS+3blaPFGciujiG3ZR9JVYJjGJhrhD9Lzq
         Yap013iIQgZwrU/czn0cgIfm1S7FhWb81YurQS3pOHwGMaXX9KCMAnXY7Z8ErRhZ19YO
         LWRHGAPstwFxdN3y8DEKtoejjQ3rWuM+K2Zja5dgDungLPZwugpCIzSqfsgOe6WImbmW
         qOzA==
X-Gm-Message-State: AKS2vOw27N38H3MjbseyBdJlV7ROFYZyu2fYszw85YbEYKj3awlwtfu8
        BQ9AMiFskHlVkFPPZzE=
X-Received: by 10.223.172.67 with SMTP id v61mr37956866wrc.112.1499119251854;
        Mon, 03 Jul 2017 15:00:51 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id r187sm24719111wmg.15.2017.07.03.15.00.49
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jul 2017 15:00:49 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dS9Oj-0005ZB-4l
        for git@vger.kernel.org; Tue, 04 Jul 2017 00:00:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git ML <git@vger.kernel.org>
Subject: Should "head" also work for "HEAD" on case-insensitive FS?
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
Date:   Tue, 04 Jul 2017 00:00:49 +0200
Message-ID: <87ziclb2pa.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I don't have a OSX box, but was helping a co-worker over Jabber the
other day, and he pasted something like:

    $ git merge-base github/master head

Which didn't work for me, and I thought he had a local "head" branch
until realizing that of course we were just resolving HEAD on the FS.

Has this come up before? I think it makes sense to warn/error about
these magic /HEAD/ revisions if they're not upper-case.

This is likely unintentional and purely some emergent effect of how it's
implemented, and leads to unportable git invocations.
