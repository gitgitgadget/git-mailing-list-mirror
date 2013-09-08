From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 0/5] branch: Fix --track on a remote-tracking non-branch
Date: Sun,  8 Sep 2013 22:58:10 +0200
Message-ID: <1378673895-23127-1-git-send-email-johan@herland.net>
References: <1378464042-17476-1-git-send-email-johan@herland.net>
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Per Cederqvist <cederp@opera.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 08 22:58:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIm3z-0002xK-9o
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 22:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab3IHU60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 16:58:26 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:61718 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab3IHU6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 16:58:25 -0400
Received: by mail-la0-f52.google.com with SMTP id ev20so4259461lab.39
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 13:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KCrjgh4xhi04xRn4SQXpVGmX/gmi7EEPWae2QSHIJ28=;
        b=dzBeE9VThJWIzJVRBrFdXbyJzSeFqN2ky7VN9nkwedx1SUb0ljlbbL7hKPA9cvggzH
         qkbcdvMhlGUnquOJGQp42zYpyPbopZB1ndD3BfJP6XNNl9/XO7ijMIvoBAWAr8dbK+DU
         jv/tYBZEH27efOP0KeLP2gW5AGCf3kQtOys3B4NGvyHri35miHGgFXixd9BxxirnblAT
         Yv5XrGa66qHNHPzE7kTVpBHbzOy8b+HAn8f1m1pqv9Uclz86dfciCxDJ/+q7kE9jN8hG
         WcBci++/+7H3tqUJbz5Fa7BQjQNd8AgH+jBmk52TngjCkFfChtflzcAWcj2/bRfUHyDh
         HDtg==
X-Received: by 10.112.42.103 with SMTP id n7mr13368256lbl.6.1378673903931;
        Sun, 08 Sep 2013 13:58:23 -0700 (PDT)
Received: from beta.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPSA id vo1sm4292384lbb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 13:58:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1378464042-17476-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234266>

Hi,

Here is the second iteration of this series. Only one change from the
first iteration: The first patch now also fixes some missing &&-chaining
noticed by Junio in t2024.

...Johan


Johan Herland (4):
  t2024: Fix &&-chaining and a couple of typos
  t3200: Minor fix when preparing for tracking failure
  Refer to branch.<name>.remote/merge when documenting --track
  t3200: Add test demonstrating minor regression in 41c21f2

Per Cederqvist (1):
  branch.c: Relax unnecessary requirement on upstream's remote ref name

 Documentation/git-branch.txt |  6 ++++--
 branch.c                     |  3 +--
 t/t2024-checkout-dwim.sh     |  6 +++---
 t/t3200-branch.sh            | 37 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 44 insertions(+), 8 deletions(-)

-- 
1.8.3.GIT
