From: "Thomas \"Enki\" Badie" <thomas.badie@gmail.com>
Subject: [PATCH] git-add--interactive.perl: Remove two unused variables
Date: Sun, 24 Jun 2012 23:37:34 +0200
Message-ID: <4FE7889E.2020009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 23:37:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiuVG-0006mt-By
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 23:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab2FXVhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jun 2012 17:37:39 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63073 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab2FXVhi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 17:37:38 -0400
Received: by eeit10 with SMTP id t10so1008618eei.19
        for <git@vger.kernel.org>; Sun, 24 Jun 2012 14:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=9i7XG0ZKBljT1nksIQ1DVoUFcXLxGM5BQbTsPbwCh0E=;
        b=Xi2bvnPuO1AKOiLEIEh/AyQb/l4uxORh4pJgkFUbIFz+4WytjDg7rYbszWlkChUeMl
         Qv84w3Xd8hZKR97L2efFGkxT5JPrDp1JNWIt2D8RYxsmzxrON0hP/sk8yzwlxexTeIr4
         pIugFw0shnydOteuclKi4tZJGvYz4arhmeOnlq78K/MiUplI+xd070FcGSmlODdE2AQw
         38vFRkuCYpD48bj4S367lugOHnSy1HR17aTDjHb9t+YJQwEs3GFr3TLyFdER4bpTeJve
         mYYIG+Tv2MKOvWOS4sBWF3daq+N/qjTosScWVBdL+tcs1IMUCPM0O99A6M3P6uXfjKlB
         hIOA==
Received: by 10.14.27.201 with SMTP id e49mr1856262eea.230.1340573857180;
        Sun, 24 Jun 2012 14:37:37 -0700 (PDT)
Received: from [192.168.0.12] (mna75-12-88-165-241-47.fbx.proxad.net. [88.165.241.47])
        by mx.google.com with ESMTPS id g46sm132469449eea.14.2012.06.24.14.37.35
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Jun 2012 14:37:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200540>

The patch 8f0bef6 refactors this script and leaves the `$fh' variable
unused in `diff_applies' and `patch_update_file'.

Signed-off-by: Thomas Badie <badie@lrde.epita.fr>
---
Hello,
This is my first patch. It introduces a really minor change, and I
also want to be sure the way I submit it is the right way. Thanks :)

  git-add--interactive.perl |    2 --
  1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index d948aa8..710764a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1067,7 +1067,6 @@ EOF
  }

  sub diff_applies {
-       my $fh;
        return run_git_apply($patch_mode_flavour{APPLY_CHECK} . '--check',
                             map { @{$_->{TEXT}} } @_);
  }
@@ -1514,7 +1513,6 @@ sub patch_update_file {
        }

        if (@result) {
-               my $fh;
                my @patch = reassemble_patch($head->{TEXT}, @result);
                my $apply_routine = $patch_mode_flavour{APPLY};
                &$apply_routine(@patch);

-- 
1.7.5.4
