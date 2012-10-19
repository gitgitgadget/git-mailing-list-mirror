From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] gitk: fix --full-diff handling
Date: Fri, 19 Oct 2012 12:56:51 +0200
Message-ID: <1350644213-4882-1-git-send-email-felipe.contreras@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 12:57:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPAGT-0006KT-9q
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 12:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757769Ab2JSK5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 06:57:04 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39447 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756675Ab2JSK5C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 06:57:02 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so154468bkc.19
        for <git@vger.kernel.org>; Fri, 19 Oct 2012 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=gnSz7t1R4JqXVCQ+vWaPrX8KfTVSI23CWs8mYWgZinE=;
        b=eBltl2CxDh7HE+Ys86qQ6i5i03IQMZ/Rgd5tE5e4G6F3SYZKz01q0fuN/wuEZUzT+/
         hQwVUq5/718f26kHtuNMRA4FSKZIDGloOOl+HtCGAtPYcxL9o3bG/SfefJ4KZ8hsyyPL
         ii6zOQXk2kWWkdYmu/4RbNHfdOanbTxZmQWLDTFD/fkPtbpDgUU+YLFtAfXfmFBllgZX
         XRqi1BmfOQGOczM62cZWb0ZO15jNGCnJ/nqswOqWwjtYymVbi92MHNHLzVqZB8MOpujq
         HdrAJkRAZrFAC6aED5zrrDbveavePeX2aYZHXsgNhXExRPNylkxFy4I1W32bBnewKrv7
         cR9A==
Received: by 10.204.11.70 with SMTP id s6mr272637bks.63.1350644219811;
        Fri, 19 Oct 2012 03:56:59 -0700 (PDT)
Received: from localhost (ip-109-43-0-103.web.vodafone.de. [109.43.0.103])
        by mx.google.com with ESMTPS id ht18sm683055bkc.14.2012.10.19.03.56.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Oct 2012 03:56:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc2.7.g0961fdf.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208042>

Hi,

I find usel to do 'git log --full-duff -- file' to find out all the commits
that touched the file, and show the full diff (not just the one of the file).

Unfortunately gitk doesn't honour this option; the diff is limited in the UI.

The following patches fix that.

Felipe Contreras (2):
  gitk: simplify file filtering
  gitk: handle --full-diff correctly

 gitk-git/gitk | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

-- 
1.8.0.rc2.7.g0961fdf.dirty
