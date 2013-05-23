From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/7] Let's get that @{push}!
Date: Thu, 23 May 2013 20:42:43 +0530
Message-ID: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 23 17:11:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfXAh-0003VZ-62
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 17:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759162Ab3EWPLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 11:11:11 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:60125 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759063Ab3EWPLH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 11:11:07 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb11so1699070pad.23
        for <git@vger.kernel.org>; Thu, 23 May 2013 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=y9wwqyDg9+n4C12XrBEHmAtPGyklpNMRe2ndvGhLZN8=;
        b=VxZI4RFZx11ucWI7iryH4hiYyModEpnJ8B16VE2wIgUPyt89QvQFzdspnBAm73iq/W
         kess82DrVgVfprITZMONs+KSU731NaP5u5iN1q5OXLWOMu0IxGj4TbsIbSgN+HOAy7DQ
         NtH0sp5psR/uZRw1P/A4bJSLukyBNYWdBz275uHZfHpJbglrQajQ2yI5F13dOh+WhXNB
         PgXxEfZ+vZR3QL8Kft+Relm75V1VohqToU06JTWRyGooOsK1wx1vCU46kCZhRCRJc9Bu
         eYF996AZlGYqwn86vy5PmKaXoNrRcJbCn0Jzehx4UEBRuREmzYbGNySqcFc3Cd2+oXp9
         2kKw==
X-Received: by 10.66.159.6 with SMTP id wy6mr13741147pab.206.1369321867255;
        Thu, 23 May 2013 08:11:07 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vb8sm12099173pbc.11.2013.05.23.08.11.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 May 2013 08:11:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.17.gd95ec6c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225254>

[7/7] is the meat.  Sorry it's in such a messy state: I was having a
field day tracing what push is actually doing.  Anyway, I wanted to
send out the series now to get early feedback.

In other news: why on earth is push doing _so_ much processing before
pushing?  Is it written very badly, or am I missing something?

Thanks.

(based on rr/die-on-missing-upstream)

Ramkumar Ramachandra (7):
  sha1_name: abstract upstream_mark() logic
  sha1_name: factor out die_no_upstream()
  sha1_name: remove upstream_mark()
  remote: expose parse_push_refspec()
  remote: expose get_ref_match()
  sha1_name: prepare to introduce AT_KIND_PUSH
  sha1_name: implement finding @{push}

 remote.c    |   4 +--
 remote.h    |   4 +++
 sha1_name.c | 111 ++++++++++++++++++++++++++++++++++++++++++++----------------
 3 files changed, 88 insertions(+), 31 deletions(-)

-- 
1.8.3.rc3.17.gd95ec6c.dirty
