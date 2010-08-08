From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 0/4] Smoke testing for Git
Date: Sun,  8 Aug 2010 14:49:23 +0000
Message-ID: <1281278967-31376-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 16:49:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi7CF-0004z5-1P
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 16:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178Ab0HHOti convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 10:49:38 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48195 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab0HHOth (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 10:49:37 -0400
Received: by wyb39 with SMTP id 39so9175367wyb.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=2chfW/1V+PXWP9uSqo1oA1RAJsoXUc85zdBexUlMofc=;
        b=mSE8nOhytEFGkaid5SQr6ctLrex7KV76P057SQuajrXZD0fvVe7f8On8WyKY2gBY9K
         QJZ90y7WUzGcuqc1XHRgpXqupVCeXv1xxJVZaF7ozyJq0w1ikoCUFTprKRZGlk543CtY
         1mNBEca1OUxQuRjcnFyItQo3TT5kyTswUBcAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=sLV/60H+4zLmIYzzDCEAF+B8xtREwe4Sa+J0UE9Q/Tl/RbSZDIRIxc2tuszL90tIu5
         hHLwtBnsS8xKntU3qpFwqXwPbO/FRtEyJ+zRrOc/s0+sKSI8IHC6oejypyX3mYnFePIh
         VU82OthmQdREpsATp3d4puwIZzimdBbHftcTs=
Received: by 10.216.236.197 with SMTP id w47mr1565309weq.114.1281278975213;
        Sun, 08 Aug 2010 07:49:35 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k83sm2005995weq.38.2010.08.08.07.49.33
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 07:49:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152911>

v2 of the non-RFC version of the smoke testing for Git series. It goes
on top of Git (due to pu changes in t/README).

Changes since v1:

  * We can't include GIT-BUILD-OPTIONS. Change by Thomas Rast

  * Add SMOKE_{COMMENT,TAGS}=3D to submit a comment or list of tags wit=
h
    the smoke report. There are examples of this at
    http://smoke.git.nix.is/app/projects/smoke_reports/1

  * Do --foo=3D"$(BAR)", not --foo=3D$(BAR) to avoid quoting issues

  * Minor changes not worth noting, like rewording commit messages a
    bit.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
  tests: Infrastructure for Git smoke testing
  t/README: Document the Smoke testing
  t/Makefile: Can't include GIT-BUILD-OPTIONS, it's a .sh
  t/README: Add SMOKE_{COMMENT,TAGS}=3D to smoke_report target

 t/Makefile |   41 ++++++++++++++++++++++++++++++++-
 t/README   |   73 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 t/harness  |   21 +++++++++++++++++
 3 files changed, 134 insertions(+), 1 deletions(-)
 create mode 100755 t/harness
