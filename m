Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A704520989
	for <e@80x24.org>; Mon, 10 Oct 2016 19:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbcJJTom (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 15:44:42 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33863 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbcJJTol (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 15:44:41 -0400
Received: by mail-pa0-f43.google.com with SMTP id rz1so60380368pab.1
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 12:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FEhu7jYKmIcWa4IQ7JozSOlp09EXHC/VRLT4OxbxKp0=;
        b=GDSiqahrmlnHWDf/wVKEt+YxEuwbq1M+fFzK8Kri/2bw59gcV9w+UbRlXshVvjqL89
         3UqtF2hJS1lKjroDlX10SKBV+jvamzDVb3FUFOdSaHZzkBP3B7QamYKM3YtprR+8cFZK
         zfShQfm2MUdQeF25l9gCvMeaWT1wp5S2wAMKvycEiKdlJPi1JPoYfu/o8XjSbanfy+iW
         rh4FmZPTj+9FYSOBSMrhrRdFincZp2IsQMOfAReV7uIm1U6x2ws+dKjDbaqil6QlwoC8
         MK5izlgKIqMifTQBqlhboXHxwuwoib78ylDRQVajEYdkzXO/X8KNX+h5Qd7EE+emYIUU
         FlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FEhu7jYKmIcWa4IQ7JozSOlp09EXHC/VRLT4OxbxKp0=;
        b=aQWqjRrIn67K0yl6u+D8HFmC9fvPuOR5Ywg1xXglYvtPegcD29fLaqrt7e9zKkY+DB
         DMO258hBnipXe3kbRl4odf48V3zt8fbt1VQ6Pe3Ur4W9sNQAEgZd2IOd1MLEhKjPbahZ
         ZMMTS7FuMJp+NXdqSooA96BFnvi6MUVPi3E5WiRkGL+/BKiI/CsSI3dw2je1xN1ejOi/
         JVXwujjLi3pQWuFgE9eTOlqQ39yPs09sSpgP0kw404WDsAbKx/vWbNM1Qc0ZFbQBQYbU
         iQQba9vhUuIVFTs7Azrh05LbPwihwVZ1kwOkCFIi8706JuQWfiQhmqrGT5qRUHNbSyGO
         xfOw==
X-Gm-Message-State: AA6/9RmEowJjkrW4LqZuUOZ/HkPPNzqUN/MxzqOaroQNi83l6sEdKGVNCYhVDCCBFJ3ExBWB
X-Received: by 10.66.77.170 with SMTP id t10mr16658301paw.40.1476128205746;
        Mon, 10 Oct 2016 12:36:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id qd12sm52897388pab.22.2016.10.10.12.36.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 12:36:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jens.Lehmann@web.de, hvoigt@hvoigt.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] documentation: improve submodule.<name>.{url, path} description
Date:   Mon, 10 Oct 2016 12:36:41 -0700
Message-Id: <20161010193641.16489-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <xmqqshs4dnq1.fsf@gitster.mtv.corp.google.com>
References: <xmqqshs4dnq1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike the url variable a user cannot override the the path variable,
as it is part of the content together with the gitlink at the given
path. To avoid confusion do not mention the .path variable in the config
section and rely on the documentation provided in gitmodules[5].

Enhance the description of submodule.<name>.url and mention its two use
cases separately.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I think the gitmodules[5] is enough for .path, so let's just
do this one instead.

Thanks,
Stefan


 Documentation/config.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e78293b..fd775b4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2811,12 +2811,13 @@ stash.showStat::
 	option will show diffstat of the stash.  Defaults to true.
 	See description of 'show' command in linkgit:git-stash[1].
 
-submodule.<name>.path::
 submodule.<name>.url::
-	The path within this project and URL for a submodule. These
-	variables are initially populated by 'git submodule init'. See
-	linkgit:git-submodule[1] and linkgit:gitmodules[5] for
-	details.
+	The URL for a submodule. This variable is copied from the .gitmodules
+	file to the git config via 'git submodule init'. The user can change
+	the configured URL before obtaining the submodule via 'git submodule
+	update'. After obtaining the submodule, the presence of this variable
+	is used as a sign whether the submodule is of interest to git commands.
+	See linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
 
 submodule.<name>.update::
 	The default update procedure for a submodule. This variable
-- 
2.10.1.382.ga23ca1b.dirty

