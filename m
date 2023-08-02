Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C3CC41513
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 19:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjHBTw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 15:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjHBTw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 15:52:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1AFE5C
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 12:52:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbf3da0ea9so1842005ad.2
        for <git@vger.kernel.org>; Wed, 02 Aug 2023 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691005945; x=1691610745;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/LJ5n9KNYLvkwMIGZVh9WuXjomTbgFcwq/6olYhvdeY=;
        b=riRdtJRgt2rTie+Af4Ba14XBnfbKal0zlPcITqp7JOr5pK2uJ/QY/twL/mrUHnpHXv
         Wpc+Cmdv3+fPrCaDSqOO9C4i979sEpGa1qCQJkIhBi9W1qnJAapptPRSSaAqH0t7sxqN
         ORHbancUq4mQEQmfHR56Qjt28Z0Vyf8denUio/hnzA+6NdItKS6a+I1i+SN3rJJJ4zOn
         eIICUzMm9zocnbeiq3qw3eDnUFXb3BY3Sb4gkeP/9ecEAZ/twsvqWZHGcTeYEdnvwQUN
         Mhr1Q0LVGUTXMo29gi/KPowoCP9QPYAr6+hLJj/Bh33DMmT/zmUMUjV53J6UPnJfNHNF
         fz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691005945; x=1691610745;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LJ5n9KNYLvkwMIGZVh9WuXjomTbgFcwq/6olYhvdeY=;
        b=dwcDf0xkmmY4Z0yHmVoMuh752bCYD4tM1HYW9evfj/TT/nxpxeEE0M8KteWVPTK1vc
         DoXWRbKUEU4ntTHpTT6nq5p1hNxCpned+hDasdHyBYVaBQBtIq7wOGQr2T5jrkciOlCV
         iTVm2wsBQ8pGhsFmKmhHSPZJ7AA9J2g1TlBy/WpRTWnyv3Dk0j4HLAY46tumFa53bqO9
         bVegsceEhpwqE/jew96BpDJsOCFBX/gnPi2pSFFPFBDeakp8rNlbgiI0ScI3H1/bTqb7
         n3BLIsOZgQfkvFvRnZaLd/YzG6yNCXFLjnOiopQnA/9RkLkInIatge9sQGoZuppt/xnK
         zSLQ==
X-Gm-Message-State: ABy/qLbZmzmXZpgY5M9fvVrHQ0s7C8rkGE/VngR2XxNDI+bIUeN/rLWX
        zupaxYI9m9LiAbR9+IrVELWWY4bhfSIGiA==
X-Google-Smtp-Source: APBJJlGif58j/9IZXfP309xY/In/p/nAFqPgzkEQ0G/b546/M+GZZnIcnFdxawiBOP7sv0TbzHDdmQ==
X-Received: by 2002:a17:902:d2d1:b0:1bb:a55d:c6e7 with SMTP id n17-20020a170902d2d100b001bba55dc6e7mr19562226plc.55.1691005944852;
        Wed, 02 Aug 2023 12:52:24 -0700 (PDT)
Received: from five231003 ([49.37.158.55])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b001bba7aab822sm12848172pla.5.2023.08.02.12.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 12:52:24 -0700 (PDT)
Date:   Thu, 3 Aug 2023 01:22:20 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Hairom Verma <hariom18599@gmail.com>
Subject: Re: [GSoC] Blog
Message-ID: <ZMqz9D7Y6-9-UU5V@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIdrQybUsjEcxMrb@five231003>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Week 10 blog is here

	Week 10: https://five-sh.github.io/2023/08/02/week10

Feel free to suggest any changes or comment on or off list.

Thanks
