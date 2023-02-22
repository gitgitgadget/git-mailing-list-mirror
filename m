Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17CBC61DA3
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 01:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjBVBOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBVBOB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 20:14:01 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0545C643
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 17:13:58 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e5so8117324plg.8
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 17:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mPqNIaPYx6IuQyMC9QN5XM6Bgi9LbwcnbZDzOe4cUQU=;
        b=jscdO+YetvnVPtguxq7XBDehi2Uxsk62yx7ejuYyxaE3RGzfIu2ygSh7RVUJPd84fN
         CHQVMltzKF9Nteqx5V01niCb32wVBybIqWmWOBWqp2p/57z512KwOIo0cwCb38/RB48V
         /2E7sT6Z/ci3YuYSC+F1BxjCDTTOMzUqAb2JNG6VU8ehIIP8uYPdjYqq3nzNCHNqZSs4
         xxF+7/D/RTRz9DrG9YjMAege58lqP+yK1E2cDG2X/+9W+V6g0OwsSQJ6J6o2cnJsoVJc
         YQayj4d3fXZMvfrukcRJnVljjZzipKJsMul56ebXQRUH62dIvlPtvPr50+PLw3Jiz7CF
         pQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPqNIaPYx6IuQyMC9QN5XM6Bgi9LbwcnbZDzOe4cUQU=;
        b=jRTZVMqwcBwBxPSK6QFM2S8lz/b0yAfOZpSwZMuVVKQ8skPtQ3DYkYNOpuEN+sh8C9
         RUWAM0KodqpvxHhh7IXfO0urJsSUXLaoIVvWvmiSCNWp2y/qmPgQOX5B8wZEQkkYRpZ1
         Z37htNh7jkwgqKAMdqcQD0+EUZrTfd4FlUi29Xtx7I94V8+TYx4eHR/3bxfg9gt3mbvo
         9HhupHtEUJF3Q7BAcP8pFJWZl94LUhJGkUhon3AT4gkW8kEynGtYdiQWInkA4SS5tTYQ
         UV4TSm83BRED/Axkw0bpGO4ThBMenZXAaQ1lttirUQ89K1qEfncq3iluFDuuCUn+2Ry6
         mlYA==
X-Gm-Message-State: AO0yUKUckMSDmM+++HSdrKeusAzvuR0zhvfsmgPgZy5wPhkk7lLywDRA
        KqbUa82C4FmF6R/rbvKpMHXDz1hXLSGZsA==
X-Google-Smtp-Source: AK7set9n/GonYsqpqOv7moXfYrBV5uvFZRqThq92b+wGPCAGZq4ZAGwFN/IlHZp7k4Wgzs7XZPDMRg==
X-Received: by 2002:a17:903:230f:b0:19a:96f9:f55b with SMTP id d15-20020a170903230f00b0019a96f9f55bmr10778102plh.27.1677028438256;
        Tue, 21 Feb 2023 17:13:58 -0800 (PST)
Received: from Vivans-MBP.lan (node-1w7jr9y92i5dg56d59ey2wgev.ipv6.telus.net. [2001:56a:740f:7b00:548b:6839:29d0:4517])
        by smtp.gmail.com with ESMTPSA id iw11-20020a170903044b00b0019a733a75a2sm10545975plb.60.2023.02.21.17.13.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Feb 2023 17:13:57 -0800 (PST)
From:   Vivan Garg <gvivan6@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, Vivan Garg <gvivan6@gmail.com>
Subject: [PATCH] Documentation/MyFirstContribution: add setup template for git send-email
Date:   Tue, 21 Feb 2023 18:13:17 -0700
Message-Id: <20230222011317.97943-1-gvivan6@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The doumentation under [[setup-git-send-email]] fails to describe what
needs to be done with the SMTP server information. Although the email
provider will tell you the specifics (such as the serverport), it must
always be added to gitconfig. By adding this, a new contributor can
simply find the information and insert it into the template, saving them
the headache of figuring out what to do with the information.
Therefore, add a template that describes what to do with the
information obtained through the email provider.

Signed-off-by: Vivan Garg <gvivan6@gmail.com>
---
The commit subject line is over 50 columns long, but the file path takes 
up the majority of the space, which I thought was important because it 
shows that only the documentation is being edited. 

The reason I felt compelled to include this is that, while it is simple 
to find the SMTP server information required from the email provider, it 
takes a little extra effort to figure out what to do with that information.
However, because it must always be added to git config, making this change 
makes it easier for anyone to find which fields they need and what they 
need to do with the information. 

 Documentation/MyFirstContribution.txt | 30 ++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index ccfd0cb5f3..37fd416b29 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -999,9 +999,33 @@ provider, and so will not be covered in this tutorial, beyond stating that in
 many distributions of Linux, `git-send-email` is not packaged alongside the
 typical `git` install. You may need to install this additional package; there
 are a number of resources online to help you do so. You will also need to
-determine the right way to configure it to use your SMTP server; again, as this
-configuration can change significantly based on your system and email setup, it
-is out of scope for the context of this tutorial.
+determine the right way to configure it to use your SMTP server; this
+configuration can change significantly based on your system and email setup, 
+but at a minimum, you'll need to edit gitconfig and set the following 
+parameters:
+
+----
+$ vim ~/.gitconfig
+
+[sendemail]
+    smtpServer = smtp.gmail.com
+    smtpServerPort = 587
+    smtpEncryption = tls
+    smtpUser = my_email@gmail.com
+    # (Optional: we'll leave this commented out and use a different way)
+    # smtpPass = PASSWORD
+[credential]
+    helper = store
+----
+
+ . This example uses gmail as the email provider and the official data
+   available as of 21/02/2023. You should check the latest information for 
+   the email provider you intend to use (including gmail).
+   
+ . The `[credential] helper = store` tells git, when a user runs a git 
+   command that requires authentication, to store the credentials in a file
+   on the local machine so that the user does not have to enter them again 
+   in the future.
 
 [[format-patch]]
 === Preparing Initial Patchset
-- 
2.37.0 (Apple Git-136)

