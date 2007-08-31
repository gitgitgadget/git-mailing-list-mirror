From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 13/14] gitweb: CSS style and refs mark for detached HEAD
Date: Fri, 31 Aug 2007 13:19:13 +0200
Message-ID: <1188559169764-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
 <11885591542097-git-send-email-giuseppe.bilotta@gmail.com>
 <11885591601143-git-send-email-giuseppe.bilotta@gmail.com>
 <11885591653402-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 13:21:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR4ZF-0002oW-Tp
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 13:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbXHaLVR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 07:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbXHaLVQ
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 07:21:16 -0400
Received: from hu-out-0506.google.com ([72.14.214.230]:32010 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964922AbXHaLVO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 07:21:14 -0400
Received: by hu-out-0506.google.com with SMTP id 19so593548hue
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 04:21:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VjM5pgEh4HHH1eaSSyRUqIOqNB0rfH9U+IuZhVPOf2f86WMLsWHCxe62FvuV3Dd4B5KEv609lEINDAdMA9OqAb0EzyY+OBrWrZJGQBGwGVS5r0yHCHs58CTOvNCVLGGlKedA/McjKtB0fvho1MZzCrPBP9I4mqZ63SjI364/pOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=p14N6chJ6EFJMG0yyjwAJPymAN65EphLInnKjYW4qRxtqQYsf5icd6vyDTSqu3yf15/lkag29/AvmYbHWqQrfpe+KCo+5ryfGkKtF5Ha/aBe0b5vsRzPsRTu9jJyP5lBOWEK9TSg/DdpuUVYwG3xgNeJfgI9+F5H5PprSVprhKM=
Received: by 10.82.134.12 with SMTP id h12mr3470219bud.1188559272713;
        Fri, 31 Aug 2007 04:21:12 -0700 (PDT)
Received: from localhost ( [84.221.55.162])
        by mx.google.com with ESMTPS id k9sm951015nfh.2007.08.31.04.21.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2007 04:21:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <11885591653402-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57161>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css  |    5 +++++
 gitweb/gitweb.perl |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index c36b20a..59ca071 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -498,6 +498,11 @@ span.refs span.head {
 	border-color: #ccffcc #00cc33 #00cc33 #ccffcc;
 }
 
+span.refs span.detached {
+	background-color: #ffaaaa;
+	border-color: #ccffcc #00cc33 #00cc33 #ccffcc;
+}
+
 span.atnight {
 	color: #cc0000;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4f7b7da..2c8a665 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1690,7 +1690,7 @@ sub git_get_references {
 	my %refs;
 	if (git_is_head_detached()) {
 		my $hash = git_get_head_hash($project);
-		$refs{$hash} = [ 'HEAD' ];
+		$refs{$hash} = [ 'detached/HEAD' ];
 	}
 	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/tags/v2.6.11
 	# c39ae07f393806ccf406ef966e9a15afc43cc36a refs/tags/v2.6.11^{}
-- 
1.5.2.5
