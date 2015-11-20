From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2] check-ignore: correct documentation about output
Date: Fri, 20 Nov 2015 21:30:48 +0100
Message-ID: <20151120203045.GA16353@spirit>
References: <1448051381.6899.2.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 21:31:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzsKe-0004eb-VK
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 21:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760241AbbKTUax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 15:30:53 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33656 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760128AbbKTUaw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 15:30:52 -0500
Received: by wmec201 with SMTP id c201so87930367wme.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2015 12:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=9qFzFrkkYcQGK/euP5RrlOZM/LhGghSAb0WrGIN4WPg=;
        b=OoMBA1WbQQeVQhzXcAVqO90fo3Cm2K0jhSa03LZSG700t/6NIn/8tcbWg4dKjQBaR7
         6BgIMi6LpT5wGvVvpwjcr9R5p1LB0a74A+j9kqfjg1OYorX2wqh5bjFlV+UWZkjlVDcd
         Nu4DH7GAQwi+82/NSSmGjXqCxP1JVOUkrI9yMfB2JERzqoTqxtjX36qqcOe15nQL+Ijh
         csQySwSCLI2P0q6LO8ak+b0eSS+/6y5xDXwhVKKadXdUgCyNoJ/T0daRjNskIB3rcyZU
         Lo2HiMetSvZ2dLIfXUO4jGDs/awuceLJpDaLBA2C65g2ZbPgTuXxs/kH1+ghOf6wHldC
         +y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9qFzFrkkYcQGK/euP5RrlOZM/LhGghSAb0WrGIN4WPg=;
        b=UP/jBtgttOs3sPoKyBnZo55ldZQX7tmfRnJYO8GSCyFq844/eI7g/7eDrNswOJ/Hhi
         8e4To42Y7kK//SrMeTblZneUZsb5pm3tCGEPYaXdcMc/lFK6iNuoZSWNZgm5PUa/x3WI
         HSyHzz7wWyU1VUS+NZmkrknURigDVC58R+cZlGYqTpOSiuUsJ7eFzVJizHfPtTo5qyz4
         0k4wZeK2bZ3RHtgvuSW0fBqSTu37/NCtbORf1NgcQcB8LiXDpUvCwDcX3G3T5svt92Qq
         n6flu89aF1J1ipekw6RPEDKqD253plMOKJ/o7bp5YNVosLgrUH0NfF1kXjoN5VhAzEXh
         hh4w==
X-Gm-Message-State: ALoCoQnRBSOxXEmxQ8GyXhf7Ois8muctVTLArqbPIYvtnJqMCH9JaytFTVC13RNYxmYQAu19FqDp
X-Received: by 10.28.18.138 with SMTP id 132mr4595559wms.6.1448051450970;
        Fri, 20 Nov 2015 12:30:50 -0800 (PST)
Received: from spirit ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id t64sm1064873wmf.23.2015.11.20.12.30.50
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2015 12:30:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1448051381.6899.2.camel@kaarsemaker.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281531>

By default git check-ignore shows only the filenames that will be
ignored, not the pattern that causes their exclusion. Instead of moving
the partial exclude pattern precendence information to the -v option
where it belongs, link to gitignore(5) which describes this more
thoroughly.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 Documentation/git-check-ignore.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 59531ab..e94367a 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -16,10 +16,9 @@ DESCRIPTION
 -----------
 
 For each pathname given via the command-line or from a file via
-`--stdin`, show the pattern from .gitignore (or other input files to
-the exclude mechanism) that decides if the pathname is excluded or
-included.  Later patterns within a file take precedence over earlier
-ones.
+`--stdin`, check whether the file is excluded by .gitignore (or other
+input files to the exclude mechanism) and output the path if it is
+excluded.
 
 By default, tracked files are not shown at all since they are not
 subject to exclude rules; but see `--no-index'.
@@ -32,7 +31,8 @@ OPTIONS
 
 -v, --verbose::
 	Also output details about the matching pattern (if any)
-	for each given pathname.
+	for each given pathname. For precedence rules within and
+	between exclude sources, see linkgit:gitignore[5].
 
 --stdin::
 	Read pathnames from the standard input, one per line,
-- 
2.6.3-495-gf0a7f49


-- 
Dennis Kaarsemaker <dennis@kaarsemaker.net>
http://twitter.com/seveas
