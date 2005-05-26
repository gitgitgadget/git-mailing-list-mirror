From: Junio C Hamano <junkio@cox.net>
Subject: Re: git full diff output issues..
Date: Thu, 26 May 2005 12:36:37 -0700
Message-ID: <7vwtplbwze.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505261223240.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 21:42:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbOD5-00047d-M4
	for gcvg-git@gmane.org; Thu, 26 May 2005 21:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVEZTkh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 15:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVEZTjS
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 15:39:18 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:18592 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261720AbVEZTgj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 15:36:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526193636.QBBR550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 15:36:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505261223240.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 26 May 2005 12:25:15 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Thu, 26 May 2005, Linus Torvalds wrote:
>> 
>> So we'd change it from
>> 
>> deleted file mode 100644
>> 
>> to
>> 
>> deleted file mode 100644 arch/um/kernel/checksum.c
>> 
>> in this case..

LT> I just realized that this same thing is equally true of just plain mode 
LT> changes, where wif we don't have any content we just get

LT> 	diff --git a/name b/name
LT> 	old mode xxxx
LT> 	new mode yyyy

LT> so I might as well parse the diff header here (I don't want to repeat the 
LT> name twice for mode changes). Oh well.

So what do you want?  created and deleted would acquire path and
mode thing doesn't?  I think adding path only to "new mode" line
would be a sensible compromise, since we are interested in what
the resulting tree would look like most of the time.


