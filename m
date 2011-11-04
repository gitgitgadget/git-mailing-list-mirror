From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/4] fsck improvements
Date: Fri,  4 Nov 2011 22:47:46 +0700
Message-ID: <1320421670-518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 16:49:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMM16-0002zr-OA
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 16:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534Ab1KDPtM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 11:49:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36170 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840Ab1KDPtL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 11:49:11 -0400
Received: by iage36 with SMTP id e36so2682080iag.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 08:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=3rT8O0F88XKT4phFXfi9Od4s7KGJm/2lBAbrMx2WHqY=;
        b=C2aQDeqIsuFNN7evMECwEYt+WhDrNGrEIjGCwZ9P0RA5LFyepVjiky/ubIqLNKWBwp
         0dYXVEDWAVxTEtmU8lO/kYvJlHZDkYlcjwmAipItIDU08GHZ5VOZI1A3D/9A2xyag3/u
         YA12hzRSD33rtpchzpXPsdxGKkdlHAZwy//MY=
Received: by 10.231.8.226 with SMTP id i34mr3325127ibi.38.1320421750993;
        Fri, 04 Nov 2011 08:49:10 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.210.255])
        by mx.google.com with ESMTPS id eh34sm22108853ibb.5.2011.11.04.08.49.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Nov 2011 08:49:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 04 Nov 2011 22:47:51 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184777>

So I looked at fsck to see if it's easy to support multithread and
found out I could reduce fsck time by half. So here it is. I think I
haven't made any mistakes but fsck is not my domain.

The last patch is reposted because it conflicts with the series. It
also prints progress when checking connnectivity.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  fsck: return error code when verify_pack() goes wrong
  Stop verify_packfile() as soon as an error occurs
  fsck: avoid reading every object twice
  fsck: print progress

 Documentation/git-fsck.txt |   12 ++++++-
 builtin/fsck.c             |   78 +++++++++++++++++++++++++++++++++++-=
--------
 pack-check.c               |   27 +++++++++++++--
 pack.h                     |    6 +++-
 4 files changed, 101 insertions(+), 22 deletions(-)

--=20
1.7.4.74.g639db
