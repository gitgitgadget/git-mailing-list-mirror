From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] builtin-checkout.c: fix usage segfault
Date: Mon, 18 Feb 2008 05:20:20 -0500
Message-ID: <1203330020-7007-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 11:21:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR37L-0002WG-VB
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 11:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756999AbYBRKUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 05:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756966AbYBRKUZ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 05:20:25 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:44532 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756973AbYBRKUY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 05:20:24 -0500
Received: by an-out-0708.google.com with SMTP id d31so373857and.103
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 02:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=qVSiYi5FUyQYhcX/kQTcPu/UewlpK5mYVBRaVwvbJ1U=;
        b=e8yRuXaofBfClwFK9TA1r7TywSJh/Z/ZY89n/2acyH6wU5pu9PmjnhNQFOdq7PIbxaAMvL+GpkHghawsrHnOnt7A9k3Q4WMKP6L9BHRpL8atty8S8IeAw6ap5obfA4on7mazJgen+6uGPAfMGCw/7hT/L4kFx8ixMG7IS1AwcjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=HULtYeRQt6AFTzFeow8T9A+tTS2xJ55xNcHFnGqK55390N/dVikrxY6lDkfTHHYWCE2oP5Ukzia23+vJdLr8rUwNoObtiYW1Qea7LTg0k6Kg+KRPXpZEeGO+lhf0t1G0uaDGUZ3F+H3WqfbX943IaDvB+t7RfXUh+NbEz6ol3z0=
Received: by 10.100.121.12 with SMTP id t12mr10928127anc.114.1203330023350;
        Mon, 18 Feb 2008 02:20:23 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id c23sm11240629ana.15.2008.02.18.02.20.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Feb 2008 02:20:22 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2.183.g9fe5b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74256>

options was missing OPT_END

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-checkout.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 9370ba0..0d19835 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -545,6 +545,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN( 0 , "track", &opts.track, "track"),
 		OPT_BOOLEAN('f', NULL, &opts.force, "force"),
 		OPT_BOOLEAN('m', NULL, &opts.merge, "merge"),
+		OPT_END(),
 	};
 
 	memset(&opts, 0, sizeof(opts));
-- 
1.5.4.2.183.g9fe5b
