Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2036E1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 14:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935194AbeFROdg (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 10:33:36 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:37286 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934470AbeFROdd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 10:33:33 -0400
Received: by mail-qk0-f182.google.com with SMTP id j12-v6so9444887qkk.4
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=AbSYaX/001SS3NxOVXVF4zDSE03pLE6YP5I1EtZN7FI=;
        b=OmqGNy7SS2sCtBW5nBJVInWr2lE3Cq86PWV7/TwKOD73tV75jFl3dyD+/2IP6pLNdh
         O8YP2tg2DYbmpUfHrlbT+ewUDRsW6nxANw+I3fkG1kmtWOaz9hnduFbBwHcosSBYdFgM
         rVMGDZQHJOewM0cQml4K5fRYAvU3aLROP4tdomg0jgFzFcC+oQM/8qFliUjD2SmATKiO
         YaOgin/7VbCjQFLEASjN0MerZRkA18n1OdOK2oxPHbjlz0QG4SF1I7HC2XSy3d+/EYEK
         NbZGRn80vhySwT9TfVW+3+PNgkNae1XXipdBAJpJi3q+iITUfwRXtiDhVEXEsu6GPOvR
         yGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=AbSYaX/001SS3NxOVXVF4zDSE03pLE6YP5I1EtZN7FI=;
        b=d8vIu6ENNKh94qWxHqefUsEqAIeJt8IAE9EIGIVwP6tv8xXgWtFPeQPofE53HkmbTF
         DKZfxpH8+a0SPxcqtP4GG5DzwkspqTxRPLvqL+ulPBZ67RmZNprGEDG/y3Sssd0j6RdB
         Z0d5TKEDSNZ7MnAHh0Qb+6eqbIawkkzFuQMEys+V6S94NKephpTDK3qvxB5HnIdKxSCv
         kbuFwf81FkQwFRDDvi63Qd1oYt/GLd27ptGCr/+6jhJEzUiJpQFkEa0YztGAultSFFhX
         2CNDEp28YLT72xw6fktP6F9c6yzj1i0lc8wC+uhEtyNuqIaGhtQj7tg9zBsFQj/GDSBY
         kcHA==
X-Gm-Message-State: APt69E2UysC97QB5kFSiu8SXOk084xKLFy0IlYAGqqev602Mpu5wb20O
        s6dNGxrJko8A95KlqmZxgn/jCwSC
X-Google-Smtp-Source: ADUXVKLKg8lg8SBdVn5NN4S5+64GtoFXouJvEv/q37gipD6HKSdIbMr0U8WC2xtdSjDf4DTpQynmeA==
X-Received: by 2002:a37:129d:: with SMTP id 29-v6mr10262093qks.263.1529332412826;
        Mon, 18 Jun 2018 07:33:32 -0700 (PDT)
Received: from [192.168.0.138] (cpe-108-182-30-78.nyc.res.rr.com. [108.182.30.78])
        by smtp.gmail.com with ESMTPSA id d72-v6sm17231481qkj.17.2018.06.18.07.33.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 07:33:31 -0700 (PDT)
From:   George King <george.w.king@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Git diff --no-index --no-prefix output loses leading slash in paths
Message-Id: <DFDB0568-9543-4135-A56D-821D4244DC8A@gmail.com>
Date:   Mon, 18 Jun 2018 10:33:16 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of 2.17.1, `git diff --no-index --no-prefix relative/path =
/absolute/path` produces the following:

diff --git relative/path absolute/path
index XXXXXXX..YYYYYYY ZZZZZZ
--- relative/path
+++ absolute/path

The leading slash on `absolute/path` is lost. This is unfortunate; my =
use case is a diff highlighter that parses and reformats paths so that =
code editors can autodetect them and link to the files.=20

Would the maintainers please consider fixing the output to preserve =
absolute paths?

Thank you,
George King

