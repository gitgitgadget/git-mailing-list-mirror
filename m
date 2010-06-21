From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH GSoC] gitweb: Add support for enabling 'write' feature
Date: Tue, 22 Jun 2010 04:00:24 +0530
Message-ID: <1277159424-6351-1-git-send-email-pavan.sss1991@gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Tue Jun 22 00:31:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQpW2-0003nL-MW
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 00:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980Ab0FUWag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 18:30:36 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61133 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754850Ab0FUWad (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 18:30:33 -0400
Received: by mail-pw0-f46.google.com with SMTP id 8so539423pwj.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 15:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VKcz3aeyS+ni5EdciYleq6IC9fxGkfH272BrWF/hGa8=;
        b=JnvEzodCrNNhUEb1nePLWSbVnU6Oy5O/WfXpNNSjy9JYNb1K1OwY1kW9V06RO/gRss
         Hi2UxkBzsz2P/pEbVcunZVMSgiUcj4eRCdyVFbRnOtGGZihQgcwt+2VrmOpVoRFvmovi
         R1vV7/hUyF/06qTlfnhMArSr0DcDaUpDZeLrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sJDGG/pMNtfYN4NSFM1evFzwDzhhBHD0nbiz3UaXiHe2uOol1FTUxHZZ8VBsvj56WG
         7Qg1bO3B3amjskOrV5ldzIT48uH62F8FbqQ+NAme0cwQA3BWlAmIRmC3h/a5TpQokn7x
         58tJvpxKFYfuixh4NCgbUDhgRHLxjz++C3BsU=
Received: by 10.115.64.6 with SMTP id r6mr4573236wak.226.1277159433614;
        Mon, 21 Jun 2010 15:30:33 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id c22sm18715232wam.6.2010.06.21.15.30.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 15:30:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.454.g6bbe9.dirty
In-Reply-To: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149456>

Provide $feature{'write'} to enable the 'write'
functionalities for gitweb. While outputting HTML
it checks for gitweb_check_feature('write') and if
it's enabled, proper links will appear along with
the HTML divs.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 This patch is based on my previous patch series.
 http://mid.gmane.org/1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com
 
 And this is my first patch in the preparation for integration
 of write functionality into gitweb.

 gitweb/lib/Gitweb/Config.pm |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/gitweb/lib/Gitweb/Config.pm b/gitweb/lib/Gitweb/Config.pm
index c528595..87f0ba6 100644
--- a/gitweb/lib/Gitweb/Config.pm
+++ b/gitweb/lib/Gitweb/Config.pm
@@ -203,6 +203,17 @@ our %feature = (
 	# (an array) or gitweb_check_feature(<feature>) to check if <feature>
 	# is enabled
 
+	# Enable the 'write' functionalities for gitweb. While outputting HTML
+	# it checks for gitweb_check_feature('write') and if it's enabled,
+	# proper links will appear along with the HTML divs.
+	
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'write'}{'default'} = [1];
+	# Project specific override is not supported.
+	'write' => {
+		'override' => 0,
+		'default' => [0]},
+
 	# Enable the 'blame' blob view, showing the last commit that modified
 	# each line in the file. This can be very CPU-intensive.
 
-- 
1.7.1.454.g6bbe9.dirty
