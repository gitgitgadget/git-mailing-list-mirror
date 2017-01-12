Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 023C21FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 12:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdALML7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 07:11:59 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:38359 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdALML6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 07:11:58 -0500
Received: by mail-it0-f44.google.com with SMTP id x2so11449312itf.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 04:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omarqureshi-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=bdLZAnIbsRAla6z4cod3iA5/orXu4/0S2TH8yT9z22k=;
        b=CitOIb8p83iCKqmhS29OUcOVcW904XFsuHtmK07sZr3A1Jckk2LMiLHl//kaR2PmTc
         bo8+PNrl1kKZ+uY1T3Nb+qQT7XijGSI+Sa+2XaUPTyZ8d+3nb+FDezMJP0f78vO7BqT9
         x4QPE/lMArkyVBFHAY9UZnZ4uVMTbESHM0H5SWAEi2LJbzpLyCmprYTndxHvzkYq5JDU
         wWfSG5icnV+8XllnJ7lMEF+MkbY9JMVlEG05jSYx7MOcfasuX2o0gw6Zq8UAfHa/Kx2V
         k0zMmoRAIrsvNY/Gv05smn5duMnAqBfgrT8TEWPl63y+amm2jAWfZ9ypQ/Z6fDGJbXvB
         6JAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bdLZAnIbsRAla6z4cod3iA5/orXu4/0S2TH8yT9z22k=;
        b=PzwvmAdkeaeUnvdxaNWsjUgqxZKPikR4yZXt3djznUaG8In49XVrVKeY5xLuojwGcO
         iYSTqemtBLPbrgu3br2gvU4IZ8/Ttw+VdhWQSC80vpYFim/tH7L9+8i/ov6QgHMgprPw
         slhSdKVOaxcGwWtI9AcNUW4XS0x9kwyAdEUAHy1ug7utmOs+eLSvoOEUOR0Igxjjlhkg
         Kl6i1HRzYDwh4oESoR1OezQg9+zSng9YLuuCvss6DFH1bohGeIsW7Fx4iIBlbtyG2XGH
         JTs61bvWlbUgr0S3P9Wvc+aD0Bs6PdNYPCVsxLmxPV0ZRoIvEx5VHeldWd1KtFImZ2RP
         TNdg==
X-Gm-Message-State: AIkVDXIRqKvTkW0g81rG2fEcM9zjo0HFOAzn54a7pLJh6zWOzxwwVYKOn+KiCMdeHdZpsnL2cO0OvYA+6ee+4A==
X-Received: by 10.36.50.78 with SMTP id j75mr12575189ita.58.1484223117638;
 Thu, 12 Jan 2017 04:11:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.24.130 with HTTP; Thu, 12 Jan 2017 04:11:57 -0800 (PST)
X-Originating-IP: [2a02:c7f:7a3a:2800:745b:a804:a81b:8752]
From:   Omar Qureshi <omar@omarqureshi.net>
Date:   Thu, 12 Jan 2017 12:11:57 +0000
Message-ID: <CA+-cb7TuPd-n-HZO-60cKAysmtTaVMcviC2W+bhxz7hikbY-RA@mail.gmail.com>
Subject: git clone failing when used through bundler on Docker for Windows
 with a shared volume
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there, I'm not sure this is the best place for this, but, this
seems to be an issue with Git when used through Docker on Windows when
there is a shared volume.

The issue is documented at
https://github.com/bundler/bundler/issues/5322 and I've provided a git
repository that allows you to simulate the issue, for this the
requirements are Docker for Windows with the Docker client installed
on WSL as well as docker-compose installed via pip.

Docker for Windows will need to be configured to have a shared drive

Also, it makes no difference if a tag is provided or not
