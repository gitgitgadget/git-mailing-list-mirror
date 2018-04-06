Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A44A1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 19:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeDFT2I (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 15:28:08 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:36340 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbeDFT2I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 15:28:08 -0400
Received: by mail-qt0-f181.google.com with SMTP id w23so2315221qtn.3
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 12:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cwSRDL+9l9rtuDvcNNbXphnGN46i9iOj37L/21Osr8U=;
        b=usfk5pcfHXUXkcc5kT8DVJ0JUSW6MV/G9dh6gw6hVIxUpMsOFFDKC7UPywP6LgU+wz
         ZKWomr1Gkkg40XpaSxm01/UUI1EXHX6UaAb6Z15bjicy9AJ3JVvy3524a1VAeT/6D/O7
         lwmhmnsutAyiPFsT7Lonp2qfy7xRzOnqo5JORk10stX9K3wgo+dE0VWAeNaitJC/4Qdh
         Fs7Djem/Qr8pZKva+moFj929UoNFF+FlzMS7yGag9hHDA/Wytqy5X/6A+m8W1zwEOR4T
         PbKdkjnjy1pYXGLTHNiVkeKi5Jc9zav6xrB3os21lWQVfSegxuwr9kTdH84y+p6fwxvL
         9U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cwSRDL+9l9rtuDvcNNbXphnGN46i9iOj37L/21Osr8U=;
        b=ftqKD+muKSkL1f13skP2GDjufPN8gmXDhVpmtNO1Nh8I6CClDG/lRh4bWx0CQYNZ2Z
         EAERRzrNamBt7WH9UmuleYBoKm9BE4S6ENT7AhPbafbyOWmGiWde8fO1S6PgBfTIS6vA
         JaxnO3i/biPJdlM9otnb4IP7o9RdovIw30r1pFqorETHSVhcKtNy44MSPon3GMItpWEV
         zx5ekce7B0dNoeSqKCjKVlfVh/bP+5w3lSfNM3S8qAatVI8x+2RBJUu7hgNwkmJkqnf9
         Xa4gZNTRNz7YP2+YKpSWH4i6HgPyJV464icUnRhpNrxkHEFHjWls7vtyQ7H0WH3dA3ue
         G5gQ==
X-Gm-Message-State: ALQs6tDCiRN3qZLijr/J32W5zmw1I/F9jVvQYDwuO7qNUJvq+lnc8miA
        o0c7ejnP3NGypdiS5UQ4CTCyui+1WRyzyXEkCLsVCA==
X-Google-Smtp-Source: AIpwx4+gMClrjjw2JprXmZpwl4/u8v1lp3SS93SHRoxkIf0KJeW8I2QsF/gflIdkLhaxEKxHlUkZ4T0AV8tj613sjvo=
X-Received: by 10.200.17.2 with SMTP id c2mr38095160qtj.21.1523042887288; Fri,
 06 Apr 2018 12:28:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.38.88 with HTTP; Fri, 6 Apr 2018 12:28:06 -0700 (PDT)
From:   David Davis <davidjamesdavis.djd@gmail.com>
Date:   Fri, 6 Apr 2018 12:28:06 -0700
Message-ID: <CANqAOmsZxpbkT3YFcZTOeRx2gnxnzc+_C-amVQjKSE=0m7_n7w@mail.gmail.com>
Subject: Git send-email not sending email patches as subsequent replies
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, I have the following git send-email command:

git send-email -5 --quiet --thread --no-chain-reply-to --compose
--subject='Recent Base Prototype Changes Summary'
--to=davisdavid@google.com --from=davisdavid@google.com

It's sending emails but as 5 individual emails and not as subsequent
replies as suggested on https://git-scm.com/docs/git-send-email below:

So for example when --thread and --no-chain-reply-to are specified,
the second and subsequent patches will be replies to the first one
like in the illustration below where [PATCH v2 0/3] is in reply to
[PATCH 0/2]:

[PATCH 0/2] Here is what I did...
  [PATCH 1/2] Clean up and tests
  [PATCH 2/2] Implementation
  [PATCH v2 0/3] Here is a reroll
    [PATCH v2 1/3] Clean up
    [PATCH v2 2/3] New tests
    [PATCH v2 3/3] Implementation

What am I missing?

Thanks,
David
