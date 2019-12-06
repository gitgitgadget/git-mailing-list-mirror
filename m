Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FEFC43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 18:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CEE206DF
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 18:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lWsXPf+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfLFSyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:54:10 -0500
Received: from mout.gmx.net ([212.227.17.22]:46733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfLFSyK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 13:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575658448;
        bh=QI43x8jxcgRwEe6iSDbx/FACOK95atk9RZAaPxzj3SE=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=lWsXPf+fMv7OPeM3S0bgERpQShox8B37GiI3HWXPc4gDb098pq1So28UUoc6R3FBT
         MQNWiWFZu4tttNl7IXEdmRS9uAlr+uKmzTu9F3m6VfnRqXIfe/wdhO6bRx0z4DKliz
         iMGgTFDAqVnNUfmP4edkrBgbzYzh6rVa4qERoeYo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.32] ([84.133.76.115]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1i1Uol2lK7-00cQ8X for
 <git@vger.kernel.org>; Fri, 06 Dec 2019 19:54:08 +0100
To:     git@vger.kernel.org
From:   Andreas Kalz <andreas-kalz@gmx.de>
Subject: Git as data archive
Message-ID: <21fcdc5f-955a-e027-0d71-15f476f6162c@gmx.de>
Date:   Fri, 6 Dec 2019 19:54:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J4lAILUym40jQB8yA9zjPvOo3jmPUXOz99AolDNXP68c630RwIv
 NImSRzLwPoh3TVCrikb7E/qPLJPvksFIRkYYeiqNC+TmZsq2whG4IDOYUuceg6FPpgg24qm
 MMioDdv8HUqJyrFaqYzM4P7VX2P78CEYh1px/kWeZOPJFr8W8u0nCO7X7+piwtRgLoJkCCW
 InxyfB3cMPInpwepGDw+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ICKx6JQMrYk=:wGhDy0AoFvW8ZR6ewFj5Yu
 s7o4IOSMkZT5oGCuPFrd+mqdqAV4enQ2Fk9L/t5v7CmNiIatwPMlZOI21EUqsMRWXb25RL+UU
 ZUmpw4LfDeWBVknqgPvS9xR7AAsRJK8e9MD3AcV5D9E4oAUckqOzSE+zhEtHwXf6zCha/5gNS
 O27LCwGHDA/qU/X/knC+fITxMR/ivGMsJLlA8mnXDx5egeZiKFf3QEyt9Fk9P3YhK5GXTET01
 3gZyy5SHOZqXn1pyKWKnyndrCLqFwP6ZwT+yLjamqqR+qhyEzuU89oKqiHLJrPW0Iyx60q4yr
 Y2SEBzwJdJ7wLTNYeK8EiTZrXvzb119lfG1518pP3IpoFCm+xIElam0h3h7A1Uw77H2dFlEOf
 yaQuFnu9fHV8gZFxtb9977ihJSb1mCTHpvRzXRgFNBURIauf7pLofcGoudME4XuOEsSStxSCE
 Htfdugjd8rnKkrpzhTyx9nAsQbd0scW/MZyltEE/9YKaA523fGDow/cOQkcZbgL7AiXwMvzLH
 ShrzGLWGmpaKgmnlTfo/Ll1PLbyuzJnmHnDGEaNBNS0MUxsG33pJ0A/OXBBPGf65st68pbYRm
 JYlT08y3QVFDAwJxVVzFiVNZv6kK1y7jVwEvuIVfyzteoA7TC/3Qa37CPjVMWNx7oNaq56axi
 BUNWrbeqfUcDNgOlWfVdik7zvx8PYet95d08CUrftQy9LTgNi/VYcJqpyV468Mqz9Gbw7h3Pz
 rVRrwZ8ylYmu8FeabL8AcfFDA6AhCElHOpWbRXZzkW7fVmNeOoSV4UQg1nv/+Qo4P2cPTM/Hh
 8yUeNKJKQhE7VwmMnl++vOfWHtakd8GfMD9qD40+JXnZ8DllESYxMruEMy6hcOcQaKh6X3MMZ
 pPycHACngCkXNU/6cPR/pebEs0Gfg6mpP6rhCcmFDwW935bUyohru1HcrOWgJcGXQAdGV/O3Z
 ojM6sFFFnNDfwiLeak4LJ+wxPFdx+KN3fcsnsxR4q02WQ46S7jDZDC51srPDeMm+uUWFQGexn
 2UVLPD5PDyOVF0rMsl/Zuph1zI9JQPWghwKna2Z4TqVrW11WBpy2dL+aRkjJaOo/dlAolQL7i
 +3Qxzwss1fpxtqHh/Vt3jH5J5jBFacEWKxjztRivsxVhxbUFh7bHQYuSzQi60Wh/XeNrDV0z1
 0+75q9x3v9hmeOqd762Es64GnhtQAyc6D7soJgyqyMrDCNTfCgQI/2EYpwbvDZtdli8pexwOh
 cDIRpmuZYoUyX5hdjrcGi78kioMxAoRPk9awTzKqi7HeZDI+M4iA1e3QfQ20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I am using git as archive and versioning also for photos. Apart from
performance issues, I wanted to ask if there are hard limits and
configurable limits (how to configure?) for maximum single file size and
maximum .git archive size (Windows 64 Bit system)?
Thanks in advance for your answer.
All the best,
Andreas
