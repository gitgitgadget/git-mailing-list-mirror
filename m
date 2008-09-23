From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: rebasing merges
Date: Tue, 23 Sep 2008 09:30:47 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-09-23-09-30-47+trackit+sam@rfc1149.net>
References: <20080922155749.c8070681.stephen@exigencecorp.com>
	<20080922231927.ef18f420.stephen@exigencecorp.com>
	<48D88813.9060400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Stephen Haberman <stephen@exigencecorp.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 23 09:32:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki2NS-0001UH-Od
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 09:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbYIWHa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 03:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbYIWHa6
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 03:30:58 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:50194 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbYIWHa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 03:30:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 002D3E077B;
	Tue, 23 Sep 2008 09:30:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GRMANHjdqA3G; Tue, 23 Sep 2008 09:30:49 +0200 (CEST)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:e35:1382:f950::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTPS id E6415E0927;
	Tue, 23 Sep 2008 09:30:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 105C0C40BC;
	Tue, 23 Sep 2008 09:30:48 +0200 (CEST)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FctJlwuh+N9r; Tue, 23 Sep 2008 09:30:47 +0200 (CEST)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id D2CCAC40BD; Tue, 23 Sep 2008 09:30:47 +0200 (CEST)
In-Reply-To: <48D88813.9060400@viscovery.net> (Johannes Sixt's message of "Tue\, 23 Sep 2008 08\:09\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96530>

>>>>> "Johannes" == Johannes Sixt <j.sixt@viscovery.net> writes:

Johannes> i.e. linearized history without merges.

A few days ago, I had a question in my team quite similar to Stephen
concern. A developer had performed a merge of a complex feature and
was ready to commit it

  --o--o--o--o--X        <-- origin
     \           \
      A--B--C--D--E      <-- master

when he realized that someone just pushed another change on origin
while he was doing the complicating merge (with lots of conflicts to
resolve). The configuration was then:

  --o--o--o--o--X--Y     <-- origin
     \           \
      A--B--C--D--E      <-- master

He would have wanted to have the merge rebased on E and Y instead of E
and X before pushing, without going through all the conflicts
resolution again (he didn't have "rerere" enabled).

Is that possible with "git rebase"?

Btw, would it be a good idea to unconditionally enable "rerere"
conflict resolution *recording*, and add an option to "rebase" and
"merge" to use "rerere" even when it is not enabled in the
configuration file? I can't think of any drawback.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
