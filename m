Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 233BB1F404
	for <e@80x24.org>; Sat,  3 Feb 2018 18:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeBCS47 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Feb 2018 13:56:59 -0500
Received: from mail-ua0-f179.google.com ([209.85.217.179]:36666 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752572AbeBCS46 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Feb 2018 13:56:58 -0500
Received: by mail-ua0-f179.google.com with SMTP id i15so16293307uak.3
        for <git@vger.kernel.org>; Sat, 03 Feb 2018 10:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uU3dRMgwu44cOykKlfPW3lHLc9SeEfebHNfzJ/aVJBI=;
        b=dek3eDBrZo1WLJRPf+LpQQcAYH3lgccdv+Ao/Bu788RwRS+f2cOipGNFOQmSmQAOpG
         6U6gIBjbAMNbGUFES0NeQJytk40tDcZKyCg2V/hIdi5PC7xOmg6E4s24KyjXfuswtgJm
         JzTJhMQIXjv1dXYTE0L7saK4isFE0Xq6iAXVZTOkwAGOx6dXCEJ5BEA9KUIOqNthv0zG
         ucrShi1opbnyVlyKYCRRThKMVGYgsbSVBzV6cG5o/Zy/1VDlySLs2MWq/K+Z+zamcZ9G
         F7/O+UTVUYkPt2flIvZhkkb9iX4KWrwbPYbIeTazkkhwOZfiUFEpXfrOaZB3wHVAzM22
         zcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uU3dRMgwu44cOykKlfPW3lHLc9SeEfebHNfzJ/aVJBI=;
        b=I/yS3WhdgHfwifmPq0kfnbWkR+jDW6y81FQzF7glrWnNHescEaoyHX8V9yVuy5PimA
         IBeJr/xKkGEqrRWE5Uv1iErLBgVuCIxCFYyUWXGGoXSnYFIyttR6kFcbQ8nP0o7pqRpx
         LDGLtAo+4z4NyVi6DfBVxhd2MVnJZKKlP/rD3AUTGZBUx8Q4+1MQrNOkrpTskEnnp7dS
         //hrkvozVOvUIp5YKIp4nDsI6u097qWzsCzGmzrmiMef4/InYqYG7rQT2xj+adpYAiFw
         F+qFUB2FsCGl1m8wPpqfbDZaShR77fEq/OM/R6Kc8hzanmYGgWrpRX8TqK2ruU89OwUM
         0lAA==
X-Gm-Message-State: AKwxytcU9XXqE9fKUdsDy2JxsbWOW7iylW2pDz9SghpFsGXxmvrouJ2C
        E4xMkd6FcaLrMhUxxB3E5pBONJQYjjKyQfzIcoQ=
X-Google-Smtp-Source: AH8x225KGZR86Sa7DlsVrl770fnuVRq9ln6zO8CkS6J3Ik03nvISq+rYQNb1iufWiIippTR+cU3YTTmLqEJXkBA8zb4=
X-Received: by 10.176.25.230 with SMTP id r38mr37373766uai.2.1517684216985;
 Sat, 03 Feb 2018 10:56:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.80.148 with HTTP; Sat, 3 Feb 2018 10:56:36 -0800 (PST)
In-Reply-To: <CABPp-BErnsyzUbu5dAFCs=Z5m3Z0k8vNkMJQ9=Tc=wWqPDYNFQ@mail.gmail.com>
References: <CAHZoaj41k0AU-S1cPH3p6gU6EzXfYiMasN7=Cv9SRd2xp=1ThA@mail.gmail.com>
 <CABPp-BErnsyzUbu5dAFCs=Z5m3Z0k8vNkMJQ9=Tc=wWqPDYNFQ@mail.gmail.com>
From:   Ayke van Laethem <aykevanlaethem@gmail.com>
Date:   Sat, 3 Feb 2018 19:56:36 +0100
Message-ID: <CAHZoaj4cZTAa5+Yuh=at-RDtdxatPY6SChHc7oJaHAep8x=r7Q@mail.gmail.com>
Subject: Re: Segmentation fault in git cherry-pick
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This looks like the stack trace in
> https://github.com/git-for-windows/git/issues/952, which was fixed by
> Johannes Schindelin in commit
> 55e9f0e5c ("merge-recursive: handle NULL in add_cacheinfo()
> correctly", 2016-11-26).  Could you retry with a newer version of git?

A newer version (2.14.2 from Debian stretch-backports) fixes the
issue. I can now do my cherry-pick.
Thank you!
