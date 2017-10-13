Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D82B61FF32
	for <e@80x24.org>; Fri, 13 Oct 2017 09:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757349AbdJMJ7c (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 05:59:32 -0400
Received: from forward100p.mail.yandex.net ([77.88.28.100]:37588 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753348AbdJMJ7b (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Oct 2017 05:59:31 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Oct 2017 05:59:31 EDT
Received: from mxback10o.mail.yandex.net (mxback10o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::24])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id C056D5102AD7
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 12:51:59 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback10o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id P4RciyseGs-pxf8baGC;
        Fri, 13 Oct 2017 12:51:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1507888319;
        bh=s6o3Dnuv13DmDaKVzkaSj892sMAqZ8eyI95m2ihLvu0=;
        h=To:From:Subject:Message-ID:Date;
        b=aD/r4JSZammVR+fYSRUee/t0ub79DdZco6JLQel6+7jQ+sQBhWIBQ0uLMdAFmmI/N
         93UhLSm+nLu+xkROvVjZ7wgNPilZwlUgM1jpYQzVQoCQmtVCXJXUh2ddzEZwgmkZha
         TB0vWGX6iLNce4ysqvYyhMvrfNyrb2eHhq9kQm6U=
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 1rScgj3bJX-pwHGjedC;
        Fri, 13 Oct 2017 12:51:58 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1507888318;
        bh=s6o3Dnuv13DmDaKVzkaSj892sMAqZ8eyI95m2ihLvu0=;
        h=To:From:Subject:Message-ID:Date;
        b=mfaEYA4+zGeMxvIGDLbYK/2vtjNOwF9LS3Y3yIeKIZ4wBuxdPlenoUJLMIM92LwaV
         0wtzkGqOQEUBkLmNH4ArrzaT7CjWjD2f25PKUnkbid8S0DG3XcaWZ3n6swSCzGCSF+
         dwXJc+0Y4ph+UUbAwCZvmA4mBJBLby9dyGY9Ekko=
Authentication-Results: smtp2o.mail.yandex.net; dkim=pass header.i=@yandex.ru
To:     git@vger.kernel.org
From:   Constantine <hi-angel@yandex.ru>
Subject: git-clone causes out of memory
Message-ID: <515b1400-4053-70b0-18e2-1f61ebc3b2d7@yandex.ru>
Date:   Fri, 13 Oct 2017 12:51:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a gitbomb on github. It is undoubtedly creative and funny, but 
since this is a bug in git, I thought it'd be nice to report. The command:

	$ git clone https://github.com/x0rz/ShadowBrokersFiles

quickly fills out the RAM (e.g. 4GB of free memory for me). To recover, 
call oom-killer through Alt+SysRq+f, then switch to a TTY and back.

Git version: 2.14.2

P.S.: I am not subscribed to the ML, acc. to 
https://git-scm.com/community I will be added to CC.
