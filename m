From: Don Zickus <dzickus@redhat.com>
Subject: Re: mailinfo: don't require "text" mime type for attachments
Date: Mon, 1 Oct 2012 09:27:46 -0400
Message-ID: <20121001132746.GV1969@redhat.com>
References: <alpine.LFD.2.02.1209301458540.11079@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 15:23:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIfxx-0004xB-BA
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 15:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445Ab2JANXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 09:23:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48477 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753076Ab2JANXG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 09:23:06 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q91DN3Vu016143
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 1 Oct 2012 09:23:04 -0400
Received: from redhat.com (dhcp-185-103.bos.redhat.com [10.16.185.103])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id q91DN1Mu026681;
	Mon, 1 Oct 2012 09:23:02 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1209301458540.11079@i5.linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206733>

On Sun, Sep 30, 2012 at 03:10:48PM -0700, Linus Torvalds wrote:
> This code goes all the way back to March of 2007, in commit 87ab79923463 
> ("builtin-mailinfo.c infrastrcture changes"), and apparently Don used to 
> pass random mbox contents to git. However, the pre-decode vs post-decode 
> logic really shouldn't matter even for that case, and more importantly, "I 
> fed git am crap" is not a valid reason to break *real* patch attachments.
> 
> If somebody really cares, and determines that some attachment is binary 
> data (by looking at the data, not the MIME-type), the whole attachment 
> should be dismissed, rather than fed in random-sized chunks to 
> "handle_filter()".

Heh.  Years ago when I tried using git as a patch-control-management
system instead of a traditional SCM,  I fed my custom git-am script an
internal kernel-mail-archives list to help process the meta data for
patches (acks, nacks, needinfo, bugzillas, etc).  It served its purpose
until we switched to a fork'd copy of patch-work.

So I haven't done 'insane' stuff in years.  :-)  I'm sure this patch is
right, but it doesn't affect me anymore.

Sorry for any problems that arose..

Cheers,
Don
