Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B191F954
	for <e@80x24.org>; Fri, 17 Aug 2018 15:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeHQS34 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 14:29:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42944 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeHQS3z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 14:29:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so7414176wrs.9
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=X8My/Fkn+tXZzdpdiqkqsxIohZ6+ikS9gY9LdDlX2Qg=;
        b=g7d0MLQ8LATBhsjKpEQI8LYf9O6ZljuKxmdPUBj6shAJzpv2XkwG/bZO0qmWhCeCeZ
         zGA7lOccIRZnJvwiqROPmdmZrJpGaqXg4yooEfo/Vs60jyTCzITBf7tVlFWQWZzvpXZx
         djhEHUsqMSKs5GzNWRN6cGceDPGiNybuir3cIoUMSJHyhn/MgJqoLJB8dPV0pX5nJhE7
         PgzvQ0jh7SE0Ll0VrfJy34CDhuJtLBtKjFXw2yQhy6IN8JMvK9pwNgtkSZNresEV7NXI
         pk45rPju+YWWvMdAb6qjohP9N/RfRsml+4DRxnEHoFC4MOg/BXAq0iyUKwBGY4OZJQ4G
         iPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=X8My/Fkn+tXZzdpdiqkqsxIohZ6+ikS9gY9LdDlX2Qg=;
        b=pj4bYCIjuqN5EghlzK0Vm6XCWdP+Yf7i19vS5gcCk0vngdrwBQeR/S42GOwFILx2Vh
         Z8L6MujrxrhIpWkAjqNdj7am3UDeDE0hWFVaXU+7PRS35zFxkPKZg4uI7RP3ASmx61xQ
         bZ2x07cue9qoaYfb6r3JTJwpOfcowhWJ3euIasKwBjO4cWk6bNYF8r4nAM+BKqiiOuZw
         vqbRscFeyCGN7Td9I1cQ65DvsHWIGGSJ89jZCE1qfw3Mf+IXIfe02HyyNXfXTiOLXWz5
         hjg6fkcd/oTZYjwVvY3MuQWqhDIhMdP1PoM/2C3K6dZl+Cv8d5MrG40mwqjWX9lu831v
         RMkQ==
X-Gm-Message-State: AOUpUlFLUvfxaCotjAibmEWpWvIxT6NvsWwLsOAj+jHzZ/pkl3mK5KIw
        JhYfAZxrCZAo1ZcsDOs+lNw=
X-Google-Smtp-Source: AA+uWPxesNQPOvhHME/mfKu8Bz0nKZwtRIxtPFKKvPGshm9H2mEdj/XaZ16uRQdo8MwiGF4Qqvbi+A==
X-Received: by 2002:adf:bd90:: with SMTP id l16-v6mr23274584wrh.250.1534519566726;
        Fri, 17 Aug 2018 08:26:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a66-v6sm1879683wmh.0.2018.08.17.08.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 08:26:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?Pawe?= =?utf-8?Q?=C5=82?= Paruzel 
        <pawelparuzel95@gmail.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] config.txt: clarify core.checkStat = minimal
References: <CACsJy8AYQL3oDLyt14eJ1emynngqKQv9GXju56gU9u4mHrFHOg@mail.gmail.com>
        <20180816155647.10459-1-pclouds@gmail.com>
        <xmqqin4afdoj.fsf@gitster-ct.c.googlers.com>
        <CACsJy8C2r5y0m88yrRQHQ-_QNXemy2pfcjxYK0zSd0J3fFy3rQ@mail.gmail.com>
Date:   Fri, 17 Aug 2018 08:26:05 -0700
In-Reply-To: <CACsJy8C2r5y0m88yrRQHQ-_QNXemy2pfcjxYK0zSd0J3fFy3rQ@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 16 Aug 2018 20:19:01 +0200")
Message-ID: <xmqqefexc8vm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Perfect. I could wrap it in a patch, but I feel you should take
> authorship for that one. I'll leave it to you to create this commit.

OK, here is what I ended up with.  An extra paragraph was taken from
the old commit you referrred to, which is probably the only
remaining part from your contribution, so the attribution has been
demoted to "Helped-by", but your initiative still is appreciated
very much.

-- >8 --
Subject: [PATCH] config.txt: clarify core.checkStat

The description of this key does not really tell what the 'minimal'
mode checks and does not check.  The description for the 'default'
mode is not much better and just says 'all fields', which is unclear
and is not even correct (e.g. we do not look at 'atime').

Spell out what are and what are not checked under the 'minimal' mode
relative to the 'default' mode to help those who want to decide if
they want to use the 'minimal' mode, also taking information about
this mode from the commit message of c08e4d5b5c (Enable minimal stat
checking - 2013-01-22).

Helped-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a9..933d719137 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -449,10 +449,20 @@ core.untrackedCache::
 	See linkgit:git-update-index[1]. `keep` by default.
 
 core.checkStat::
-	Determines which stat fields to match between the index
-	and work tree. The user can set this to 'default' or
-	'minimal'. Default (or explicitly 'default'), is to check
-	all fields, including the sub-second part of mtime and ctime.
+	When missing or is set to `default`, many fields in the stat
+	structure are checked to detect if a file has been modified
+	since Git looked at it.  When this configuration variable is
+	set to `minimal`, sub-second part of mtime and ctime, the
+	uid and gid of the owner of the file, the inode number (and
+	the device number, if Git was compiled to use it), are
+	excluded from the check among these fields, leaving only the
+	whole-second part of mtime (and ctime, if `core.trustCtime`
+	is set) and the filesize to be checked.
++
+There are implementations of Git that do not leave usable values in
+some fields (e.g. JGit); by excluding these fields from the
+comparison, the `minimal` mode may help interoperability when the
+same repository is used by these other systems at the same time.
 
 core.quotePath::
 	Commands that output paths (e.g. 'ls-files', 'diff'), will
-- 
2.18.0-666-g63749b2dea

