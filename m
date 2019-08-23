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
	by dcvr.yhbt.net (Postfix) with ESMTP id 49A171F461
	for <e@80x24.org>; Fri, 23 Aug 2019 20:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392534AbfHWUoM (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 16:44:12 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:41031 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388903AbfHWUoM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 16:44:12 -0400
Received: by mail-oi1-f177.google.com with SMTP id g7so8002998oia.8
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pf5aRtVAyjjR7qYxuN9xVzC8gRlC/QLLo0l1Czv7aZ0=;
        b=QQxyGoPO74mMV29kHkb89Y9eMEpMT2hIG7df1FvtgFqnoRqaGvqVyIUbaQIsWUNI+J
         gSNipCElAtVXU4fbOl2ozh5yWB37w8UfcaTLIw3NXnBKWoW/HtyvNGOKA3SYIRr5s5Bq
         iBq/KwcG+1x4G1uDk9WSDifnj17eCwrXHPtEAfGTuUjWaaiaYA9yf722QhQHX6zbpWNe
         qCsGkJjTN+ADen2Fb9x12vtSkVu9prB3Wl9htFJ1Owv541aVqbktBbiDwQJHMW9iWYIB
         I2iLdmRBV31jLFrskaMQ1QbMnfDne15Cf8j4ZUtUwpBTpY1hqjYmzNPqIZ8u5lrdB0R6
         WIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pf5aRtVAyjjR7qYxuN9xVzC8gRlC/QLLo0l1Czv7aZ0=;
        b=h+QAu4giaAU2vOFBztpUGue2meWcc8GhqZx06Jzj1LiLYd8sC+oSpySRgrJdgUAFl1
         jtPANxxp09UYGD5GQPaKxVkvbMQ6DAoHiQ5FtGCSvcqU5C580q4aCF6be7CzPNYuyQxJ
         QkcUAkDE9UDR/GWwjkodAnSrBfIKRVxn3qBE2dKmFgmUq3uIAXB/OkZdzKCEyDxsql6X
         R2OpRfF4k/aKdFSkD9s1OFjn/CpSM3Vtxaiqg9W4JzmUP61RjOMuwg6Bjajz4sCayVqe
         KkdzxljxYvcpGkdqfgV/iSALY4x6LMTKxO2sIIW8CKgxBIwMds39P6xix/f8oogO/+3D
         r1lA==
X-Gm-Message-State: APjAAAXid5CSi3dpntPX8L5u6XKDj09dQZtzzGiMxyAsp6hx/C9lllZf
        amze6EiwCITAAHyDyrxjDaIg5bb8ROIzYb21SP/qp3k6
X-Google-Smtp-Source: APXvYqzVl3q1a/kVPT97FQBmGmth3BoYZ3IATCxpw7UNVhO43UUMYmg3wvzDpbtu+uf5J0mX6alyHfbJVhl3aUFIZpk=
X-Received: by 2002:a54:4f91:: with SMTP id g17mr4648824oiy.103.1566593051095;
 Fri, 23 Aug 2019 13:44:11 -0700 (PDT)
MIME-Version: 1.0
From:   Albert Vaca Cintora <albertvaka@gmail.com>
Date:   Fri, 23 Aug 2019 22:43:45 +0200
Message-ID: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
Subject: [Feature Request] Option to make .git not read-only in cloned repos
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi git folks,

Honestly I'm not aware of the reason behind .git being read-only, but
I'm sure there is one.

However, I'm sure that a large percentage of developers out there will
agree with me that having to use force (-f) to delete every cloned
repo is annoying, and even worse, it creates the bad habit of always
force-deleting everything.

Would you find reasonable to add an option to keep .git writable on
cloned repos?

PS: I'm not subscribed to the list, so please CC me on replies.

Thanks!
Albert
