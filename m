From: Jakub Narebski <jnareb@gmail.com>
Subject: git-blame and blame GUI wishlist
Date: Mon, 6 Aug 2007 00:09:37 +0200
Message-ID: <200708060009.37595.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 01:38:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHpgT-0002m7-3z
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 01:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbXHEXif (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 19:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbXHEXie
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 19:38:34 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:20235 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbXHEXiX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 19:38:23 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1268009fkz
        for <git@vger.kernel.org>; Sun, 05 Aug 2007 16:38:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=LKdBtbfuzeXolYcuumYWT6w6cSj+1DYliCKsaHT4kmCgrWUXADs/v5U0IM2kAfkZXxinjjcVsJsAnR/X2qaGAksu97AHqxE/n0oBBhXcSGeuAEzExauz3R5l1aKkwqfR6iQKnrzDYHkvgCmpugC0/J8/pyrmKEcHHkqUksd3his=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=kNb6KUu3JqYmhCzwKRPzTNIxZQcgvkeVO1j2cDBz/ulvzq4n69Kw4tdlnIIWtGd/xXRuN53cyzRYDiTCOMytodmNVPHo8wXnQCFCAtF5p7Tohz6jolsbKKfp8R0J8cVrlL5FKFAqDgZGfvOLygd4Q20sRCX9L/l1k5VeaA8KPvA=
Received: by 10.86.49.13 with SMTP id w13mr3952925fgw.1186357102316;
        Sun, 05 Aug 2007 16:38:22 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id o11sm11427967fkf.2007.08.05.16.38.19
        (version=SSLv3 cipher=OTHER);
        Sun, 05 Aug 2007 16:38:21 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55083>

1. In git-gui blame viewer you can click on shortened sha1 of a commit
   to see file at given version. Unfortunately git-gui goes to other
   version of a file by reblaming a file starting from scratch.

   It would be nice to have 
     git blame --incremental=<revision1> <revision2> -- <file>
   which would blame only lines which differ between <revision1>
   and <revision2>. We can assume that <revision2> is ancestor of
   <revision1>, I think. I'm not completely sure if it is possible
   and reasonable, i.e. if one can assume that only lines which
   differ need reblaming...

   And of course use this feature in "git-gui blame" which should
   speed up exploring file history a bit.


2. Sometimes I'm interested only in part of a file. Thus I'd like
   "git-gui blame" to understand line-range parameter of git-blame.
   It means that I'd like to be able to say for example:
     git gui blame -L '/^sub git_feed/,/^}$/' HEAD -- gitweb/gitweb.perl
   and have only given range of lines blamed, with the rest grayed out
   in the "inactive control" style. Of course in the case I specified
   line range incorrectly, I'd like to have menu entry or a button to
   reblame _whole_ file... Or perhaps do blaming of a whole file in the
   background, after blaming specified range fo lines.

   This should speed up "git gui blame" a bit. By the way, of course
   git-gui should start with the selected line-range visible.


3. Sometimes when reviewing patches I do wonder: why the preimage looks
   like it looks like. It would be useful in that situation to be able
   to blame the patch (context lines and pre-image lines). Although I'm
   not suer if it would bevery useful and used often [enough].


P.S. qgit uses some bottom-up all-files mechanism to get the blame of 
all the files together. Could anyone describe in few sentences the 
algorithm qgit uses? Would it be useful to put it available e.g. in 
gitlib-thin for other viewers, or not; what do you think?

P.P.S. Of couse the examples and ideas are not limited to "git gui 
blame"...

-- 
Jakub Narebski
Poland
