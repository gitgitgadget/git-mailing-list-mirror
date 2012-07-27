From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 0/2] Small log simplifications
Date: Fri, 27 Jul 2012 10:21:37 -0700
Message-ID: <1343409699-27199-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 19:21:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuoEb-0006s8-Lr
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 19:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab2G0RVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 13:21:48 -0400
Received: from mail-vb0-f74.google.com ([209.85.212.74]:51268 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab2G0RVq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 13:21:46 -0400
Received: by vbnl22 with SMTP id l22so353773vbn.1
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=08fwdknJsxWx6t79hPi0ZL/Qd5FDY3L4R8AWCqdDuHc=;
        b=ArKsADRRowPU/uajT9h+5m//TbusZPYB51mry3Ya7EQPwtN5P7RVd6+uzgdijuyHlg
         FzbeNuWOisdDCHY/Z//QrytxxvtBS2RsEtxZOLaO1B3AsJsZznND1vEqOky7zkuT/JfG
         +YgcxQRG+GV80upai4xXBM0RpgvCOkaKyqHZHMjD1ifGHMEYqnGb4b4vqA/XESUCnqG+
         Zv8gIWxMa5w8SrT5Ds9NUQEmDyvXnGla8il6ZEHXJgmfWRbTcfDen3MwYqa7zXArirjs
         SHYEl8MwPVRtuXnLvjfBhfMnG//dmR8PvRsaAV+UmWSfTImAUfIFw/H2m0DssgrCOh2e
         KaVQ==
Received: by 10.236.88.111 with SMTP id z75mr1608113yhe.6.1343409705575;
        Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
Received: by 10.236.88.111 with SMTP id z75mr1608109yhe.6.1343409705542;
        Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id n2si259732anp.3.2012.07.27.10.21.45
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 6EC32100047;
	Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 123EBC14F1; Fri, 27 Jul 2012 10:21:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
X-Gm-Message-State: ALoCoQnQNHekCRk9mjY+UHdB3+C5svVCuhuKQVh2SSXe5liRi60DPt7FT9QHoWEsCTMAkBiFVznEGjKr9i8oFflgjzuZVhxSUagfKk5O3vqGmV8YGlIHWB6PbgbIKRFhUjKeNNSggNCi158zy9jmCVnh43yZoaQUqmZPhxTJ7nUhnuB9hFhA4vxcEJmajK5ipb5WZxmIh5rv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202361>

These are just some things I noticed while looking at the revision
walking code. I'm not very familiar with the code at all, so the
patches may very well be completely wrong; view them as newbie
questions in patch-form if you like.


Martin von Zweigbergk (2):
  remove unnecessary parameter from get_patch_ids()
  log: remove redundant check for merge commit

 builtin/log.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

-- 
1.7.11.1.104.ge7b44f1
