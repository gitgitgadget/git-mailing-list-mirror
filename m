Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37F601FF34
	for <e@80x24.org>; Wed, 10 May 2017 07:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbdEJHYC (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 03:24:02 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33032 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbdEJHYA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 03:24:00 -0400
Received: by mail-io0-f180.google.com with SMTP id p24so8084899ioi.0
        for <git@vger.kernel.org>; Wed, 10 May 2017 00:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ixW1pzqGG0c6MO+J6Sygl27zBTI7/fGlv1JzhoKnVQ8=;
        b=eKOWyTP7IvO50Wm5n/BOMMGd5kqWbd46tRArwq023ahph88XdEzEh5aRlOVHS0EjWK
         YGy9VyroV/hfFo5I+xAlbenVRNNQpLA5ymAx6uvkzmRMj/czOewruYF2KV7/zgGJ9tfN
         9Vr0VLIS03rcNBPm87A246NhVWZrwBGZx+9ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ixW1pzqGG0c6MO+J6Sygl27zBTI7/fGlv1JzhoKnVQ8=;
        b=I0rX7b/6OEQGMbxYSAys0Kt3qvoMNGYpZkHULPm600zJgjf4K98hd22XL0vOpgv78E
         vBVfh8IlEFz58o7/A2NXa6HmeQGiImm9NyO1BIiLEZGOFWl03t6MiMhZTdgXSHcWmQw7
         zujHy57NjsR3lJ4Zefc+lguv8dyYZlYoy3byZjH5K5+5fv7dkSLZ9jwnG2f0/Ks254D9
         Qhwx94MsXfdhF0jNXb6wbHpGSaa3/KmPWQJWtjKiHn+RO6M0NWUXZ5aAYvi62ZAp5JhA
         l9WXOntAftv/lEvqiESzkGCUQMt7EKpBICjJwHhk2q8EL94kOYE5Fn762Zm3ZFvlz99o
         SFZQ==
X-Gm-Message-State: AODbwcBY4dcxOgSXlcqLuiW1skDgNqsPeZiHLuwMadb5GxCXUIny7XwW
        H1v/vnOjZf918XTzAviWKkWIeOpRug8S
X-Received: by 10.107.19.194 with SMTP id 63mr2491515iot.188.1494401039915;
 Wed, 10 May 2017 00:23:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.10.131 with HTTP; Wed, 10 May 2017 00:23:59 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed, 10 May 2017 12:53:59 +0530
Message-ID: <CAKohpok0=0__AcNZAfziTMYVDhGka3o0hzEN6HHZc=YUr7hWYQ@mail.gmail.com>
Subject: [Query] Override sendemail.tocmd
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a use case and wanted help from you guys..

I have set the sendemail.tocmd option in my kernel's .git/config
file and that works very well. But sometimes I want to avoid that
(for example sending the patch to someone without the list and
maintainers).

The suppress-cc=all option works quite well to avoid almost
everything (including running --cc-cmd), but it doesn't suppress
--to-cmd.

Are there any specific reasons why it is being done that way?

Currently I need to go edit my .git/config file and remove tocmd
before sending any such patches and it sucks :)

--
viresh
