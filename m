From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 0/2]  git-gui: generic and robust worktree/gitdir support
Date: Thu, 19 Feb 2009 02:15:43 +0100
Message-ID: <1235006145-16760-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 02:17:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZxXU-0002WS-3d
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 02:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbZBSBPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 20:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbZBSBPv
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 20:15:51 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:12884 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbZBSBPu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 20:15:50 -0500
Received: by fk-out-0910.google.com with SMTP id f33so155872fkf.5
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 17:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=29vwLBcHHAuw4xf3KiUARRPNVTFeSyHtCeSCRDUX2XY=;
        b=hPP50EqwKQVsM4qAREvpdmhyBIQ3ckOcWf3HsFVOMSOnQvymNylkIqEZCINxDHed/j
         bN4F/JHjLiJmef1kg3wr6db9FzEEVVg8PB/BwtC9ROblVhAQXzoOU6q8XYC2kWg+ikaV
         O7kvGJyjYIuUy0LI9vIyl2DeeNPifwWY+Jm40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=LoxGbH6mFzlbMyZZ4Cd1GLGtWJ0ykUz3m857OLuZFJK+o8G02kOhcxitD6cLmZOjQS
         kn9dHg41JualIaZ5mko8tKyT0MNOvan4n4eK5ON1ZIngC1hxfckycMHTTNRXBCq+gs9e
         HZUNiiL8u0LVjAun+PBM3o1ktVjDIRFm8Hom4=
Received: by 10.103.227.13 with SMTP id e13mr29279mur.20.1235006149006;
        Wed, 18 Feb 2009 17:15:49 -0800 (PST)
Received: from localhost ([94.37.6.213])
        by mx.google.com with ESMTPS id j10sm219463muh.1.2009.02.18.17.15.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 17:15:48 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.179.g17e82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110605>

Version 2 of the patchest to make git-gui work with non-standard
gitdir/worktree locations, by making it support the GIT_DIR and
GIT_WORK_TREE environment variables. As a plus we also get improved
detection and support for bare repositories.

Giuseppe Bilotta (2):
  git-gui: handle non-standard worktree locations
  git-gui: handle bare repos correctly

 git-gui/git-gui.sh |   69 ++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 54 insertions(+), 15 deletions(-)
