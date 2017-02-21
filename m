Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5011201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 22:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbdBUWDW (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 17:03:22 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34829 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdBUWDU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 17:03:20 -0500
Received: by mail-yw0-f194.google.com with SMTP id l16so10690830ywb.2
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 14:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vCrmtJ7aI7curDkYIhyedMxV9G/xWVdNs68Jk81P8jM=;
        b=iPZ9LHB1BZyDQudcYDMhWoZuorBncdusdbKBVSvUgnhUjOsbfulngENKPJo8btRg1L
         vRuqNw885naco05gCfz4zyOJ4p/ndf8WxxzCedesjWMTt3x6fFYCjMqr9tVZ9EnE22bg
         94Jdo8Fpl70+OGw6dsgqyuHD7dI20/SfjsqO2KDHwdGs93lp3ESOYkpujYXFy1T86hrJ
         zJLx+QyWbuQxjO6CBZpjVtClFKUx7V3OfOUxb5IwCHskauCE49RZ3KedffCMq9TnAhHt
         MtHnS2HKU2HtFoupMc6gn3lr0gUAwEQtWhjEQZuPBNFP3pxPJd1PtzGS5uAs2Bwa0RzR
         FDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vCrmtJ7aI7curDkYIhyedMxV9G/xWVdNs68Jk81P8jM=;
        b=fVArJ5UicCZMH6JwPGKYOeEUvInIDYTV3Cf3q4fnTEJhycH/1EYPT5hqDBJhnCy1MN
         YCQYiy0zYUiuQRD8j91zPr7md7ZaVcLv+9Scwxtu3E55Qin2TZ8jn9oXVJNPUmD4yEyX
         1kXcEPIIzhdwO6O/1SJ9X/R2WVWDbFFC70rH+NXanhzeyjSK2Fo9ATvuS8aBIDLHf+hI
         K83Lfkbs/tSpGw/LgtrySVTRhYJm9aL8Fsn1U5Cnor8O1Ide679bbxQZ9ILOdc7Cnh+B
         A+suUOmHjLocaWeEzN3ndgFv6N5VVGrrtTQ4/V0D8M20R+jde5YaTIu0tA59QaOHkTeY
         Kihw==
X-Gm-Message-State: AMke39nO1SmjLXnkuFKiO8NXJFJq+dlV/w6SHvJBlkSrpflNaQACZ+2wE1evyTuR7oZz7g==
X-Received: by 10.13.245.198 with SMTP id e189mr21355251ywf.135.1487714599311;
        Tue, 21 Feb 2017 14:03:19 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d997:8b5d:f579:2a90])
        by smtp.gmail.com with ESMTPSA id c18sm8785539ywh.79.2017.02.21.14.03.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 14:03:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ross Lagerwall <rosslagerwall@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote: Ignore failure to remove missing branch.<name>.merge
References: <20170218002341.23099-1-rosslagerwall@gmail.com>
        <xmqqtw7nfift.fsf@gitster.mtv.corp.google.com>
        <20170221203836.GA11736@hobo.lan>
Date:   Tue, 21 Feb 2017 14:03:17 -0800
In-Reply-To: <20170221203836.GA11736@hobo.lan> (Ross Lagerwall's message of
        "Tue, 21 Feb 2017 20:38:36 +0000")
Message-ID: <xmqq37f7fbh6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ross Lagerwall <rosslagerwall@gmail.com> writes:

> On Tue, Feb 21, 2017 at 11:32:54AM -0800, Junio C Hamano wrote:
>
>> I was waiting for others to comment on this patch but nobody seems
>> to be interested.  Which is a bit sad, because except for minor
>> nits, this patch is very well done.
>> 
>> The explanation of the motivation and solution in the proposed log
>> message is excellent.  It would have been perfect if you described
>> HOW you get into a state where branch.<name>.remote is pointing at
>> the remote being removed, without having branch.<name>.merge in the
>> first place, but even if such a state is invalid or unplausible,
>> removing the remote should be a usable way to recover from such a
>> situation.
>
> I got into this situation by setting branch.<name>.remote directly.  I
> was using push.default=current, and wanted a bare "git push" on the
> branch to push to a different remote from origin (which it defaults to).
> Configuring branch.<name>.remote made git do the right thing.

Ah, OK.  As you may have seen from the test I sent, I thought the
user started with

	git checkout -b <new> -t <remote>/<branch>

in which case both are always set, and removed only one of them,
and that is what I called "deliberate sabotage".

What you did does sound like a very valid use case.  Let's update
the test to use that pattern and document the intended use case to
help with this fix in the updated log message.

Here is what I tentatively queued.

Thanks.

-- >8 --
From: Ross Lagerwall <rosslagerwall@gmail.com>
Date: Sat, 18 Feb 2017 00:23:41 +0000
Subject: [PATCH] remote: ignore failure to remove missing branch.<name>.merge

It is not all too unusual for a branch to use "branch.<name>.remote"
without "branch.<name>.merge".  You may be using the 'push.default'
configuration set to 'current', for example, and do

    $ git checkout -b side colleague/side
    $ git config branch.side.remote colleague

However, "git remote rm" to remove the remote used in such a manner
fails with

    "fatal: could not unset 'branch.<name>.merge'"

because it assumes that a branch that has .remote defined must also
have .merge defined.  Detect the "cannot unset because it is not set
to begin with" case and ignore it.

Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/remote.c  |  4 +++-
 t/t5505-remote.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index e52cf3925b..01055b7272 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -769,7 +769,9 @@ static int rm(int argc, const char **argv)
 				strbuf_reset(&buf);
 				strbuf_addf(&buf, "branch.%s.%s",
 						item->string, *k);
-				git_config_set(buf.buf, NULL);
+				result = git_config_set_gently(buf.buf, NULL);
+				if (result && result != CONFIG_NOTHING_SET)
+					die(_("could not unset '%s'"), buf.buf);
 			}
 		}
 	}
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 8198d8eb05..f558ad0b39 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -153,6 +153,25 @@ test_expect_success 'remove errors out early when deleting non-existent branch'
 	)
 '
 
+test_expect_success 'remove remote with a branch without configured merge' '
+	test_when_finished "(
+		git -C test checkout master;
+		git -C test branch -D two;
+		git -C test config --remove-section remote.two;
+		git -C test config --remove-section branch.second;
+		true
+	)" &&
+	(
+		cd test &&
+		git remote add two ../two &&
+		git fetch two &&
+		git checkout -b second two/master^0 &&
+		git config branch.second.remote two &&
+		git checkout master &&
+		git remote rm two
+	)
+'
+
 test_expect_success 'rename errors out early when deleting non-existent branch' '
 	(
 		cd test &&
-- 
2.12.0-rc2-231-g83a1c8597c
