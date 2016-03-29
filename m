From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH 2/5] t/t5520: explicitly unset rebase.autostash
Date: Tue, 29 Mar 2016 18:59:57 +0530
Message-ID: <1459258200-32444-3-git-send-email-mehul.jain2029@gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
Cc: sunshine@sunshineco.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 15:31:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aktjw-000520-L5
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 15:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbcC2NbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 09:31:21 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33860 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbcC2NbU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 09:31:20 -0400
Received: by mail-pa0-f67.google.com with SMTP id hj7so2084308pac.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZrbPT8isUMjELBxHv4Kbhk/i2a+Nzte/fHx3dMUgfqs=;
        b=HUnKlc8UBgYDA7Ar2i6B+VPkFz3MxNA1erfY7l+yAboNsZGc4D5IPaoy7GpJ/YGpkG
         uzdrGA5OWTDYHMnSH3a3ZVEh8dgyMxJ4GMeu/dVXw77urUJvOajDwRStVv6h6Rz3Ia14
         wQFZjmzp/dfSePquENMyashEYmmhDqbfIIdP8tNfcyHOE8IWx3u2l6S0xc1oanZ/8QcM
         U72hzCvyOdi2OuaJ3pDScDrSyzFpVOfsNIvpnghbPuqYP1bWNw7zR2zEJlQHJfMVTEzA
         zrsVyJZ8cYCWTvyOL8AGgSnUFXUZPViSd4co37FWf6etw4BYXVFfC8NgHur3cUdPNP1k
         4ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZrbPT8isUMjELBxHv4Kbhk/i2a+Nzte/fHx3dMUgfqs=;
        b=lAl4S75wobZbBDrjOiGL6bBnMoXNzAHDh9OvWjAuZSY+QJpwhRyQsBCQoECaL+7KVV
         6mLFiHKnikj9LexlN3+M/aeNws8qKUrJNe4dP4lq5tiC9DA9zK6Aivdty/wIBimd+Cc1
         FDDKiA6rqAg58AWRNgAICfbXBTUXFTUTloMtjGP2zusJpRQdKf9gSFXaI2tvbNyarBq1
         dwUNrVpgowEV+iTC4ftT0pGxfffAVRLyARVNIdObL1J5/2zzhNWSFo/SGO29e0iJjldm
         tAGtCY08VBZYBi5/abFRR7GdHKKHd86I5f9T0q+Bh6IBGipqNsyawW/oOnbJLqMScMa3
         QfMw==
X-Gm-Message-State: AD7BkJJu+ngk/HqOza/zhXAK/eFkQnKdHYZF6XM1hbX2FbVVaj8Ixh6Z/uKYgA1qHgBJjQ==
X-Received: by 10.66.246.165 with SMTP id xx5mr3468394pac.87.1459258279030;
        Tue, 29 Mar 2016 06:31:19 -0700 (PDT)
Received: from localhost.localdomain ([1.39.38.29])
        by smtp.gmail.com with ESMTPSA id s66sm43430514pfi.3.2016.03.29.06.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 06:31:18 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290136>

Tests title suggest that tests are done with rebase.autostash unset,
but doesn not take any action to make sure that it is indeed unset.

Make sure that rebase.autostash is unset by explicitly setting it.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 t/t5520-pull.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 5be39df..9ee2218 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -279,6 +279,7 @@ test_expect_success 'pull --rebase --autostash & rebase.autostash=false' '
 '
 
 test_expect_success 'pull --rebase: --autostash & rebase.autostash unset' '
+	test_unconfig rebase.autostash &&
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
 	git add new_file &&
@@ -307,6 +308,7 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash=false' '
 '
 
 test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
+	test_unconfig rebase.autostash &&
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
 	git add new_file &&
-- 
2.7.1.340.g69eb491.dirty
