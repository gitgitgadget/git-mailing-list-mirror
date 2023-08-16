Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E9DC25B7D
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 20:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbjHPUYm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 16:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346132AbjHPUY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 16:24:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370F726A8
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 13:24:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bdb801c667so45802655ad.1
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692217462; x=1692822262;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8BfkJiP4ntE8rZbjUsCQZquqT6JQG0x59/TX2BGnpg=;
        b=nJBswMst0B8R7s7QrlgnscOHtneppZEo41HZYy5Oobo6JbFrCUIeAYw2AZd0rQtbOK
         IAi0Vcrk9slhryew6CSv1dn6QWzVoCm0Kw96jtZaDPdkSk8gUFClemoT5oSJ7eST55Ws
         EfvJlKZmm0UFTg2WP+xlidhCii0eGtG5eMzgnUP6FWYmjAHptOL6EqNH2GY3OUoLKUS0
         XaCGGVq2NUbQ9wSGbUoLQmCABMFwXT8N05QM2nAM7tVbNR9u+tVxpmccPkoAOW3mmkqI
         SSFScb8phOwnEAlEQOJPs8EAWm4+wubCWoPBy5agnSJcdN6nF2DxMbHGHzRQQfQsk0IG
         d6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692217462; x=1692822262;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8BfkJiP4ntE8rZbjUsCQZquqT6JQG0x59/TX2BGnpg=;
        b=FmgkG9TgWywQKQ/ZiVoTjNx0SwQf/3GdGRYLc5GpijjV8Uy2tbsh952VdnPwxvgzsM
         Xkmdq/XtlT0BWMv5QaulylykB9EtQbVmuM2Vp9oZ9Tvhvu4xjJHk6rGaUJ3HMB1xVzOz
         vxfnRx6QFE8d+bYqJiXHx+fxTWMonzu950S6GuDdSbNNoAgQb4lUIcorbbJ0tX1OIsES
         YxnPGgFVvNomlbhf1WNGs+YxNJB+5vVIp8PMpSr3OxvIsNEh0hXcMJkhJcjX1t3z67mD
         DhPpGhxW/0dNMNei2mpDGtHy5v9hggmqzsmREHPz/ynXCt+ZIWXumo0lLLOXqvcflAd3
         B6cA==
X-Gm-Message-State: AOJu0Yw1Cc4XwQfaHbiIGdUJdnUfrSXSQKaI3smtKiAh6vkN+MWev/Zw
        aVaBaNysl2rp+kJeBfZ7XZQMkbCLvNArWQ==
X-Google-Smtp-Source: AGHT+IG2GzH98N5Ap0T3JQn9YtVuyCzK2HWA0VucZ59WmdBIoLFGWhzC0egg7gzTIRTfb+QfQIrNfg==
X-Received: by 2002:a17:903:1251:b0:1b8:66f6:87a3 with SMTP id u17-20020a170903125100b001b866f687a3mr3824127plh.52.1692217462296;
        Wed, 16 Aug 2023 13:24:22 -0700 (PDT)
Received: from five231003 ([49.37.158.198])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001bbb598b8bbsm13626265plw.41.2023.08.16.13.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:24:21 -0700 (PDT)
Date:   Thu, 17 Aug 2023 01:54:17 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [GSoC] Blog
Message-ID: <ZN0wcT8q7_FKJLLs@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIdrQybUsjEcxMrb@five231003>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Week 12 post is here

	Week 12: https://five-sh.github.io/2023/08/16/week12

Feel free to suggest any changes or comment on or off list.

Thanks
