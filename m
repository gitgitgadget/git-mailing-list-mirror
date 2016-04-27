From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH] Makefile: remove dependency on git.spec
Date: Wed, 27 Apr 2016 19:54:35 +0200
Message-ID: <20160427175431.GA15178@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 27 19:54:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avTff-0005Zl-Lg
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 19:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbcD0Ryk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 13:54:40 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37284 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbcD0Ryj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 13:54:39 -0400
Received: by mail-wm0-f48.google.com with SMTP id a17so26790077wme.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xn3E1obApCmdlrodTxCs7/J1bHkaXJxpGuO4PciDXz4=;
        b=f10licTpGqZ2IFFGGMSrtxIJbS6e0Z3xCOzFmNtrd+TO4pga0lkJxIrTlMNQ+vFcbl
         th02BHHTdHazZp8r+0Bd48aBn8ubxs24PwoMnoqRkO4jMt/bJoINcr8RDxZ+QqJci9kl
         u6V4KzogchC3V/6nyDLS+l+jSbgPqiRgEL4s/13J69dTi6MfW8ohTKw4h8GkzIy0ANEK
         mSWLtyyZg9BVAYfZQVo9PV2yUZ7sBmRssRW56xqsLQHyvktqAixkV2x1bjcXajJLPRnu
         d7gvgCLLjMrU9PQMH22GdMKfRD4ZlEINGwdbPEfgknmAcWjkT4ZjQEs7DYJcH3Igj/Ck
         KO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xn3E1obApCmdlrodTxCs7/J1bHkaXJxpGuO4PciDXz4=;
        b=TMW3oXFhb+PYdIJVyvEVRq9krIPUinhowXYAY/KS68UISROmUI2I1jNVTlMghyx7wK
         p3jT9Zp/aLgMFyp1Oj25E4t1aw1dYbi26r912f9gltgRbPsSksDorhbVKe5h3ksp6cYe
         0RJPeU87pstgfH1v76uYAiQtyGXh1s1bQPlXSKS92FUMXeGK6G4ScTgGWnWaoNjEWBuI
         wDW74jVxhTCdNeBLOiV3PyP9t2BH8I5ZW1Yfbpfv6fYN22n9qQYTG4BIpSboESYeOHLZ
         ONRkLEo1q52i4qwJvR+O5PY7JVfu1FNECU8/VC3jNYVCcOQ/+DXIgdVLTE+9UcMc225T
         +dsQ==
X-Gm-Message-State: AOPr4FUS3T9Kucwkr2PzLiym/VLBC15YBWp+bETClQq7J/gILZuOy5FoKi0V6I2ajat3lA==
X-Received: by 10.194.201.37 with SMTP id jx5mr10456694wjc.60.1461779677518;
        Wed, 27 Apr 2016 10:54:37 -0700 (PDT)
Received: from spirit ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id gr4sm5204971wjd.23.2016.04.27.10.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2016 10:54:36 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292775>

ab21433 dropped support for rpmbuild using our own specfile by removing
git.spec.in, but forgot to remove the dependency of dist on git.spec.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 23182bc..8083b10 100644
--- a/Makefile
+++ b/Makefile
@@ -2396,7 +2396,7 @@ quick-install-html:
 ### Maintainer's dist rules
 
 GIT_TARNAME = git-$(GIT_VERSION)
-dist: git.spec git-archive$(X) configure
+dist: git-archive$(X) configure
 	./git-archive --format=tar \
 		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
 	@mkdir -p $(GIT_TARNAME)
-- 
2.8.1-387-gd7fd66b
