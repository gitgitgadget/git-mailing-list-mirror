From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 07/16] send-email: cleanup_compose_files doesn't need a prototype
Date: Thu, 30 Sep 2010 13:43:00 +0000
Message-ID: <1285854189-10240-8-git-send-email-avarab@gmail.com>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 15:44:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JQh-00012b-Dh
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068Ab0I3Nn5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:43:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42011 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab0I3Nn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:43:56 -0400
Received: by wyb28 with SMTP id 28so1858034wyb.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1qGYzTfZzw138x+Q+BYqbbNq/qv7nWtqdD6lFK67TNU=;
        b=s3DWIvAFwIdAp/VCuxv08iYEZAJ/AJJEfavGpwU4gOn6aCEbepkabVm3OpR55riDL3
         jTC4jrmA+R2FDHOqGo+8FZQlvk2s94yN/duYJvcGh6wzoLs2M+guQinldvbrdcEvixrx
         e5w+qS0urIY/ii8EzOKzE1rC9+kCNJO5i2HG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=RmDCHAvE+o8Ly69BwplXg3tFF+gwNxSdOAya4gzoXTmoaRSg6VP7m1EmGM7aPN2ahQ
         8B79gHpipKNY1gtPnXxwMAKRnfAGk8GHaWI4jlJTeGDPePZA7979JuY1BS6p/GqhlurZ
         22fqGYsF+f4U77gEGHQgno4yBTHqmEPFE8t8s=
Received: by 10.227.143.12 with SMTP id s12mr3155043wbu.125.1285854235450;
        Thu, 30 Sep 2010 06:43:55 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.43.53
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:43:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157658>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 90b777a..ce9b5eb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -136,8 +136,6 @@ my $have_mail_address =3D eval { require Mail::Addr=
ess; 1 };
 my $smtp;
 my $auth;
=20
-sub cleanup_compose_files();
-
 # Variables we fill in automatically, or via prompting:
 my (@to,$no_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
 	$initial_reply_to,$initial_subject,@files,
@@ -1325,7 +1323,7 @@ foreach my $t (@files) {
=20
 cleanup_compose_files();
=20
-sub cleanup_compose_files() {
+sub cleanup_compose_files {
 	unlink($compose_filename, $compose_filename . ".final") if $compose;
 }
=20
--=20
1.7.3.159.g610493
