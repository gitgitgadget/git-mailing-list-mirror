From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/4] git-gui: clear the goto line input when hiding
Date: Thu, 13 Oct 2011 15:48:13 +0200
Message-ID: <a59d40509d4f80a6dae99bae5ef6311bb607bd34.1318513492.git.bert.wesarg@googlemail.com>
References: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
Cc: David Fries <David@Fries.net>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 13 15:48:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RELeC-0002Hq-06
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 15:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356Ab1JMNsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 09:48:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33264 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264Ab1JMNsW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 09:48:22 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so1464856bkb.19
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=qevBwTgwmHZYINXBG35bsfc8dgxNg+tXbMVFeIDoo04=;
        b=UcGpke+ZD8UWVr4xq9ImEs4kjTzSrANK+ex9FBQmG3YGt/61C1BYNj6hSlY4lRAIWy
         lbWgEI6Du8mnlPzBW3lC27RzHCHQmicNYaZyKK3fvTJSaWm5GYYfNiQLOMwt5JlWaL45
         G+azln8Ex9ywj/TpWGBM/yb9u1nWgmudh4z6M=
Received: by 10.204.134.25 with SMTP id h25mr2985610bkt.2.1318513701580;
        Thu, 13 Oct 2011 06:48:21 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de. [141.30.68.111])
        by mx.google.com with ESMTPS id k26sm3760121bks.1.2011.10.13.06.48.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Oct 2011 06:48:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.789.gb4599
In-Reply-To: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
In-Reply-To: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
References: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183485>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/line.tcl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/line.tcl b/lib/line.tcl
index 4913bdd..692485a 100644
--- a/lib/line.tcl
+++ b/lib/line.tcl
@@ -41,6 +41,7 @@ method show {} {
 
 method hide {} {
 	if {[visible $this]} {
+		$w.ent delete 0 end
 		focus $ctext
 		grid remove $w
 	}
-- 
1.7.6.789.gb4599
