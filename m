From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/3] submodule--helper: Have some refactoring only patches first
Date: Mon, 31 Aug 2015 12:19:24 -0700
Message-ID: <1441048767-29729-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 31 21:19:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWUcB-0003Ij-VS
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 21:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbbHaTTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 15:19:31 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34571 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbbHaTTa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 15:19:30 -0400
Received: by pabzx8 with SMTP id zx8so148515294pab.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 12:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Unql5FjZQXqm2OwMLZP1Ybx94RLIc6zFZKKAkuJeypU=;
        b=Iv+MARQu8U6HPUdr/XY+8iVkib9LOfJda0mVjpAYwmllwz5Qtbi0IITL+30K/aonwp
         GapktDP7zz0V1UpG2olTu0wYSqXkIagHoGCZMxzH1r5V9fIEaARvigJfmXm1M79oX013
         S84C1QCWQp6U2VvLe0yKWd3wa6yiFkhXisopEyUVhlUkDghhs2mDUAPNHhkQFPoCfmiY
         VSwAQ0IIjpcyVg1lLHql7VBF4xdpFy8ze6t4uyChOAe0FgPZgEilZbKF7UBsQ6BbjIB0
         7/yru8D1apY+Y86eTThvPyG7nMJQZoHZn525dK2LcNHwxeM0WZFX0OOqGT8awzgND1kj
         Nazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Unql5FjZQXqm2OwMLZP1Ybx94RLIc6zFZKKAkuJeypU=;
        b=krJRwMNhgke68ge49NRz3R+S/A9BW+otz8MRVvXLMDFNqwpygCXBrTDqUk9mlS/G2o
         F4hUEHG1lIqyzvbH9ekhrszRysAk/+zBv5kJZY+pyqcS65nwLAKQ669Qfq4EW6qsMzSL
         IjHMxvDs6NWYCIT9p+YDj6N6Rae6nsOkKtng7ic0U1g5GLe9Oq0vVPhItBPa5ITkDO1q
         Ibo05h4qBzh84h6DT3e9GP2p6to4OanrS2yDzpfSdB9KvWfsy2NASfUus1IxvniiiD7J
         uXpPHZprRO678FGYwAGEUB1qnHkAmQMn714nyVZRCrh1JKsPeqS3UwBwKlB+dsHpHdkq
         dEXw==
X-Gm-Message-State: ALoCoQncsqUKuMBNa+Vt4PlnemNEivWGyQhz2ltMXl2L+N+pRw5aqdcQIGA9pgtpvv80KxDLPe+8
X-Received: by 10.66.255.42 with SMTP id an10mr39330182pad.107.1441048769908;
        Mon, 31 Aug 2015 12:19:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:25db:53e9:3895:b743])
        by smtp.gmail.com with ESMTPSA id hm7sm15461721pdb.24.2015.08.31.12.19.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 12:19:29 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.geed6e44.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276917>

This patch series is the first part of the larger series I sent daily last week
and contains only those patches which have had good review by Jeff, Dscho
and Junio doing only internal refactoring, not introducing any parallelism yet.
It replaces all patches on top of (5a1ba6b48a62b,
Merge 'hv/submodule-config' to 'sb/submodule-helper')

Changes are only small nits:
 * whitespace correction in free((char *)pointer);
 * break a long line,
 * git submodule--helper -h adheres to the standard help output
 
One of the mistakes I made last week was mixing these quite stable patches
with highly RFC/WIP patches and not pointing out loud which is which.

Thanks,
Stefan

Stefan Beller (3):
  submodule: implement `module_list` as a builtin helper
  submodule: implement `module_name` as a builtin helper
  submodule: implement `module_clone` as a builtin helper

 .gitignore                  |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/submodule--helper.c | 286 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 166 +++----------------------
 git.c                       |   1 +
 6 files changed, 306 insertions(+), 150 deletions(-)
 create mode 100644 builtin/submodule--helper.c

-- 
2.5.0.264.geed6e44.dirty
