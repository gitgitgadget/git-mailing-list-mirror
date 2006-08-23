From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2] gitweb: Replace git_commitdiff_plain by anonymous subroutine
Date: Thu, 24 Aug 2006 01:58:14 +0200
Message-ID: <200608240158.14991.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 24 01:59:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GG2ct-0001oe-W7
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 01:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965316AbWHWX7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 19:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965311AbWHWX7K
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 19:59:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:26440 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965211AbWHWX7I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 19:59:08 -0400
Received: by nf-out-0910.google.com with SMTP id o25so459782nfa
        for <git@vger.kernel.org>; Wed, 23 Aug 2006 16:58:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=S9Z32enTs0z8nuYeeXfRxSVdK3jOOOcossywsEH+lCDtWbtMrKdppCfChcr1JBswH5YmJiiheQxf/9K/Diial1VS/iBGac8juxH1F0AfuPVYiGyb0YJ7pCZzvpkUOUF61Q3k3blR2nYWCWeJzvxbDQnPvN+37w2+3x05lTCtenM=
Received: by 10.49.10.3 with SMTP id n3mr2767303nfi;
        Wed, 23 Aug 2006 16:58:51 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id q28sm3271090nfc.2006.08.23.16.58.50;
        Wed, 23 Aug 2006 16:58:51 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25935>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9367685..c238824 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -234,7 +234,7 @@ my %actions = (
 	"blob" => \&git_blob,
 	"blob_plain" => \&git_blob_plain,
 	"commitdiff" => \&git_commitdiff,
-	"commitdiff_plain" => \&git_commitdiff_plain,
+	"commitdiff_plain" => sub { git_commitdiff('plain'); },
 	"commit" => \&git_commit,
 	"heads" => \&git_heads,
 	"history" => \&git_history,
@@ -2820,10 +2820,6 @@ TEXT
 	}
 }
 
-sub git_commitdiff_plain {
-	git_commitdiff('plain');
-}
-
 sub git_history {
 	if (!defined $hash_base) {
 		$hash_base = git_get_head_hash($project);
-- 
1.4.1.1
