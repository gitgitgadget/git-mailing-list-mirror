From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v5 0/4] Re-rolled merge normalization
Date: Thu,  1 Jul 2010 11:09:48 +0200
Message-ID: <cover.1277974452.git.eyvind.bernhardsen@gmail.com>
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 11:10:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUFmg-0007Bl-V6
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 11:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab0GAJKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 05:10:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51526 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab0GAJKF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 05:10:05 -0400
Received: by fxm14 with SMTP id 14so1009761fxm.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 02:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=KP8XqrT+iIVuAReSDn+OSfCaebSB7FoLdwtEF6hZ+ws=;
        b=Z/CiywMYMVAaTj4S6r8/faLBBAxfyd0w6ZmIV+na4skjtZmyUdbpMwbWhUtFBXUfm1
         h6Hg9hNRHenH5xz9CGD61lj2L+ZnAhdIt/YY2BQ/zWT4G0or/7tjYiPTdfMQeI+Yscru
         6y7K51dKXiQN2aKrfEkX0lkP97CnIZIjVu2Ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CQCMIOcTSnthVP3hXuIQP4AhhM1rTehz7CzJCGgTgLyMrHDtxxkKmmxisCciGx94xy
         hc6k+Y1cfDyz0yknmkqFSIDbX8346JKzEKVzkUPw3VSxZsJkB0tt6DQM9zb6FNvxS46B
         bORrLv11/CIc1z9dYFdbFFuSnuuCvnBc3T3dQ=
Received: by 10.204.81.98 with SMTP id w34mr7236834bkk.29.1277975403190;
        Thu, 01 Jul 2010 02:10:03 -0700 (PDT)
Received: from localhost.localdomain ([62.113.137.5])
        by mx.google.com with ESMTPS id bi18sm11444654bkb.21.2010.07.01.02.10.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 02:10:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc1.4.g09d06
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150013>

Hi Junio,

I took the liberty of re-rolling my series with your improved d/m patch.
I re-added some optimizations to your patch and renamed the config
variable to something a little more typeable.
-- 
Eyvind

Eyvind Bernhardsen (3):
  Avoid conflicts when merging branches with mixed normalization
  Try normalizing files to avoid delete/modify conflicts when merging
  Don't expand CRLFs when normalizing text during merge

Junio C Hamano (1):
  Introduce "double conversion during merge" more gradually

 Documentation/config.txt        |   10 ++++++
 Documentation/gitattributes.txt |   34 ++++++++++++++++++++++
 cache.h                         |    2 +
 config.c                        |    5 +++
 convert.c                       |   37 ++++++++++++++++++++----
 environment.c                   |    1 +
 ll-merge.c                      |   15 ++++++++++
 merge-recursive.c               |   51 ++++++++++++++++++++++++++++++++-
 t/t6038-merge-text-auto.sh      |   59 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 206 insertions(+), 8 deletions(-)
 create mode 100755 t/t6038-merge-text-auto.sh

-- 
1.7.2.rc1.4.g09d06
