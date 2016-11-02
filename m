Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD72820193
	for <e@80x24.org>; Wed,  2 Nov 2016 23:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756510AbcKBXRa (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 19:17:30 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35673 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753108AbcKBXR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 19:17:29 -0400
Received: by mail-pf0-f178.google.com with SMTP id i88so19519958pfk.2
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 16:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MIT1KJe7B9vhA4uTT4U62rKptaV7VZbDw4BofMjkljE=;
        b=QDMnN5QuM3PfMeoL1tYBCsxRDzeVfv6ufieqluW5oTnT5wJNSLs1TFX39MU532Pv2v
         y/1m78jrsuI2l8RECt06CSi8Ro2zL9/aguMza1SQs2T/bzrS8+ehdxS9Ly+lF0JkTPm9
         1nM0kZk0wdlcjvE9omn6gPWVG4zm8UPa0UGq1P8z0jS2erZyB1NGAlo4cHXG35xzn+Vs
         71c1897ekT5Z82bUT5RKYwKrw2d5emYVRwa1JXhRGa8w2EL40golIy4ydNaBuB6JAhtI
         IJOZXvTre3QfxbP/hdrmvu7sFrUmSyOBSQdkYTJoaKuxAXDT1yNenrIItz5NRG3iNjcD
         cJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MIT1KJe7B9vhA4uTT4U62rKptaV7VZbDw4BofMjkljE=;
        b=DcdPr9KTPfNqAS8lAISu4Do13Gn46tWPOP2fM2adkOpa1UqBRki9/87iD/c1ITe3sr
         GX04FDNk/4AjSIfvZ2chNUqmFfvxf2XUi+CTPy6q9hnfvU1aVcg2D1K+MkrciR7p3yCz
         0rfp6rKzX+2+1YJYm/vpniXg1ylKz+795+0UOVPW5puusktNLqKOaqFXYOdFiz36lpEd
         0C+5Qx8zYqQbdMjOJNXnpPGPmBAiojobgyu+aDz9auw7e7W8IeyrMwCWowhAxoltemwc
         baS+tyY3NOPSs4CE3ymELU9+YP9mxPFMMhlasI/go8VIQy5raajutL4QqwC0DEmT1cSi
         Jedw==
X-Gm-Message-State: ABUngvfRIK17wt9PLLKQ5AK3rPHxKdLpg4w6bX3TN9/B9jFdvKuOBdgRQKgE0Kj4e60HafPg
X-Received: by 10.99.64.132 with SMTP id n126mr9190217pga.87.1478128648876;
        Wed, 02 Nov 2016 16:17:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b836:b884:f13a:bcf4])
        by smtp.gmail.com with ESMTPSA id d26sm7243581pfb.37.2016.11.02.16.17.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 16:17:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] submodule-config: clarify/cleanup docs and header 
Date:   Wed,  2 Nov 2016 16:17:19 -0700
Message-Id: <20161102231722.15787-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.2.621.g399b625.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small series that would have helped me understand the submodule config
once again.

Thanks,
Stefan

Stefan Beller (3):
  submodule config: inline config_from_{name, path}
  submodule-config: rename commit_sha1 to commit_or_tree
  submodule-config: clarify parsing of null_sha1 element

 Documentation/technical/api-submodule-config.txt | 11 +++--
 submodule-config.c                               | 59 ++++++++++--------------
 submodule-config.h                               |  4 +-
 t/t7411-submodule-config.sh                      | 11 +++++
 4 files changed, 44 insertions(+), 41 deletions(-)

-- 
2.10.2.621.g399b625.dirty

