Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 507AD1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 03:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfHUDcf (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 23:32:35 -0400
Received: from mail-yb1-f180.google.com ([209.85.219.180]:34083 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHUDce (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 23:32:34 -0400
Received: by mail-yb1-f180.google.com with SMTP id u68so462663ybg.1
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 20:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ThPVonC6PAy+p+x4UgihcxRQvAlis+hEisME+utF+Qg=;
        b=glNfJDwxf/6TeXzJGFRW+ebV0x1pjxe/Dj6a5ChvkVm8A3z//yHu9v9NhRjLFw3ZiZ
         GGgxsE+Gb7K8KnQWbky2ll/d6lVcMb17MsBhN1Jvvg0akif9MmyBTdpsua7ZnqPBT+DY
         hW1+yjSffY7o5tU2CgpGdicPMJEkqwk98A86MHKDVFP+3fKzHUnW0z5Iw1tf66Dpk+aU
         Z1K753ocxNKJTdd3c1LWkK/n6HBGyIu+znEKU2OTVcsxwkTIKX5pWg60DDs2SbVf9tWL
         EPagMliga/wu14oxUxy1IberORuZH9z9JS9mHZXzX/gNi5SB+TG0qHnYJh1d21vaH1v/
         w6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ThPVonC6PAy+p+x4UgihcxRQvAlis+hEisME+utF+Qg=;
        b=iLTnNJ5QSGRZEF5UAjn0a76U0FJ/mZVNIdLwd8ZZ6P8QaX/oDMdFQ5GaJA9tTWPGiI
         IDYepkbCGj5tt9YZom44Q+ScEOwRawRDt3qiZhlkEdxxf6CZuvFUjx3p8HdL1lS7X9tY
         OblYNz3kGRTUt9LI7oLFsaeMxL51aTBQz+CDGkCgBp7+3rx29UcFiPIaj9tRBfigbFEm
         XJoKwuePNAKEoIrkHIFzBVlr/H1O6XPWykQyr5hjrRMbeA2KkTzpzqJKykEc3oGBO/dB
         LAsnTEZxSf2Z8F0vY5wkR/lQN3LmymC/q6PDC3GQy4aS8tvH7qGvV1CXTNfsqFnrbwLW
         pmtQ==
X-Gm-Message-State: APjAAAXLk3jKHruqQfTXGW4lZjuTj+0DgfI26HE9mM8R6ujkkxBa4qjW
        86Ob55G8ckB4Wbay9TND4LGIvEtTioz+5KjLpt96bf930g==
X-Google-Smtp-Source: APXvYqyeVfeovfdHzp6BJyJyQcjq77Buw6PswxXgYxeXMLCtYyI+Fu2mzZ2URzPY8p0UQJkESFJX6pr8IQDHrtaJaAo=
X-Received: by 2002:a25:c7c1:: with SMTP id w184mr21340514ybe.310.1566358354011;
 Tue, 20 Aug 2019 20:32:34 -0700 (PDT)
MIME-Version: 1.0
From:   Wayne Walker <lwaynewalker@gmail.com>
Date:   Tue, 20 Aug 2019 22:32:23 -0500
Message-ID: <CAJCsJ5fygkaB-=EoYC3EJ3HrBbGUW+cdsXTddUUEyBzT1TB+Zg@mail.gmail.com>
Subject: git grep failure?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I use git grep constantly.  Today it failed for me. It isn't looking
at all the files for some reason.  Am I somehow missing something?

midsizeschools@ut:~/tams (master u= origin/master)$ git ls-files | wc
    254     254   10062
midsizeschools@ut:~/tams (master u= origin/master)$ git grep -l . | wc
    250     250    9938
midsizeschools@ut:~/tams (master % u= origin/master)$ git grep -l . |
sort > b
midsizeschools@ut:~/tams (master % u= origin/master)$ git ls-files |
sort > a
midsizeschools@ut:~/tams (master % u= origin/master)$ diff a b
26,27d25
< app/models/tars_attendee.rb
< app/models/tars_district_registration.rb
144d141
< nbproject/private/config.properties
156d152
< public/favicon.ico

# git knows about the file:
~/tams (master u= origin/master)$ git ls-files | grep
app/models/tars_district_registration.rb
app/models/tars_district_registration.rb

# the string is found by grep in the file:
~/tams (master u= origin/master)$ grep accepts_nested_attributes_for
app/models/tars_district_registration.rb
accepts_nested_attributes_for :tars_attendees, :allow_destroy =>
false, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

# but git grep doesn't find the file????
~/tams (master u= origin/master)$ git grep accepts_nested_attributes_for
~/tams (master u= origin/master)$

# git version is reasonably new - not my server, can't upgrade it
~/tams (master u= origin/master)$ git --version
git version 2.19.2

--
Wayne Walker
lwaynewalker@gmail.com
