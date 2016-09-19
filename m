Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 172E82070F
	for <e@80x24.org>; Mon, 19 Sep 2016 14:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759473AbcISOFM (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 10:05:12 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36248 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756863AbcISOFL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 10:05:11 -0400
Received: by mail-io0-f179.google.com with SMTP id m79so92206840ioo.3
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DdjoladScXLzKZ1mLR0av2pcNS6zxl70sSd7tfx+BP4=;
        b=wax733i+dM/cKhHtnX7yn9SnQ1D0IF5RI+ViBLFH2eEwgV8qZQnM7VGfCdSISOzTcp
         8QxHG6Iq4kbHO9Js/2BazzQiKuXdNlslyyB/+dqHAaCRjyFbImmy+rfHCM4xE9hVLOqb
         /7ETBFeHg/5hkBdl/li6xbk1CkKv/UsjgiB59xo95HRpi3PTeP5pq+3Adb2q71rVsvpI
         TxVuU9G2Wn9pAAm/ANbjGRaxUXaqunFr8yfABLCsnGx6PDaRwpRi4vCVVG3DZIkkXWd5
         ZGhw5XHuAj6o3b92dg5tGRIJ8/0bYABY+hZwuWTJ2q3vehAtVSAvLeT+zGbRYA4xIM/i
         ERsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DdjoladScXLzKZ1mLR0av2pcNS6zxl70sSd7tfx+BP4=;
        b=GNW3k5rg7iLWXqY6dgLh6dPoKaMUX/kmZ5TnRjCFdMgB6/yZ0plICp5lypuFqSQ8XI
         0QRpA/asIHG/E/rghPs0znQPoWsTLHHN3g1uMi7VkJ7oWbmPorXaxp8jYGiu9utOANsh
         3kLGRoYVmZLIjKedcz0MdxutSoK2rCuoRm6y2CPQXw5AEghkpatYosLYiaNHvKOOI89P
         epHEO8iI9LhB1rK2Ic9XTanSbQWZibGB0iS38eypWjlDjvJwY5ScC4c90IgLXhMehu5+
         6Uyz7G5zuf0/00ySp8QoRyUgbP6tH0sb2uyLxG/e10aclB2YbvhQa7rMfxIR9Fory32l
         XqYg==
X-Gm-Message-State: AE9vXwPBGUuPLEQckSFhxhSvdCTm48F5FFIeMkPmh1H7EJSS1J9SDaPbftRiyhnRyazdxiwI37qK54fS5l9Mzw==
X-Received: by 10.107.171.133 with SMTP id u127mr39780791ioe.102.1474293910489;
 Mon, 19 Sep 2016 07:05:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Mon, 19 Sep 2016 07:04:40 -0700 (PDT)
In-Reply-To: <1473984742-12516-12-git-send-email-kevin.m.wern@gmail.com>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com> <1473984742-12516-12-git-send-email-kevin.m.wern@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Sep 2016 21:04:40 +0700
Message-ID: <CACsJy8B1bbKBhg1ke4u6PV3k4FWz-bhBPyN2X=mV2Z2=8Mhy=A@mail.gmail.com>
Subject: Re: [PATCH 11/11] Resumable clone: implement primer logic in git-clone
To:     Kevin Wern <kevin.m.wern@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 7:12 AM, Kevin Wern <kevin.m.wern@gmail.com> wrote:
>  builtin/clone.c             | 590 +++++++++++++++++++++++++++++++++++++-------

Argh.. this is too big for my brain at this hour. It might be easier
to follow if you separate out some code move (I think I've seen some,
not sure). I'll try to have another look when I find time. But it's
great to hear from you again, the pleasant surprise in my inbox today,
as I thought we lost you ;-) There's hope for resumable clone maybe
before 2018 again.
-- 
Duy
