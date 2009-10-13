From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v3 0/8] imap-send: Windows support
Date: Tue, 13 Oct 2009 19:25:17 +0000
Message-ID: <1255461925-2244-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 21:27:18 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f143.google.com ([209.85.221.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxn1h-0007D9-Q0
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 21:27:18 +0200
Received: by qyk7 with SMTP id 7so10659202qyk.15
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 12:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=8Ak9jcDmBa+HMFOlI7iLXUOBVA0rLcnRjTQRsDn8c7U=;
        b=vjns/VaXQqV/+/yt5AEqLuk5sJbZ+1q+VZsyiej58dSvan8nRYO68HzHGSdfTx1cUK
         G8U6E1FaVht8qf7KZrbaDLb/364z3ZfA/WkDIEfvvZN2YLZ4tpuy19giQePovMFBjMo/
         sTctjahduHA7ofrqMa/4pllEWTV8j6ToNshCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=MdGRBC6iYoEdL0D4wIUvdo3tEICZYrzo15NqqtCpLQOcD1VX+AvH/DjEeKixeqQWlt
         /V9U9LCML4qLSBHyZB99J8LsbsIreoMBdr9JrgGJMuxHxrX9y1+H/S3V0NcbUACYdrws
         ustXwlsOicd+Bfc+DhCbc4nF0eEfO7Fd614qw=
Received: by 10.224.55.212 with SMTP id v20mr365282qag.26.1255462030728;
        Tue, 13 Oct 2009 12:27:10 -0700 (PDT)
Received: by 10.176.140.25 with SMTP id n25gr7403yqd.0;
	Tue, 13 Oct 2009 12:27:04 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.147.25 with SMTP id z25mr439596ebn.11.1255461943912; Tue, 13 Oct 2009 12:25:43 -0700 (PDT)
Received: by 10.211.147.25 with SMTP id z25mr439595ebn.11.1255461943883; Tue, 13 Oct 2009 12:25:43 -0700 (PDT)
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com [209.85.219.220]) by gmr-mx.google.com with ESMTP id 13si331767ewy.6.2009.10.13.12.25.42; Tue, 13 Oct 2009 12:25:42 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.220 as permitted sender) client-ip=209.85.219.220;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.220 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-ew0-f220.google.com with SMTP id 20so6219112ewy.40 for <msysgit@googlegroups.com>; Tue, 13 Oct 2009 12:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer; bh=UJf6U7Kd0vMHbTVjjE+Vx+9Rto2cOnO6Q6lis+fOwfU=; b=tVgNNXMDe4B2HoJEhSNJacJQ3uBrRqcpE5BFwafeAW65tbl4SX+ufbFUzZZ251R8zO it6EJg+IkP1gP49xBS+Q/6wm69kNKXEdYKBxzIMLjhJahzuQIhDWW8sdleHedAD5xDPK EvhnKVBg4dVOsJnX//lq/2eN/nd9uH67hsN18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer; b=FUz3OzBrLqWahe4Vy1i+Gq//ru1o3DYLyA3dYi3Qyuxrw6BGr992RG3cBtOxkWOvxb 8VU/7jkZcI5s4UuncUKX68exNe0n6KroxyKP/JSNKwORfWLkZxnJQ4Mbu7BDcdAd6Ggf tUtFgThZGWWe8VoZrOJHxZUgWmZEigUi59/6Y=
Received: by 10.211.141.15 with SMTP id t15mr9209373ebn.59.1255461942325; Tue, 13 Oct 2009 12:25:42 -0700 (PDT)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12]) by mx.google.com with ESMTPS id 7sm1229190eyg.19.2009.10.13.12.25.41 (version=TLSv1/SSLv3 cipher=RC4-MD5); Tue, 13 Oct 2009 12:25:41 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130192>


Here's the 3rd iteration of my patches for
Windows-compatibility in imap-send.

 - Patch 1-3 is about getting rid of or rewriting
   code with portability issues.
 - Patch 4 fixes a compilation error on Windows
 - Patch 5 enables compilation of imap-send
 - Patch 6-7 enables SSL-suport for mingw
 - Patch 8 enables imap-send and SSL for msvc

Changes in this iteration compared to v2 are as
follows:

 - A typo has been corrected in the commit message
   for 1/8
 - some unneeded preprocessor directives has been
   deleted from patch 4/8

Thanks to Matt Kraai for reviewing v2

P.S:
Perhaps some people are only on the msysgit mailing
list and wonders where v2 went -- I forgot to CC
you guys last round, sorry about that! If you're
interrested, you can read the discussion here:

http://thread.gmane.org/gmane.comp.version-control.git/129471

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
