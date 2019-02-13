Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8941F453
	for <e@80x24.org>; Wed, 13 Feb 2019 18:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfBMSud convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 13 Feb 2019 13:50:33 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:34344 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfBMSuc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 13:50:32 -0500
Received: by mail-lf1-f53.google.com with SMTP id u21so2622367lfu.1
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 10:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ITh6Z1keW7UQ2IzURGXt27oRc0pb5aPIiqV/2kOdfdY=;
        b=Fyg8i887c26XgqFkLdpVlHc3vvoV9j3XKqhW5vQ1fyQagzo1zOBaXmqi63OTCgW1Qu
         4gC/pklWDVVQrMUXNVjTVcgLfQ2v6HTK5nglRZAexLp6bHSCVOcbKA25gFzsG8lJ5hqY
         29GHJ3n0EvDM3Zk4HqpB5/dOdMmjV6ihdreaKgLrTPa0gvQltuqVOiJ5Jkqbv5iaapmP
         xnw1Kaaoiq4h8vBZn7FTi1W0t579y3UmmwEel5C5xwGF2UJFEhWvCe3TrpyzdDTFqcnm
         wb2X3b2ooctFL0DxNncGQ+qyaaMcdK9/Y36pBXLGOW0OPlubHxly1bpRJxtqr1fY56G3
         oGXQ==
X-Gm-Message-State: AHQUAuYD/VjfuZagCDfDv18ebMXH3QrQCjDxNGTlcA1grqdM7JZ0OCzv
        QgKkckoewfiDxgxwYcfNt/BLn9dXqRQ=
X-Google-Smtp-Source: AHgI3IYaqZFNbfNy4mEfPBhOJjKG/olaK3JQT2KVbs/Weqii0PQf0d8+IUu735hFfcVn8wtYtuwFHA==
X-Received: by 2002:a19:645e:: with SMTP id b30mr1187891lfj.15.1550083830297;
        Wed, 13 Feb 2019 10:50:30 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id j82sm13490lfe.13.2019.02.13.10.50.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 10:50:30 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id l7-v6so2937620ljg.9
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 10:50:29 -0800 (PST)
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr1147493ljh.135.1550083829723;
 Wed, 13 Feb 2019 10:50:29 -0800 (PST)
MIME-Version: 1.0
From:   Sylvain Lacaze <sylvain@lacaze.me>
Date:   Wed, 13 Feb 2019 18:50:19 +0000
X-Gmail-Original-Message-ID: <CAH1FtBpcZJ8V4B=RJ0SfC+kehpmpaBGafDzXvi8i33rc++jOUw@mail.gmail.com>
Message-ID: <CAH1FtBpcZJ8V4B=RJ0SfC+kehpmpaBGafDzXvi8i33rc++jOUw@mail.gmail.com>
Subject: External tool is ignored when using difftool with --no-index
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have “p4merge” setup as diff.tool and merge.tool, and it work great
in normal operation (i.e., “p4merge” opens), e.g:

$: git difftool HEAD~3 somePath/someFile.m

However, when I use “—no-index” to compare 2 arbitrary file, difftool
just uses diff:

$: git difftool --no-index somePath/someFile.m somePath/someOtherFile.m
$: git difftool --no-index --tool=p4merge somePath/someFile.m
somePath/someOtherFile.m

Both the above command just yield normal diff.

I’m using the latest GIT build:

$: git version
git version 2.20.1.windows.1


Best,

Sylvain
