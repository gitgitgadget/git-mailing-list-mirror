From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] git-repack: re-enable parsing of -n command line option
Date: Sat, 10 May 2008 16:52:51 -0400
Message-ID: <48260B23.5050305@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 10 22:54:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juw50-0000qc-TP
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 22:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbYEJUxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 16:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753791AbYEJUxA
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 16:53:00 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:46596 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbYEJUw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 16:52:59 -0400
Received: by yw-out-2324.google.com with SMTP id 9so995362ywe.1
        for <git@vger.kernel.org>; Sat, 10 May 2008 13:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=YiA106U6mAPElvdZIk9lOA7FMaOg2dPkWe22VGWZx2k=;
        b=c7lcrgxkJz2ey8RFyfWGvi+LJtKvMag6IzMI5wZKLDprA0L8SFaYDoiA7667yiZs731KHAWQ2fU+qK4pTL2wJ942zNkCi95jzBmt3kTxPHkCXlkmItPyox9D9tdc8kymLAG6NFrs8TWB42+pj03Z0BmtawYwC9G/0hxT/8P4nqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=PKnhTrc8Fi9RAG5mUcPsma9ZD+zdWVRjo19I2jF/0Qr8yQP7Dk3wqWWP/YzPpyIOOOn4PDtPeV4qE1g2XNWEvH+8sFQ4QRHLBR62YBf+z4CFp5PmS4r+R1n1VzauG3+QBFI/WpRipjPZlKavlWMxtJ21SXTNCRFKPX19RNsVRl0=
Received: by 10.150.52.2 with SMTP id z2mr6459951ybz.47.1210452778247;
        Sat, 10 May 2008 13:52:58 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id 9sm5649835yxs.5.2008.05.10.13.52.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 May 2008 13:52:57 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81698>

In commit 5715d0bb60dd90b03519cc436310f3cabe5b9b2a parsing of the '-n'
command line option was accidentally lost when git-repack.sh was migrated
to use git-rev-parse --parseopt. This adds it back.

Signed-off-by: A Large Angry SCM <gitzilla@gmail.com>
---
 git-repack.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index e18eb3f..2ece4fa 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -11,6 +11,7 @@ a               pack everything in a single pack
 A               same as -a, and keep unreachable objects too
 d               remove redundant packs, and run git-prune-packed
 f               pass --no-reuse-delta to git-pack-objects
+n               do not run git-update-server-info
 q,quiet         be quiet
 l               pass --local to git-pack-objects
  Packing constraints
