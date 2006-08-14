From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 7/9] gitweb: Skip comments in mime.types like file
Date: Mon, 14 Aug 2006 02:15:22 +0200
Message-ID: <200608140215.22378.jnareb@gmail.com>
References: <200608140202.46160.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 14 12:17:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCZVE-0001tP-WF
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 12:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbWHNKQu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 06:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbWHNKQu
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 06:16:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:24460 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751980AbWHNKQl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 06:16:41 -0400
Received: by nf-out-0910.google.com with SMTP id a4so20978nfc
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 03:16:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TUBr1gq+wzKe09kfDsq2TuiHc3OPnL1E7BU0gWBokiuocxDK+wj6MZhLc6ZE4BLexwvuD5VOLYWE4C6kzGMlVTcbbvfoj8GadeoxlssOh8S3JDyvMkjgHixYhHAOl87FqszE3QPutyH0szU52e8WnzC4R6wjd9lMdIOH1PhZOts=
Received: by 10.49.41.18 with SMTP id t18mr975736nfj;
        Mon, 14 Aug 2006 03:16:41 -0700 (PDT)
Received: from host-81-190-23-158.torun.mm.pl ( [81.190.23.158])
        by mx.gmail.com with ESMTP id m16sm9637471nfc.2006.08.14.03.16.40;
        Mon, 14 Aug 2006 03:16:40 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608140202.46160.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25342>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4fe3fc7..52ae2aa 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -858,6 +858,7 @@ sub mimetype_guess_file {
 	my %mimemap;
 	open(MIME, $mimemap) or return undef;
 	while (<MIME>) {
+		next if m/^#/; # skip comments
 		my ($mime, $exts) = split(/\t+/);
 		if (defined $exts) {
 			my @exts = split(/\s+/, $exts);
-- 
1.4.1.1
