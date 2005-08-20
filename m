From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multi-head pulling series
Date: Sat, 20 Aug 2005 11:54:54 -0700
Message-ID: <7vfyt4l9q9.fsf@assigned-by-dhcp.cox.net>
References: <7vek8rlnbn.fsf@assigned-by-dhcp.cox.net>
	<200508181245.58250.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 20:55:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6YUu-0000gk-2u
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 20:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbVHTSy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Aug 2005 14:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbVHTSy7
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Aug 2005 14:54:59 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:11937 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932781AbVHTSy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2005 14:54:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050820185454.RNHS3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 20 Aug 2005 14:54:54 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200508181245.58250.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Thu, 18 Aug 2005 12:45:58 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

>> 	$ cat $GIT_DIR/remotes/www
>> 	URL: http://www.kernel.org/pub/scm/git/git.git/
>>	Pull: master:ko-master pu:ko-pu
>>	Push: master:master pu:pu foo:bar
>
> Isn't this mixing two kinds of information:
> 1) Some default/persistent mapping of local to remote heads
> 2) The default heads which are pulled/pushed when only giving the remote

I am not convinced myself that default/persistent mapping makes
much sense, and updating the stored mappings dynamically when
the user uses non-default mappings in push/pull as a one-shot
operation does not make any sense at all at least to me.  You
should rather consider that the current specification does not
deal with (1) at all.  The set of default pull/push refs does
not make much sense without mappings for them, so that is what
the file records.
