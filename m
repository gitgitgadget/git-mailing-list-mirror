Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96CDB20A40
	for <e@80x24.org>; Fri,  1 Dec 2017 11:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbdLAL7I (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 06:59:08 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:37198 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbdLAL7H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 06:59:07 -0500
Received: by mail-wr0-f175.google.com with SMTP id k61so9830073wrc.4
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 03:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0zMXN3eQJqs8tldJmW4TXtfszO4EcEECuOgSBQ1iTTE=;
        b=hj63+AUohuWEHIwaqqzMSCizhqef9cH4H4jdel0Rs086d8eEtnxVNOspx9j8li5whv
         jaKhRkPMBabqkt3tW+d4RKJ7sjQTJoPmbC+WcllB1eT+D53iLiuGWu0LpNO9s3J44AV0
         A6APS99Cxnpa5oOWg28aIDRYXQ/Xbloz8uSg0hbFc2yzoH4Nn6QaxBnlUzyqHu+uLP2A
         4BIgahEOjd+civ9YlnE6A3OaTV0IDfYQuod8gqvmYC2O4ZLuPSnS4DCdUbhc021lwJ2t
         53PvTwRx1als0ZYRDj1UhyGoW78tP4owF1Ox5Z+GpuUK/nl/7rVte0SXGcHbdPh8EqLX
         AO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=0zMXN3eQJqs8tldJmW4TXtfszO4EcEECuOgSBQ1iTTE=;
        b=IV7cJbRmFBtptv+/v3fMM2Jzr+QuaKXs+H+W3eswrjxJi9udvdNHEC5yZR2FulevM1
         lM6DVWMpX6uOZWV7c9E1pcHUCCxn2ivsJWPpdYjTu8fjKPzV07JkoikOzqrrPSttvF7T
         6Gq82WxHy85V040/CSzgVdXJfPqmG5ThjZYdlOMOlsETChH2U0hjMhgDyfmJl1JkcFeL
         znc6AdNK2CvejAIh/x7ypRWrKj9C4gzILPLNQwgDK7NjQCXhaazGtRzT2ThqLRr9Rgfy
         VvEHntjpMw+JMHKQu6U6RMpxyOX4pKF8ZumQPBFbLPqjsCqrZY3n7EpsS9v0jGyD5fVy
         kp0g==
X-Gm-Message-State: AJaThX79bxITm5Zsml6+5+xae9TRuP8HtzkSRVNwRpVLwVKMuid8hJUg
        xE+Lu/of2sSeOr949dJMbmYDm8Km9Q9F3UUlqWpsHA==
X-Google-Smtp-Source: AGs4zMazQmvv1CFhPgx27vmtjmlV7yPdb/xzMWMt1H9cth+s5GnzFL/XsOMoSo1wQpgVNzb8apux8HHYqmzsjSImqRE=
X-Received: by 10.223.147.133 with SMTP id 5mr4863611wrp.230.1512129546158;
 Fri, 01 Dec 2017 03:59:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.1.70 with HTTP; Fri, 1 Dec 2017 03:58:45 -0800 (PST)
From:   =?UTF-8?Q?P=C3=A4rham_FH?= <parhamfh@kth.se>
Date:   Fri, 1 Dec 2017 12:58:45 +0100
X-Google-Sender-Auth: jWrnmq38thdNJO8vCmrjZqb5NP0
Message-ID: <CAM-FauOP_FG=N=npVhuKdiYATDAGxeP+q+qud3-X3g99=g_mBQ@mail.gmail.com>
Subject: Aborting a merge will delete new files added
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

While sorting out a merge conflict I accidentally added an untracked
folder to the index. Later I decided to abort the merge with `git
merge --abort` and I expected it to unstage the untracked file but it
instead removed it. This was not what I expected.

Cheers,
P=C3=A4rham
