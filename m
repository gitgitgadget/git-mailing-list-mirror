From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 06/12] gettextize: git-submodule "cached cannot be used" message
Date: Mon, 13 Sep 2010 22:09:12 +0000
Message-ID: <1284415758-20931-7-git-send-email-avarab@gmail.com>
References: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 00:10:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvHEf-00079c-PS
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 00:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290Ab0IMWKm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 18:10:42 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42802 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab0IMWKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 18:10:15 -0400
Received: by wwd20 with SMTP id 20so393888wwd.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=oWT3bz2vbCsNPnE1TvAfmBGGpeZQz4Fe5Np1t5MYdUg=;
        b=YimXxWDHyOTxQIztz0mNjn6a9icnawWmOtMBd0WxAe+Q3RaVCNYuS4d331aqL3RfWS
         5bpw3itr1Igrnj0z3imoG1BJI2aVmmVLxlFkzRTnI3ehY7PqRTv3IKkhJNDlKP2bKuX8
         LZCqdc0I9Q/b3kW0RZyiaX//LjBNl2Fd05I78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=N5UkL0bIvM8NtvPcxSpsp0VCiRqk0VnCY62on+Ue7KZzWNgDvk3aTrH0jKjU6M4Ik+
         LD/QvY5KDnIWdVUutFmdOTkonJGYpTs74/ZfGyzo4myFPt83awFHW5sZY8M+YJg+KCqC
         rnxMU7CXeqHjOACNCr9IKodiehxyAMEqU+RGc=
Received: by 10.216.176.83 with SMTP id a61mr4931672wem.47.1284415811020;
        Mon, 13 Sep 2010 15:10:11 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm4296416weq.9.2010.09.13.15.10.09
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 15:10:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.220.gb4d42
In-Reply-To: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156144>

Gettextize the "--cached cannot be used with --files" message. Since
this message starts with "--" we have to pass "--" as the first
argument. This works with both GNU gettext 0.18.1 (as expected), and
the gettext(1) on Solaris 10.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2b33c5f..fcb11d9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -585,7 +585,7 @@ cmd_summary() {
 	if [ -n "$files" ]
 	then
 		test -n "$cached" &&
-		die "--cached cannot be used with --files"
+		die "$(gettext -- "--cached cannot be used with --files")"
 		diff_cmd=3Ddiff-files
 		head=3D
 	fi
--=20
1.7.3.rc1.220.gb4d42
