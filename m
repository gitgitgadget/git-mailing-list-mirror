Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D06CCE7B05
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 08:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjI1IQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 04:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI1IQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 04:16:56 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D8D11F
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 01:16:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso210632771fa.1
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 01:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695889009; x=1696493809; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4I9r/+YEZon/wtnXyUpS2eGoWQe94IV//wdDriNxY44=;
        b=LUPimpNQNJqTKCRVpPy9Y5LQSsTKuuG3Mi/qRPxzhYKJ1DrdAMgK74f62diuX3be50
         vmKGASMmypdoihfcbZbgcS/l2E0ZqXwX/20sIZMo+5F+oAAwVdN9s8f7EozONESkcv3r
         lnXk4chny6+bc5T5JgNKUe/XLsPgahiqdV8Cm6BG6hyqA16bfDwETNiHmPWpOJVtIt+u
         5L/hKlaSNjcjEVB2Dy05/4K21/WntIGOLREKz1pnfp6UCzHLaaFtBwzL65Si5PSKhMN+
         c5bSYV8oFX7Zd+vYZeJorzzwWvdHqDbqB1AnAjTufMEtdT55vzOGG0fXnvFnDUDvi5OB
         MKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695889009; x=1696493809;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4I9r/+YEZon/wtnXyUpS2eGoWQe94IV//wdDriNxY44=;
        b=Qr8aNbWjM8zbhMQ4WhdE5m0U/h8kB9jSkC2KiMZx5lD+rNbka+/Twm892toeu4xwmU
         T84c/+LXZR2OeEZprdCCZXrglx8wDx+qNL1oWcoBaZ/x/gwUgwiZSxXrOpI93T49LWT5
         +DwQ/sVdzQ3lzyHpH6Jbh+ZTAPCxW/BL5pI9qNmenh6wEJUMN3qJAn7QmgZ+NdqPadyX
         vhZWlnxa22vkIPRPFh395VEBPx8rDAD2GOfYlYP2bf1dIKO+U7jG3nvCK+LhNmU5Secx
         y3qBzsAUE7kvnIs1QNcOwmdgPXlA89b39LZGe9mAQmkPzbWKx1A8apbrn52DJY3ce9D3
         4aXA==
X-Gm-Message-State: AOJu0Yxz9Lv43SNhZcFfMf1R3rTfQPTvk0AivVGMab2+3LfQjUuZXXTx
        okzBUrs0H7baJPBGBdKo7bSSxa8tEuoOkmRNcdJpwC3jm8ni/A==
X-Google-Smtp-Source: AGHT+IHhPIDri/8rW3j/LvGd48745d3ldzJXGeoTU0yTcFbOku8T04C+QF6jyEhoN9SmEpuSI9m6XNE3XvGUV7tm/hA=
X-Received: by 2002:a2e:8712:0:b0:2bc:e954:4203 with SMTP id
 m18-20020a2e8712000000b002bce9544203mr587226lji.26.1695889008684; Thu, 28 Sep
 2023 01:16:48 -0700 (PDT)
MIME-Version: 1.0
From:   Saurabh Sonar <saurabh.sonar120@gmail.com>
Date:   Thu, 28 Sep 2023 13:46:37 +0530
Message-ID: <CAJ-L=uAjXB67Zx1BPpdJYF_y1RS+UqwpyTMF1F4o3yO+1o76vg@mail.gmail.com>
Subject: Feature Request - Unique commits list
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After merging the master branch into my local it is hard to find my
own commits in git history.

To solve this issue I suggest, There should be an option to find out
which commits are only present in only current branch and not present
in any other.

The user should be aware that if he deletes the branch some list of
commits are not merged or present in any other branch and he is going
to lose them forever.
