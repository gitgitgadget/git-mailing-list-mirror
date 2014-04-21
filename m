From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 0/2] peroper align of datetime filed of git-blame
Date: Mon, 21 Apr 2014 14:02:02 +0800
Message-ID: <cover.1398059411.git.worldhello.net@gmail.com>
References: <7vbnvvllx4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Brian Gesiak <modocache@gmail.com>, Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 08:02:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wc7JK-0006Oj-PB
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 08:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbaDUGCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 02:02:30 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:48688 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbaDUGC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 02:02:28 -0400
Received: by mail-pa0-f44.google.com with SMTP id bj1so3392299pad.17
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 23:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=C9TQFHVZxCWMXB7TVxxw2CztOFsLE8Ba+mU7E25mTMo=;
        b=ISm2bujceU0gOSF2fWvkVviF8u7jgMVAbmZDQjYIkt5ilZD261S+v2BuQlQRDdlOJP
         WbYLjoZIsYBlS6EJABqT36NLQYZdhsqSINX+uq5cwpbxehNRomoxaO9ovwKzdVnz7xhQ
         tE0meV5K1v/IBX/ttiJK3EEIZbXgGKQNENC6wr0M+IHGzSlhgWDqyQrbX6+bGA+e9MDS
         LQeGLMKzoP6jzCnk59k87TFYmY3Sx2vU0bwmgp1xJgOJtCE7RXVUl1T17Q8ZcyA/6xe8
         kG3ZQx3SOQegZt04vnzGccZnuTyEfPnSDjwoWzvLpspqE+NCJ8DCg+o9mebQRP3K3a/Y
         32Jg==
X-Received: by 10.68.193.100 with SMTP id hn4mr36351186pbc.50.1398060148277;
        Sun, 20 Apr 2014 23:02:28 -0700 (PDT)
Received: from localhost.localdomain ([124.207.10.6])
        by mx.google.com with ESMTPSA id vx10sm181140376pac.17.2014.04.20.23.02.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Apr 2014 23:02:27 -0700 (PDT)
X-Mailer: git-send-email 1.9.2.476.ga74def0
In-Reply-To: <7vbnvvllx4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246606>

Changes since v2:

 * Fixed typos in commit log 1/2. Thanks, Eric.

 * With the help of Junio, write a helper to get suitable blame_date_width.

Jiang Xin (2):
  bugfix: fix broken time_buf paddings for git-blame
  blame: use a helper to get suitable blame_date_width

 builtin/blame.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 8 deletions(-)

-- 
1.9.2.476.ga74def0
