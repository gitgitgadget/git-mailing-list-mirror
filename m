Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A281F597
	for <e@80x24.org>; Sat,  4 Aug 2018 23:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbeHEBS3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 21:18:29 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:46807 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbeHEBS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 21:18:29 -0400
Received: by mail-oi0-f43.google.com with SMTP id y207-v6so16028487oie.13
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 16:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=gDU0y9EnGG5A3nkfxyJXB1Tkd/5s66MDXH4gC9F8NEc=;
        b=aqtPxbz79eXDReuWh8LtZWLeB2RYoa6H2rxnowAd989JiTM30icIeY+WwrVrsuY75D
         RcxtySswnJJ7YlMCLhjUfs5cI1ailTYQwsoESkEVmCZADQFacv/Jyl6vWgI0a1Q/6uH2
         L1ciKsI/0tQYOKNZUc3PhbCIDgUSKGhF5rWl9rfZaAOa0aUNdR64x8nU0ies8UbJvjCl
         ytZKWyFSYZlQ8nneb0UzR4K6E/X+J/1IcpSkkkEPDhhOFqecpBy4ulNhSOtGqiI6NuyI
         cCokur7vI8YsdMKh1ZJw5OIG9dTDeQB0vf6ABi7Hdpzmv+lsU1lnkZT8p2xTN28fwU/X
         Q/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=gDU0y9EnGG5A3nkfxyJXB1Tkd/5s66MDXH4gC9F8NEc=;
        b=HD1OybJisRSEd+ViyCTRUEgO+JMQBX9iL8wuYpD5aCyVtZWeBOKibITQ+AtFGBR+JY
         1KXb1/B1iDaY6GmFSefNGpzZmVWklsBllBv9AjWQjeFE9p4hOS8M2eun8CGE39Jf1amO
         QPWpniqDl+3suqOepTtm/KKsmcSGqFWjROdZZjzzjGHACHSDvFYfPF9x3WqpzFVAjNXS
         8I9iczdDGTkn+PicjTzQbQ4T/XGasknP9liJe9xq4JCBW6ZbR5ip1WLXboHQrplxb8GX
         ZUKD8lE0OK0d7ffYv/97BGQGdJe1jIfxvRj0Mvf0lHl5ybKHioYRfSRKazsvwXxjd5W5
         vdGw==
X-Gm-Message-State: AOUpUlHztEg2bxFjkJO5k2syJeP25+BiqPb7wauImpNsAlfwLxyg8rSN
        cN4H0p4gBkd73b4OV9N/ROS+mx4RM76V8modz0JlJPHq
X-Google-Smtp-Source: AAOMgpd5AFwWVH0NLiN/ifNx5lc8Ex9KgZFJx4qgXXXmLmvvqJRY3LozC4Z+oOxmxv4c/F8b4MeTtcBj86ITGEgeb4c=
X-Received: by 2002:aca:cc46:: with SMTP id c67-v6mr9465043oig.197.1533424571167;
 Sat, 04 Aug 2018 16:16:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c712:0:0:0:0:0 with HTTP; Sat, 4 Aug 2018 16:16:10 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 4 Aug 2018 19:16:10 -0400
Message-ID: <CAH8yC8mXaNDmLBpDmtVTP+6Yc8_fCz8YCadOL41fOvb2J6j=8Q@mail.gmail.com>
Subject: How to push using SSH and pull using HTTPS for all repos on GitHub?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm having trouble setting up my ~/.gitconfig to push using SSH and
pull using HTTPS for all repos on GitHub. The idea is, no passwords on
pulls and only use the password for push.

I've got the first part of the equation using the following in my
~/.gitconfig (the ellipses are user info):

   $ cat ~/.gitconfig
   ...
   # Enforce SSH
   [url "ssh://git@github.com/"]
       insteadOf = https://github.com/
   [push]
      default = current

The above pushes and pulls using SSH. Pulls only need HTTPS so I tried
adding the following which does not work as expected:

    [pull "https://github.com/"]

I've found several ways to break Git when trying to setup the HTTPS pull.

My question is, how do I setup the HTTPS pull in my ~/.gitconfig?

Thanks in advance.
