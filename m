X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Vilz <niv@iaglans.de>
Subject: following Documentation/howto/update-hook-example.txt
Date: Mon, 20 Nov 2006 00:10:45 +0100
Message-ID: <20061119231044.GA31562@hermes.lan.home.vilz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 23:11:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Content-Disposition: inline
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31871>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glvog-0008DE-GN for gcvg-git@gmane.org; Mon, 20 Nov
 2006 00:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933710AbWKSXLG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 18:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933649AbWKSXLG
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 18:11:06 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:47375 "EHLO
 vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP id
 S933710AbWKSXLD (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006
 18:11:03 -0500
Received: from localhost (localhost [127.0.0.1]) by
 vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 2E0623E73 for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 00:10:59 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1]) by localhost
 (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xwlg7+k5Ue7a for <git@vger.kernel.org>; Mon, 20 Nov 2006
 00:10:39 +0100 (CET)
Received: from localhost (hermes.lan.home.vilz.de [192.168.100.26]) (using
 TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id
 6ABCF3E6A for <git@vger.kernel.org>; Mon, 20 Nov 2006 00:10:37 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

hello guys,

I tested the script mentioned in update-hook-example.txt and noticed,
that the following line in allowed-users

refs/heads/tmp/         *

and the if-clause above 

matchlen=$(expr "$1" : "$head_pattern")
if [ "$matchlen" == "${#1}" ]; then

does not recognize the header

refs/heads/tmp/blah

... so, all users trying to update or create branches named
tmp/<insert_fancy_name_here> are denied, because nothing matches.

also the example case in which linus should be allowed to push and
create branches bw/blah and bw/blupp doesn't work.

If I try following rule in allowed-users

refs/heads/tmp 		*

and someone tries to commit refs/heads/tmp, it works as intended.

This is at least in bash 3.1.2.5 ... (i tested that on my powerbook this
week end). Perhaps it worked in November 2005. I don't know which
version of bash was the latest then.

For all other examples in this document, it grants and denies pushing
and creating branches as intended.

I haven't tried the tag-case yet.... could be, that this also doesn't
work anymore.

Greetings
Nicolas
