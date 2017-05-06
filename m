Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6513A207D6
	for <e@80x24.org>; Sat,  6 May 2017 10:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbdEFKXf (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 06:23:35 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36141 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdEFKXe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 06:23:34 -0400
Received: by mail-wm0-f52.google.com with SMTP id u65so42021608wmu.1
        for <git@vger.kernel.org>; Sat, 06 May 2017 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=u34aTkJ/7p/9mdDafHmbvBugj8NdU9TcdZtPAz4FF38=;
        b=TkHxVlAeGRBl+PezOWlyIHDjiUg4nGkm+J9f1OTZsnIijhVnZxr3s/O1XqL4VdHevy
         286/pdJ8BsdoyuGfYecg9Yuoo2w4SZ+V4CxpWNm1FfLGyLjB1Ct8u4E6ySltuMP+No6/
         rKn4Yer35qqJJ0WJkMT2SAF8SxLId1giWiFZj4Tu2iKN6GJTwInjkDKBEDzmstjDS2YV
         jOdOUM1U87qpNpHUT62vjn8KJksWTnljwJwt5aPYmfUvZPyFPMTkxouG8I8ciZDvuE/3
         v5z6/UFx3WlKy04HGV0y4YySgiw3x382PABd6X+cdJigR3rcmfy6fYuLb83k9vG3BJL0
         jxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=u34aTkJ/7p/9mdDafHmbvBugj8NdU9TcdZtPAz4FF38=;
        b=TKQ/BBaW/PWgEANHsE/uFAPT8mq0cLY/tSY6rIbVgf5IIsx1AG8id09KjC89Ob/K5d
         ytqQVLQ/+16z0s6fi0gsQAJnF2Ze7TgnkGb8KY1d8MfYfk0sXlHVGEgN/dsbdx4cJ4/I
         ixEBzJoIblhg+FLNxS5DNOhkGX9Z98E45tkomRpzMi4TDVI4WsyRM6ozW945CKx+JYj3
         b3yunbEARVFRJxxDn0c1kBb7Iz2FAMx7cG/azudleafnXcQk32tICTB3X97EbQB5VTp8
         61JkDVRJXlBquj2spQY5Mm39KLe1PioD1uuzLSBT85kkzZv2NjI6G1xAjHBf2gmTSL25
         qcBg==
X-Gm-Message-State: AN3rC/6hd+gRiWf2oP2PqPHtzTtJG9KG9oToxXjeznH6q3+mof/5Ro1u
        ev5DlsDCYFs/L3hzRYg=
X-Received: by 10.28.69.203 with SMTP id l72mr7570869wmi.75.1494066212475;
        Sat, 06 May 2017 03:23:32 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB7339.dip0.t-ipconnect.de. [93.219.115.57])
        by smtp.gmail.com with ESMTPSA id 188sm4905070wmf.29.2017.05.06.03.23.31
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 May 2017 03:23:31 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Script to rebase branches
Message-Id: <8D018370-79F9-450F-97AF-31EF4C95BA44@gmail.com>
Date:   Sat, 6 May 2017 12:23:32 +0200
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am about to write a bash/sh script that helps me to rebase a bunch of 
branches (e.g. select branches based on prefix, conflict resolution/
rerere support, ...).

I wonder if anyone has such a script already and is willing to share it.

Thanks,
Lars
