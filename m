From: larsxschneider@gmail.com
Subject: [PATCH v1 1/2] travis-ci: enable Git SVN tests t91xx on Linux
Date: Thu, 19 May 2016 11:10:08 +0200
Message-ID: <1463649009-56941-2-git-send-email-larsxschneider@gmail.com>
References: <1463649009-56941-1-git-send-email-larsxschneider@gmail.com>
Cc: e@80x24.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 11:10:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3JyJ-00045c-3U
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 11:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbcESJKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 05:10:17 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34581 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932668AbcESJKO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 05:10:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so19282263wmn.1
        for <git@vger.kernel.org>; Thu, 19 May 2016 02:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3eVi2pWE/fr0fzHmxmYmY8XD2nVhkPvLtZMqGqOz+2Y=;
        b=I8jGORaiFz2pfWcvBPHkpm/Jj3gzHR/3SK/2YIHYB8BspMWlAfpqvsCdSlgx1m7UhI
         oHjjtv7pTUiaqwgVfGLPAn4OLfdU69EkVBoV2zdttS0NzhXTZklNQ8ubtIlIjTRZjg69
         EjMuDtTxPETwIgHkvFbEyVeEA+HL+f9iTbIF3MwtqVVW3MBvjWt5A223PwyTvOicDsSC
         Mow0KCEj4ankw3eVPtxup/hSpbzBebfAebQv6R2cwVdvDB0Zzoh8mW2vZW9QZsLpFt7M
         phKdgyxP0gv0EIKX1mqhdf5hvEUZNkdNVcp/gzuVjDh+mavsTLUyP8tNDefCMXMCb47W
         5BuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3eVi2pWE/fr0fzHmxmYmY8XD2nVhkPvLtZMqGqOz+2Y=;
        b=dWCkuEZAsxFSnhVI87QoHqlVpqCBNeyG4Jt5303YOtRdNUCKtohxpRr2hvh+Zkf1AA
         SfFDYRLUvHFfI9dyFDeQ1aTiefyWcCX0tPpVT3dk4vUyA2eg9hzVbqSedeyi3JLuzIyU
         U4pxN8fQkQoEzVUwDw9bt++WzoNGuTgHycArE9QvhEisyZkHBqAnfkn2GugKDYiGl2pn
         amnTwlLG6rUxmB4XW7f/MzAb9ygyV8v59TjnYHPcV0ACmKbJ51zcNcoozdGIOWoctawL
         CTLOdmN+Rs/nz+NDLh0ZD8wT4JWdRJCamhjDYGJwUEZfGcuZzSOvGBAfzA9f0FS2Cdi9
         dQmw==
X-Gm-Message-State: AOPr4FVZeM+5CpzJcmoOHXu0WoRH6B98Rz4nkb332C703YfNjngGbM8zAIw/SuHso0U9/g==
X-Received: by 10.28.1.151 with SMTP id 145mr1395585wmb.25.1463649012984;
        Thu, 19 May 2016 02:10:12 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB7732.dip0.t-ipconnect.de. [93.219.119.50])
        by smtp.gmail.com with ESMTPSA id n66sm13716029wmf.6.2016.05.19.02.10.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 19 May 2016 02:10:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1463649009-56941-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295048>

From: Lars Schneider <larsxschneider@gmail.com>

Install the "git-svn" package to make the Perl SVN libraries available
to the Git SVN tests on Travis-CI Linux build machines.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index adab5b8..c20ec54 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -18,6 +18,7 @@ addons:
   apt:
     packages:
     - language-pack-is
+    - git-svn
 
 env:
   global:
-- 
2.5.1
