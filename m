From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v5 0/8] imap-send: Windows support
Date: Wed, 21 Oct 2009 19:04:43 +0200
Message-ID: <1256144691-2908-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Oct 21 19:05:19 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f190.google.com ([209.85.217.190])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ecg-0007dm-6j
	for gcvm-msysgit@m.gmane.org; Wed, 21 Oct 2009 19:05:18 +0200
Received: by gxk6 with SMTP id 6so6761700gxk.13
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 Oct 2009 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=p8wgR0ojdInUY1iQ7AZdbU1oo1gm7akooOiLyBPcPd4=;
        b=Qs+4kdA5nfs09wqOaNLKUyeTV4Uhv7wJy8y9oA4kzt4WXFdOuUG4TZKpPGaxkoNCss
         dfFEjRk2MwgWZgN2JAtoj82DYm57+J18ljgKOfTosNpuPA5da5volIEgytVbeadVZi8U
         1FbrQ1pSklRch+ZXDU60LWtWMcOguuxHRsesE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=XTA036ETbW0Ewv4vK895Ap2kxxxtb3/R6ShfJOl0j1HhkBtguv24MZT4XxACfbUX63
         TRapBK70yt3ohFtnnQ75N2U9+Z2YsVOxVh7W0p5jkUEDZSRCvxWyQmV2HhaWy+5ZfutM
         /Vbz8cwhzAgX6L+ASr2BTkCV8MdeVW0FAHH2o=
Received: by 10.150.17.3 with SMTP id 3mr666331ybq.33.1256144710976;
        Wed, 21 Oct 2009 10:05:10 -0700 (PDT)
Received: by 10.177.108.35 with SMTP id k35gr7475yqm.0;
	Wed, 21 Oct 2009 10:05:08 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.161.31 with SMTP id n31mr677032ebo.5.1256144706727; Wed, 21 Oct 2009 10:05:06 -0700 (PDT)
Received: by 10.211.161.31 with SMTP id n31mr677031ebo.5.1256144706704; Wed, 21 Oct 2009 10:05:06 -0700 (PDT)
Received: from mail-ew0-f208.google.com (mail-ew0-f208.google.com [209.85.219.208]) by gmr-mx.google.com with ESMTP id 15si39364ewy.0.2009.10.21.10.05.05; Wed, 21 Oct 2009 10:05:05 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.208 as permitted sender) client-ip=209.85.219.208;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.208 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-ew0-f208.google.com with SMTP id 4so4267634ewy.37 for <msysgit@googlegroups.com>; Wed, 21 Oct 2009 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer; bh=6RadEU/CjxovzhVUQfSChaTh517Wr9bG+xaCYP9Yzs4=; b=BWcf+TGe7MTC28H8/iSZXts9iJHJJGJFv3A3SnQPrW8EahO88y6iyXqA1/DFbOf+c9 xwYlCWIf6MnqZ+zqozK6QWkcaVs9w7YVRBSaEws4TvCwSkiX8YE/lpJsfSt3n7fwzsW4 kz8JWSk0GrykvYH+0mVNwEblBusLP8kVjlSms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer; b=BDEQZZnObNDmOPfZoXowSWcFPVZDUldAdgcGuVU9BOfplYKmVuae1ej9MyIUJF/9li 0058IIYLOrkXCP5IHIjV1+MYdInU7hEkuDhSw//NaUhWH+OtdS8AmHm+hmSo9WdqIq// bPyXkwb+lHe0sbqTNwxEx4XMTQT4KLGFQq/ng=
Received: by 10.211.158.8 with SMTP id k8mr9306696ebo.38.1256144705589; Wed, 21 Oct 2009 10:05:05 -0700 (PDT)
Received: from localhost ([77.40.159.131]) by mx.google.com with ESMTPS id 7sm1086747eyb.0.2009.10.21.10.05.04 (version=TLSv1/SSLv3 cipher=RC4-MD5); Wed, 21 Oct 2009 10:05:05 -0700 (PDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130930>


Here's the 5th iteration of my patches for
Windows-compatibility in imap-send.

 - Patch 1-3 is about getting rid of or rewriting
   code with portability issues.
 - Patch 4 fixes a compilation error on Windows
 - Patch 5 enables compilation of imap-send
 - Patch 6-7 enables SSL-suport for mingw
 - Patch 8 enables imap-send and SSL for msvc

The only change compared to the previous iteration
is that patch 7 and 8 enables NEEDS_CRYPTO_WITH_SSL.

Please note that I haven't tested Patch 8 with
NEEDS_CRYPTO_WITH_SSL under MSVC, as I don't have a
working setup with both msysgit and MSVC installed.

I'd love it if someone with such a working setup
could verify that it works, preferrably also with
BLK_SHA1 enabled.

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

 Makefile                        |    6 +-
 compat/mingw.h                  |   21 ++++
 compat/vcbuild/scripts/clink.pl |    3 +
 contrib/buildsystems/engine.pl  |    3 +
 imap-send.c                     |  226 +++++++++------------------------------
 5 files changed, 79 insertions(+), 180 deletions(-)
