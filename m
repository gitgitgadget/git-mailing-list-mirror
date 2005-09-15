From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-daemon --inetd
Date: Thu, 15 Sep 2005 12:57:34 -0700
Message-ID: <7vek7qyuhd.fsf@assigned-by-dhcp.cox.net>
References: <43290EFF.3070604@zytor.com>
	<Pine.LNX.4.58.0509150829090.26803@g5.osdl.org>
	<4329BDD9.4010507@zytor.com>
	<Pine.LNX.4.58.0509151142570.26803@g5.osdl.org>
	<4329C93D.2020701@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 22:00:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFzrX-0004v0-QR
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 21:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbVIOT5h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 15:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbVIOT5h
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 15:57:37 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:13804 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030424AbVIOT5g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 15:57:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050915195736.UYXS8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Sep 2005 15:57:36 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4329C93D.2020701@zytor.com> (H. Peter Anvin's message of "Thu,
	15 Sep 2005 12:19:25 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8636>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Could git-upload-pack be integrated into the git-daemon binary, so that 
> the exec isn't needed?

In the longer term, I'd like to extend git-daemon-export-ok to
mean:

    - the presense of empty file means any supported operation
      not just git-upload-pack is allowed for backward
      compatibility.

    - otherwise list of allowed git-* server side program.

and be able to extend daemon.c:execute() function to check
and execute server side programs other than git-upload-pack.  So
the answer from me is a mild no.
