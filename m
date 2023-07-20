Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06487EB64DD
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 20:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjGTU5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGTU52 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 16:57:28 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98C91999
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 13:57:26 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e97fcc60so864733b3a.3
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 13:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689886646; x=1690491446;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/kYUieuQLhjEwjQ2hPpoj/h63A9/vDdAStpcc59lEo=;
        b=U1ghSlU4WriQjLA8325MClOl9jUZvhfAStjwWl1O1DFca/TnACW13hb9MWsxfVpbrz
         2yHYqvER3oYLpZMV7Y58+jVd6b6RkGxEguIaT2zgY0Zz7OkxMmo7v1tDGaT28K086esd
         QgwDwPMyxjQnd73oUGDCigY40xD7qsGoeTjTns8LCL8EvNLhxBZhybmYX80FIte9+K9D
         inX9qOYQRkmjvyXtxs00PSgX4hg42jTwDMQs8/tf1dATgOwxt02ADkgOBI0fLMv6ghlo
         Q/3+Qd+vx8T0Enmer9jlK1upQFnUrilm8B3DFbNGkGQfIfH0KGPV1lPZeg27I4DTwOp5
         2lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689886646; x=1690491446;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/kYUieuQLhjEwjQ2hPpoj/h63A9/vDdAStpcc59lEo=;
        b=fB/1enIWTo2XbW178Cnl1fCv5T4qnEUZC3oiWAAx1gxE9oDOm6FCvs3ycJq7aSxz8a
         LTD27RNpcPVWVFj2o7JDJ60INy/q3DQwgVj/3m6dat097Ue8oEVSmW99WBnNsMyYMDD6
         23RExC2thcDwvulBLUVGmi3NpVAb8Yhkpn7/rq9z1TvLABY5m+NWesjMAZtF/wC9mtaY
         ZrRgzBeZJ0NPCeUqg4jhIJhm4A2eAnPWr8D85qTKzED/VvtLQfOTIb2hG5g40w3cC2Sm
         i+fVpF3WZ2u+3qU6n50lMAVWPZanm1dNrnWzJCVgCIQjr4s2KDbmLeD0vRxfqun7OQVV
         sC2A==
X-Gm-Message-State: ABy/qLZfIPOOySAE8XTmiSH+yQyjcbMbRBS03rHujOD/NLzIiazMmWfB
        I6iu39eJXJRg+K5mtQR8K9lL/bncYpPa9Q==
X-Google-Smtp-Source: APBJJlHDxrMiqNOeXwZs47eLLbkrRbnqlFmNStYfcysn8l4LWmwtYI8uIHi3l4MZzxHR4e4s3EgLWg==
X-Received: by 2002:a05:6a00:3996:b0:666:ecf4:ed6d with SMTP id fi22-20020a056a00399600b00666ecf4ed6dmr6852630pfb.18.1689886645681;
        Thu, 20 Jul 2023 13:57:25 -0700 (PDT)
Received: from five231003 ([49.37.158.8])
        by smtp.gmail.com with ESMTPSA id ff17-20020a056a002f5100b006675c242548sm1573040pfb.182.2023.07.20.13.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:57:25 -0700 (PDT)
Date:   Fri, 21 Jul 2023 02:27:21 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [GSoC] Blog
Message-ID: <ZLmfscrwHjIOsK4r@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIdrQybUsjEcxMrb@five231003>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Week 8 post is here

	Week 8: https://five-sh.github.io/2023/07/19/week8

Feel free to suggest any changes on or off list.

Thanks
