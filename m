Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EFDEB64DC
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 20:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjF1UBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjF1UBK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 16:01:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F421FF5
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 13:01:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b7f2239bfdso2794685ad.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 13:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687982468; x=1690574468;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5fKkuCMpOBcdGUaZb+XOqNeinkrdqa5G0OjdubUFzA=;
        b=B87fLgveVVziCpJ2RmPY44Zg9/laYfS8TM4RTpmP3DcyjvwPMSSEmnQxlRmV+pt1Sk
         kUNajmyzCvTSVojvrQqliWvogcjyueQi50Cg8ROtfVuo+KbaXW7hTwt0tA5DX4FxQHBC
         P+QiFYb1jYUklajYaRKuM1Br/VVDt72QYmNB33cizrY8aOUb/SRjf8XEik2EYmnp3S1o
         XVvsXsyq/UAYPiAWbPOTWVF0Mojc0DgWckj+l8OQpVe7uk7RGXHKMENJWJfc+fzCIH6E
         25wBjSaQEvg6hgjfvZY8N2ysR7GawwQZtrNjZULuNtH9ArI5DjL2cftXUZ09ov2SX0v5
         d31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687982468; x=1690574468;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5fKkuCMpOBcdGUaZb+XOqNeinkrdqa5G0OjdubUFzA=;
        b=bmQLfrnbDHfFOzZJH8cEbfInnFXVPJea5znNC16MuBqUawlVV9jAjwX+K1rSjHd9FQ
         ox07ghfDbfRK/26Gk/WTWjJSSaCIek70IRNeWBFVREdOsvXDg+mVuqFJfa9qcTYHWy5g
         fnk9d2XxgAwrdACccRdCTv7MlOPDogF3UrWX9W6mof2axLuR2d0gryulqZQahsVIT81Q
         eDhNMNXu2dJf7Wdmac+KEgU0xhOEgsyigevlls1dlRA9xdQj1xqoEizylt2CGaJ630Rc
         7SuXAaFw8vWOshXylXpPC4yUjeRqw0PF7rRrZhPNXvbx65l5OSToTiGKlL2y/K+7+mDw
         Xxkw==
X-Gm-Message-State: ABy/qLZZXbxQpvipH+9wMnwOtNmwKAiKLNGiRQYa0paahlvSdQc6JGl2
        A7+tNJ5bR6OuKsifeNCZjzhBT5ObHEU=
X-Google-Smtp-Source: APBJJlHH80N80rULAi8Cy5cKFhjqRAuqujIKu3ddM5V4HMpt4rTgwItoY9cXRpeg1qih7Csqq23JCQ==
X-Received: by 2002:a17:902:b681:b0:1b8:4f92:565e with SMTP id c1-20020a170902b68100b001b84f92565emr670573pls.21.1687982467750;
        Wed, 28 Jun 2023 13:01:07 -0700 (PDT)
Received: from five231003 ([49.37.158.157])
        by smtp.gmail.com with ESMTPSA id x187-20020a6363c4000000b005533b6cb3a6sm7738010pgb.16.2023.06.28.13.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:01:07 -0700 (PDT)
Date:   Thu, 29 Jun 2023 01:31:02 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [GSoC] Blog
Message-ID: <ZJyRfiayyANY1JHK@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIdrQybUsjEcxMrb@five231003>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Week 5 post is here

	Week 5: https://five-sh.github.io/2023/06/28/week5

Feel free to suggest any changes or comment on or off list.

Thanks
