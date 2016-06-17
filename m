Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,BODY_URI_ONLY,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548FD2018A
	for <e@80x24.org>; Fri, 17 Jun 2016 16:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbcFQQG1 (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 12:06:27 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36379 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbcFQQG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 12:06:26 -0400
Received: by mail-wm0-f42.google.com with SMTP id f126so3906396wma.1
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 09:06:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mtu-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=0ALpWMTVMLFNt1J71XBDsama99yuyLcf5WSkikB30h4=;
        b=0USfXnoOL2iJE084RV7ZuAfYEfOBjQSOFv6l5veXwVNU+DySae+XY+XfVBL6sd8JwX
         BelnSia7CnLcpsVo1h99dMoDChGmfT9l9x0XEeWjdJBxIqFFT7BsbxtqFEVz96fZ2y89
         Vr3ReMqKgz6D0CF0EzB8h+RMTsS7he7BX1c7bMUXlMIchjylDbGhm1bQ8ljkJrwGMLEZ
         4iw+IKGSED7Z+gJGYvK6YEV6HmsyvCRvRc/lBS1BhMl3W7URqB7vVvJFvrIXmZK8Chp+
         t1E4yxg5Lk5vHduz46AIgS2bf/c1rxEbNyP3U00X9ur7d+n7OiZStSq9AqGXLsZ/sBS1
         8Hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=0ALpWMTVMLFNt1J71XBDsama99yuyLcf5WSkikB30h4=;
        b=CHy1bNbZLrrW28+OZCXA5c+bQFeVwhXZxZUM0B5kRG3VxvgyzCyNVgWcEiW94mKpkf
         2jebBLPwUOAz5BUOW1BOGBWjXml5/HydtQjRm2cMKCpA9u8njFm4ekk0lg/0//FqxisI
         fLYltwMxIOMQwp5vy9/kv0qD6yhYIYP6eLp/j5whYVHrY3A7/BtJemhyFI6izTG3cGHF
         Zz7V39V85kwTEbMI7CGiCuqfWyg1SpJNSXzjm6Ixty2bN8p7Xu20JG5EerfpMeS1fELu
         yVWua5IADaf/4eIfqQsNBHQYBsXHgY2M/sZKIWx9uJU3Vs66sO7+Rw5Jcj6EiWk+pJZp
         Jpkg==
X-Gm-Message-State: ALyK8tKoQ2uZSRaCGs7dMGAV11Lroa8DCsD7ykWqE7iB1L9RSOA8cf0bE9GJtBzb341qNPMHSurnwje2Z1a4X9jn
X-Received: by 10.28.195.135 with SMTP id t129mr444814wmf.78.1466179585241;
 Fri, 17 Jun 2016 09:06:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.14.197 with HTTP; Fri, 17 Jun 2016 09:06:05 -0700 (PDT)
In-Reply-To: <CALuTVP62fr4+r-df8QnMiD30MUoimTrCbiwpp8AQ6qzVwDPEkA@mail.gmail.com>
References: <CALuTVP62fr4+r-df8QnMiD30MUoimTrCbiwpp8AQ6qzVwDPEkA@mail.gmail.com>
From:	Alex <alexr@mtu.edu>
Date:	Fri, 17 Jun 2016 11:06:05 -0500
Message-ID: <CALuTVP4BADSC2MBXabLCajAAai8GUE5zusvT++toftGCsLQeeQ@mail.gmail.com>
Subject: Fwd: Stash and Stash Pop Exit Codes
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I was wondering why git stash exits with a 0 code when it can't stash
anything and why git stash pop exits nonzero when it can't stash pop
anything. I was trying to script something and wanted to check if
anything was stashed before stash popping.
