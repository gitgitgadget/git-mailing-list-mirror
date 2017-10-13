Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A53320372
	for <e@80x24.org>; Fri, 13 Oct 2017 02:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753377AbdJMC6O (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 22:58:14 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:43582 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753291AbdJMC6O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 22:58:14 -0400
Received: by mail-qk0-f172.google.com with SMTP id w134so3488589qkb.0
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 19:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=W+3zjCrXUh6Qg3pVgnY3izm6vZ7zOuPKBop5CFJdyHI=;
        b=JWf6XnI4oWQ9JrwKe43eiRKlnX92bfF6zOIpL3jlOOaYDuJOE8CdDIuDUPxcwv03ic
         rc/7N8wbuV2grc3b792qwSt2vImji7t2izOUxVLb5Z2po9Efq/UXViU+eErURqdHQhOK
         qo/QD+Yoj42KINy3lXCL2RX0wOfi4QV1pYz3QP4cpVSaz7HsTRNtZHWDmZoW3lTkTd7I
         D8tEKY7TuggnAX8kUkQDD4bGu+KbYlo0ssh4pNVf4hsX8Ro/hdlLpJL2RckI7NWGfj+y
         UWKFaad33DBPLCwEXvHAXxZasaIM1Bl5wf1F3/Y6lLmh6PerUYTN2e3haCyb2mv5d4TW
         FuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=W+3zjCrXUh6Qg3pVgnY3izm6vZ7zOuPKBop5CFJdyHI=;
        b=ocdz+xg8Hj/AXdlVapjaBrpjJNA7AYuKh6ryXWQgBmB3vTCQs1CgUlsbXLWfQKCjM7
         A5wyzvAUj/c53DFBhbuGakcZQk4d5/mymLkJPD05GQN9p8TZrOPamu3/bWvrY6y7gwVK
         lo+ezlpRPSRuGwO5qbki0TpOBD6Vlt6oKAF95Qv4sSNNPBCH4juKOWftY5wiNupjDiSE
         ZPwdoWikpjdtt68mJXgp2IGNINa8OG3uAD39k8u4mHP612bjHbqkMCVq0NXKom4BGSyj
         vt1Ilm1T5PSNbpmBCoCU7SBTcPK8Y8I+qGTFuPa4E+jGOewacUgDjVRR/zu/Th3f0VdQ
         14oA==
X-Gm-Message-State: AMCzsaVQlnOHGpLcJQLAG/KkFJvefpa9by6MRl+nVh+e3VGVPd1QqSrU
        Z+EcXU6QoPhOcMP41c3F6lPjW9NQhGz+gqGvZ/s=
X-Google-Smtp-Source: AOwi7QACs9d5FA/jB3/PQzsQa2UCYOug+dIqpsgmgDi/5mihJi4Mn2L/aq3VgJ8CE8KUk6S0RJ19YSVP3XU6jpL8nr8=
X-Received: by 10.55.180.132 with SMTP id d126mr3009qkf.268.1507863493329;
 Thu, 12 Oct 2017 19:58:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.32.226 with HTTP; Thu, 12 Oct 2017 19:58:12 -0700 (PDT)
From:   =?UTF-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Date:   Fri, 13 Oct 2017 11:58:12 +0900
Message-ID: <CAC2JkrLm3QCNW1t-Yju-sA=9Tbv8hH1AHZUEDux8kSG9mkG5wg@mail.gmail.com>
Subject: Can I remove multiple stashed states at a time?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want to remove multiple stashed states at a time.

But "git stash drop <stash>" removes only one stashed state at a time
and "git stash clear" remove all.

Can I do that?
