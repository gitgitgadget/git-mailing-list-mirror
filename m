From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 00/10] gitweb: remote_heads feature
Date: Sun, 24 Oct 2010 12:45:26 +0200
Message-ID: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 12:46:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9y5N-0004kV-RS
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 12:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449Ab0JXKpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 06:45:52 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39237 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932370Ab0JXKpv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 06:45:51 -0400
Received: by wwe15 with SMTP id 15so2499176wwe.1
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 03:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=q+nmTGMFdzE27zK2jO6ZVSeEy5XRbSF/+lcM7/xZr+8=;
        b=WfyimE70f0C9ATDWzqFY4Q8ZOrEnpQR5DJpzCbvYt5JRccZym1WoS6S5fpOQm18G8v
         QKxyw1xwNtEkHKD7SqtGFq00Txuaeq79raHOpgymxOzpYbV6G2h+bbfPw+BLY6XXAoLH
         paWZcFe9a2kxM+wgq7jaAMcW8agImNT0kQkVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TT5XFZ+Zcv4K+H10Vtm/HDhZIB78XIItURSrL4tnPFS3TjbN0xGf4e3GxHHW0xpBPT
         UdjecoqgPNi2RI9sqtwyDMLzsmgfRlIJkkRVi1cAQoJ5zIK1bKylyOWP2oygHmAFkS+v
         XLg2E95PBHN6s4UE3HmZ8UhCzEjuk64FwFtF4=
Received: by 10.216.8.199 with SMTP id 49mr4899662wer.1.1287917149201;
        Sun, 24 Oct 2010 03:45:49 -0700 (PDT)
Received: from localhost ([151.60.176.122])
        by mx.google.com with ESMTPS id 7sm3309554wet.24.2010.10.24.03.45.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 03:45:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159844>

In this 6th version of the remote heads feature for gitweb, much of the
internal API has been cleaned up thanks to the suggestion from Jakub and
others. There were also some other stylistic changes, and a few patches were
reordered/merged.

The first 4 patches are rather straightforward and can probably go
straight in. The 5th patch is a bugfix for something that is only
triggered by the name manipulation done with the remote heads, but can
probably be useful even without the rest of the series.

Patch 7 provides 'single remote view', depending on patch 6 for
improved visuals of the page header.

Patches 8 and 9 provide some infrastructure for the grouped remote heads
display introduced in the last patch.

As usual, you can see it live @ http://git.oblomov.eu (look at the rbot
project in particular for the "lots of remotes" case), comments welcome.

Giuseppe Bilotta (10):
  gitweb: introduce remote_heads feature
  gitweb: git_get_heads_list accepts an optional list of refs.
  gitweb: separate heads and remotes lists
  gitweb: nagivation menu for tags, heads and remotes
  gitweb: use fullname as hash_base in heads link
  gitweb: allow action specialization in page header
  gitweb: remotes view for a single remote
  gitweb: refactor repository URL printing
  gitweb: provide a routine to display (sub)sections
  gitweb: group remote heads by remote

 gitweb/gitweb.perl       |  283 ++++++++++++++++++++++++++++++++++++++++++++--
 gitweb/static/gitweb.css |    6 +
 2 files changed, 279 insertions(+), 10 deletions(-)

-- 
1.7.3.68.g6ec8
