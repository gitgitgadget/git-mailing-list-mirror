From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 11:46:16 -0700
Message-ID: <7vsm0jyryf.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505191426000.20274@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 20:48:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYq2b-0001Hf-7p
	for gcvg-git@gmane.org; Thu, 19 May 2005 20:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVESSrO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 14:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVESSrO
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 14:47:14 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:4598 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261219AbVESSqT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 14:46:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519184618.PJPZ1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 14:46:18 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0505191426000.20274@localhost.localdomain> (Nicolas
 Pitre's message of "Thu, 19 May 2005 14:29:46 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

NP> On Thu, 19 May 2005, Junio C Hamano wrote:
>> - the command line interface "-M" to read "-M" or "-M[0-9]"
>> (one digit); -M defaults to -M5 and give the cut-off point at
>> similarity score 5000, -M9 at 9000, etc.

NP> Why not a fractional value instead?  -M1 is 100% the same while -M.95 
NP> allows for some 5% changes.

We are essentially saying the same thing.  Internally diff core
uses score between 0 and 10000 but single digit proposed above
or fractional both hides that from the user by normalizing the
scale to something less arbitrary (in my case 0-9 in your case
0-1.0).



