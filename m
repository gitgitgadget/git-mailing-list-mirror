From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 14:44:57 -0700
Message-ID: <7vis1odspy.fsf@assigned-by-dhcp.cox.net>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	<1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com>
	<1115858022.22180.256.camel@tglx>
	<7vekcdmd16.fsf@assigned-by-dhcp.cox.net>
	<1115884637.22180.277.camel@tglx>
	<7vvf5ogxdu.fsf@assigned-by-dhcp.cox.net>
	<1115930845.11872.79.camel@tglx>
	<4776.10.10.10.24.1115932163.squirrel@linux1>
	<1115932872.11872.86.camel@tglx>
	<2477.10.10.10.24.1115933520.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, "Junio C Hamano" <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 23:41:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWLQf-0001QN-0O
	for gcvg-git@gmane.org; Thu, 12 May 2005 23:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVELVsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 17:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVELVrD
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 17:47:03 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:58109 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262144AbVELVpF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 17:45:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512214459.WINQ7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 17:44:59 -0400
To: "Sean" <seanlkml@sympatico.ca>
In-Reply-To: <2477.10.10.10.24.1115933520.squirrel@linux1> (seanlkml@sympatico.ca's
 message of "Thu, 12 May 2005 17:32:00 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "S" == Sean  <seanlkml@sympatico.ca> writes:

S> When an object is committed locally it is set to the local time.  You can
S> only have this feature when you use private commit objects (shared blobs
S> are okay).

This brings up an interesting possibility, which is off topic
from this thread.

You _could_ (I am not advocating this, just thinking aloud) have
GIT_OBJECT_DIRECTORY and GIT_COMMIT_OBJECT_DIRECTORY pointing at
two separate object pools, with the value of
GIT_COMMIT_OBJECT_DIRECTORY being on
GIT_ALTERNATE_OBJECT_DIRECTORIES list.  Your commits go to
GIT_COMMIT_OBJECT_DIRECTORY (local to the tree) and everything
else go to GIT_OBJECT_DIRECTORY (can be shared across trees).

Hmm.... Interesting.  My gut feeling tells me not to go there,
though.

