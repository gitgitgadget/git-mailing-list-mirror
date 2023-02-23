Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8634C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjBWI2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjBWI2b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:28:31 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4D21F4B2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:28:30 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id pt11so12634889pjb.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UBAO8ASu3lTklaXQ8Q/7MKGA5QHcdcfDE20PT3NYgg=;
        b=Jaw8a6W206AqSDbjolSYOeSLDy7fgsDPYDeq7esthFzsTf8oiVthj3pWKpcwQ6xuop
         ZPlDZ+nxCsxmAWyqOMEGci40Yss5oKKhBZ1fyNetp5nB1Uw4WwqiBDSlscy3ES72gM7P
         V/ZQIivcr3STuzp8QvdMw55f6BJv5S1ZVV46E1GIM1/J5wnGyuGHR53OYnU5SUPrFxs6
         H7KAzvlyINu8stwJBlmU/XA28lZm0+FmjBzTW4YnbFsOykVc1MM+jf1hsdoZJpPjx/Pz
         ubQMRbdzB2WC0gWz2puitWB/NvREPHbD8rVmt0YyB6sm4DBY9JLbICTvONpkRENi90QU
         k8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UBAO8ASu3lTklaXQ8Q/7MKGA5QHcdcfDE20PT3NYgg=;
        b=UYyXEkTzzvH78a11DB++Y6+p5PpPR8EqUZPJRX50NiTNdHoT8wW1v/IPdpB8LZ6ius
         OBOAw0zK6SmBmq0Sl3+kAtISCx8Vwql3WmbTORtpL3cCDFvCKjl9dcHhUS1Q1syD59JB
         /wdey9NggjbXBB3Ga4TP99kkZCBEX6yFmeEpOETLJIaPtso6GrmHDE4IM/SZWivBaQLr
         QgX4/qOvI2aZqE4nHTjPrxRHs0DlkQykTbuIDRUgQbUuVBYpLdEEWWl+Gfz/sraiwqdM
         ksZ2tStoKbMCs17MeMSXCh0tzSr4+G8LHQEWC/NuCwLAu4GUNyxLRg/ZHiIAexiv8r0K
         W8hQ==
X-Gm-Message-State: AO0yUKVys/kzDWePVee78haCDR+jGrsUfZlXs0DbfWjHbUDnLBg9H5Ik
        7m2qnWSv042kv5+eAAdXcUthg8MO+DI=
X-Google-Smtp-Source: AK7set/p41TJRGK1GOtXJD7krlUfbOq/3lLbdIWBB8cvDsn+BKLPwyuL1uECZHyL2t5tGIztcH0IAg==
X-Received: by 2002:a05:6a20:3ca0:b0:be:e0c3:5012 with SMTP id b32-20020a056a203ca000b000bee0c35012mr11062553pzj.1.1677140909806;
        Thu, 23 Feb 2023 00:28:29 -0800 (PST)
Received: from Vivans-MBP.lan (node-1w7jr9y92i5dgt19tzyticxhd.ipv6.telus.net. [2001:56a:740f:7b00:8020:1c0:b10e:fa81])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78c11000000b0056d7cc80ea4sm6513908pfd.110.2023.02.23.00.28.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Feb 2023 00:28:29 -0800 (PST)
From:   Vivan Garg <gvivan6@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, nasamuffin@google.com,
        Vivan Garg <gvivan6@gmail.com>
Subject: [PATCH v3] MyFirstContribution: add note about SMTP server config
Date:   Thu, 23 Feb 2023 01:27:59 -0700
Message-Id: <20230223082759.36021-1-gvivan6@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230222011317.97943-1-gvivan6@gmail.com>
References: <20230222011317.97943-1-gvivan6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation on using git-send-email previously mentioned the need
to configure git for your operating system and email provider, but did
not provide specific details on the relevant configuration settings.
This commit adds a note specifying that the relevant settings can be
found under the 'sendemail' section of Git's configuration file, with a
link to the relevant documentation. The aim is to provide users with a
more complete understanding of the configuration process and help them
avoid potential roadblocks in setting up git-send-email.

Signed-off-by: Vivan Garg <gvivan6@gmail.com>
---
 Documentation/MyFirstContribution.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
 
Range-diff against v2:
1:  d295b4d913 ! 1:  8710c50b1d MyFirstContribution: add note about SMTP server config
    @@ Metadata
      ## Commit message ##
         MyFirstContribution: add note about SMTP server config
     
    -    In the documentation on using git-send-email, it was noted that the configuration
    -    for sending email can vary based on your operating system and email provider.
    -    However, it was not explicitly stated that you will need to set up your SMTP
    -    server details in git's configuration file under the 'sendemail' section. This
    -    information is critical for users who are new to using git-send-email and may
    -    not be familiar with the additional setup required to use their SMTP server. By
    -    adding this note to the documentation, the aim is to provide users with a more
    -    complete understanding of the configuration process and help them avoid
    -    potential roadblocks in setting up git-send-email.
    +    The documentation on using git-send-email previously mentioned the need
    +    to configure git for your operating system and email provider, but did
    +    not provide specific details on the relevant configuration settings.
    +    This commit adds a note specifying that the relevant settings can be
    +    found under the 'sendemail' section of Git's configuration file, with a
    +    link to the relevant documentation. The aim is to provide users with a
    +    more complete understanding of the configuration process and help them
    +    avoid potential roadblocks in setting up git-send-email.
     
         Signed-off-by: Vivan Garg <gvivan6@gmail.com>
     
    @@ Documentation/MyFirstContribution.txt: typical `git` install. You may need to in
      determine the right way to configure it to use your SMTP server; again, as this
      configuration can change significantly based on your system and email setup, it
     -is out of scope for the context of this tutorial.
    -+is out of scope for the context of this tutorial. Additionally, note that you 
    -+will need to set up your SMTP server details in git's configuration file. The 
    -+relevant settings can be found under the 'sendemail' section (see 
    ++is out of scope for the context of this tutorial. The relevant settings can be 
    ++found under the 'sendemail' section of Git's configuration file. (see 
     +linkgit:git-config[1]).

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index ccfd0cb5f3..0430434822 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1001,7 +1001,9 @@ typical `git` install. You may need to install this additional package; there
 are a number of resources online to help you do so. You will also need to
 determine the right way to configure it to use your SMTP server; again, as this
 configuration can change significantly based on your system and email setup, it
-is out of scope for the context of this tutorial.
+is out of scope for the context of this tutorial. The relevant settings can be 
+found under the 'sendemail' section of Git's configuration file. (see 
+linkgit:git-config[1]).
 
 [[format-patch]]
 === Preparing Initial Patchset
-- 
2.37.0 (Apple Git-136)

