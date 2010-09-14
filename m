From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 00/20] gettextize: git-stash & git-bisect
Date: Tue, 14 Sep 2010 13:52:00 +0000
Message-ID: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:52:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvVw3-0003vr-Ms
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab0INNwa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:52:30 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47340 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab0INNw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:52:29 -0400
Received: by wyf22 with SMTP id 22so7426257wyf.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Upjl9eOsJB7cT5v2Y2bCT/2uYOfSxSIGdVx83fO9l3s=;
        b=nnFG+h7a2vCKsqvE7UBqSqCdyjunwLcdPibATjqB99RQ8ywIBL4zGCSwSR90H+KdZv
         xSHMcCdGl5aDtrcFWG+1SwQQvtUl2peh9OPGipUVM7GMUDJ9yAMa4GAj5jA283YtrBbD
         fCyKXr/dGHtLZkbkLCRn2m/D3/dR5njPxH7S4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=cGh+qn95ZKEGIKnpVIPkhcxcVrQn7sT/LhQSRxUF0XDP/akgzW+xVQ2tLfDXpcmuOW
         e1amzDVI85WJzLlc5dX6JHXV2P29nSWTvhz5uBgy++Glxq8i9Dq70gHD70zq/tA3w3WQ
         0YrDMQfTsXzs6BxPRWdQxyo1bIK3MNQNPubrM=
Received: by 10.216.169.136 with SMTP id n8mr3936458wel.65.1284472347697;
        Tue, 14 Sep 2010 06:52:27 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.52.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:52:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156172>

This is an RFC on a series that makes git-stash.sh and git-bisect.sh
translatable. With this git-rebase is the only mainporcelain command
that isn't translatable (soon to be fixed).

I'll be folding this into the next version of the ab/i18n series I'll
be sending to Junio. No need to apply it to the current one.

Note that this isn't diff --check clean, because the code I'm altering
wasn't:

    git-bisect.sh:117: indent with spaces.
    +                       die "$(eval_gettext "'\$arg' does not appea=
r to be a valid revision")"
    git-bisect.sh:190: indent with spaces.
    +                revs=3D$(git rev-list "$arg") || die "$(eval_gette=
xt "Bad rev input: \$arg")" ;;

Patches to fix these whitespace issues can come later after the i18n
series is applied.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (20):
  gettextize: git-stash add git-sh-i18n
  gettextize: git-stash echo + gettext message
  gettextize: git-stash say + gettext messages
  gettextize: git-stash die + gettext messages
  gettextize: git-stash die + eval_gettext messages
  gettextize: git-stash die + eval_gettext $* messages
  gettextize: git-stash die + eval_gettext $1 messages
  gettextize: git-stash "unknown option" message
  gettextize: git-stash drop_stash say/die messages
  gettextize: git-bisect add git-sh-i18n
  gettextize: git-bisect gettext + echo message
  gettextize: git-bisect echo + gettext messages
  gettextize: git-bisect echo + eval_gettext message
  gettextize: git-bisect die + gettext messages
  gettextize: git-bisect die + eval_gettext messages
  gettextize: git-bisect bisect_run + $@ messages
  gettextize: git-bisect bisect_reset + $1 messages
  gettextize: git-bisect bisect_replay + $1 messages
  gettextize: git-bisect [Y/n] messages
  gettextize: git-bisect bisect_next_check "You need to" message

 git-bisect.sh |   84 ++++++++++++++++++++++++++++++++-----------------=
-------
 git-stash.sh  |   75 +++++++++++++++++++++++++++++++------------------=
-
 2 files changed, 94 insertions(+), 65 deletions(-)

--=20
1.7.3.rc1.234.g8dc15
