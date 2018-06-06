Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B541F403
	for <e@80x24.org>; Wed,  6 Jun 2018 22:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbeFFWvT (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 18:51:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39241 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752119AbeFFWvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 18:51:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so14958434wmc.4
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 15:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=WUOtPWkkG6/0vzyDNfH4tK7qdGBSFtSWyBzjfV4BMs0=;
        b=FgR2GVYavVt/5ZtGLCPKOvMiKFgjM68jd2bmtQP2MOncQPQyJ1yQuG7szDf+Mf7O/h
         OlQiNlMA6vor89qdLNaG2qkKyhbDLealZgs9xi9T42ivIpssNJRKHBQJW/JzdduIBzEz
         aFs+MdJM3iLCmwXL89C+rEMLd/AZORNouLZNOvgR79yhfT2fODLV/l2xnUz8CcRvreIU
         hgZYUEu+SyqSMdYCiKwe7/Wyk6pitbY/8AXPeZhHTiiTbhaQxkLFjDu23pWC+Okf9OnK
         MBvNZ8D2T/WECmKyF5Khx8u5nKQ0KlbndA0K1j3sxUyXtQQa8iLq1p4sKvbs57DCp1Po
         YEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=WUOtPWkkG6/0vzyDNfH4tK7qdGBSFtSWyBzjfV4BMs0=;
        b=C0MVeSp3GMO+xy+IE/pm3zOgNPaVc9XUBx0Xp/XRcNN9hPbHVAhIek0p0QrHlVjx01
         HueAVj/3L/si2kbBkCZJXmJ4BaOEFDMDmQbNZk99AApa3u8BkWxuf/77/AMXj9Or6/0u
         KnkVCmKbfWsLEpzctjS9y7D5jPeyVDpeaH+FaJQxN3qjWssjz3tnSoC3ITYSGnteIWY2
         +jv0aYblkKB1Wd4D8DhSi9DFogbriGIPzjpHxZ+2iXJ2rY3yQHTQPGr56emS+Hxfb8vT
         p9GtYcjsSmUcs0a76cFURyMh1G+ZLlOXid4ROKBkIekpRY2q2wlDmuRzuqZTYNY/vEpb
         d9xw==
X-Gm-Message-State: APt69E1gIaK3ciwwPn+iFKJ0H6L7dE1GGum9jwjsYRsY77U2tlBnD35m
        8cI5pMXfbMQeysG7W3XrxFQ=
X-Google-Smtp-Source: ADUXVKLnSfUdIZ2t5F6MxT7Rd4QIk9zp6iEefRP7sO92FIURjabxLhWBMgaqgscVGpKqhmwTRUQmJg==
X-Received: by 2002:a50:8cb7:: with SMTP id q52-v6mr5600078edq.17.1528325477459;
        Wed, 06 Jun 2018 15:51:17 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id b1-v6sm9005327edq.82.2018.06.06.15.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 15:51:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Timothy Rice <timothy.rice@unimelb.edu.au>
Cc:     Todd Zullinger <tmz@pobox.com>,
        Thomas Fischer <thomasfischer@fastmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>, git@vger.kernel.org
Subject: Re: git rm bug
References: <1528313557.2662346.1398855328.3E0F8023@webmail.messagingengine.com> <alpine.LFD.2.21.1806061532420.9259@localhost.localdomain> <1528314421.2665575.1398886712.579F37CE@webmail.messagingengine.com> <20180606200137.GJ3094@zaya.teonanacatl.net> <20180606201012.GA2454@sleipnir>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180606201012.GA2454@sleipnir>
Date:   Thu, 07 Jun 2018 00:51:15 +0200
Message-ID: <87a7s7zfz0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 06 2018, Timothy Rice wrote:

>> It does seem like something which could be noted in the git
>> rm docs.  Perhaps you'd care to take a stab at a patch to
>> add a note to Documentation/git-rm.txt Thomas?  Maybe a note
>> at the end of the DISCUSSION section?
>
> That same documentation could mention a common workaround for when someone
> does really want to keep the empty directories:
>
> $ touch ./path/to/empty/dir/.keep
> $ git add ./path/to/empty/dir/.keep
> $ git commit -m "Keep that empty directory because it is needed for <whatever>"

nit: The .gitkeep convention seems to be much more common in the wild
than .keep, and it's probably time we documented that somewhere, even
though it's not a magic .git* file like .gitattributes et al.
