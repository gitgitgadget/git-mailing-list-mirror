Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB79120958
	for <e@80x24.org>; Wed, 29 Mar 2017 18:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932327AbdC2SC2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 14:02:28 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35055 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932276AbdC2SC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 14:02:27 -0400
Received: by mail-qk0-f174.google.com with SMTP id r142so20082172qke.2
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 11:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2+2xuIuweS3XntzIxp1lvVgRyXnz2BP10WLPmpjnun8=;
        b=WYZ0OIaNv++rBAhEp8vvZOQqsIjQsVrAQ0KzoisshZbRFmAJtoBmNs+JlzxqzxkJZv
         crw1VFyt2ayGVSrW1WcxWXrY3UqLn3AuQnOL4B0/xcgB7cvozhZ6DqURSZ2rESjESOhm
         0cPJlpIfjsREa+MxLA2rotJ5vrF2dafimiXW42yZNnX4tTv3F2XaQmWpLdJ2NW5d55ha
         BCxJL5f7MHnZ68kVMi/ovcJnPQW4kiz4hYmgWOXOSwZQCzsYT2M2zHKPfQry8Ck9GKDo
         Gi5wMFMbdKrdbzFdGfOThkEIQY6Wm9x5OilYwrPDU4JyRlT14AtM9xTlPFuQR0CUOE0p
         nGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2+2xuIuweS3XntzIxp1lvVgRyXnz2BP10WLPmpjnun8=;
        b=aOAUeeApANJeKqUfVfCQ31CLXjEwRnGJmnGV5VtqH765Al2WjvydiYsIDM6hoWG51W
         B2xoaU6dcNbypwVCkBrmnxMtK0vcsJcacybki8eLEBvy/vRklf+OgCZkhPkcwNlz8zkJ
         m5AFHVlzrlEeE1fkUGXYphWJo95ieyUpOQL3GJVggneisnrjlhnoYRO4810NZkSzZxqD
         qUN6GfOu0pErkZgogd+uO1rZz5+wvCK/GEp745KSWET+o4HvUtE8hDNL+xkgJUIllMjY
         oUzjxTuLPXiMJxGE8WMw54vB/WAQxTUoLt/Sgj6Mi/RAMNratW2lNEoW9fR5838DT8Dh
         PHIQ==
X-Gm-Message-State: AFeK/H0vYUlsPwho6Y4B8lKvbBncPkeOjg+cpsTJvIJZFH/cxWCJPm4gnzfNzpUkAscLD9TMhfewD6gQVMaxtQ==
X-Received: by 10.55.212.203 with SMTP id s72mr1914942qks.261.1490810546115;
 Wed, 29 Mar 2017 11:02:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.95.84 with HTTP; Wed, 29 Mar 2017 11:02:10 -0700 (PDT)
From:   Eyal Lotem <eyal.lotem@gmail.com>
Date:   Wed, 29 Mar 2017 21:02:10 +0300
Message-ID: <CALA94fPqm5UnYBwqZ5fDJ=DL_9EaZeRfqHB5ZzUQt11FSz4ZMA@mail.gmail.com>
Subject: BUG: Renaming a branch checked out in a different work tree
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git version: 2.7.4
installed from Ubuntu repos:
Ubuntu Version: 1:2.7.4-0ubuntu1

When renaming a branch checked out in a different work tree, that work
tree's state is corrupted. Git status in that work tree then reports
itself being on the "initial commit" with all files being in the
staging area.

--
Eyal
