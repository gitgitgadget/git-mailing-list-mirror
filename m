From: Junio C Hamano <junkio@cox.net>
Subject: Re: Careful object writing..
Date: Tue, 03 May 2005 16:22:53 -0700
Message-ID: <7vr7gnsxma.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
	<81b0412b05050316045fa31c2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 01:16:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT6d1-0005rQ-6X
	for gcvg-git@gmane.org; Wed, 04 May 2005 01:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVECXW4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 19:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVECXW4
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 19:22:56 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:49303 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261908AbVECXWz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 19:22:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503232253.QQFV23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 3 May 2005 19:22:53 -0400
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b05050316045fa31c2a@mail.gmail.com> (Alex Riesen's
 message of "Wed, 4 May 2005 01:04:23 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "AR" == Alex Riesen <raa.lkml@gmail.com> writes:

AR> On 5/3/05, Linus Torvalds <torvalds@osdl.org> wrote:
>> I also change the permission to 0444 before it gets its final name.

AR> Maybe umask it first? Just in case.

In general worrying about umask when you see chmod is a good
practice, but it probably is not applicable to this particular
case.  A person with umask 077 should still get 0444 if the
SHA1_FILE_DIRECTORY is shared with other people, and if it is
not shared, his initial git-init-db would have made it 0700, so
it does not matter it the files files underneath it have 0444.

