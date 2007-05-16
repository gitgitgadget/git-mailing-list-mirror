From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Change base font size to "small"
Date: Wed, 16 May 2007 12:51:38 +0200
Message-ID: <200705161251.38729.jnareb@gmail.com>
References: <6efbd9b70705071613p23017509qaf9af12c1d14f9cb@mail.gmail.com> <87odkmgaj5.fsf@morpheus.local> <20070515150912.GA3653@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Hudec <bulb@ucw.cz>,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 23:42:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoRGq-0001np-Ea
	for gcvg-git@gmane.org; Wed, 16 May 2007 23:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934067AbXEPVmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 May 2007 17:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934038AbXEPVmw
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 17:42:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:38681 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933823AbXEPVmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 17:42:50 -0400
Received: by ug-out-1314.google.com with SMTP id 44so205464uga
        for <git@vger.kernel.org>; Wed, 16 May 2007 14:42:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tDnE7CXqwWlffrEnBa+usRZBFFywh1GuQtY0yhKzjwigo5UZpmJ3d1wAYO5nC++MZ0VctmFN9al0TTgKB8E2K4S2OJx2BhkHLkkqQaQJClZRhtfaV19W1ftAEMWPjIg9aZFcQMghEm6hXt+UJt1FWII2h41G32oN+yNFWRXaOZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ayLe6z6/iajqxwE9VNIUm8HD4CusWBaX447N2YcdtrWmBL9Q9Jnavl3k3mZcl3Ur0cK6uz8SB0nCdN4NQEQQN+YW+o3fs1INYlAgBcYnLTdM7exBu9BPV0F8wI/jNBTh+Lw2ajafjyjNyBp5Rwc/kv1EwJNMTNLUqg5Pm4hTzF8=
Received: by 10.67.119.5 with SMTP id w5mr6669171ugm.1179351767991;
        Wed, 16 May 2007 14:42:47 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e8sm381467muf.2007.05.16.14.42.45;
        Wed, 16 May 2007 14:42:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070515150912.GA3653@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47459>

Commit 63fcbe00a66d7cb7d8bce9a36120a19a809a33b8 by Peter "Pasky" Baudis
  "gitweb: Do not use absolute font sizes"
made gitweb use default font size, the font size you have configured
your browser to use, as a basis; other font sizes are given as
percentage.

David K=C3=A5gedal noticed problem with this approach: too many web sit=
es
explicitly select extra small font sizes, which means that you have to
select a "standard" font size in your browser that is a bit larger
than one would actually like.

Additionally, as Jan Hudec noticed, gitweb should explicitely request
being somewhat smaller than normal, because it has good use for long
lines.  Normally one would usually want to set font so large, that
more than ~120 characters won't fit on the screen, since otherwise
pages that don't use margins are simply unreadable.  However gitweb
presents a table with several columns, so having wider line is OK for
it.

Jan Hudec proposed to use 'font-size: small' to take above issues into
account.  This avoid using "brain-damaged" explicit-pixel sizes, while
taking into account nature of gitweb output.

Thanks to mentioned commit by Pasky we need to add 'font-size: small'
in only one place, for BODY element.

See the original messages:
  Message-ID: <87odkmgaj5.fsf@morpheus.local>
  Message-ID: <20070515150912.GA3653@efreet.light.src>


Proposed-by: Jan Hudec <bulb@ucw.cz>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is commit wich has commit message larger than patch itself, but
I think the explanation is as important as patch itself, perhaps even
more important.

 gitweb/gitweb.css |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index b57c8be..02623cb 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -1,5 +1,6 @@
 body {
 	font-family: sans-serif;
+	font-size: small;
 	border: solid #d9d8d1;
 	border-width: 1px;
 	margin: 10px;
--=20
1.5.1.4
