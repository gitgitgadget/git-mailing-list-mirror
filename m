From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Bug#428413: commit mail sender messes up order of arguments
Date: Sat, 15 May 2010 20:26:15 -0500
Message-ID: <20100516012615.GA5599@progeny.tock>
References: <20070611150405.GA4211@lapse.madduck.net>
Reply-To: Jonathan Nieder <jrnieder@gmail.com>, 428413@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: 428413@bugs.debian.org, Andy Parkins <andyparkins@gmail.com>,
	git@vger.kernel.org
To: martin f krafft <madduck@debian.org>
X-From: bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org Sun May 16 03:27:18 2010
connect(): No such file or directory
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Envelope-to: glddb-debian-bugs-dist@m.gmane.org
Received: from liszt.debian.org ([82.195.75.100])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>)
	id 1ODSdP-0000p8-OE
	for glddb-debian-bugs-dist@m.gmane.org; Sun, 16 May 2010 03:27:15 +0200
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with QMQP
	id 0017013A55EC; Sun, 16 May 2010 01:27:14 +0000 (UTC)
Old-Return-Path: <debbugs@busoni.debian.org>
X-Original-To: lists-debian-bugs-dist@liszt.debian.org
Delivered-To: lists-debian-bugs-dist@liszt.debian.org
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with ESMTP id BE2766C845E
	for <lists-debian-bugs-dist@liszt.debian.org>; Sun, 16 May 2010 01:27:14 +0000 (UTC)
X-Virus-Scanned: at lists.debian.org with policy bank bug
X-Spam-Flag: NO
X-Spam-Score: -2.599
X-Spam-Level: 
X-Spam-Status: No, score=-2.599 tagged_above=-10000 required=5.3
	tests=[BAYES_00=-2.599] autolearn=unavailable
Received: from liszt.debian.org ([127.0.0.1])
	by localhost (lists.debian.org [127.0.0.1]) (amavisd-new, port 2525)
	with ESMTP id 7zY-uuKpn-eL
	for <lists-debian-bugs-dist@liszt.debian.org>;
	Sun, 16 May 2010 01:27:07 +0000 (UTC)
Received: from busoni.debian.org (busoni.debian.org [140.211.15.34])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by liszt.debian.org (Postfix) with ESMTPS id 8174213A55C8;
	Sun, 16 May 2010 01:27:07 +0000 (UTC)
Received: from debbugs by busoni.debian.org with local (Exim 4.69)
	(envelope-from <debbugs@busoni.debian.org>)
	id 1ODSdD-00026l-3s; Sun, 16 May 2010 01:27:03 +0000
X-Loop: owner@bugs.debian.org
Resent-From: Jonathan Nieder <jrnieder@gmail.com>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: Gerrit Pape <pape@smarden.org>
X-Loop: owner@bugs.debian.org
Resent-Date: Sun, 16 May 2010 01:27:01 +0000
Resent-Message-ID: <handler.428413.B428413.12739731837927@bugs.debian.org>
X-Debian-PR-Message: followup 428413
X-Debian-PR-Package: git-core
X-Debian-PR-Keywords: wontfix
X-Debian-PR-Source: git
Received: via spool by 428413-submit@bugs.debian.org id=B428413.12739731837927
          (code B ref 428413); Sun, 16 May 2010 01:27:01 +0000
Received: (at 428413) by bugs.debian.org; 16 May 2010 01:26:23 +0000
X-Spam-Bayes: score:0.0000 Tokens: new, 18; hammy, 151; neutral, 66; spammy,
	0. spammytokens: hammytokens:0.000-+--H*u:1.5.20, 0.000-+--H*UA:1.5.20,
	0.000-+--H*u:2009-06-14, 0.000-+--H*UA:2009-06-14, 0.000-+--git-core
Received: from mail-gy0-f180.google.com ([209.85.160.180])
	by busoni.debian.org with esmtp (Exim 4.69)
	(envelope-from <jrnieder@gmail.com>)
	id 1ODScZ-00022g-5p; Sun, 16 May 2010 01:26:23 +0000
Received: by gyb13 with SMTP id 13so1843874gyb.11
        for <multiple recipients>; Sat, 15 May 2010 18:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vS3tVAJG7Ep16Cc8aggclQvsnPnrchcTUm/2QR//4ao=;
        b=j/XNqXmGq3cG/TbLxCvP5aDBwZS5Dl2ARm47FfLeQnpl7E6gK/vAqS5l8J5L1LcEl2
         M0B3KvxjPwLF388Atef5A01L2XgqsuA+uuZOJE8N/BPwAOjrsIJ4+u29BgF44h5yx0i5
         pYvR9s6Aviy6WEiP/aUqjw2Wr8suhcupMhKfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ey5VZtgQ0DU3+PsuOxukEBlRMcbk00awyG/h8GQFaCGkIx8RGdklEfYnKVvmmn6PF4
         oOgpZgFXN8xyZbnpGs+sGO8G2bT4Z0h5pQlVTmmb8J19gO3dxRQlkAgKqcsHbZPNQ21U
         0+C7u6ENsE/mB5+dWIZ89pVlqIujAVYdZqV1A=
Received: by 10.150.119.26 with SMTP id r26mr4071286ybc.60.1273973173596;
        Sat, 15 May 2010 18:26:13 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2548004yxe.14.2010.05.15.18.26.11
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 18:26:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070611150405.GA4211@lapse.madduck.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Resent-Date: Sun, 16 May 2010 01:27:03 +0000
X-Debian-Message: from BTS
X-Mailing-List: <debian-bugs-dist@lists.debian.org> archive/latest/624759
X-Loop: debian-bugs-dist@lists.debian.org
List-Id: <debian-bugs-dist.lists.debian.org>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
Precedence: list
Resent-Sender: debian-bugs-dist-request@lists.debian.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147173>

tags 428413 - wontfix
reassign 428413 git git-core/1:1.5.2.1-1
found 428413 git/1:1.7.1-1
quit

martin f krafft wrote:

> According to the default hooks/post-receive file, the hook is called
> with three arguments on stdin:
>=20
>   <oldrev> <newrev> <refname>
>=20
> This leads people to assume that in command-line mode, the order
> should be the same. But it's not, because the email hook instead
> calls:
>=20
>   generate_email $2 $3 $1
>=20
> this is at least misleading and not documented anywhere.

So maybe we should document it.

I haven=E2=80=99t checked that the below is actually true; I just took th=
e
commit message to v1.5.1~9 and paraphrased it.  Thoughts?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/hooks/post-receive-email |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receiv=
e-email
index 58a35c8..30ae63d 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -23,6 +23,13 @@
 # possible for the email to be from someone other than the person doing =
the
 # push.
 #
+# To help with debugging and use on pre-v1.5.1 git servers, this script =
will
+# also obey the interface of hooks/update, taking its arguments on the
+# command line.  Unfortunately, hooks/update is called once for each ref=
.
+# To avoid firing one email per ref, this script just prints its output =
to
+# the screen when used in this mode.  The output can then be redirected =
if
+# wanted.
+#
 # Config
 # ------
 # hooks.mailinglist
--=20
1.7.1




--=20
To UNSUBSCRIBE, email to debian-bugs-dist-REQUEST@lists.debian.org
with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian=
.org
