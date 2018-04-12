Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64DF11F404
	for <e@80x24.org>; Thu, 12 Apr 2018 15:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753100AbeDLPxg (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 11:53:36 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:39857 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752906AbeDLPxf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 11:53:35 -0400
Received: by mail-qt0-f180.google.com with SMTP id l8so2874770qtp.6
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 08:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vizalytics.com; s=google;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=rTHYoWP05Beft6eZW8Ktkah/oBkg9sEOmd4cWOKqe+o=;
        b=PoH1RYmZ7/KYeMbvj3UnhYQM1xS2jZSMLMgQd15t2BaXWj29R65tIFyFzD2+ySh5/z
         XVCbux6ADj1xNqXYl+2ACwsN5udphuiWw61nI+89E2lJ8VEvciOvJtROEgMLzCtPrQqH
         D+k83ivcVyKjtSfLdH/v7DdJc4VwpCm3b9Cg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=rTHYoWP05Beft6eZW8Ktkah/oBkg9sEOmd4cWOKqe+o=;
        b=VTJRarSZ413GuJ7riZi+jjCEzj1wyGdzpW1ulRg6ZOaA6DP6s+PjF4EXRHiZqgOpy0
         g7iqu1wE1dt/WeZ0v8PSwQyUl5wyfLIdP1VEImRBxMarg0nFzYIwyFF42M7qjn4i+K3Q
         dtZ3+xmxSQbdSRAqbtHoIrIcgX8H2GbgNXTzFSbHtxn/mkvccxW1EhQpU7qs4TTybH8G
         ogO2vdEuWSQkoi4BHjlRvp5qkbz8KAaRIcfpeUgP+y+8V90VP3ioUzt7wbz3VTbuQE0Z
         XdQhB/WouLaWkz3mYj5u1rd89w1XhYIdVX6ieYy1AreBUBsougOnqcjc35tvEPneVi/f
         pagw==
X-Gm-Message-State: ALQs6tBYWFdWVEMnSfb2xCdcfp/T6vZ3LxfegDO2OSMEGC/8EWrsY3zQ
        AX74pkP5IQ65Bc5rZlcjM2tvCjXVn0s=
X-Google-Smtp-Source: AIpwx49lM0FymtFvJyDPXhdcmLLV7LvZd8p//tYBl9F94VthJcaIu+A7mx3ovIJWpuPczuy8FPkJPA==
X-Received: by 10.200.45.124 with SMTP id o57mr2056467qta.316.1523548414458;
        Thu, 12 Apr 2018 08:53:34 -0700 (PDT)
Received: from ?IPv6:2604:2000:1303:4017:c04:40c5:7e86:71ec? ([2604:2000:1303:4017:c04:40c5:7e86:71ec])
        by smtp.gmail.com with ESMTPSA id b76sm3192269qka.3.2018.04.12.08.53.33
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Apr 2018 08:53:33 -0700 (PDT)
From:   Isaac Kaplan <isaac@vizalytics.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: git gui issue
Message-Id: <DCC85DBF-44B9-4473-B6D2-1ADD270DC844@vizalytics.com>
Date:   Thu, 12 Apr 2018 11:53:33 -0400
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm having a bug with git gui. Please help me find the right place to =
report it.


version stats:
$ git gui version
git-gui version 0.21.GITGUI

$ git version
git version 2.16.2

how the issue is produced:
using=20
  Git Gui
    preferences
      Additional Diff Parameters   set to --ignore-all-space
save, exit and relanch gui.=20

select an unstaged change where the only differences are ignored based =
on --ignore-all-space
one example of such a change is adding 4 space to an existing blank line
this gives the misleading message "No differences detected."   and =
triggers a rescan. This results in losing the place in the unstaged =
changes list and a rescan that does not change the list.=
