From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/5] t9010 (svn-fe): avoid symlinks in test
Date: Fri, 13 Aug 2010 19:06:15 -0500
Message-ID: <20100814000615.GH2153@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net>
 <20100813000848.GA8076@burratino>
 <4C65BA46.9010604@kdbg.org>
 <20100813234723.GC2153@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Aug 14 02:08:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok4IG-0002VL-2Q
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 02:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213Ab0HNAIH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 20:08:07 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54915 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185Ab0HNAIG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 20:08:06 -0400
Received: by vws3 with SMTP id 3so1675326vws.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 17:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=c7bsjneZYjAEnPT/ckMZX99Njqeon62ysANEfakzOzY=;
        b=jrwvvD89HHXTsvpGogWgODCfo9qk4XE4zp9gMmJTW9NpCblpSChRJ4MXhyXJQ6g0OD
         nGYfNS2n6U3lTld+iLhoa3LKxKvQsvBjK94Mq2GIPIm5EutQ/icxpmVHnmdLS20kNhqG
         ntYoNefingOZlUQdG0g5L6PlDzL3PfW7VJC4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QAQDDu/DQ+nqZMDww50HrnrSw9IRM579D+Uh6+zUsF7h4ZKyc3f7ux4jQtFuV2M5Ao
         lPr2xBgXCttnGxydpGnGCJuUPrCU3+2GCpNXjSh1rwPKYXC/2zaRdry1qyW+qOaeyhYg
         A5qncWql0HME1U8KXDQqk1wPOMUMRoNvk7egA=
Received: by 10.220.76.200 with SMTP id d8mr1217364vck.261.1281744485704;
        Fri, 13 Aug 2010 17:08:05 -0700 (PDT)
Received: from burratino ([64.134.175.141])
        by mx.google.com with ESMTPS id s20sm1230427vcr.4.2010.08.13.17.07.54
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 17:08:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100813234723.GC2153@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153534>

The svn-fe test fails on Windows in the =E2=80=9Csvn export=E2=80=9D st=
ep because of
the lack of symlink support.  With a less ambitious dump, it passes.

Acked-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9010-svn-fe.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index dd8e78e..a713dfc 100644
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -27,6 +27,6 @@ test_dump() {
 	'
 }
=20
-test_dump simple t9111/svnsync.dump
+test_dump simple t9135/svn.dump
=20
 test_done
--=20
1.7.2.1.544.ga752d.dirty
