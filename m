From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH 1/5] gitweb: Add a comment explaining the meaning of $/
Date: Wed,  4 Dec 2013 14:42:59 +0100
Message-ID: <1386164583-14109-2-git-send-email-krzesimir@endocode.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
Cc: gitster@pobox.com, jnareb@gmail.com, sunshine@sunshineco.com,
	Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 14:43:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoCjx-0007Bq-3W
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 14:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459Ab3LDNnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 08:43:33 -0500
Received: from mail-ee0-f45.google.com ([74.125.83.45]:40089 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932433Ab3LDNnc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 08:43:32 -0500
Received: by mail-ee0-f45.google.com with SMTP id d49so2394822eek.4
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 05:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JVj/s9ahL0rfq2aaktp1ApaTNBDvJrCZ7+NMPZOVfh4=;
        b=kG17y37Jw454+pRl+OmPFpMzsMITujF/qkpd3lDIb0GoHmEBC8GszqNC71t4yDe3Qi
         vB1UVgmMXj9Xe0Tw/W6IQdpcNYNRenjRGV+qJYqYOg46GBHWfi1SsdHpmrNlyS+Pyr0n
         BkhuypIpmW0wAWRNKIzBBldySAHfc7NoJYvtqF/sSz8xQs6TK+93meEb+NRyiYaNfljm
         NdxAgkaKmcLo6F7qdY+CytY/QzSCPLIu3YECWcSFBb9AxCLdu73qNYGsSY9iMmsYA5cK
         9bnAuiEKopA+RUAoKn3WERTX81T+10jWQiT8umQCzVw52qp2xGpf6DPIEJ3A7wvnmDMl
         Rgxw==
X-Gm-Message-State: ALoCoQmhNlSWioTVPyYcqH6QnFB5cLvmwSfFQ8Wx0vJnYsV/NUWeXcAWu7qg4NSEX8uZ23/BeIEF
X-Received: by 10.14.9.131 with SMTP id 3mr11463530eet.45.1386164610719;
        Wed, 04 Dec 2013 05:43:30 -0800 (PST)
Received: from localhost.home (95-91-240-208-dynip.superkabel.de. [95.91.240.208])
        by mx.google.com with ESMTPSA id z42sm22327433eeo.17.2013.12.04.05.43.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2013 05:43:29 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238778>

So future reader will know what does it mean without running "perldoc
perlvar".

Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
---
 gitweb/gitweb.perl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 68c77f6..ee61f9e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2629,6 +2629,8 @@ sub git_parse_project_config {
 	my $section_regexp = shift;
 	my %config;
 
+	# input record separator, so getline does end on null, not
+	# newline
 	local $/ = "\0";
 
 	open my $fh, "-|", git_cmd(), "config", '-z', '-l',
-- 
1.8.3.1
