From: Jonathan Lebon <jonathan.lebon@gmail.com>
Subject: [PATCH 0/4] diff-highlight: make a few improvements
Date: Mon,  2 Nov 2015 21:05:30 -0500
Message-ID: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
Cc: peff@peff.net, Jonathan Lebon <jonathan.lebon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 03:06:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtQzV-00030D-2r
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 03:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbbKCCGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 21:06:25 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36789 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbbKCCGV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 21:06:21 -0500
Received: by qgad10 with SMTP id d10so2283550qga.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 18:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dcWznK4v1BHfR0rn7MiRV9bz+zO6ptsg+padSf/S1ug=;
        b=K55KDi3bX8HsImAtybGnq9/Nkl2VgRbgPyV1bJmiUvFsm5K2ypnbDZek/jsdtxtZrC
         s78fDuOrxmwC6yPZE6u8m5IYCP6oGjrUj3Pi+NaJZI6M4r1NkZFoNI5pn7LEGEP+SSsL
         zmCDG6WPVx7fbxXT0kWHtHOeZJMSVRre6t1CwLIZ0YUZOC1zAp4F0C559/1Gek2Z5SoE
         ka80ZqhZJR7uWM47ps9zzwXzP+tlZj9vcxXUxbRXvCtF2sUBn+BXxhBfkqG5DKVqh8Ah
         KY06aReetAgR/6nk9HMMtwKJLILtlPBKSbjIjVuk+HQLkYYC5q1BNhUydoHnxlQ8Zi5u
         g+QQ==
X-Received: by 10.140.98.183 with SMTP id o52mr33329056qge.70.1446516379962;
        Mon, 02 Nov 2015 18:06:19 -0800 (PST)
Received: from vostro.yyz.redhat.com ([38.104.156.250])
        by smtp.gmail.com with ESMTPSA id s21sm9013447qkl.36.2015.11.02.18.06.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 18:06:19 -0800 (PST)
X-Mailer: git-send-email 2.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280742>

These patches bring a few improvements to the contrib/diff-highlight
Perl script. The major improvement is done in patch 3/4, which improves
diff-highlighting accuracy by implementing a recursive line matching
algorithm.

Please note that I have limited experience with Perl, so there may be
better ways to do things. (Let me know if that is the case!)

Jonathan Lebon (4):
  diff-highlight: add `less -r` to cmd in README
  diff-highlight: factor out prefix/suffix functions
  diff-highlight: match up lines before highlighting
  diff-highlight: add maxhunksize config option

 contrib/diff-highlight/README         |  87 +++++-----------
 contrib/diff-highlight/diff-highlight | 189 ++++++++++++++++++++++++----------
 2 files changed, 161 insertions(+), 115 deletions(-)

-- 
2.6.0
