From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] Stacked Git 0.15-rc1
Date: Mon, 13 Jul 2009 23:06:52 +0100
Message-ID: <b0943d9e0907131506s329bc2c2qe35180ac783a52f3@mail.gmail.com>
References: <b0943d9e0907121540n4b9199e2re3152e71d84a0f5@mail.gmail.com>
	 <20090713133343.GA23946@skywalker>
	 <b0943d9e0907131007q18dbed72tc017be92ed23a61d@mail.gmail.com>
	 <20090713172017.GA29333@skywalker> <20090713174743.GB29333@skywalker>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Karl Wiberg <kha@treskal.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 00:07:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQTfr-0006Fr-Po
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 00:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbZGMWGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 18:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbZGMWGz
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 18:06:55 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:53884 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088AbZGMWGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 18:06:54 -0400
Received: by fxm18 with SMTP id 18so2480860fxm.37
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 15:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tN8yg2u4o8l01U+jhjTcpyBxNzdTrQEkAP1tuNZzG+Q=;
        b=ULgu+c/FqIHS+PDlqyF5Dly+0btMoP1R0CVev/tdr+TzpDjf3+bvfpsrw0ZgbGfqWl
         jotdcJMtoni4F4OdDYa2gdaRZou0OrFOD3Sp2P8zKe9xTOiVh32f/UZupMF8rHSJExBu
         2/7jMCGlrHakf4c12fbLQdpf/PAoo2UH3fTGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qfUUFuv0flYZ47E42AyN3LrgNO7hQYb6KwGiRr6hxUo3wDqHokhuRawecpIcEqoGwA
         1w52mXc7F/oiHKwLv8EOP4I/i03PP2edW45pp3ZQciqcAa6RZn1JbggiHJ02TAEC9Htf
         wxCNYRXEpFfK538yck9iKhBDMIR07iQn33kR4=
Received: by 10.223.106.148 with SMTP id x20mr2529557fao.68.1247522812960; 
	Mon, 13 Jul 2009 15:06:52 -0700 (PDT)
In-Reply-To: <20090713174743.GB29333@skywalker>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123206>

2009/7/13 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
> On Mon, Jul 13, 2009 at 10:50:17PM +0530, Aneesh Kumar K.V wrote:
>> On Mon, Jul 13, 2009 at 06:07:06PM +0100, Catalin Marinas wrote:
>> > 2009/7/13 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
>> > > stg show now gives me output like below
>> > >
>> > > ESC[1mdiff --git a/fs/nfs/nfs4acl.c b/fs/nfs/nfs4acl.cESC[m
>> > > ESC[1mindex 09946da..c9a6dee 100644ESC[m
>> > > ESC[1m--- a/fs/nfs/nfs4acl.cESC[m
>> > > ESC[1m+++ b/fs/nfs/nfs4acl.cESC[m
>> > > ESC[36m@@ -37,6 +37,7 @@ESC[m
[...]
> I had PAGER=less in my .bashrc. I had set it that way because of
> https://bugs.launchpad.net/ubuntu/+source/less/+bug/67381
>
> Removing that fixed the problem

Thanks. You shouldn't remove that actually. The patch below should
give similar behaviour to Git (added to the "proposed" branch):


Set the LESS environment if the pager is 'less'

From: Catalin Marinas <catalin.marinas@arm.com>

This fixes the coloured output if the PAGER environment is set to less
(similar behaviour to Git).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 stgit/config.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/stgit/config.py b/stgit/config.py
index f205e5b..75bdadb 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -37,7 +37,7 @@ class GitConfig:
         'stgit.keepoptimized':	'no',
         'stgit.extensions':	'.ancestor .current .patched',
         'stgit.shortnr': '5',
-        'stgit.pager':  'less -FRSX'
+        'stgit.pager':  'less'
         }

     __cache = None
@@ -121,6 +121,8 @@ def config_setup():
     global config

     os.environ.setdefault('PAGER', config.get('stgit.pager'))
+    if os.environ.get('PAGER').startswith('less'):
+        os.environ.setdefault('LESS', '-FRSX')
     # FIXME: handle EDITOR the same way ?

 class ConfigOption:

-- 
Catalin
