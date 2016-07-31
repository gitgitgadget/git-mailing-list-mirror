Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560D11F858
	for <e@80x24.org>; Sun, 31 Jul 2016 14:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbcGaOd5 (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 10:33:57 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35781 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbcGaOcZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2016 10:32:25 -0400
Received: by mail-wm0-f49.google.com with SMTP id f65so341441276wmi.0
        for <git@vger.kernel.org>; Sun, 31 Jul 2016 07:32:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=yGEzgeI2aEWOCV3nhellgFQsML+X6cqIkWClqeo5NTc=;
        b=TaLEGLOtdjKyhMQxjj10kshrMoGg+2kYXa/Kn3oaH3uIST7JLoxjL91gQFKxE9ujYp
         NAZ4H/oMtPDRXjzLRKemG3e+Ut7d5oYXseiQKOFBK0JSAYlbbKqe3e9ZrlZ93s1O5zPx
         kzfIi40FzjgQP3FM/7lIqrX6jiKkcZSflR/Ua00B99d15tLebhXAIbVC2CMkM3qGopL4
         haWrHa4k4Ux2Qop80DyeFeFOYPT2tSFCyNPW+pSKb+Nt891GXsp2XIKflrw+O9l4BOMZ
         SzMN+0YPUqI8WHSnSKhjCSvTAZxLEyls0Amuh2qwZfldzrQYObVj8ZMJmE0DVpCAGrGG
         wdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=yGEzgeI2aEWOCV3nhellgFQsML+X6cqIkWClqeo5NTc=;
        b=JyDl7J+Wkgzeo19SKsv9j8ycy1OL1gF9jqHnzbqMWjsqAN4k+ntK4tmmNR0OfeOY96
         xsJTJhJ1BfflPA9KDOPxQ3qOQLZDXqgRXl4FuXLp5+3gIZe1T/cfJJ3G+oqqHsLIs+rZ
         ygq5FCkPg//wyobyWIe5nzkdb9cyKHvzofF9lB18wBqzfjKNeTGkPmVcg2GKabiJUPw5
         3iKmcpNAeEUT6h7IGEb2iV5PjljapRZGptSH3WrxrVUXikb+ZY00B/Y7T//E7yzcPSUs
         //OjB7th/p8MCT6XzFbOrd3/SyYtOR51J/ji6DbS0ZijspWdwOrGhlD+s6rHt4mev/XT
         VhbQ==
X-Gm-Message-State: AEkoouusKeopiEpwLK+OzGkIw9UfR3paVaBWlAx/nC65zYN7Ly7O5XglMfaPqQLl5iYZ5Q==
X-Received: by 10.194.184.148 with SMTP id eu20mr46616074wjc.137.1469975543819;
        Sun, 31 Jul 2016 07:32:23 -0700 (PDT)
Received: from [192.168.0.5] ([81.56.235.196])
        by smtp.gmail.com with ESMTPSA id i3sm25841324wjd.31.2016.07.31.07.32.22
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jul 2016 07:32:22 -0700 (PDT)
From:	Sylvain Garrigues <sylgar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: git 2.9 subtree split with rejoin 
Message-Id: <1BED74C8-2E4C-4CA7-B785-F0666B69C1A7@gmail.com>
Date:	Sun, 31 Jul 2016 16:32:21 +0200
To:	git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello,

It seems now with 2.9 you cannot use git subtree split —rejoin without —onto otherwise you get:
fatal: refusing to merge unrelated histories

I wish I could pass --allow-unrelated-histories but that doesn’t work.

Adding —onto makes the split operation much much longer. Could we make a bug fix which allow to pass the --allow-unrelated-histories flag to subtree split?

Thanks,
Sylvain.

