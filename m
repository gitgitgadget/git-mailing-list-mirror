From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH] Remove redundant close_ref function
Date: Tue,  8 Apr 2014 14:17:09 -0700
Message-ID: <1396991830-20938-1-git-send-email-sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 23:22:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXdTb-0004sa-IT
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 23:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757385AbaDHVWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 17:22:34 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:53799 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639AbaDHVWd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 17:22:33 -0400
Received: by mail-pb0-f73.google.com with SMTP id rp16so207111pbb.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=+feHQeoYhq0YXKmQqorbolNgZwpU+V8vea3EPVkBx5g=;
        b=E+wQMoBxqK4A1sf/BnWoa3/GUtTWQ7qsykU1/6MxAKRc3FGG+N/n2vB6PzlTmfLemS
         qBhp5ye5mKFBipRqS6ABIVSXdPlqAJsCyQzx5/BmYpy6Gdu8YM8glFxjo5dX+zKg1sqF
         +VId+og6ZvvmoDHYdFdGlRWkA6DFzh4YCyJdQhAXToQR+Nrfiw3JNibShVpGZIGcd7Q6
         +DXuQBAnt61bxRyIbbXrmLK0WF7KeEexBzIjdjemcOnjLObPJlyYk1L0u75uF9pDL0UI
         HYaE9TunwLzua8y04Zl2gpmnC5T1NEsZLEm4LEFsgpm7Xp3U7gkTwEwGtiwqQ0AD4Pc0
         6yaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=+feHQeoYhq0YXKmQqorbolNgZwpU+V8vea3EPVkBx5g=;
        b=j3MCED74xQnY/a5uYmntCVqWr2vgqyZ4JfN/XPByBxW8j//c142Id7eCEwvmN4ysZv
         nxBLypEIil6y3LkAP9Mhp+nxZMVOryUS5f+H8ExxqbUwiHmD6ST2l/IeYfdIR9Y2tHrw
         2iEYswrtqgqd0D6gnpny7HKnfBPevMiuRkLei5ZUWsGa/noclHkLw4kpCxv93JAYYqG8
         SLbROgRju4qOev1ACj/8h8/s7MOVxB/JSOcijVxzLhMcgtLwLOhds4hjHKkLnM9HLdKy
         rCm0jcAEhL741tFHiIuX1rv3PQsCLCnb4jHRJ/LCVSlMjrf3nn6F8c6kR8jplxWgmAHL
         iuTQ==
X-Gm-Message-State: ALoCoQmRLdcLEyjwuTOff4iumsHXUmrvqGiFXzpEDR6PnXpUnL7WPPam98VSxR0vH4+izyrk+vBCnKzr9iGJeNdw4AKtdkswjsruZWACqU6vfCCmnRB3G2Jjq7aSwIKVneEnzfK4D48cWDK8AC0ClKUGxhrgMChwpu5cGORjfP9sukDTOVbn3QI/++MNRU4xp2aHoxdBjo31/QkbBMvdcyPKm+6ma0FtI2z8n6wUCAxf+griIGKg5aI=
X-Received: by 10.68.201.134 with SMTP id ka6mr2974678pbc.4.1396991834470;
        Tue, 08 Apr 2014 14:17:14 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si636093yhb.6.2014.04.08.14.17.14
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Apr 2014 14:17:14 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 43AE331C259
	for <git@vger.kernel.org>; Tue,  8 Apr 2014 14:17:14 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DD2F6E07A7; Tue,  8 Apr 2014 14:17:13 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.475.ge4eef26.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245959>


List,

This is a trivial patch that removes the function close_ref() from refs.c.
This function was only called from two codepaths and can be removed since both codepaths shortly afterwards
both call unlock_ref() which implicitely closes the file anyway.

By removing this function we simplify the api to refs slightly.
This also means that the lifetime of the filedescriptor becomes the same as the lifetime for the 'struct ref_lock' object.
The filedescriptor is opened at the same time ref_lock is allocated and the descriptor is closed when ref_lock is released.


regards
ronnie sahlberg
