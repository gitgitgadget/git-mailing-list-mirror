Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EF0E1F45A
	for <e@80x24.org>; Sat, 17 Aug 2019 00:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfHQAjr (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 20:39:47 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:40081 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfHQAjq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 20:39:46 -0400
Received: by mail-pf1-f202.google.com with SMTP id e18so4883536pfj.7
        for <git@vger.kernel.org>; Fri, 16 Aug 2019 17:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=97HK8bbd1SoPr/h8L2ZTFUVyv2qGuINVZmN5/Pidwc8=;
        b=U/sY1aA/2Tpw+6mnx0yf7AhUTOkh16FokKlnAVmoUUEwXeq/G6kMFRg6y4NtN63663
         LddfiYyFM86kx2jggZ0x/rQ8386hOls/7htgzrGYcTdf+czXVIN0HFk3s4b5Bu8xYspY
         yuhGQL/+jUlGdXbdW9sqF9Vg2bYb/Z34NaaWPSi3kamxaTj/7Tmgw38jMVXi4dUn+dnr
         hc0T6NjRkMsRAL0tJPNdmmjlnO18wY3fU/IWs3TO4jMyxGejS91MqFhPFwNvopgbx9WU
         Ex2ZoG0Wa8NwJAKk1EwZIDfaTWADsBYH/EOzTOMeQbOl0sq9II2n+4LzsUy1LcU7lAbq
         WpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=97HK8bbd1SoPr/h8L2ZTFUVyv2qGuINVZmN5/Pidwc8=;
        b=Lborj1CiQTWg2qj9G+5j6pQGm6rd1ynuNx5sJlV3jd666KMA+X+Ez/eQg29V/BKnYN
         NM5j8h5sDe/ZHRiJyzy4iHfEpirykgIyPaLPwmkzCQhedOQ2zlyvFazpPLXCBqKH9gxm
         SuiTT2i0Wxuo09obsltDdP76fZRodVuZjJAOlTV+pYhLYDYZ6q7vMeswQEt2Ma4m8C0b
         5akCNUqSwU0EkdQsDAu3CxqTRNN43x3fXvdj64QXd/yKnjyTbOU38utP19fwcqVhZwiy
         Klglqth3Ky5wa/pmD5R+KKhJZOUpoWJf4Hwq7KgTP/7ZHObzUuKnWisZU1mCo/x3oC+l
         PzZA==
X-Gm-Message-State: APjAAAWYKawh8HxMzcsfjJtGNbw/XthXRknXgwyEido2W4ICA8hlJj+t
        Zx5l25zITTJQctCopAZ5g1C3HtHL+BHjVlGIKJzWvd7o29n2FYXoWQVc1n1qjcPfEb7JKdXXs8+
        xyL9zOa917ZwWfW5O5/sfgD+muh4eeCbMnFiEn5/VV7ZIEziNwOZIKBsEI16rLIYxhT+FHnyzeQ
        ==
X-Google-Smtp-Source: APXvYqwqD4BqXQXB2OrQ6Yf91N5SMdhQBIanxMdqlVQWxfXwsU5kX2Ul0TuWr0pin4LVrKmI30L0fuAriLiEcvh1UP8=
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr10132553pgr.62.1566002385497;
 Fri, 16 Aug 2019 17:39:45 -0700 (PDT)
Date:   Fri, 16 Aug 2019 17:39:24 -0700
In-Reply-To: <20190815023418.33407-1-emilyshaffer@google.com>
Message-Id: <20190817003926.102944-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2 0/2] add git-bugreport tool
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Having read Dscho's response after already writing this reroll, I think
it is a compelling case to rewrite as a C builtin, although I'm worried
a little about the best way to continue to call porcelain commands to
protect against bitrot.

Regardless, I think the proof of concept in patch 2/2 still deserves
review; likely a reimplementation in C would see
git-bugreport-config-whitelist generated in a similar way, but as a
header instead of a textfile. So I'm still very interested in comments
on the direction and the Makefile changes there.

The patch 1/2 changes are primarily based on Stolee and Junio's
suggestions; thanks both. There's some rewording of manpage and commit
message, as well as fixes when I realized this command did not work as
expected from a worktree created with `git worktree add`. I also moved
the reflog contents to the very bottom of the output as they're likely
harmless, but very verbose; I didn't want the user to stop reading and
never examine the shorter and scarier generated output, like the config.

Thanks for thoughts.
 - Emily

Emily Shaffer (2):
  bugreport: add tool to generate debugging info
  bugreport: generate config whitelist based on docs

 .gitignore                             |   2 +
 Documentation/config/sendemail.txt     |  68 ++++++------
 Documentation/git-bugreport.txt        |  51 +++++++++
 Makefile                               |  10 +-
 bugreport-generate-config-whitelist.sh |   4 +
 command-list.txt                       |   1 +
 git-bugreport.sh                       | 139 +++++++++++++++++++++++++
 git-sh-setup.sh                        |   2 +
 t/t0091-bugreport.sh                   |  25 +++++
 9 files changed, 267 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100755 bugreport-generate-config-whitelist.sh
 create mode 100755 git-bugreport.sh
 create mode 100755 t/t0091-bugreport.sh

-- 
2.23.0.rc1.153.gdeed80330f-goog

