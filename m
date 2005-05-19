From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/1] Diff-helper update
Date: Thu, 19 May 2005 04:11:17 -0700
Message-ID: <7vis1f1ne2.fsf@assigned-by-dhcp.cox.net>
References: <7v3bslqc94.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505180821470.18337@ppc970.osdl.org>
	<7v64xgpgb0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505181110480.18337@ppc970.osdl.org>
	<Pine.LNX.4.58.0505181134470.18337@ppc970.osdl.org>
	<7vll6cnup4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505181338270.18337@ppc970.osdl.org>
	<7vacmsnl92.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Thu May 19 13:11:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYivB-0000H3-SI
	for gcvg-git@gmane.org; Thu, 19 May 2005 13:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVESLLV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 07:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVESLLV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 07:11:21 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:51904 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261537AbVESLLT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 07:11:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519111118.WZO26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 07:11:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vacmsnl92.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 18 May 2005 16:54:17 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
LT> On Wed, 18 May 2005, Junio C Hamano wrote:
>>> 
>>> I suspect doing something like this might be saner instead,
>>> assuming non raw-diffs come at the end.  

LT> It won't ever trigger, since we only exit the loop once we see EOF.

JCH> I was not talking about correctness, but the readability of the
JCH> code.  Breaking out from the loop to process raw-diff and
JCH> switching to straight copy would make our intent more explicit.

I was completely mistaken about what you were talking about.
Your output (helper's input) is (<non-diff material>* <raw-diff
material>*)*, so of course we should not break out of the main
loop.

