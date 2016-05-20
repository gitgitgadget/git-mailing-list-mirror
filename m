From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/11] completion: remove zsh hack
Date: Thu, 19 May 2016 23:58:39 -0500
Message-ID: <1463720325-8853-6-git-send-email-felipe.contreras@gmail.com>
References: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 06:59:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3cWd-0001bo-IW
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 06:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbcETE6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 00:58:54 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36020 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138AbcETE6w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 00:58:52 -0400
Received: by mail-oi0-f68.google.com with SMTP id g16so7294569oib.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 21:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ujIIR7gQbWVF1WQKApx+3cuwQedbjYBTZzKipbyE9lU=;
        b=e3IeJbaNNNAJHkGjv2iPH21/DRf9rLGCKm1/NmK9e0SVbSU1Dr0LTWetdsH2U1j46t
         A/+gOeGYCh8+vSO7vwFaXWD/8iyr9TfveR85A4FprHlDXAsm39e0CU9NyxIYcTNHqyRa
         ur9fJOvsB0H1TvbSn1sZAAkymDAcChZ+dN+7wVXthMD4ODbQEGzcDjITNtARCl2y70hR
         0/Hgs5vf4/AAxEfmJbbX12uj1LFEFX+diVNcmQAs8xskFO5ALkcudIyxjO9s3wvnLGc/
         0jpkBr41rKco6rc17kWMZIQzcndzly43hpXwAuwdy4kXvabCRkPNOsoNUWd0fhru84hY
         H/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ujIIR7gQbWVF1WQKApx+3cuwQedbjYBTZzKipbyE9lU=;
        b=RaD7aiUsZSnqUCukr4J103MvzkniwpdBymwRDujd/8599eqiVVWuuZeATJKnHzvQmM
         ftxf64w+v1i0RMGtgmTmt3uoEZJDKDv6BFUopVtdZOGdQCdwKuGY9VfEd0eDeRjZjQp9
         OkQhImrWlIZm2zRw6psgEh8Re3/IZ0Faa0XPMN/I4UvNTLtGu0m6G+kP3Apjzl7YKD5k
         qMugZ7FczHgAfMqnT1KxF4gheWn0p6FfHLDn90S8GpCHAL2fQ1TRea/SKADbw2GDLHVT
         9BhfoyA5n4a1xakqXJuZ/gFMWkWMnXeQZopSjvCEjhPMTgGxZlo1Mkv9v3BHhCLylgBR
         pKrQ==
X-Gm-Message-State: AOPr4FXraLOhuM9tfna4srK3IPg52tEeTMkcWm9danYxp3QVDDPRqSgULZxUTXNmBIRNcw==
X-Received: by 10.202.182.69 with SMTP id g66mr605915oif.26.1463720331249;
        Thu, 19 May 2016 21:58:51 -0700 (PDT)
Received: from localhost ([189.208.111.205])
        by smtp.gmail.com with ESMTPSA id y127sm4783704oie.28.2016.05.19.21.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 21:58:50 -0700 (PDT)
X-Mailer: git-send-email 2.8.0+fc1
In-Reply-To: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295141>

We don't want to override the 'complete()' function in zsh, which can be
used by bashcomp.

Reported-by: Mark Lodato <lodato@google.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 contrib/completion/git-completion.zsh  | 6 ------
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9cbae6f..6c338ae 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2684,6 +2684,7 @@ __git_func_wrap ()
 # This is NOT a public function; use at your own risk.
 __git_complete ()
 {
+	test -n "$ZSH_VERSION" && return
 	local wrapper="__git_wrap${2}"
 	eval "$wrapper () { __git_func_wrap $2 ; }"
 	complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/null \
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 475705a..e10df7d 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -16,12 +16,6 @@
 #
 #  fpath=(~/.zsh $fpath)
 
-complete ()
-{
-	# do nothing
-	return 0
-}
-
 zstyle -T ':completion:*:*:git:*' tag-order && \
 	zstyle ':completion:*:*:git:*' tag-order 'common-commands'
 
-- 
2.8.0+fc1
