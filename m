From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] bisect-helper: fix grammatical typo in exit_if_skipped_commits()
Date: Mon, 20 Apr 2009 23:31:52 -0700
Message-ID: <1240295512-22651-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 08:33:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw9Y5-0003Yf-2Y
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 08:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbZDUGb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 02:31:57 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbZDUGb5
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 02:31:57 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:24504 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbZDUGb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 02:31:56 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1258554wah.21
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 23:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=W05r2WR4HcDGISEZC6XowY9gWpisXsqXj5ZuiVgB9Hg=;
        b=eZQuK5oPNAk+/L5CUtCX4L1ucyJII6MS8KlP6MN9m6Ps+KzSA9yd88mRcl1jDvs/IN
         8zl0+25RrNDDNkJ3E8bhBWnMs8ViVEHbLkLiOwB6C2RH2hjgB2LhtCXflqedhIwVYkIr
         0cmMu0nsjSGb7t3yNyoi3k0xCJP8nx8zJdvgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SkZ9GH/zw23a/stU4jSRfU5+cj6XWt9qqBQQ/evRkJ2U5ueQQhGMyRm8jVysNLdW5q
         LB2P4f3jpsDBLY8PcLxcNTI87AkBD2CIXz9jqVq2w4BUSP1FLRo3IuqQrdivlJ4UDi3u
         rfUDzOtCTOowoTME2aopv90EPQwXWBMuR9eA8=
Received: by 10.114.122.9 with SMTP id u9mr3776476wac.129.1240295515730;
        Mon, 20 Apr 2009 23:31:55 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id v9sm8541067wah.60.2009.04.20.23.31.53
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 23:31:55 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 20 Apr 2009 23:31:52 -0700
X-Mailer: git-send-email 1.6.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117096>


Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
Christian Couder wrote:=20
> Le lundi 20 avril 2009, Stephen Boyd a =C3=A9crit :=20
>> Christian Couder wrote:=20
>>> +   printf("There are only 'skip'ped commit left to test.\n"=20
>>> +          "The first bad commit could be any of:\n")=20
>> Should this be "There are only 'skip'ped commits left to test"?=20
>=20
> Yes, but the same message was printed previously, so it is a slightly=
 =20
> incompatible change and I think it should go into another patch. Woul=
d you =20
> care to send such a patch?=20
>=20
> Thanks,=20
> Christian.=20
=20
This is against pu.=20

 bisect.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bisect.c b/bisect.c
index f6e1378..5902e83 100644
--- a/bisect.c
+++ b/bisect.c
@@ -575,7 +575,7 @@ static void exit_if_skipped_commits(struct commit_l=
ist *tried,
 	if (!tried)
 		return;
=20
-	printf("There are only 'skip'ped commit left to test.\n"
+	printf("There are only 'skip'ped commits left to test.\n"
 	       "The first bad commit could be any of:\n");
 	print_commit_list(tried, "%s\n", "%s\n");
 	if (bad)
--=20
1.6.2.3
