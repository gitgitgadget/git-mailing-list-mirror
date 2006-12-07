X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Commit f84871 breaks build on OS X
Date: Thu, 7 Dec 2006 16:42:40 +0100
Message-ID: <81b0412b0612070742x51af6011ua96962c53158cea0@mail.gmail.com>
References: <2D096A57-D7B3-49C7-81E4-EB47A0D933B2@silverinsanity.com>
	 <Pine.LNX.4.63.0612071554180.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	 <E8038C15-B359-4DE9-B3E0-45B065AEDBFA@silverinsanity.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_44617_11716634.1165506160366"
NNTP-Posting-Date: Thu, 7 Dec 2006 15:43:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=q8ZV42bynsCGHwq6QjgtpVZPeO7Puc2cxQDYSz5ZOjtwbgIGoxHsuZj+ixwBUttO85BOw8tOyl5KxbxiaNaT9Vyu4cLC1b5bjYZIK62e7uGQaiSlDagEUXorJ+EsgYxuojUzRDZBIsdlR+qMBc7Qprz1RgvyyKbur6aEaMJVytY=
In-Reply-To: <E8038C15-B359-4DE9-B3E0-45B065AEDBFA@silverinsanity.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33596>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsLPM-0001Kd-BB for gcvg-git@gmane.org; Thu, 07 Dec
 2006 16:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760676AbWLGPms (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 10:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760074AbWLGPms
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 10:42:48 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:39882 "EHLO
 wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760674AbWLGPmq (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 10:42:46 -0500
Received: by wr-out-0506.google.com with SMTP id i7so641514wra for
 <git@vger.kernel.org>; Thu, 07 Dec 2006 07:42:46 -0800 (PST)
Received: by 10.78.178.5 with SMTP id a5mr1507698huf.1165506165398; Thu, 07
 Dec 2006 07:42:45 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 7 Dec 2006 07:42:40 -0800 (PST)
To: "Brian Gernhardt" <benji@silverinsanity.com>
Sender: git-owner@vger.kernel.org

------=_Part_44617_11716634.1165506160366
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Does the attached patch help? I highly suspect the perl.mak generated
by MakeMaker.

diff --git a/perl/Makefile b/perl/Makefile
index bd483b0..b936e0d 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -29,6 +29,8 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo '	echo $(instdir_SQ)' >> $@
 else
 $(makfile): Makefile.PL ../GIT-CFLAGS
+	$(RM) $(makfile)
+	$(RM) $(makfile).old
 	'$(PERL_PATH_SQ)' $< FIRST_MAKEFILE='$@' PREFIX='$(prefix_SQ)'
 endif

------=_Part_44617_11716634.1165506160366
Content-Type: text/x-diff; name="perl.mak.old.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="perl.mak.old.patch"
X-Attachment-Id: file0

RnJvbSA1ZTAwZjg2NWZhMTNhNDI1ZDQzOTVhNzBhYWNhNzk4ZGZhZjA5M2RjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDcgRGVjIDIwMDYgMTY6NDA6MDYgKzAxMDAKU3ViamVjdDogW1BBVENIXSB3b3JrYXJv
dW5kIGZvciBNYWtlTWFrZXItZ2VuZXJhdGVkIE1ha2VmaWxlcwoKSXQgc2VlbXMgdG8gdHJ5IHRv
IG12IHBlcmwubWFrIGludG8gcGVybC5tYWsub2xkIGZpbGUgd2l0aG91dCBjaGVja2luZyBpZgou
b2xkIGV4aXN0cyBmaXJzdC4KClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBn
bWFpbC5jb20+CgpkaWZmIC0tZ2l0IGEvcGVybC9NYWtlZmlsZSBiL3BlcmwvTWFrZWZpbGUKaW5k
ZXggYmQ0ODNiMC4uYjkzNmUwZCAxMDA2NDQKLS0tIGEvcGVybC9NYWtlZmlsZQorKysgYi9wZXJs
L01ha2VmaWxlCkBAIC0yOSw2ICsyOSw4IEBAICQobWFrZmlsZSk6IC4uL0dJVC1DRkxBR1MgTWFr
ZWZpbGUKIAllY2hvICcJZWNobyAkKGluc3RkaXJfU1EpJyA+PiAkQAogZWxzZQogJChtYWtmaWxl
KTogTWFrZWZpbGUuUEwgLi4vR0lULUNGTEFHUworCSQoUk0pICQobWFrZmlsZSkKKwkkKFJNKSAk
KG1ha2ZpbGUpLm9sZAogCSckKFBFUkxfUEFUSF9TUSknICQ8IEZJUlNUX01BS0VGSUxFPSckQCcg
UFJFRklYPSckKHByZWZpeF9TUSknCiBlbmRpZgogCg==
