Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E1C20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 12:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbeLGMgX (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 07:36:23 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:35595 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeLGMgX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 07:36:23 -0500
Received: by mail-vs1-f48.google.com with SMTP id e7so2355284vsc.2
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 04:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AgJ7IsX4NsoKHMc11BOueTAZpZgzhiDHaRE4xfhjOXE=;
        b=uIekzXtB7iFBH+0+P8wEbgoV7I4HlQUNnzSt9B0+j8b22QWyYkSit1wxtFBny4FgDc
         +TEi1Pd+L8bTJ60INty7K1xTfsxxI7eGA6GUO8RUR7/AdtvJUVWKhy8rkLnd9qsHgCUL
         /uB+4SP1EJiMT1AofMWyhII04DWakF16HPENyBnWkwCu686RppbULbNP1uynGJ7+xIwb
         B/r6H0vGWJl+vacWgJzvseC8xasMn+yyYkYYS5ldpMtaqyL8tOOLIZZRyTf3PU1B+iB5
         3928hzgl7wR9MnqQw4ydL5Y1y1J+IWjSBOxhZ6zvylyLEnEHE5KQ5O0riOFMRYpO5mP1
         I+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AgJ7IsX4NsoKHMc11BOueTAZpZgzhiDHaRE4xfhjOXE=;
        b=qvIqDKREWHbu0N8+kW9/Iv8CnGsVFXBZnhyguEcPutxWUqvFCCH1qMsLA7kFFRlsBe
         0YqDOnM+vGRqTz80U0lsgSas+1iVHq5kEs3/CnImYHsjGb3WWtiHibqTI/u21ZIU588s
         F4+8TGenHaR1KVWZt96w1hfU81iTdBk9LApIp4Q9m8voJhseJrBCThKlkXHIxNWvT+BE
         o67FbMU5OqycSh4aGF2x9L46A2ctIcYBpmXUgkrzUnSkFHYTcuMk+yip2rHTs246n6CM
         lsETDpBJ/aqu9X6S5bCIDm0uTVlt0sCQD7zbDmmOCkrfyvXH8KJdg4Lq8+fYw/LOjpst
         74OA==
X-Gm-Message-State: AA+aEWYkmp2Mv0d4M1r7ZhuzOPv7uKHtYFTKq0RJhrWSJbFsFyZr9oVj
        IWx/pMn1Acz3wLh1mnFVRnIR5Xe9XNlySH0JIMfCiMxL
X-Google-Smtp-Source: AFSGD/VhHP19kHWPuWMGG8NRJBolhm/aszaTJd+sTgb1yR87GeiKIQpOOcl/kxhjqOyOEasyVYTVqDlNM15Rjsxxpxo=
X-Received: by 2002:a67:24c6:: with SMTP id k189mr819733vsk.16.1544186181813;
 Fri, 07 Dec 2018 04:36:21 -0800 (PST)
MIME-Version: 1.0
From:   Victor Toni <victor.toni@gmail.com>
Date:   Fri, 7 Dec 2018 13:35:55 +0100
Message-ID: <CAG0OSgeTqFYGqqOOBF0TbKpsWb70Bv_wQ6-b4Ke=LTg6Z0OUMg@mail.gmail.com>
Subject: Get "responsible" .gitignore file / rule
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a rather complex setup with deep directory structure it happens
every now and then, that files get ignored when trying to add them.
As these files are _not_ shown in `git status` but in `git status
--ignored` so I guess the culprit is some misconfigured `.gitignore`.

Trying to ad the specific file gives a:
$ git add ignored/file/name
The following paths are ignored by one of your .gitignore files:
ignored/file/name
Use -f if you really want to add them.

Using -v doen't add any verbosity. I'm using git 2.19.1.windows.1 if
this matters

I'm wondering if there is any way to show which rules (ideally with
the .gitignore file they are coming from) are causing a specific file
to get ignored so I could easily fix the .gitignore file?
