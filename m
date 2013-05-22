From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/2] Fix invalid revision error messages
Date: Wed, 22 May 2013 16:09:53 +0530
Message-ID: <1369219195-20096-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 22 12:38:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf6R1-0002MS-A1
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 12:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988Ab3EVKiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 06:38:15 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:60260 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079Ab3EVKiO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 06:38:14 -0400
Received: by mail-pd0-f175.google.com with SMTP id 6so1217029pdd.34
        for <git@vger.kernel.org>; Wed, 22 May 2013 03:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=iWFPs7Vvvb4d9BGKL0V3dFnMR0sGVHY6+fqrmn9HBi0=;
        b=TVXWYGtYEftd4ypjIJuWmOC2vJbLszRNQCgGK6NDkW3USsm5aXEO7Kv2o17xgS7TTp
         UqrXjhgbQpCfpfYnsKsYaWdG/UyAEwF9yk7wgPZ+1bWjYFwQrNZn7zE0jS8W4zK0DyPi
         +HB6G/i59hpRE35YxY1c9bfykznTHlDyTggTtekrdqFm4RGQpF3F5OmGJHdDIVxaOHp5
         ebitKrQjBnuYkv9H4ohf9jENiUYRvJeyLaFdVlnxJacvOMdrK6jvH8f7PRvFGqBbcln9
         FDmbuPgQbmUgR2Q/IBJB2zcqZV4fZI2LkcQTjUpVaXGGfjQm61T+ninrcdiLniNaXp0s
         Cgvg==
X-Received: by 10.68.197.165 with SMTP id iv5mr6900286pbc.213.1369219093976;
        Wed, 22 May 2013 03:38:13 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id un15sm5905724pab.7.2013.05.22.03.38.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 May 2013 03:38:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.10.g6f8d616
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225142>

As Junio pointed out in [0/2], this is not for 1.8.3; it's just a
regular "enhacement".

In [1/2], I've extended the commit message with the justification I
wrote out for Junio.

In [2/2], I've made sure to print the "correct" error message
everytime: I missed the detached HEAD case last time.  I'm not in
favor of anything "prettier", as I already explained in my email.

Thanks.

Ramkumar Ramachandra (2):
  sha1_name: fix error message for @{u}
  sha1_name: fix error message for @{<N>}, @{<date>}

 sha1_name.c                   | 23 +++++++++++++++++------
 t/t1507-rev-parse-upstream.sh | 15 +++++----------
 2 files changed, 22 insertions(+), 16 deletions(-)

-- 
1.8.3.rc3.10.g6f8d616
