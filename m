From: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
Subject: [PATCH v2] pull: make --rebase --verify-signatures illegal
Date: Thu, 28 Apr 2016 15:44:35 +0200
Message-ID: <20160428134435.GA5901@netblarch>
References: <20160428095254.GA5205@netblarch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 15:34:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avm5Y-0003i3-IE
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 15:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbcD1Nei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 09:34:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35996 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbcD1Neh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 09:34:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id w143so23472346wmw.3
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wASp0i1au9I5yOpVZWUrrhfB3yjcBqX4rTSL9Ls4Quc=;
        b=RNuKeP35inLpXbfYamaQ1R7palPr7x26JOfVtunH0ocBNFSJrmiA3y2GsrTW+OSQzc
         Q/72FA5818WFhUaWGA5iLgVT1+KJK7rJEJ127FSacAHgRzrmUKdfBJGmTXqO7gFUUZJ5
         tJScVSoNhfJBX0+E5scSVNzx6OJzNDs9bb6pN0HYxM/hBIbKO8zSFbNIZgICF1+6Scku
         bzvc0prQA/gYVMA69emWePVQL9Znucy+p0wdjq0ddPcCbnMADMxuktYQMsBNfTrm/aqK
         y5MLHsf+bVb0rlkRqyLEl1jVDfBydq985xog0yahu7pniTP2NlvtvBjYklJwhFKaP2TW
         4yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wASp0i1au9I5yOpVZWUrrhfB3yjcBqX4rTSL9Ls4Quc=;
        b=LKeRE8HcYOaB4IvBGxuWcW4X1TnlEVd1FFngDDl8d9iCD3PnHfeXCsQVlg7hZ4WYiN
         CCsHzESC3BwvXfkf64N94wVW0H5mL4etyBD9n09JTnGh+btakxwX6J9om7yypwmC+MJl
         ZaxuyMdjGSdZPjnDQUuxxkH3/Pf02+0pi5TOS1gBl6IAtlKGXK5jLTHjd6ulF4kX37rI
         21YmKdlWqX0quxCshomwxsMPgE3yTlB0ax52LJ/U8eQmO3RcvEAGGWgThG0RKfT/IUH9
         mG0rvghnydWUiO7ZZUV4ootVMh0pFj6fDnGv7PYq+FHYFvF/T1Inx6pW2qDG6yopswM8
         hiPw==
X-Gm-Message-State: AOPr4FWo2EFiAwVIU06N3QiDGWFYLxcEFxbW5AQCmo5Ni62IP82HeVKt7hEMhlWN+yl3cQ==
X-Received: by 10.28.92.69 with SMTP id q66mr17193195wmb.102.1461850471205;
        Thu, 28 Apr 2016 06:34:31 -0700 (PDT)
Received: from netblarch ([2001:41b8:83c:ff04:cdf1:96f8:56e0:4777])
        by smtp.gmail.com with ESMTPSA id b12sm31699601wmb.0.2016.04.28.06.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2016 06:34:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160428095254.GA5205@netblarch>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292874>

Previously git-pull would silently ignore the --verify-signatures
option.

Signed-off-by: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
---

I made the error-message conform to the CodingGuidelines (removed
capitalization and full stop).

Also, in the previous mail I said that I proposed a patch for git-pull
last December, when I actually meant git-rebase.

 builtin/pull.c  |  2 ++
 t/t5520-pull.sh | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index d98f481..b6e1507 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -809,6 +809,8 @@ static int run_rebase(const unsigned char *curr_head,
 		argv_array_push(&args, "--no-autostash");
 	else if (opt_autostash == 1)
 		argv_array_push(&args, "--autostash");
+	if (opt_verify_signatures && strcmp(opt_verify_signatures, "--verify-signatures") == 0)
+		die(_("the --verify-signatures option does not work for --rebase"));
 
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 739c089..cb8f741 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -341,6 +341,20 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
+test_expect_success "pull --rebase --verify-signatures is illegal" '
+	git reset --hard before-rebase &&
+	test_must_fail git pull --rebase --verify-signatures . copy 2>err &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse before-rebase)" &&
+	test_i18ngrep "The --verify-signatures option does not work for --rebase." err
+'
+
+test_expect_success "pull --rebase --no-verify-signatures" '
+	git reset --hard before-rebase &&
+	git pull --rebase --no-verify-signatures . copy &&
+	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test new = "$(git show HEAD:file2)"
+'
+
 # add a feature branch, keep-merge, that is merged into master, so the
 # test can try preserving the merge commit (or not) with various
 # --rebase flags/pull.rebase settings.
-- 
2.8.0
