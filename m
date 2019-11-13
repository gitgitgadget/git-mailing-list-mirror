Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CDA71F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 13:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKMNOI (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 08:14:08 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:33218 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfKMNOI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 08:14:08 -0500
Received: by mail-wm1-f44.google.com with SMTP id a17so4895699wmb.0
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 05:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=88D/zEkSFQWao3uL8LP3BfEoFQRAvvO1ZatM7lok5Nc=;
        b=gSpzgb9/VfRpX0nlAxXSfEDRYld9PfnjpibWhooTn/rpP5KJfA9oUCvTeChII81N3F
         G3ilxRqwvofip+MQR7Go+1IK2aiq5mIWY6tDT3JuY1IJJ+3rW77Xu8pbqnd4v5Ja0SxR
         kS7tgRi/0XqOWgUU0L/0gQe69j17+Zyov76MDqZOswYVoCccAiSzWWR/ZHBNBx++OLse
         UpWG0Gj+zeU/wy1imfXEsJbdFJo4mEjCfU+EBOY1GPTrpar/g/uWvMwhTbYx8vwZG4mC
         ZNuWBtKHGDS527DNFcdSSPRWu87U94Mjfeim8W+zJH7K+rxOTuKw3yIkDpVSwDV+qC9u
         jntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=88D/zEkSFQWao3uL8LP3BfEoFQRAvvO1ZatM7lok5Nc=;
        b=ncdIoV3gvnZy8TXSqLCANJRHQeXWwoFT7yAdGdFP2RGLBtvoUWHPizTcQ1drAtN0iN
         qWki8WXfriQGLfuKoiiZN360d6LXo5la6X8YxnDPKshVQVTpzn6nJBkFwn2YSxt1l/Cb
         nPBnsPVsp1NKoPmdtMCTTkEMcs0AFGx5x0VMQC6DwVjPf9A4dXd9GmQrX6qMA0qNazCX
         IK8KG1mEggBcIe339GymkCSy++Q3GZ9XXTRNJHYuMkGQzNZR6RUD6y0vosq2/CNcqmND
         id3UoBRujRde/gfByje3WLgyuyjDgE/UetlSqzIjlitQfRDYazzbj2EgiegaMS0jF4yV
         +RxQ==
X-Gm-Message-State: APjAAAXUas1ZtlmcAuPATZoU0JJpejDfKFMlxtNipJpIzJ+wfKogT6Sa
        fHbF98js7w8Ek2XP3qXfQ+Jg2Q2P
X-Google-Smtp-Source: APXvYqx0u2Ockwkx5usiIT881YUMTeYiKxbS3A6A4l82fby9FnSJ8AErR7AwiAWlbd8HzL2woKcoOw==
X-Received: by 2002:a1c:6854:: with SMTP id d81mr2929901wmc.75.1573650845528;
        Wed, 13 Nov 2019 05:14:05 -0800 (PST)
Received: from [192.168.178.35] (mue-88-130-57-004.dsl.tropolys.de. [88.130.57.4])
        by smtp.gmail.com with ESMTPSA id b14sm2685199wmj.18.2019.11.13.05.14.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 05:14:04 -0800 (PST)
To:     git@vger.kernel.org
From:   Marius Raht <mariusraht@gmail.com>
Subject: Feature Request: Check if commit is existent via http-protocol
Message-ID: <c5147250-4af2-0e98-db6e-20602a38fba4@gmail.com>
Date:   Wed, 13 Nov 2019 14:14:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

for the development of a git client on a SAP System we need to make sure 
that a specific commit is existent in a specific branch. For that we 
have to ask the git server for the related information via the http 
protocol. There are two option from my point of view to achieve this:

1) You can request a specific list of commits of a branch by index (e.g. 
"1 to 30 <sha1 of branch>" would send the first 30 commits from the 
server to the client of the branch "master"
2) You send a request to the git server to verify that a specific commit 
is within a specific branch´and the response is something like "TRUE" or 
the sha1 of the branch the commit belongs to (branch of the time the 
commit was created).

Best regards,

Marius Raht

