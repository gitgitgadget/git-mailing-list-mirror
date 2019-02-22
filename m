Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.9 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MISSING_SUBJECT,PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62FAE1F453
	for <e@80x24.org>; Fri, 22 Feb 2019 12:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfBVMB5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 07:01:57 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:36348 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfBVMB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 07:01:57 -0500
Received: by mail-lj1-f172.google.com with SMTP id v10so1523398lji.3
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 04:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:mime-version:content-transfer-encoding;
        bh=So4S5EBp/259hn6kpuuHBFx1VmxEHGQSGQm7falLHkw=;
        b=oUQ+6j1/vIdLPbekqhvPxRaqIY3A+CdeWZToUyzwQUTrgaquyQDxNsY4AHlLIvIkIz
         OdsbIhkKveGruFzJ9lwYhJC5YxxVIZ9/bJDq872Oe3vQOAEQCPkNhOn4OdVkcsluMi2l
         v0CszKK3VPI5U4W+ngseLZd24zJqlkWHDAyhGq6XQ+JdR4o80ckSP89e1YPY0KqAzv0c
         kD1oj9UZeT+yBu2jub31BdpEuG1iIvdD9t7u1O3Ht6S4m1D+0rHM32xTYWH+Riu4u91i
         bgQh1+Je9WWwD4AIGvMW3xuVks+JTg0s2qNvtGCbl6K9Z74RR4+2dM4IN6bVhGrMMn1e
         bksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:mime-version
         :content-transfer-encoding;
        bh=So4S5EBp/259hn6kpuuHBFx1VmxEHGQSGQm7falLHkw=;
        b=YaCCVR2c6IHxcxVJlJMyqYu2m0YIZuIoN2pi047KEor4kZ6GMi5hwr4dtB5SJSh2la
         QbGdqSLOmVUNsLVA74ZYffQAXGKxAXS9ORDh7hFbie5Rzij7/TyQb2zlhSuY4qPLta0o
         4NdYk9TWsgQaHfg8LMzJT6lJ9394zRqRbLL3I7lXisM07pQAxBUvL3v4cPP+tX+I4WFq
         yV9QjQbdMAQGxVOxXF+lopcYFGnauwQVqJeFuo/AB1LYwMjWpaRuuGQfcpKrb1OWWvol
         gOqgzyKuVFPjT5bqrp4D5yL78/u39igx7qQEVmERJ7fjSc2autN8ufzNtvvo/2TIOeLD
         JfnQ==
X-Gm-Message-State: AHQUAuaEOltXZxLn+BQlkuPBAfn991ljynNmcEQYNIfQ+4LuMwePRDsW
        k3wG3gQmv0wNtLMNz/Vl4rZx6t7u
X-Google-Smtp-Source: AHgI3Iavxu0Cg1zfOkrqbzVySof8Q6AA6Ng5dVHKE6b8LGZNGRM0QSd0Ks2OJSauB8Nvd1UvJOjvjA==
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr2171317lji.57.1550836914379;
        Fri, 22 Feb 2019 04:01:54 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:4291:4c8e:1946:ec70:a378:ccf4? ([2a00:1fa0:4291:4c8e:1946:ec70:a378:ccf4])
        by smtp.gmail.com with ESMTPSA id l11sm444042lja.38.2019.02.22.04.01.52
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 04:01:53 -0800 (PST)
Date:   Fri, 22 Feb 2019 15:01:58 +0300
X-Priority: 3
Message-ID: <-qf9epy9ivlg9-g633b7-brtu27ym5ulf-j9u6c2-64sbnh4csgdv4x8rzrdplkje3vvfvs-feb3d3ak92mbta8qhue2im5bg9p5hg-wdwlbs-zayhb7jljy5z-vjq4j8-33d6la-qcec233enabx522txh.1550836918627@email.android.com>
From:   =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCh0LrQvtGA0LrQuNC9?= 
        <skorkinao046@gmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CgrQntGC0L/RgNCw0LLQu9C10L3QviDRgSDQvNC+0LXQs9C+INGD0YHRgtGA0L7QudGB0YLQstCw
IEh1YXdlaQ==

