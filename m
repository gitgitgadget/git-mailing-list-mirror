From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/3] Introduce pull.autostash
Date: Fri, 22 Mar 2013 17:59:56 +0530
Message-ID: <1363955399-13153-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 13:29:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ15x-0005Fy-Az
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 13:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680Ab3CVM2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 08:28:49 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33811 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab3CVM2s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 08:28:48 -0400
Received: by mail-pd0-f179.google.com with SMTP id x10so1576530pdj.38
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Wzv9bpj0mkwRKCeu/knxD3pmjfr1FPQY/U17/T4i3Gs=;
        b=bWeIq/KiOPlE2vQjCrIjMp1YF9ZuGgEa9qsPqCc0FzbEkCEj8GNB/k9y3Zf+osjpFn
         O4zP9k5nuLofsnqhbUbh8uJHDhuj/mwXJf45oNeG1CWBG9YC6k5kKME5S3IEHdlYmJnK
         aud60ByCRVQa6Kqk7QsNnTOP1fSExP/HvfAnQLQekOMFASe+gwHBfzJ55Gcj0piN0q37
         TDJGAOhBQubEEl1pQ6KuwZSlVakMhic52Qhv6lsVBLMT/E4BxzxYMP33KPUF56Nu84oh
         io6Ew6cQWIhTPDq0T+xUPIAJXb4GZW8Ceg4X5EfmA6zSo3jn4M8yVV6DJeg1vkE3sQwp
         TUXg==
X-Received: by 10.68.95.1 with SMTP id dg1mr2262103pbb.161.1363955328264;
        Fri, 22 Mar 2013 05:28:48 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id ve7sm2839591pab.11.2013.03.22.05.28.46
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 05:28:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.gad203c2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218794>

This series adds a pull.autostash, making 'git pull' a tad bit more
usable.  It is part of my bigger plan to make 'git pull' just DTRT
(via configuration variables) in 90% of the cases.

[1/3] and [2/3] are tiny "while we're here" patches.
[3/3] is the main patch with tests.

Thanks for reading.

Ramkumar Ramachandra (3):
  git-pull.sh: prefer invoking "git <command>" over "git-<command>"
  t5521 (pull-options): use test_commit() where appropriate
  git-pull.sh: introduce --[no-]autostash and pull.autostash

 Documentation/config.txt   |  5 ++++
 Documentation/git-pull.txt |  7 ++++++
 git-pull.sh                | 30 +++++++++++++++++++---
 t/t5521-pull-options.sh    | 63 ++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 99 insertions(+), 6 deletions(-)

-- 
1.8.2.141.gad203c2.dirty
