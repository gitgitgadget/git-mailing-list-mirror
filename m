From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/6] transport-helper: some clarifications and a fix
Date: Wed, 17 Apr 2013 19:05:18 -0500
Message-ID: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 02:06:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UScN6-0006rP-Ik
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 02:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899Ab3DRAGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 20:06:36 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:57499 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab3DRAGf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 20:06:35 -0400
Received: by mail-yh0-f41.google.com with SMTP id q11so364492yhf.14
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 17:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=4JuedV4hUX/XUoLyRnAWXYl8EzmvTHx86F4frRdWNYE=;
        b=nOnjQRVFNNgxMbKqXBBLZJHBDD0O9s5dDLaEkuhvFnYVfZKAfEmDj4LWmqUooe3gKy
         WTj82UY8nKrIvGPTvHjD+ueK3UpJG2Xl7EGAKbtrBTHV7swNE8gCSqb6Qmcl7GwVyF0l
         sdwZPq7UBCMbPASc2vUsQp5/uloHUQcDmB6K1GgKf9hYtDR07oUuDwWoJa5D1TrZNbRl
         MWmz0M2FOHwWJC7mDQJih/gZDdebKKHIuXdZsxBgTobNonPLJ+slneGAGSruFsYh1/OA
         ANMVrbdnV2AMnAos7UFHuWb37JZmiWui4oyw7DoJdrbHhFCvnq+6ZoM96wVwpdlkwhD5
         TuoQ==
X-Received: by 10.236.191.33 with SMTP id f21mr5593259yhn.119.1366243594781;
        Wed, 17 Apr 2013 17:06:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id s45sm13028990yhk.22.2013.04.17.17.06.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 17:06:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.679.g509521a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221587>

Hi,

It seems the workings of transport-helper are anything but clear, so let's try
to clarify them a bit, and after that, hopefully it would become clearer why
the last patch is actually a good fix.

Felipe Contreras (6):
  transport-helper: clarify *:* refspec
  transport-helper: update refspec documentation
  transport-helper: clarify pushing without refspecs
  transport-helper: warn when refspec is not used
  transport-helper: trivial code shuffle
  transport-helper: update remote helper namespace

 Documentation/gitremote-helpers.txt | 12 ++++++------
 t/t5801-remote-helpers.sh           | 39 ++++++++++++++++++-------------------
 transport-helper.c                  | 37 +++++++++++++++++++++++------------
 3 files changed, 50 insertions(+), 38 deletions(-)

-- 
1.8.2.1.679.g509521a
