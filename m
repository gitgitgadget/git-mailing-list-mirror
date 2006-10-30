X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Mon, 30 Oct 2006 19:59:05 +0100
Message-ID: <200610301959.05313.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 19:05:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PMDlvJXvw3+NSQ+wOE+iUiltrlQLDiTwFdNRLEN7VR/NXS5k1S9yf+sSVA1mmJEAbuAJSzo6ImpK5y7QQzqXYOfeX/DDmKWT7aRSHkpzP5aE5VQBpx/+BX9VvtrsCOOENJEUgcuynNmr8RHKVR6SPJgqI6M+E6HWbTGE5SLgmHo=
User-Agent: KMail/1.9.3
In-Reply-To: <200610301953.01875.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30504>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GecMB-0003My-8M for gcvg-git@gmane.org; Mon, 30 Oct
 2006 19:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161384AbWJ3S7R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 13:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161385AbWJ3S7P
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 13:59:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:28079 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161384AbWJ3S7M
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 13:59:12 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1226209ugm for
 <git@vger.kernel.org>; Mon, 30 Oct 2006 10:59:11 -0800 (PST)
Received: by 10.66.255.7 with SMTP id c7mr4689615ugi; Mon, 30 Oct 2006
 10:59:11 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 53sm3684599ugn.2006.10.30.10.59.10; Mon, 30 Oct
 2006 10:59:10 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Use "&iquot;" Latin 1 entity ("&#191;" -- inverted question mark =
turned question mark, U+00BF ISOnum) instead '?' as replacements for
control characters and other undisplayable characters.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a15e916..edca27d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -567,7 +567,7 @@ sub esc_html {
 sub esc_path {
 	my $str = shift;
 	$str = esc_html($str);
-	$str =~ s/[[:cntrl:]\a\b\e\f\n\r\t\011]/?/g; # like --hide-control-chars in ls
+	$str =~ s/[[:cntrl:]\a\b\e\f\n\r\t\011]/&iquest;/g; # like --hide-control-chars in ls
 	return $str;
 }
 
-- 
1.4.3.3
