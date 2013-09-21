From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] build: add default configuration
Date: Sat, 21 Sep 2013 12:50:58 -0500
Message-ID: <f779019f-2417-45b1-afcb-e58e93d64489@email.android.com>
References: <1379764036-3782-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 19:51:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNRKs-0002tY-7A
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 19:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089Ab3IURvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 13:51:10 -0400
Received: from mail-ye0-f170.google.com ([209.85.213.170]:52774 "EHLO
	mail-ye0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab3IURvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 13:51:09 -0400
Received: by mail-ye0-f170.google.com with SMTP id r4so647067yen.1
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:message-id;
        bh=xjMFGOPR8euR1DjDE3hO+Ax+DQMB4UlYo25SWRR1Aoo=;
        b=VKiGYyGQzLm1SwSZdggm6VUwPLdSBXXSqqnqpoTC5GiOYqPKnhgxhO4uZTDp0nnmUo
         /7Jx7lb9TAUX+OaKjhghM4VHjVjLpX47SmA0zYsIU5zmFj7xpvLwGQIJpVgSHzB8u7OW
         DD+4vUlHtyqJARIp8svcFMqXGltLpPa6VPZTdzVgHPcbK09ThXtZ7jsBov7ScN54bOPv
         5Prfcr5JyWewkBztTJHFLg+VV5eaV28uScIKCWRrez66xtJOH7diLwo/v+qRyvlEOP4z
         5NKVnV9YHWO135At+2m4PQKUZoYPWfSY36VBN9L5GDGuA32iXlYpIaitNEp1jZ3M8nXl
         paUA==
X-Received: by 10.236.83.69 with SMTP id p45mr13841696yhe.40.1379785868459;
        Sat, 21 Sep 2013 10:51:08 -0700 (PDT)
Received: from [10.65.19.245] ([190.63.1.186])
        by mx.google.com with ESMTPSA id j67sm7480690yhe.26.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 10:51:07 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <1379764036-3782-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235133>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
>For now simply add a few common aliases.
>
>  co = checkout
>  ci = commit
>  rb = rebase
>  st = status
>
>Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>---
> Documentation/git-checkout.txt | 5 +++++
> Documentation/git-commit.txt   | 5 +++++
> Documentation/git-rebase.txt   | 5 +++++
> Documentation/git-status.txt   | 5 +++++
> Makefile                       | 5 ++++-
> gitconfig                      | 5 +++++
> 6 files changed, 29 insertions(+), 1 deletion(-)

The .spec.in file contains a manifest of all the files provided by the git package. We're adding a new file so there may be a %{sysconfdir}/gitconfig entry needed there.  

> create mode 100644 gitconfig
>
>diff --git a/Documentation/git-checkout.txt
>b/Documentation/git-checkout.txt
>index ca118ac..7597813 100644
>--- a/Documentation/git-checkout.txt
>+++ b/Documentation/git-checkout.txt
>@@ -14,6 +14,11 @@ SYNOPSIS
>'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>]
>[--] <paths>...
> 'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]
> 
>+ALIAS
>+-----
>+
>+git co
>+
> DESCRIPTION
> -----------
> Updates files in the working tree to match the version in the index
>diff --git a/Documentation/git-commit.txt
>b/Documentation/git-commit.txt
>index 1a7616c..8705abc 100644
>--- a/Documentation/git-commit.txt
>+++ b/Documentation/git-commit.txt
>@@ -15,6 +15,11 @@ SYNOPSIS
> 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
> 	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
> 
>+ALIAS
>+-----
>+
>+git ci
>+
> DESCRIPTION
> -----------
> Stores the current contents of the index in a new commit along
>diff --git a/Documentation/git-rebase.txt
>b/Documentation/git-rebase.txt
>index 6b2e1c8..69b192d 100644
>--- a/Documentation/git-rebase.txt
>+++ b/Documentation/git-rebase.txt
>@@ -14,6 +14,11 @@ SYNOPSIS
> 	--root [<branch>]
> 'git rebase' --continue | --skip | --abort | --edit-todo
> 
>+ALIAS
>+-----
>+
>+git co

Typofix: git rb

>+
> DESCRIPTION
> -----------
> If <branch> is specified, 'git rebase' will perform an automatic
>diff --git a/Documentation/git-status.txt
>b/Documentation/git-status.txt
>index 9046df9..30ecd25 100644
>--- a/Documentation/git-status.txt
>+++ b/Documentation/git-status.txt
>@@ -11,6 +11,11 @@ SYNOPSIS
> [verse]
> 'git status' [<options>...] [--] [<pathspec>...]
> 
>+ALIAS
>+-----
>+
>+git st
>+
> DESCRIPTION
> -----------
> Displays paths that have differences between the index file and the
>diff --git a/Makefile b/Makefile
>index 3588ca1..18081bf 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -1010,7 +1010,7 @@ ifndef sysconfdir
> ifeq ($(prefix),/usr)
> sysconfdir = /etc
> else
>-sysconfdir = etc
>+sysconfdir = $(prefix)/etc
> endif
> endif

Hmmm that's odd that the original used just "etc", but this seems correct (I don't have a machine around to check).

One small complication here is Mac OS X -- I always end up needing to special-case it to use /private/etc because /etc is a symlink and it's very easy to break the system by replacing it with a real directory.  Kinda ugly, but it's best to be safe.  I learned that the hard way.

> 
>@@ -1586,6 +1586,7 @@ template_dir_SQ = $(subst ','\'',$(template_dir))
> htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
> prefix_SQ = $(subst ','\'',$(prefix))
> gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
>+sysconfdir_SQ = $(subst ','\'',$(sysconfdir))
> 
> SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
> PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
>@@ -2340,6 +2341,8 @@ install: all
> 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
> 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
>	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
>+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(sysconfdir_SQ)'
>+	$(INSTALL) -m 644 gitconfig '$(DESTDIR_SQ)$(ETC_GITCONFIG_SQ)'
> ifndef NO_GETTEXT
> 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
> 	(cd po/build/locale && $(TAR) cf - .) | \
>diff --git a/gitconfig b/gitconfig
>new file mode 100644
>index 0000000..c45d300
>--- /dev/null
>+++ b/gitconfig
>@@ -0,0 +1,5 @@
>+[alias]
>+	co = checkout
>+	ci = commit
>+	rb = rebase
>+	st = status


-- 
David
