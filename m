From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/11] sha1_name: improvements
Date: Tue,  7 May 2013 16:55:00 -0500
Message-ID: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 23:56:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZpsN-00083T-Kv
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 23:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699Ab3EGV4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 17:56:39 -0400
Received: from mail-ye0-f177.google.com ([209.85.213.177]:58002 "EHLO
	mail-ye0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab3EGV4h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 17:56:37 -0400
Received: by mail-ye0-f177.google.com with SMTP id q3so246725yen.8
        for <git@vger.kernel.org>; Tue, 07 May 2013 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=/gkmt+TYnQuhtufMPzzs+JdKOauRNn60VCoMxoGEfU0=;
        b=UXhw+RmYCRqhlQOHwv2zRdAKdBMP7kbEH5yv46+gx+8y/qfO4romTNjhEolfzidwVv
         J+voX+wCM4EUn+K4nFvBpkr4Sjbf2TS0MkHvlLLjHj57MbbPgC8CYa1bCge/IROdGByb
         LxngjZNg5dZW4l2H4/ci2/u9v0zyVnnIe0/rUgrg1QM7ysflIcVHe8zNT2lUxv/vXeK9
         qHKeSH3UYVIW60ZQ5gd0OFmBzcwrAmZgp6RmZ27eP5OsuOsUxol3WXzugHuLUQxlbYGo
         l61/98DXNDpr2+HOy1rqL9oPGvIQv16B6Gbeetwkbav1AufHhPP6pF48w6XC8DXqX6YC
         WJdA==
X-Received: by 10.236.132.196 with SMTP id o44mr3862221yhi.37.1367963796508;
        Tue, 07 May 2013 14:56:36 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b70sm7055499yhm.3.2013.05.07.14.56.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 14:56:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223605>

Hi,

While trying to add support for the @ shortcut lots of cleanups arised. Here
they are in a single series.

Felipe Contreras (7):
  tests: at-combinations: simplify setup
  tests: at-combinations: check ref names directly
  tests: at-combinations: improve nonsense()
  sha1_name: remove no-op
  sha1_name: remove unnecessary braces
  sha1_name: avoid Yoda conditions
  sha1_name: reorganize get_sha1_basic()

Ramkumar Ramachandra (4):
  tests: at-combinations: increase coverage
  tests: at-combinations: @{N} versus HEAD@{N}
  sha1_name: don't waste cycles in the @-parsing loop
  sha1_name: check @{-N} errors sooner

 sha1_name.c                | 42 +++++++++++++++++++---------------
 t/t1508-at-combinations.sh | 56 +++++++++++++++++++++++++++++++++-------------
 2 files changed, 64 insertions(+), 34 deletions(-)

-- 
1.8.3.rc0.401.g45bba44
