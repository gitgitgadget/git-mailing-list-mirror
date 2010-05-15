From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/6] git-cvsserver: password support for pserver
Date: Sat, 15 May 2010 02:45:58 +0000
Message-ID: <1273891564-7523-1-git-send-email-avarab@gmail.com>
References: <7v3an9tc5w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 04:46:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD7Oo-0008Gd-I6
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 04:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365Ab0EOCql convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 22:46:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:48640 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab0EOCqk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 22:46:40 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1937174fga.1
        for <git@vger.kernel.org>; Fri, 14 May 2010 19:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WZjpwpDVb0Q3hvNE/ejL4iMCLfd2obJpaJFDpoJZDzA=;
        b=SOhP7nUFvTRSUelB3mV1tQSdRFJxS88xr+jAiVDVMPHh5qokcMeg2jGMpLzI27yRFE
         u6o8/yVpvDrqd0KxkxueGoJToE8e6C4cc0uJlOQUxZzW7unh3oYmX8E62Ch5V2PUO+nB
         AwxIcKSQjFoXrqVlDfwHqMIEpyXblSRf5OyoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=F0MHqzTQ1bzk8GRWd6rJpRhqhdedseE4Lr4QffbkOi4GDcQsDMpeMOb5ud9Va79b/Y
         spEW3RbfUTm9KOxv0cn7Okl5Yu5zhFEbooxrdPRNeE8bl4QqWgN4N1elvg3D7ZX2O4WY
         7JvDyMlNy92B6iRQhLBpbHv6pkek+gge7F5Fk=
Received: by 10.86.239.14 with SMTP id m14mr3851270fgh.78.1273891598826;
        Fri, 14 May 2010 19:46:38 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 22sm4155718fkq.17.2010.05.14.19.46.37
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 19:46:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.84.gd92f8
In-Reply-To: <7v3an9tc5w.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147127>

This series adds optional pserver authentication support to
git-cvsserver. It's useful in legacy environments that rely on pserver
authentication support, and for various reasons can't easily switch to
ssh-based authentication.

This series was originally submitted in 2007/2008[1] and approved by
Junio[2], it stalled because I didn't follow up[3] on sending it in an
applyable format until now.

Changes since the series was originally submitted:

  - There's now a test for pserver authentication support

  - Fixed the commit message of a few commits & squashed some commits.

  - It now complies with Documentation/SubmittingPatches. I.e. has
    signed-off-by lines.

  - Changed my E-Mail address in the commits.

1. http://lists-archives.org/git/640574-authentication-support-for-pser=
ver.html=20
2. http://lists-archives.org/git/640617-authentication-support-for-pser=
ver.html=20
3. http://article.gmane.org/gmane.comp.version-control.git/85521/

Sam Vilain (1):
  git-cvsserver: use a password file cvsserver pserver

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (5):
  git-cvsserver: authentication support for pserver
  git-cvsserver: indent & clean up authdb code
  git-cvsserver: Improved error handling for pserver
  git-cvsserver: document making a password without htpasswd
  git-cvsserver: test for pserver authentication support

 Documentation/git-cvsserver.txt |   37 +++++++++++++--
 git-cvsserver.perl              |   97 +++++++++++++++++++++++++++++++=
++++---
 t/t9400-git-cvsserver-server.sh |   16 ++++++-
 3 files changed, 137 insertions(+), 13 deletions(-)
