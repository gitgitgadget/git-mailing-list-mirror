From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 23/29] The log.decorate setting should not influence guilt rebase.
Date: Tue, 13 May 2014 22:30:59 +0200
Message-ID: <1400013065-27919-24-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:37:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJSW-0008Ka-Eo
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbaEMUhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:37:42 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:41101 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbaEMUhh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:37:37 -0400
Received: by mail-lb0-f169.google.com with SMTP id s7so708333lbd.14
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bGZ216pKC3s1i9gVKKxXD7BufyF0e3hfa2Xe1vxkqTA=;
        b=Y3Q/qbFaV6ga+uvBRTKloCI1GtKCgkOn0yaUduugSfPEBzNPI027xoC3WwvS2KFeP0
         ORLCXsOuSJ2iMlEDAi7FeZrcaRUqgODUvSUSek8yLikRug7sXf5gt4ZiG4zWCCvOsZlx
         I5c1cRFxEhpQ01p8xt68TYLNuuF9t5O7hd+Ehtvnip9FAVdJeq9yVzgJAOlDlX6xQjHA
         N2rE747AvbEuNhK0YRzABk81MXSHzMrUC26Fv7ofmS4p7sTANsQgwkatSRP6HnVltl68
         zgW1i+PP70XAD9racifhxoe/6/5MbCbv3gTd2CtliCBLg4nU4/6BA05ejWQZAopVQsPE
         2CAg==
X-Gm-Message-State: ALoCoQku2ok4E8z/Cb9u8+3WuHQRog/t+OByxioBu3tnYFehgti8RkztafoXvLSItkILoDXQCrY7
X-Received: by 10.152.23.233 with SMTP id p9mr19551613laf.31.1400013455635;
        Tue, 13 May 2014 13:37:35 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.37.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:37:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248842>

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt-rebase | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt-rebase b/guilt-rebase
index fd28e48..a1714a0 100755
--- a/guilt-rebase
+++ b/guilt-rebase
@@ -66,7 +66,7 @@ pop_all_patches
 git merge --no-commit $upstream > /dev/null 2> /dev/null
 
 disp ""
-log=`git log -1 --pretty=oneline`
+log=`git log -1 --no-decorate --pretty=oneline`
 disp "HEAD is now at `echo $log | cut -c 1-7`... `echo "$log" | cut -c 41-`"
 
 #
-- 
1.8.3.1
