Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44020C77B75
	for <git@archiver.kernel.org>; Wed, 10 May 2023 02:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjEJChu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 22:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEJChq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 22:37:46 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDA140DC
        for <git@vger.kernel.org>; Tue,  9 May 2023 19:37:45 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-643b7b8f8ceso3032811b3a.1
        for <git@vger.kernel.org>; Tue, 09 May 2023 19:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683686265; x=1686278265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pq+xK5ty7N+yJQ7tj22R6RhYEt7YvBK8MSfZ69sk8M0=;
        b=SFbTQkXaXGp8bulgq3eBBe2Phd9wWgOrwyhI3o13AwiMajFC5EshldWNJaty/Bjel0
         AauaEkg2EAT0EX7KKNhbCkmALBAxueYW9Ovdz9WUc2jZKa5mtzKkQ5rU4oUfJbeKYYUn
         syF9ESvbSLtjrY1I1BZZjv6LbBdm0C/45o/MqZ+3cswkawFah6SSEOt8W+Fh7dzUOyKl
         oWmqVu6sHsrC+lbVfJ6jTFbmm8/U+ZS9uFHeDMwv1pwpwVUMFe8yWjCzGFJx5SAw3lzG
         rtriB8NdNwWCbTH/Fdjvh1U2NBJ+lQeauPgrGjRqrEAw5PfHcDbAtvXZ2PtXLO7FGXDu
         N1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683686265; x=1686278265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pq+xK5ty7N+yJQ7tj22R6RhYEt7YvBK8MSfZ69sk8M0=;
        b=kMuQ97FpAnmYHJBPMBVXHt/WfqVDTQYGVnejhICZKkCAmr5BexxLL3FV6lSEconU1J
         1tUkKKSoAoRnEYsXgAFnLazsxVx9dsekJLIeCr7rWwutNUcKjKfKSvMC4wbw68gAjtrt
         eIDgUCYShWU01vKDD1w5sWLO5Vh2C5S3LBR6aR0tGTCrkdYKd4L+5/5/dcLEW+lI9gxf
         Zfrb+S68RBB6mB9RyM/nEvJCokf3IL4uw9bo98bJYte1T9uRBIxRkOA+eG1/RToLd2Dz
         WrgZ6QwPUm+Tjw+BWJi4FM+F6EAjYcTVnrs/x1we6NDsFRKCCsaK4L9THaJ45bjIWT6l
         lhiA==
X-Gm-Message-State: AC+VfDx9vf/PULW859VFGIdH4YRn6KeGYowOpN2MFLMUWiuZ9Fc4r5X7
        c5zgxdOlAsvGbCvu6+1teUQ=
X-Google-Smtp-Source: ACHHUZ7TJZHG4BX1jfTaooyhZizKQ5OEDJsS++nJXF1wV2KKqYv4RxQJK21tnTsJpG7a86ufOj47hA==
X-Received: by 2002:a17:902:eccd:b0:1a6:4127:857 with SMTP id a13-20020a170902eccd00b001a641270857mr21490044plh.5.1683686264648;
        Tue, 09 May 2023 19:37:44 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.58])
        by smtp.gmail.com with ESMTPSA id y19-20020a1709027c9300b001a1b66af22fsm2396925pll.62.2023.05.09.19.37.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 May 2023 19:37:44 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     calvinwan@google.com
Cc:     avarab@gmail.com, git@vger.kernel.org
Subject: Join us for Review Club
Date:   Wed, 10 May 2023 10:37:37 +0800
Message-ID: <20230510023737.2500-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.335.g9857273b
In-Reply-To: <CAFySSZBFxupHp-o8ApF4A1KnmefUYTPcbbRZgk1-FUknbw07_w@mail.gmail.com>
References: <CAFySSZBFxupHp-o8ApF4A1KnmefUYTPcbbRZgk1-FUknbw07_w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>This week, we'll be discussing Avar's series to fix tag parsing for
>mismatched types [3]. Let me know if you're interested and would like
>to join (off-list is fine), and I'll send you an invite :)

I have the idea of participating, but I may not give many comments on
the review at the moment. After gradually getting familiar with git, I
may be better involved.

Thanks.
