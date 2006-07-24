From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] upload-pack: fix timeout in create_pack_file
Date: Mon, 24 Jul 2006 00:55:18 -0700
Message-ID: <7vac6ze8t5.fsf@assigned-by-dhcp.cox.net>
References: <E1G2t9n-0005PW-72@moooo.ath.cx>
	<7vd5bvh67p.fsf@assigned-by-dhcp.cox.net>
	<E1G4uZw-0006vZ-VO@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 24 09:55:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4vHj-0003aX-5M
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 09:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWGXHzW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 03:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWGXHzW
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 03:55:22 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:35786 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932076AbWGXHzU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 03:55:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060724075520.CCCI12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Jul 2006 03:55:20 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G4uZw-0006vZ-VO@moooo.ath.cx> (Matthias Lederhofer's message
	of "Mon, 24 Jul 2006 09:10:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24133>

Matthias Lederhofer <matled@gmx.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>
>> My gut feeling is that your patch would be fine as is (have you
>> tried and confirmed that it helps cases other than slow
>> clients?)
> ... I tried a server with --timeout=600 and a client
> that cannot download the whole pack file in 10 minutes.  Without the
> patch the server closes the connection, with this patch it works.
> Additionally I tried it with a client reading so slow that the server
> was blocked for more than --timeout seconds, then the server closes
> the connection too (this is more or less the DoS case).

Thanks, that's all I wanted to know.  Let's have it.
