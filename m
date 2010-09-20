From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [tig] compilation error: undefined reference to `set_tabsize'
Date: Mon, 20 Sep 2010 19:42:00 +0200
Message-ID: <20100920174200.GA13017@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, fonseca@diku.dk,
	git@vger.kernel.org
To: stefan.naewe@googlemail.com
X-From: git-owner@vger.kernel.org Mon Sep 20 19:42:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxkNZ-0006j5-5t
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 19:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122Ab0ITRmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 13:42:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49009 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab0ITRmE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 13:42:04 -0400
Received: by wyf22 with SMTP id 22so4546178wyf.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=ddGfT0ljHPNwER2ikttSw8zAKa0yUXv3qCgZ5Rn30EY=;
        b=syhmz2rm//OIrI51fFwfNKcZ91S7IuOed6xySKIjyvIOGDK72QsiZ8dRmchzkLboSB
         kcOKIxTMxCu8u9wqmStN9+taq/f7LNok+nrFSe7xZv+gniww4jqJ2uXEl1oCv9RCnkCJ
         li6p3nanGi35+r1oM9fqKMMOG8ug37W0CoSwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=i/PLbH83cONKdy906s2Li6CmG9dkEBalRElGr89Aa0LRVQccdcEm76eXWKrUsjo3CP
         riWmrji0APNINzZMds7i/n42Nxuh3ipcbO5o+LJpyytIaBKBB9Ezd9D33SPCKpFcQhXO
         GGK+vvDpR1uI99IkC5TotEymkO0O0TcvtyksM=
Received: by 10.216.93.10 with SMTP id k10mr4620870wef.38.1285004522892;
        Mon, 20 Sep 2010 10:42:02 -0700 (PDT)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id b10sm5333170wer.41.2010.09.20.10.42.01
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 10:42:02 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156643>

Hi,

tig don't compile anymore here:

  % make
  gcc   tig.o  -lncursesw  -o tig
  tig.o: In function `init_display': tig.c:7113: undefined reference to `set_tabsize'
  collect2: ld returned 1 exit status
  make: *** [tig] Error 1
  %


and bisected on

commit f1fe753be71ef3ce5abcbb16c2a359f97e5c7e7d
Author: Stefan Naewe <>
Date:   Sun Sep 12 11:03:52 2010 +0200

    Use function set_tabsize()
    
    this fixes the following compile error on cygwin:
    tig.c: In function `init_display':
    tig.c:7112: error: invalid lvalue in assignment
    
    Signed-off-by: Stefan Naewe <>
    Signed-off-by: Jonas Fonseca <>


Or did I missed something?

-- 
Nicolas Sebrecht
