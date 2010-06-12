From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix typo in hash key name in %opts in git_header_html
Date: Sun, 13 Jun 2010 00:35:59 +0200
Message-ID: <20100612223425.19002.86147.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 13 00:37:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONZKp-0005L9-4h
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 00:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab0FLWg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 18:36:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60835 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab0FLWg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 18:36:27 -0400
Received: by fxm8 with SMTP id 8so1678553fxm.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=F15m7uPM1LTDrrZi55Mks4a2vAQxCZTZKwcUd7vjFIM=;
        b=pNWDTk39uxLrYx4f1/4OfwZnj+9a+BX2Sx/wd6xWy7r0+OAzTGnrGsWpD0OBBc7Hg7
         BYduR7kLKFAUz7zyCz644ubAm4rc8w1K5xLE6VVn7GBepUBVSKmKsecYiQ7KuCCdnGYI
         Ksi+UwS1B8QT4ed/RVmuN6nFZRgSCAx4AuBCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=TH5mEI97hLuggXwPvPNFlTSG/N531X5juj6EOYI3guKy6PGJreFBA1Eh+TwFqozF74
         HbHTV3gpmB0knlZbaGpAa76N9l1BH2z3lfh7FA/aOpp3TUI0fbB1R9Hv5ptf53QcLTPZ
         N/UHMb3iQsW8c3LGnsl+DEDln7smKn3rQ22iw=
Received: by 10.102.240.16 with SMTP id n16mr1086165muh.100.1276382185640;
        Sat, 12 Jun 2010 15:36:25 -0700 (PDT)
Received: from localhost.localdomain (abve213.neoplus.adsl.tpnet.pl [83.8.202.213])
        by mx.google.com with ESMTPS id y6sm3931433mug.50.2010.06.12.15.36.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 15:36:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o5CMZx4P019048;
	Sun, 13 Jun 2010 00:36:09 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149032>

The name of the key has to be the same in call site handle_errors_html
and in called subroutine that uses it, i.e. git_header_html.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I'm sorry about that.  Stupid mistake.

I have noticed this when working (again) on gitweb output caching
series.  There was toss-up on which version ''-no_http_headers'
or '-no_http_header' to choose.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 934aacb..e108bbc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3220,7 +3220,7 @@ sub git_header_html {
 	}
 	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
 	                   -status=> $status, -expires => $expires)
-		unless ($opts{'-no_http_headers'});
+		unless ($opts{'-no_http_header'});
 	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
 	print <<EOF;
 <?xml version="1.0" encoding="utf-8"?>
