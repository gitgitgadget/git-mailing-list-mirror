From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 35/73] gettextize: git-fetch split up "(non-fast-forward)" message
Date: Tue, 22 Feb 2011 23:41:54 +0000
Message-ID: <1298418152-27789-36-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:46:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1w8-0000rs-Un
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744Ab1BVXqZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:46:25 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:51284 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356Ab1BVXoH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:07 -0500
Received: by bwz10 with SMTP id 10so3867040bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gN+jOkT1SX2olHF9/3I2Dv/U8vVno2bIVa2vQE9/BQk=;
        b=Y+SqCjFJGyjz1jB/3gaj9fIFEITcwWgvpd55qYzggYIRuWTZj7QiGpE6q00cN/6eV4
         LprmXL5QqV9+uVzV8xCCmqBJfvsjWE9La3RmOQzucHnu/XtWArIIcWs/Wm0EqTrJTGpp
         J0NaEv6yA6+GeOWdgxlJ1N/l9oCgRyGRvwXDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GVmUddZegitZeUiEJdjEtGkMO6Tp6jRJC/BJSRCikyIHV8zXD8zGOyXA5Wc2FQTa2k
         k9SkV8Prh9kIG95enaaKUUCW2sBbQgJsJIQByXyk8KAzSdWEEA6Oips4RYcvmA+ZqMuZ
         4TD5c1PWZqSwj2KMCk9hydNooPX0YxP//JqUc=
Received: by 10.204.62.73 with SMTP id w9mr2968548bkh.11.1298418246010;
        Tue, 22 Feb 2011 15:44:06 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.05
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:05 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167638>

Split up the "(non-fast-forward)" message from printf directives and
make it translatable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/fetch.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4f622fd..ee2c5f5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -317,9 +317,9 @@ static int update_local_ref(struct ref *ref,
 			r ? _("unable to update local ref") : _("forced update"));
 		return r;
 	} else {
-		sprintf(display, "! %-*s %-*s -> %s  (non-fast-forward)",
-			TRANSPORT_SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
-			pretty_ref);
+		sprintf(display, "! %-*s %-*s -> %s  %s",
+			TRANSPORT_SUMMARY_WIDTH, _("[rejected]"), REFCOL_WIDTH, remote,
+			pretty_ref, _("(non-fast-forward)"));
 		return 1;
 	}
 }
--=20
1.7.2.3
