From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 00/10] submodule output patches
Date: Fri, 29 Apr 2016 17:40:35 -0700
Message-ID: <1461976845-18228-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>,
	Per Cederqvist <cederp@opera.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 02:41:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awIy0-0006bS-M6
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 02:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbcD3Akv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 20:40:51 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33043 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbcD3Aku (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 20:40:50 -0400
Received: by mail-pa0-f45.google.com with SMTP id zm5so57498913pac.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 17:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=d7ByO7NmC9tKBOp4MSpuc0Z5uD71KkSCYDaiDZOE1sA=;
        b=duWJ73UnjRZdmWdoEcRRZ0DdlYBxVOzm99L5H04bpmUgCafrKWnFJbhPAO305dpRXz
         rK9kTVlXHs9/J9dJAzT0Hxxo1sOB0TTfhMr/YdOcWjQ605PTPQpSK2fyj6bWicyOjOBt
         RdU+OIqyfPsDQn677HzR2Bxy6UkgiiAM5xlM9J13PRc4/5wExmoYwYed+n6cm5qddE0Q
         r7DgRG1HaCvSwapoJLXoTEkCZx1FWf4ZJO7Vp1U2AqZkX60DmWihE2dV3L216DsCMKtH
         mtbrPKTfx3YQoN1gpmheXX3wlbu3ae4Mut+LX1tRtwqKORbqJH6Bve06CYSAcLEQQJ9K
         zyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d7ByO7NmC9tKBOp4MSpuc0Z5uD71KkSCYDaiDZOE1sA=;
        b=K0CMAxjmgHmsCHTW3f6OzV05aNX7QVoW2pg4Rw41nj7deUPzxUbZvUcqbu17t+u9Zk
         EkZWnupoJPcsHTgTaLPV37MJzSr1yEcuWOLAoMX7378lV1790QVzKJSuHNCyCzBsl0d+
         A4z+GrEcptKmv1VCXhiE0JLQA05/a3Abvq75F0uU6EnuetFa2ZaJeUvtjvgVc5m2zecD
         x6XOmGepKGCqTisXoVRTjWiLR1f2g2EpUrBtfxlhyAd+ZX33t44T7j6u2/1ATfHBaXmi
         pVgghMC87VqiCD1uf4Vm48U1osXF604rc8nvg1cbm0+j26J1tgfP54ie3ZNMn8m6Aeha
         24oQ==
X-Gm-Message-State: AOPr4FU9vzDBSK54LoLdtD7td+K4KXM2Ym7DW2IAfyMRzmbck/UT8ZsV+olkLfji2sZtlay2
X-Received: by 10.66.145.35 with SMTP id sr3mr33045045pab.82.1461976849302;
        Fri, 29 Apr 2016 17:40:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id d6sm26378703pfj.75.2016.04.29.17.40.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 17:40:48 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293087>

Patch 1 was send outside of a series already.

Patch 2 and 3 are preparatory things for the submodule groups stuff

patches 4-9 are making the output of the submodule command consistent
(similar to patch 3, but I do not foresee a need for it yet)

Patch 10 is a controversial thing I'd assume as it breaks existing users.
We should take it for the next major release (i.e. 3.0)
I just want to put it out here now.

Thanks,
Stefan

Stefan Beller (10):
  submodule deinit test: fix broken && chain in subshell
  submodule deinit: lose requirement for giving '.'
  submodule init: redirect stdout to stderr
  shell helpers usage: always send help to stderr
  submodule add: send messages to stderr
  submodule deinit: send messages to stderr
  submodule foreach: send messages to stderr
  submodule update: send messages to stderr
  submodule sync: send messages to stderr
  submodule deinit: complain when given a file instead of a submodule

 builtin/submodule--helper.c  |  9 +++++----
 git-sh-setup.sh              |  2 +-
 git-submodule.sh             | 21 ++++++++-------------
 t/t7400-submodule-basic.sh   | 38 +++++++++++++++++++++++++-------------
 t/t7403-submodule-sync.sh    |  4 ++--
 t/t7406-submodule-update.sh  | 23 ++++++++++++++++-------
 t/t7407-submodule-foreach.sh | 35 ++++++++++++++++++++++-------------
 7 files changed, 79 insertions(+), 53 deletions(-)

-- 
2.8.0.32.g71f8beb.dirty
