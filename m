From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/6] Support triangular workflows
Date: Wed, 20 Mar 2013 18:14:55 +0530
Message-ID: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 20 13:44:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIINR-0001ft-Cb
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334Ab3CTMny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 08:43:54 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:62266 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384Ab3CTMnx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:43:53 -0400
Received: by mail-pb0-f42.google.com with SMTP id xb4so1330042pbc.29
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=/d8J9Ab1i0xzdpoE0TFNIznfzb7Pelccjthi5jxXaaA=;
        b=R5FnfcNlgzjuEBDP2na6DYlNm++yxPFuw4sEsO5EU1AbzBcRiRpF01k/prx32bJI1j
         XyxLTrIk7ly0tDHRgdrdSUNUrlfnQ9NTbBXtdu2OOUYvfzinF90lMHRoLCCz9bKl+aZs
         Q/KwRqrKOrYqdPnkdj1xTxygSZLYV4eXqVrCs7BcqUNGZHfurGMf9gw+A4hsZqo+Vg4f
         GOWsTh+LIcS75OOip1x2YCcLEn/SJFiSZbdvf14PCdC6OpxBj+OB3Obb6vk8f+IL9oy4
         6ylMgfmrDbWI4ys3Q5dDe2aCtcxmKGq+cOAtnpPAi2VazuqsxDDtRSACovJNdqsHNGpC
         c4FA==
X-Received: by 10.66.13.10 with SMTP id d10mr8991692pac.53.1363783432807;
        Wed, 20 Mar 2013 05:43:52 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id y13sm2031559pbv.0.2013.03.20.05.43.49
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 05:43:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218598>

This follows-up [1], with three important differences:

1. pushremote_get() and remote_get() share code better.  Thanks Jeff.

2. All spelling mistakes have been corrected.  Thanks Eric.

3. One new test for each of the new configuration variables.  The
extra two parts [2/6] and [3/6] preprare the file for introducing
tests.  However, I've not gone overboard in this preparation; I don't
replicate the work done by Jonathan in [2].

Thanks for reading.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/218410
[2]: http://thread.gmane.org/gmane.comp.version-control.git/218451/focus=218465

Ramkumar Ramachandra (6):
  remote.c: simplify a bit of code using git_config_string()
  t5516 (fetch-push): update test description
  t5516 (fetch-push): introduce mk_test_with_name()
  remote.c: introduce a way to have different remotes for fetch/push
  remote.c: introduce remote.pushdefault
  remote.c: introduce branch.<name>.pushremote

 Documentation/config.txt | 23 +++++++++++++++---
 builtin/push.c           |  2 +-
 remote.c                 | 36 +++++++++++++++++++++------
 remote.h                 |  1 +
 t/t5516-fetch-push.sh    | 63 ++++++++++++++++++++++++++++++++++++++++--------
 5 files changed, 104 insertions(+), 21 deletions(-)

-- 
1.8.2
