Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06C0B1F404
	for <e@80x24.org>; Sun, 16 Sep 2018 07:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeIPMhn convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 16 Sep 2018 08:37:43 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:40015 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeIPMhn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 08:37:43 -0400
Received: by mail-qt0-f172.google.com with SMTP id h4-v6so12570735qtj.7
        for <git@vger.kernel.org>; Sun, 16 Sep 2018 00:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ccNL+hqI6opkzk0icZWBhbP7a1aXO9lyj2pst9mOZMc=;
        b=V0iBn1Sq+HImqtfld5sFRGMRsZtJf6cyqnFVppIIfAwS2TAW7nis/XQf0cxtR3vtv1
         eMRD9Tu70aPiFPTx5NiFkyq4hT+GWAzV7LV5ojdy2qHTWmciFWWSqNcZSzybNR5zcSaV
         u/1m0aK/8ZBxV8fslYqa3sMGbxho5byeqsEj9rshANthWL2xxK0kHQ6kwsPLD+3lu4sV
         nRIHbU7WKDlUs7J9un8stoGm+6EgPG/+BMoRFlr1NycW283zWWG1TUdko3oYzKrIld0j
         pZufhliPyxsf8STXPxKYy97x+gqlWAK5DZuhOFDKyoh1YIhw+VBs/I9Nc23YRUHcX1BN
         L7zQ==
X-Gm-Message-State: APzg51DD2BFvhD4ixQlRohWnMUTUDLSRmmy4e9HmTnUT72NE3V6qJh3S
        CFLQrdUP+NKv9FAVH+WrpX9eAXt5O7LDjDxjjhg=
X-Google-Smtp-Source: ANB0VdayL0RVdTVixx9wqFvD22Wr4pC048hb7WLXQKBEcnHmnJAuonml9+onGfxmo64a7y7Jnxyc9Usrame+Zu1nTMM=
X-Received: by 2002:a0c:e5ce:: with SMTP id u14-v6mr13887712qvm.6.1537082144476;
 Sun, 16 Sep 2018 00:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAKd-JgStGb4Ka9Rs6G2e4ADQKZVrsJMsNGz1sRP_4Ej4=FtxtA@mail.gmail.com>
 <CAKd-JgS3omKbN+OzQL2dUun6Seg9CjDNk8KEj9m83xdTZE=7FA@mail.gmail.com>
In-Reply-To: <CAKd-JgS3omKbN+OzQL2dUun6Seg9CjDNk8KEj9m83xdTZE=7FA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 16 Sep 2018 03:15:33 -0400
Message-ID: <CAPig+cQWW9kibWYKu5oRDgo_Pt4wVmzkqzbTG=YGvwqRCXcNXw@mail.gmail.com>
Subject: Re: [Bug report] Git incorrectly selects language in macos
To:     primenico@gmail.com
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 14, 2018 at 10:20 PM Niko Dzhus <primenico@gmail.com> wrote:
> Looks like the issue appeared after updating git from brew.
>
> A quick search revealed that brew changed how it builds git recently.
> I think, it just didn't include i18n by default before, so I never
> noticed this.
>
> Anybody here familiar enough with the build process and dependencies
> of git to pinpoint what exactly is causing this and how to fix it?...

This problem is not specific to Git. Earlier in the thread, Ævar
asked[1] if the problem also occurs with other command-line programs,
and indeed it does. For instance, I tried with 'wget' installed via
brew, and it exhibits the same odd behavior. Ævar suggested that there
might be some magic special-casing English, which makes me wonder if
brew builds such magic into gettext(?) or if the magic is part of
MacOS itself.

[1]: https://public-inbox.org/git/87a7ojlp31.fsf@evledraar.gmail.com/
