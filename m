From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: git smart-http do not authent to allow git ls-remote to be called anonymously
Date: Sun, 30 Sep 2012 22:35:35 +0800
Message-ID: <CAHtLG6Q+XO=LhnKw4hhwtOe2ROeDN1Kg=JN5GTQqdvYjk-Sv4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 16:35:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIKcV-00044B-Q7
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 16:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225Ab2I3Ofh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 10:35:37 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45395 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797Ab2I3Ofh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 10:35:37 -0400
Received: by lbon3 with SMTP id n3so3319683lbo.19
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=rVH0CKI28EMekYBbQhbUqb1/Ol9b4JwAF7eGUQet1x4=;
        b=oYkGANLzbt/1At2fb7+mjcDUoVl/utW6TPKqEqgJuBr4YWHnE1E2PtwCJsKQI+JREL
         vhvK8S9ItmhaxRfnQCuS/hMYVGZSq4S/qMeBOWY0p+cu7c5yS+djbBwfqtF/PxJa4tZv
         XG0m69BWWMPDA027tjuLUiSroUVlCTKgSFfmdovEF8zMUxk+Rj7jifY2jNkw8NcZWHCX
         h1tzSnZy7y38kX1WGcqpP88F3a33DzBute80lTF8aRzJTS2W4uC6qlCvN/D+Fg3v6q5J
         efCHCoQmXQfD3eKtzb0tOGyt/IK71K/AdiHXia6xxfxMNDVC9Hf6cTC2gBZVTOVto9XI
         0JQw==
Received: by 10.112.82.103 with SMTP id h7mr334612lby.50.1349015735612; Sun,
 30 Sep 2012 07:35:35 -0700 (PDT)
Received: by 10.112.19.35 with HTTP; Sun, 30 Sep 2012 07:35:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206687>

Hi,

I use smart-http on Apache.
If nothing to be pushed / pulled, I do not want password to be
supplied. And allow git ls-remote to run without password

*.git/info/refs?service=git-upload-pack
*.git/info/refs?service=git-receive-pack

I only need authentication on

*.git/git-upload-pack
*.git/git-receive-pack

/etc/apache/httpd.conf

<LocationMatch "^/git/.*/git-(upload|receive)-pack$">
    AuthType Basic
    AuthName "staff only"
    AuthUserFile /etc/apache/apache.pwd
    Require valid-user
</LocationMatch>

However this does not work. It does not ask for password at all.

I use Ubuntu 10.04, Apache 2.2.14, Git 1.7.11.3.

Directory structure: any depth (more than 1 subdir) of path from /git
to .git folders

Could you advise how to configure this? Is this a bug?

Regards,
ch3cooli
