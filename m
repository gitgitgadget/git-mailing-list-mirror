From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/3] tests: Better prerequisite handling & documentation
Date: Fri,  6 Aug 2010 21:19:22 +0000
Message-ID: <1281129565-26124-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 23:19:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhUKT-0005P2-9P
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 23:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762069Ab0HFVTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 17:19:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51612 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab0HFVTl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 17:19:41 -0400
Received: by wyb39 with SMTP id 39so8201142wyb.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=vVn7LGQrYmV+UMHCdDrtV44JepFV/H4TZy3OYuDFa74=;
        b=C8BMYFLNxkRe+ES91Jvtv0eTE64NG7MbJn+zIEahON7Z5oBGV5OH9pILgdiuff1ooE
         AGiJTqKTMxpgEyCgJlk/vBb1dbFrciX9Q8rWjBZtCDDyslAP/h/6Id66xSgfHe0Q3WEd
         KKbvZYBN12hMSeqK7TLat5JuUbaTn99g+ZGek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=wkEjSVTJBeNI0vJhGCnDSYAVzpb9xHSdKY6PR8gDBXfCy90FAmC+B1ANOwNq5mgMv4
         6+Yp4mwEEMvnSklpbIitCgw2KC+koIbC5DOqfGoU3fJQOMwIozNFKQ4KyITdl539yZP2
         MFk/GMvy+dq1XZCz3nKipaY34HbIfo4sDFjr0=
Received: by 10.216.10.5 with SMTP id 5mr11052148weu.81.1281129579790;
        Fri, 06 Aug 2010 14:19:39 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k7sm1167559wej.2.2010.08.06.14.19.37
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 14:19:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152814>

There were some useful nuggets in the "Tests in Cygwin" thread from
May last year that I've dug out and improved. This series adds support
for multiple test prerequisite, and improves the t/README
documentation by adding a "Prerequisites" section.

There's also a small fix to the raw test output.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
  test-lib: Add support for multiple test prerequisites
  test-lib: Print missing prerequisites in test output
  t/README: Document the predefined test prerequisites

 t/README         |   51 ++++++++++++++++++++++++++++++++++++++++++++++=
-----
 t/t0000-basic.sh |   17 +++++++++++++++++
 t/test-lib.sh    |   22 +++++++++++++++-------
 3 files changed, 78 insertions(+), 12 deletions(-)
