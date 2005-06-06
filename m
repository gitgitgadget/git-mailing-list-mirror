From: Timo Hirvonen <tihirvon@ee.oulu.fi>
Subject: duplicate htons() in check_file_directory_conflict()
Date: Mon, 06 Jun 2005 23:02:46 +0000
Message-ID: <1118098966l.5384l.0l@garlic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Jun 07 01:00:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfQZF-0006cy-Tj
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 00:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVFFXDD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 19:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVFFXDD
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 19:03:03 -0400
Received: from marski.suomi.net ([212.50.131.142]:58763 "EHLO marski.suomi.net")
	by vger.kernel.org with ESMTP id S261163AbVFFXCw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 19:02:52 -0400
Received: from spam1.suomi.net (spam1.suomi.net [212.50.131.165])
 by marski.suomi.net (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0IHO00CATQIO6DE0@marski.suomi.net> for git@vger.kernel.org;
 Tue, 07 Jun 2005 01:59:12 +0300 (EEST)
Received: from garlic (addr-82-128-203-168.suomi.net [82.128.203.168])
	by spam1.suomi.net (Postfix) with ESMTP id 375CC1A20E9	for
 <git@vger.kernel.org>; Tue, 07 Jun 2005 02:02:47 +0300 (EEST)
To: git@vger.kernel.org
X-Mailer: Balsa 2.2.6
Content-disposition: inline
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Not virus scanned: please contact OPOY for details
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.291,	required 5,
 autolearn=not spam, AWL 0.81, BAYES_00 -4.90,	UNWANTED_LANGUAGE_BODY 1.80)
X-MailScanner-From: tihirvon@ee.oulu.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

create_ce_flags() macro calls htons() so the htons()s in  
check_file_directory_conflict() should be removed or alternatively htons  
should be removed from the create_ce_flags macro. I noticed the bug when  
compiling cogito with -Wshadow.

read-cache.c:208
        pos = cache_name_pos(pathbuf,
                             htons(create_ce_flags(len, stage)));


read-cache.c:232
        pos = cache_name_pos(path,
                             htons(create_ce_flags(namelen, stage)));

-- 
http://onion.dynserv.net/~timo/


