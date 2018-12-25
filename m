Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1919B211B9
	for <e@80x24.org>; Tue, 25 Dec 2018 13:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbeLYNzl (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Dec 2018 08:55:41 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34844 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeLYNzl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Dec 2018 08:55:41 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so17836481itp.0
        for <git@vger.kernel.org>; Tue, 25 Dec 2018 05:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pxFDKLxGBECFoOcRn0udneu0dfhvKx7fb41bBxFOAxk=;
        b=TIOIpZqh8rZCxPAtWobTmzjbWXJwHenQsFXAbu7VwTt5zNXWeyCR7iI/T255rUXUwy
         zFq/AtODMg0tgUDpOnJFzbGHmvORzGTYJmR8X+IZC5A2QXl2e87ucV91lhfjFHBXM43+
         k+fYkFJrUne0bFACwIXCfSHoEvN7lelr2AQvlGpI1y20ZV1nHqzkrRjX4IlX4605/JlP
         VfoPEdPAgXSCDQeqdwWH9J5aGiLOLJTjBbYgloFkpK7ffw0E80h/QmiszBbx45PGY6od
         2ak8idWmvBGzbamHqBZcBKbDyzZAbMT2n8WQbqMzhJ+GM+skM2hOwmoIYR/vAWRBL+UT
         JVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pxFDKLxGBECFoOcRn0udneu0dfhvKx7fb41bBxFOAxk=;
        b=RwjFAoyhlmjKe3lMas9ckkYemJ/EqNBx4/5V/4fY/DGAvHlfLAVN35EbI+lrO95ojy
         GbqyxA9ccae+rFar0N3bT1ss2WRq6KeTtJUkMEIeW3qLV1jaFw8nRa0XEwnbtHOMG5Vs
         A+jy+OqSnR7ir77B4mAhcIkfeapMpQ2eJt1RbpSr0gYv3PsoBI9e+gnoycYRZ9DBj9j7
         WFlBbN+L2moP7BmF0XxqzuFUnUErm/n03JNX6EManfn+0Scp/gSBr4MBjhYyFLcxcwct
         VzNXLM4sBYs18fAjP2Hn/GKYSGOyBMVGgOoZNI9hPIN35ZaU3bIEdARDN6r7rYVU/Qok
         0Pew==
X-Gm-Message-State: AA+aEWY1ZoxAnbY0qo5xYc07C+6fP80NggF0xA8mHLZKGZ1BNAjdg0qc
        OtXi0AHPsKPiT7fqoOB5VrZYt3XA
X-Google-Smtp-Source: AFSGD/U1OnSsD6RFOuODtHoPYmn73N3dg10nq5UBFeUGCwsu0HYdFckhaDp8GLv5y3zrW/Epn0AeNw==
X-Received: by 2002:a24:6890:: with SMTP id v138mr11260252itb.53.1545746138781;
        Tue, 25 Dec 2018 05:55:38 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [99.245.246.183])
        by smtp.gmail.com with ESMTPSA id x79sm10903617ita.34.2018.12.25.05.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Dec 2018 05:55:38 -0800 (PST)
Date:   Tue, 25 Dec 2018 08:55:35 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v5 0/4] Add git-merge --cleanup support
Message-ID: <cover.1545745331.git.liu.denton@gmail.com>
References: <cover.1542768902.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542768902.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Merry Christmas, everyone!

I've finally had some free time to throw together the changes I promised
a couple weeks ago, so now git-merge will support --cleanup just like
git-commit.

Not related to this but while I was making my changes, I noticed that -F
and -m don't die properly in git-merge when they accept invalid
arguments. Instead, they just print an error message to stderr and the
program keeps running. Is this the expected behaviour?

Changes since V1:
	* Only check MERGE_MSG for a scissors line instead of all prepended
	  files
	* Make a variable static in merge where appropriate
	* Add passthrough options in pull
	* Add documentation for the new option
	* Add tests to ensure desired behaviour

Changes since V2:
	* Merge both patches into one patch
	* Fix bug in help message printing logic

Changes since V3:
	* Add patch to cleanup 'merge --squash c3 with c7' test in t7600
	* Use test_i18ncmp instead of test_cmp to pass GETTEXT_POISON tests

Changes since V4:
	* Add patches so that git-merge messages will be cleaned up like in
      git-commit

Denton Liu (4):
  commit: extract cleanup_mode functions to sequencer
  t7600: clean up 'merge --squash c3 with c7' test
  merge: cleanup messages like commit
  merge: add scissors line on merge conflict

 Documentation/merge-options.txt |  7 ++++
 builtin/commit.c                | 41 +++++++++-------------
 builtin/merge.c                 | 45 ++++++++++++++++++++----
 builtin/pull.c                  |  6 ++++
 sequencer.c                     | 29 ++++++++++++++++
 sequencer.h                     |  4 +++
 t/t7600-merge.sh                | 53 +++++++++++++++++++++++++---
 t/t7604-merge-custom-message.sh | 61 +++++++++++++++++++++++++++++++++
 wt-status.c                     | 12 +++++--
 wt-status.h                     |  1 +
 10 files changed, 221 insertions(+), 38 deletions(-)

-- 
2.20.1

