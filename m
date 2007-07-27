From: Bradford C Smith <bradford.carl.smith@gmail.com>
Subject: [PATCH 0/2] another attempt at make_absolute_path()
Date: Fri, 27 Jul 2007 15:10:54 -0400
Message-ID: <11855634561516-git-send-email-bradford.carl.smith@gmail.com>
Cc: Junio C Hamano <gitster@pobox.como>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 21:11:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEVDO-00035y-Bs
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 21:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761852AbXG0TLD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 15:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761139AbXG0TLB
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 15:11:01 -0400
Received: from qb-out-0506.google.com ([72.14.204.235]:56010 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760814AbXG0TLA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 15:11:00 -0400
Received: by qb-out-0506.google.com with SMTP id e11so797977qbe
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 12:10:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=Xx4kKTnxGI60s62gje63RSwP/N3mbvnicMmZDhuiaOmDYjq/2tD5lYbp1ZqFcVW66l6ImJLKZlHXjcL7A+b0k4FS/9LPEeEcynb6d4AJW22EVUDedeEGSB1usUS2gBcfABdaq7S7INwoO+tQPodpxtkvFL/ipURTo/S8rFeN8UA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=gwBIbD3cCaw9PVND9K28f31F5TYlGYvVIx1BJZsDhxzY6jRhuCYTdotIELtYHMTo0UlLEskCKRUXqZDbEIoQTMfo2ZuAAMachoVjTrgCLdnmylL5/LpEIKSENHM4XWvp81j1ELcRZ6YLJ+QF4GO26bkDoHbIsOpl/Zy0G/g2Sho=
Received: by 10.100.44.13 with SMTP id r13mr3182140anr.1185563458582;
        Fri, 27 Jul 2007 12:10:58 -0700 (PDT)
Received: from localhost ( [160.36.232.47])
        by mx.google.com with ESMTPS id b14sm64269ana.2007.07.27.12.10.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jul 2007 12:10:57 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc3.9.g9ef91
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53949>

Here's my attempt at make_absolute_path() and friends.  I think this
version handles symlinks cleanly to avoid problems with '..' path
elements Junio pointed out recently.

I built these with another patch I previously submitted to make
git-config consistently use lockfile.c routines and tested it with the
regular test suite plus some extra tests Junio sent to the list for
checking git-config symlink handling.

I also built a separate executable with just the path handling routines
in it and spot-checked several cases to make sure it appeared to be
working as expected.  ('/', loop of symlinks, lots of extra slashes, .
and .. elements, etc.)

Best Regards,

Bradford
