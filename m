From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v4 0/8] imap-send: Windows support
Date: Mon, 19 Oct 2009 17:42:01 +0200
Message-ID: <1255966929-1280-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Oct 19 17:44:39 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f156.google.com ([209.85.212.156])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzuPU-0006rY-VJ
	for gcvm-msysgit@m.gmane.org; Mon, 19 Oct 2009 17:44:37 +0200
Received: by mail-vw0-f156.google.com with SMTP id 28so4738984vws.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 Oct 2009 08:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=jc7Nt/lSD4jmeLi+XakfpqVds7RfhbZg/EiXQBddOfQ=;
        b=VWpGv2ZDr6HKgTmzruK0MA5d6aEUirYBKQHijTDHGpRm+Mqc0cdLGnavWm29ws/n1G
         H1tUvvA/uNz6ovn9pTAaeygdEKlydN2Y3+cDbyBxnctWMOwC8B2lep9JQ5QiATWV3JfP
         dOWlp6P05DA49GwTzUuUNxYrZrr89HWi9wN1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=Pf0zcixnFgTBcsRYLl2k6BGIOwSA63UL/DLQy0Qs2uKBCczcORMwK0Z0OC5QgDyWgq
         S7O/hAcAeo5sSxYzguSPWQKV0wAGack/h4kQzTenYB7KLr+97O415DCvDzdJW6EqOpiH
         te6brg5gchnegsH4fZliy8ZR071zKSenCCwqg=
Received: by 10.220.68.102 with SMTP id u38mr121616vci.5.1255966985132;
        Mon, 19 Oct 2009 08:43:05 -0700 (PDT)
Received: by 10.176.181.37 with SMTP id d37gr7446yqf.0;
	Mon, 19 Oct 2009 08:43:03 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.4.13 with SMTP id 13mr338631ebd.10.1255966982400; Mon, 19 Oct 2009 08:43:02 -0700 (PDT)
Received: by 10.210.4.13 with SMTP id 13mr338630ebd.10.1255966982374; Mon, 19 Oct 2009 08:43:02 -0700 (PDT)
Received: from mail-ew0-f219.google.com (mail-ew0-f219.google.com [209.85.219.219]) by gmr-mx.google.com with ESMTP id 15si913403ewy.4.2009.10.19.08.43.01; Mon, 19 Oct 2009 08:43:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.219 as permitted sender) client-ip=209.85.219.219;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.219 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-ew0-f219.google.com with SMTP id 19so4198812ewy.28 for <msysgit@googlegroups.com>; Mon, 19 Oct 2009 08:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer; bh=K9qaoOO58J7Cwv3VXBxYUaRCycGm6+fJIWO/BlWYj5Q=; b=kp3wqavDnd2bTUx2wod9E4xUsu/J5v6VEc+j+te0wJ/DfHnBcoUhtauYSBcdDnkbmf 5r7VbMqW7Z3L01bA0Cq10vlTO6/2YFXE9SYGqhrpJ+K+wRfo2t2JdgjHznJ7DeklTh0I ELxZe6FIjgHo+jIYlg+VD0iqfJ9aG272kB1r4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer; b=aiqZy8HLgS6F8sHK+W4P8v59tzbBV9nq5aWSdPWu9DuUFdk/mZZyajOa7eEWz0tzWe cSuds9GgL2hz7lujQTi5HSW680fEpJ7EY3mbd6l+n9ZvgeJgMuaae8MGBofQlxT02YqK PtrsVJb+2fftFBMqSRW2Q1NFs37iZj/fezki4=
Received: by 10.211.131.40 with SMTP id i40mr54263ebn.99.1255966981204; Mon, 19 Oct 2009 08:43:01 -0700 (PDT)
Received: from localhost ([77.40.159.131]) by mx.google.com with ESMTPS id 7sm4970533eyb.32.2009.10.19.08.43.00 (version=TLSv1/SSLv3 cipher=RC4-MD5); Mon, 19 Oct 2009 08:43:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130709>


Here's the 4th iteration of my patches for
Windows-compatibility in imap-send.

 - Patch 1-3 is about getting rid of or rewriting
   code with portability issues.
 - Patch 4 fixes a compilation error on Windows
 - Patch 5 enables compilation of imap-send
 - Patch 6-7 enables SSL-suport for mingw
 - Patch 8 enables imap-send and SSL for msvc

Changes in this iteration compared to the previous
are as follows:
 - Patch 3/8 calls "sh -c" instead of "/bin/sh -c"
 - Patch 5/8 keeps the list sorted

Thanks to Johannes Sixt for reviewing v4

Erik Faye-Lund (6):
  imap-send: use separate read and write fds
  imap-send: use run-command API for tunneling
  imap-send: fix compilation-error on Windows
  imap-send: build imap-send on Windows
  mingw: wrap SSL_set_(w|r)fd to call _get_osfhandle
  mingw: enable OpenSSL

Jeff King (1):
  imap-send: remove useless uid code

Marius Storm-Olsen (1):
  MSVC: Enable OpenSSL, and translate -lcrypto

 Makefile                        |    4 +-
 compat/mingw.h                  |   21 ++++
 compat/vcbuild/scripts/clink.pl |    3 +
 contrib/buildsystems/engine.pl  |    3 +
 imap-send.c                     |  226 +++++++++------------------------------
 5 files changed, 77 insertions(+), 180 deletions(-)
