From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 0/2] Migrate ls-tree to parse-opts
Date: Fri, 13 Nov 2009 20:34:06 -0800
Message-ID: <1258173248-31059-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 05:34:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9AL6-0006AC-Jh
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 05:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757812AbZKNEeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 23:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757787AbZKNEeI
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 23:34:08 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:52529 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757713AbZKNEeH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 23:34:07 -0500
Received: by gxk26 with SMTP id 26so3672602gxk.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 20:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=Xa3J9nmte8VRlAJrePJlD6kbctqmswSK2948870QJ9c=;
        b=Whsqtpg/8it/vSSjlsbSZJrnJwlb5iFYu50W3VEVOOLt8EdM2CdXDgW0ytiGHNKd0h
         5JZTyjuMdsbTbCyvGgnj5ijrhFvs50eQD2qJWmjcz2JzIzkH3zKl0KPcTAndhwh/GfTu
         Gy7kJMH4VsgQsB/1l2B59H2UkY3bw84o6Cr/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ka6u8/xNJUDRtzo5DvDDXZ+4G6qbmUCzFzWpe2SfTciez3OGQn+TQsiNQqo6/5KJ5s
         ZkMmjuwtdkarFHq8HcPX73tiFPX6aU85U9aPRht0kkVVR3D0Gs244Wt04MgPCTa/4FAu
         MRNh5T/BDzMJwu8my2XDb/epbVgzicS9k8j9M=
Received: by 10.150.234.30 with SMTP id g30mr9349486ybh.205.1258173252084;
        Fri, 13 Nov 2009 20:34:12 -0800 (PST)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 5sm577387ywd.8.2009.11.13.20.34.09
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 20:34:11 -0800 (PST)
Received: by earth (sSMTP sendmail emulation); Fri, 13 Nov 2009 20:34:08 -0800
X-Mailer: git-send-email 1.6.5.2.155.gbb47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132857>

This looked pretty straightforward. I guess --name-status is there
for backward compatibility. Should it be there anymore?

Stephen Boyd (2):
  t3101: test more ls-tree options
  ls-tree: migrate to parse-options

 builtin-ls-tree.c          |  100 +++++++++++++++++--------------------------
 t/t3101-ls-tree-dirname.sh |   89 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 127 insertions(+), 62 deletions(-)
