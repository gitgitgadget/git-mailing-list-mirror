From: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
Subject: [PATCH/RFC 0/2][GSoC] revision.c: Allow "-" as stand-in for "@{-1}" everywhere a branch is allowed
Date: Mon, 16 Mar 2015 11:11:41 -0400
Message-ID: <1426518703-15785-1-git-send-email-kenny.lee28@gmail.com>
Cc: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 16:12:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXWgz-0000sc-MN
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 16:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934196AbbCPPMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 11:12:22 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:34445 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191AbbCPPMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 11:12:09 -0400
Received: by qcaz10 with SMTP id z10so46367676qca.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 08:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=N29kU/YYkBHVdhLf90AhlcIAl1EaR9cQkv22bXpY0mA=;
        b=LV+aJ9xpR3wUFSAiJyexJj+8sAzAkL/RByqL5USraml9COl2Q+uh8nqMojqFDveaD7
         UCf9Iy36NsilO/H6CPt3w7g/bopm5OBwiUc3/Z6sWLSFVU8O4Exmc8rIbPXFoX4tQpbI
         5/o7eFRcSEI5arQoKPn12iw7o5ND5xgvn9trzNz1d3XQfXezWt5D4ou0z1kDoXaIqZcJ
         V+npIofk4b2DrEcXa7kqZGKDMpTgU6QtXQQXOQPoAsrv51uN2QcsUpmjjhdt0DKbNbcF
         3YKjp/9ezPS2hqp1EOhkIfcwI6glnb6bTGfLv/C+uNXUj1MFpVk5PHYvsAv/KmZ/3DBV
         ZV/w==
X-Received: by 10.55.31.97 with SMTP id f94mr74985874qkf.10.1426518728005;
        Mon, 16 Mar 2015 08:12:08 -0700 (PDT)
Received: from fujitsu.wireless.concordia.ca ([132.205.236.24])
        by mx.google.com with ESMTPSA id t102sm7636693qgt.45.2015.03.16.08.12.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2015 08:12:07 -0700 (PDT)
X-Mailer: git-send-email 2.3.2.224.gae1335b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265562>

This is an attempt at a microproject for GSoC

An attempt to add revision range support to Junio's JFF patch sent a few days ago. The first patch is the a copy of the one he posted.

I was wondering if it was a good idea to add support for commands like "<rev>..-". Files that starts with "-" requires "--" or a "./" format but what if we have a file named "next..-" and call "git log next..-" ?

Junio C Hamano (1):
  "-" and "@{-1}" on various programs

Kenny Lee Sin Cheong (1):
  Add revision range support on "-" and "@{-1}"

 builtin/checkout.c |  3 ---
 builtin/merge.c    |  3 +--
 builtin/revert.c   |  2 --
 revision.c         | 16 +++++++++++++--
 sha1_name.c        | 57 +++++++++++++++++++++++++++++++++---------------------
 5 files changed, 50 insertions(+), 31 deletions(-)

-- 
2.3.2.225.gebdc58a
