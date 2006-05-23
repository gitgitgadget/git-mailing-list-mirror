From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Set the executable bit on gitMergeCommon.py.
Date: Tue, 23 May 2006 01:34:53 -0700
Message-ID: <7virnx5ec2.fsf@assigned-by-dhcp.cox.net>
References: <20060523081238.GB4038@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 10:35:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiSMF-0002JK-4Z
	for gcvg-git@gmane.org; Tue, 23 May 2006 10:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWEWIfL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 04:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWEWIfL
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 04:35:11 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:30655 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932123AbWEWIfK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 04:35:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060523083509.XKMP15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 May 2006 04:35:09 -0400
To: "Peter Eriksen" <s022018@student.dtu.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20586>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

> From: Peter Eriksen <s022018@student.dtu.dk>
> Date: Mon, 22 May 2006 15:35:42 +0200
>
> Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>

It makes some sense to make git-merge-recursive.py executable,
just in case somebody wants to run it without preprocessing.

However, gitMergeCommon.py is a module without the main program.
It does not even have the usual "primarily meant to be a library
but you could run it standalone" idiom at the end:

	if __name__ == '__main__': test()

So I am not sure if this patch makes sense -- does it misbehave
on your system when installed without +x bit?
