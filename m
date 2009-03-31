From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 0/4] send-email: correct various issues
Date: Tue, 31 Mar 2009 12:22:10 -0400
Message-ID: <cover.1238516122.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>,
	=?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 18:24:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoglB-0007f0-QC
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 18:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756409AbZCaQWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 12:22:47 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755902AbZCaQWq
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 12:22:46 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:46070 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403AbZCaQWp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 12:22:45 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3180189qwh.37
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vQLqyeDQzahJ/iu3zuOPLlanIGrwy+rVmKJvq19RR/Q=;
        b=YF2YfbvmPoZylRFvNjZw/yOpYmTOvJTDqmdb8U5rj4Kes8OT2rMjd5w4lUWF1fcY+m
         CJTk60GnRCI4quLyx5VGpuo9Qc5asUvKUX0an9IStmH9zNecPhmXUn0/moOmMff0GM8G
         8Vc4/LxRdBHqx78ZrSYZ9eH+quuJjfXTgex8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=s3hmquccWsKWGaGPytJF3apbj3EUMCMVCN7BbMzMnrA78KzdVt010K2H/ay+y4b9ux
         BWT1+U3d5OZBY6tcXGV9BKhMKr4a+9zhCn//l5OK0HLM8KUfEPom8p+RPwVbgLVlWD6F
         6Vw+RUCzW3TkLNCnilivFTM0mM2SS+aq4Slzw=
Received: by 10.224.37.77 with SMTP id w13mr8412804qad.142.1238516563718;
        Tue, 31 Mar 2009 09:22:43 -0700 (PDT)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 4sm138784qwe.15.2009.03.31.09.22.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 09:22:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.427.g15408
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115275>

Junio, these are technically all independent bug fixes, but they were
minor, so I've lumped them together. I figured you'd just add them to
the js/send-email topic anyway. Also, I apologize for causing trouble i=
n
master. :-(

Bj=C3=B6rn, I've cc'd you for 3/4, which caused me to notice the proble=
m that
led to 4/4. Uwe, I've cc'd you for 4/4.

Jay Soffian (4):
  send-email: don't attempt to prompt if tty is closed
  send-email: ask_default should apply to all emails, not just the
    first
  send-email: correct two tests which were going interactive
  send-email: ensure quoted addresses are rfc2047 encoded

 git-send-email.perl   |    9 ++++++---
 t/t9001-send-email.sh |   25 +++++++++++++++++++++----
 2 files changed, 27 insertions(+), 7 deletions(-)
