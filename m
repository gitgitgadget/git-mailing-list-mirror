From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 20/20] index-helper: indexhelper.exitafter config
Date: Thu, 19 May 2016 17:45:57 -0400
Message-ID: <1463694357-6503-21-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:47:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Vmf-0006mD-U0
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbcESVrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 17:47:04 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36547 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932637AbcESVrB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:47:01 -0400
Received: by mail-qg0-f44.google.com with SMTP id w36so51244441qge.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3QC2Y/WC80yj2gM8w7Vc8dvoHPGSf9QPJ8q/aflh00E=;
        b=nL8Mfobj92xosyp6HuqDwqTCnZDyLLOuHgy1dGFzAZzBtB5DD0Vyoji3qMSBZApbsS
         cvK00oiolEeLKbsvDbfOmUvhlxjcCeGQeTjuLyZfns97d2Xd61QAfkoADKV9hIi36v2j
         +zzwFQB4uhqwb8SYkNY9m39iDdwX230YfjBvk7HPkMH+eb+JhBIICaixzlEhTXrmNqAT
         EzFl66KNBFNcTxinARevXCuoTK1F/7ngElDsWD5dhVywPWpn/0I0FUKRXJWetSPkxVF9
         UWUWn2PVeqw+qQzwWocdK5QKGYQvzUVbtjak/UVi2Gj4JHUGk4BUhmIHmgZbCLsoLjhX
         5uMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3QC2Y/WC80yj2gM8w7Vc8dvoHPGSf9QPJ8q/aflh00E=;
        b=O0H/cf3PU0AtT+OaGIYyimA1S9VNj/CTM9PdvkJ7wiYOjuglhoJefKHLqNkKxViO2p
         DC7rcdq1RiBE+RATPuKC+8Fik/x5k1gAMhUiEavRG2s7ptXoCvZsK1nfRfhTW8Qsm8w7
         9Kvzv1J7fx7pTfkHxn72vks+JRn4dd+2z4lZPvnD66gDRETrpZP8DQxNTr6R69IWMClr
         rQJkAR0XfhH0K1F4IBU1gzG4n5ZPlqLAUqWrOHxaMhhcGl+4jlHIw8pnoB5wZuBy6SxZ
         LSxNal0eBnbOX8oGuGuOk8acwHezmwq7vTLGp+szF6ncG/tj3WtxFvhmhow8rVnnbp/t
         zIRA==
X-Gm-Message-State: AOPr4FUMYYnso0E1evDvlvoxFvYBbwOJo0RPmrBr+8yuR6/KqOFkspROG7feubP+VYiqoA==
X-Received: by 10.140.250.66 with SMTP id v63mr17480424qhc.101.1463694420650;
        Thu, 19 May 2016 14:47:00 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:59 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295116>

Add a configuration variable, indexhelper.exitafter, which provides a
default time to keep the index-helper alive.  This is useful with
indexhelper.autorun; some users will want to keep the
automatically-run index-helper alive across their lunch break and will
thus set indexhelper.exitafter to a high value.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/config.txt | 4 ++++
 index-helper.c           | 2 ++
 t/t7900-index-helper.sh  | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 385ea66..336d5a2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1860,6 +1860,10 @@ indexhelper.autorun::
 	Automatically run git index-helper when any builtin git
 	command is run inside a repository.
 
+indexhelper.exitafter::
+	When no exit-after argument is given, git index-helper defaults
+	to this number of seconds. Specify 0 to wait forever. Default is 600.
+
 init.templateDir::
 	Specify the directory from which templates will be copied.
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
diff --git a/index-helper.c b/index-helper.c
index 2d97c77..a639de8 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -425,6 +425,8 @@ int main(int argc, char **argv)
 	git_extract_argv0_path(argv[0]);
 	git_setup_gettext();
 
+	git_config_get_int("indexhelper.exitafter", &idle_in_seconds);
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(usage_text, options);
 
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index 3cfdf63..6c9b4dd 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -66,4 +66,12 @@ test_expect_success 'index-helper autorun works' '
 	test_path_is_missing .git/index-helper.sock
 '
 
+test_expect_success 'indexhelper.exitafter config works' '
+	test_when_finished "git index-helper --kill" &&
+	test_config indexhelper.exitafter 1 &&
+	git index-helper --detach &&
+	sleep 3 &&
+	test_path_is_missing .git/index-helper.sock
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
