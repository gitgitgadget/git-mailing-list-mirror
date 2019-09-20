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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1772B1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 20:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfITUZM (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 16:25:12 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:57289 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbfITUZM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 16:25:12 -0400
Received: by mail-pg1-f201.google.com with SMTP id h5so5090739pgq.23
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 13:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qgLVi33IiW2G6mD/egMvl24a6CasyK5do8+RoSF5+A0=;
        b=ukGODT+J9D82PJvscLeJoLnNk0rhHoo5kqmC04S9cMMtdapv8Vr6l7oCOH8zswnvzk
         LzeW9rctlQ3HqJtb/Q00FEdFZwkqZ90/39PIpbmmWb/D5jaRTBjwyH2/yd4HbbMKquxJ
         GdL94oZ0F6kwWB9IFPBSr2am+4DdtC86goHMhRtNo3gpLTidP/5Fvlm6bd+kR+cDIdzI
         4rcnp2TRXmDmYDBi02XecWNmVfy7a4+KcOCD4YYde0RQEwTy2pWVA7hiEZzo3O/6kkwz
         RgXvRxni4lcjIekslftrsY79E1fnJql3+riNyeBOvwygR3tAsmsNC+gvbfYS/J8drEIJ
         ieQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qgLVi33IiW2G6mD/egMvl24a6CasyK5do8+RoSF5+A0=;
        b=VyxuOAqUt6wJV9niNGddoKj7v/Cgn8HzoxxONlUyWh1U8iPnBAI8hQB7DlkkxbyB4x
         CYKvZKMNBVArmszf+wQBLZAzNWkS1Tw5t5oZyVYX1DJ5I3dcFyku2LZAAht0QpKfQiCM
         PJG6Mndh0Dpmnf9YYNmDKkBtibvpGwB/fqs3SSmqILq3C52UuFYTjlHfQas7hmw9vMC1
         13aIkZBxOZlkUGveJAuJjFxu87iToEIzVvFWIVM1g1n72+7z71AUlT+6Dh7AOmxRM7ue
         FxZO6j6LffJ9H0bEBTk1aCjrn56mGaV/rmHDosUFJMzFaZUTmLgVqeXp2Yy8S9iY90Kr
         9oGw==
X-Gm-Message-State: APjAAAV/77gZvMnnkniUE2/iw8srf8IkLuGQjA71XhYgBEweYI8hRLz3
        PdeHuQKy5IHqfGnuyb6Zg1QC8xAHlUXdUyC0Ak48
X-Google-Smtp-Source: APXvYqwj0zZGdwKNp2mvEMFHjbAhYXBghPbH5fre5Krf2Rj6Py7e1v5qQxHk45qHhCMj4zFEckdjm3o2vdiUyPektFTn
X-Received: by 2002:a63:546:: with SMTP id 67mr17304027pgf.429.1569011109743;
 Fri, 20 Sep 2019 13:25:09 -0700 (PDT)
Date:   Fri, 20 Sep 2019 13:25:06 -0700
In-Reply-To: <xmqqzhiyvqhe.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190920202506.74644-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqzhiyvqhe.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: Re: [PATCH v2] merge-recursive: symlink's descendants not in way
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, newren@gmail.com,
        szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> OK.  We notice that we need to newly create foo/bar but we
> incorrectly find that there is "foo/bar" already because of the
> careless use of bare lstat(2) makes "bar" visible as if it were also
> "foo/bar".  I wonder if the current code would be confused the same
> way if the side branch added "foo/bar/file", or the confusion would
> be even worse---it is not dir_in_way() and a different codepath
> would be affected, no?

I don't think there is a different codepath to be affected - as far as I
can tell, dir_in_way() is the only cause (at least of this particular
error). I've tested this case [1] and the current code actually works -
as you said, dir_in_way() will not report anything in the way (since
foo/bar/file doesn't exist in the working tree), so the merge will
happen as expected.

> Nicely done.  Thanks, will queue.

Thanks.

[1]
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index faa8892741..f284aeb173 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -468,15 +468,16 @@ test_expect_success SYMLINKS 'dir in working tree with symlink ancestor does not
                git checkout master &&
                git rm foo &&
                mkdir foo &&
-               >foo/bar &&
-               git add foo/bar &&
-               git commit -m "replace foo symlink with real foo dir and foo/bar file" &&
+               mkdir foo/bar &&
+               >foo/bar/baz &&
+               git add foo/bar/baz &&
+               git commit -m "replace foo symlink with real foo dir and foo/bar/baz file" &&
 
                git checkout branch1 &&
 
                git cherry-pick master &&
                test_path_is_dir foo &&
-               test_path_is_file foo/bar
+               test_path_is_file foo/bar/baz
        )
 '

