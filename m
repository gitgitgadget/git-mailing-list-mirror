From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 08/73] gettextize: git-clone "Cloning into" message
Date: Tue, 22 Feb 2011 23:41:27 +0000
Message-ID: <1298418152-27789-9-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1wp-0001H8-2D
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894Ab1BVXns convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:48 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658Ab1BVXnj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:39 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Om75IfCBDexxdKz8PnyfoY1kqvXXGNTS6Py6ZMv36B0=;
        b=NBLlzHdx6imU+7zyRAmhUrUKxDei2LhEPo+v0vPQi3KMHtbAMPxuiT9nxU5pSrXzJS
         5lw32fnAj2yj+FGZ/H5ybd6Y0/535wxNd2a8EEyFF2u5V/MydEHIHk3/VesIf/ml/EY2
         BLwhUF5Ej7RvffwjdatBP+mrDdZ4bB1NdqESA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cSiY62kPTlIy5y/IOZ+d/ln9t8f3R81zeH35ckcvvam8COvuxBLg2zzlyz/sepWriO
         RviFQnjsGRTaHqKQa8lhCkZcVtTlhy9bFv3UjSwJYBxEYSbiWAnWN4r0xQoH1+hBEwUm
         6W+CsNrUHY1eYhAqVToG3pBWr3bkDy2NeZVLI=
Received: by 10.204.14.202 with SMTP id h10mr3096410bka.182.1298418218278;
        Tue, 22 Feb 2011 15:43:38 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.37
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:37 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167642>

Separate the "Cloning into %s" and "Cloning into bare repository %s"
messages to make them easier to translate. No noticeable change
intended.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/clone.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f46d09b..db0240d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -468,9 +468,12 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		die(_("could not create leading directories of '%s'"), git_dir);
 	set_git_dir(make_absolute_path(git_dir));
=20
-	if (0 <=3D option_verbosity)
-		printf("Cloning into %s%s...\n",
-		       option_bare ? "bare repository " : "", dir);
+	if (0 <=3D option_verbosity) {
+		if (option_bare)
+			printf("Cloning into bare repository %s...\n", dir);
+		else
+			printf("Cloning into %s...\n", dir);
+	}
 	init_db(option_template, INIT_DB_QUIET);
=20
 	/*
--=20
1.7.2.3
