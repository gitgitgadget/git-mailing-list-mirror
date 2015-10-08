From: David Turner <dturner@twopensource.com>
Subject: [PATCH 0/1]  merge: fix cache_entry use-after-free
Date: Thu,  8 Oct 2015 14:47:50 -0400
Message-ID: <1444330071-8909-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 20:48:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkGEU-0006pA-Q4
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 20:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632AbbJHSr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 14:47:58 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34853 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbbJHSr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 14:47:57 -0400
Received: by qgt47 with SMTP id 47so50016306qgt.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 11:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3ZVu/2Ab4/WioIsui/lcEN1rirXi1MPrExOdL9KMBGY=;
        b=Dfz1rZ9fiKD2k4I+F60/MKodzMmlnXdbeYwAXviHYZIq2ZMfxaYEB/WBDJUn3t+7WO
         IR+KrWEdZBzBOILSiLtcsCHbXKZsLY8mVu7wUyY/4k/y5dF2nleZcL4SAX/llpHB8DlN
         uZT3Nuq7w2VSGF/0xnIj0ImWU68TG5lPGMadtyTKx1s21bhixlVCxlD5/hJfcWRewi8S
         4dFmuhZWpwFe8Z0o1K8yqOgJdMnFmDK8vH3ieRYb50qqx18Q3ZT2puCTAMfqbYNdvw/n
         FRenhngfhLaF3ZkNyLh9bY9vdzGUkBWjQqu1pYy6JL98JhRm9dqeE2CrwnCX3IIjhT6V
         137A==
X-Gm-Message-State: ALoCoQkllMUNyjOwb+MF3JHdEo9oEKedPUSXzB0noNINvml2Jq62hP1WLoXmMeJKXgRou+WhzlAg
X-Received: by 10.140.85.135 with SMTP id n7mr10045334qgd.53.1444330076372;
        Thu, 08 Oct 2015 11:47:56 -0700 (PDT)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id e51sm19234094qge.46.2015.10.08.11.47.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Oct 2015 11:47:55 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279257>

Keith diagnosed the problem and wrote the patch.  I wrote the commit
message and am sending it upstream with his OK.

Keith McGuigan (1):
  merge: fix cache_entry use-after-free

 cache.h        | 27 +++++++++++++++++++++++++++
 name-hash.c    |  7 ++++++-
 read-cache.c   |  5 ++++-
 split-index.c  | 12 +++++++-----
 unpack-trees.c |  6 ++++--
 5 files changed, 48 insertions(+), 9 deletions(-)

-- 
2.4.2.644.g97b850b-twtrsrc
