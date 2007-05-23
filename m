From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rebase max-pack-size?
Date: Wed, 23 May 2007 00:23:10 -0700
Message-ID: <7vodkc3swx.fsf@assigned-by-dhcp.cox.net>
References: <4648848B.1030304@gmail.com>
	<7virak5cr5.fsf@assigned-by-dhcp.cox.net>
	<56b7f5510705222333l6e285e67l1dc327322a2ab250@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 09:23:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqlBo-0006oL-26
	for gcvg-git@gmane.org; Wed, 23 May 2007 09:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935AbXEWHXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 03:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756460AbXEWHXM
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 03:23:12 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:33546 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935AbXEWHXL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 03:23:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523072311.MLAZ6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 23 May 2007 03:23:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2XPA1X00B1kojtg0000000; Wed, 23 May 2007 03:23:10 -0400
In-Reply-To: <56b7f5510705222333l6e285e67l1dc327322a2ab250@mail.gmail.com>
	(Dana How's message of "Tue, 22 May 2007 23:33:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48147>

"Dana How" <danahow@gmail.com> writes:

> Patch 1:
> * Pull "sha1flush()" or similar out of sha1close() inside csum-file.c.
>  This will require some edits to callers.
>
> Patch 2:
> * Add a comment to "confusing loop" to explain what it's checking.
> * Complain about --stdout && --max-pack-size combination.
>
> This will have to happen tomorrow.
>
>> And I have to agree with Linus; responding this way was more
>> cumbersome than it should have been.
> Understood.
>
> Thanks,

Although I mentioned it, as we have only one caller that does
not want to close the file, we probably do not need the first
patch right now.

Also thanks for the clarification on the (nr_result != nr_objects)
stuff -- it should have been obvious, as I was the guilty party
who originally introduced that condition (i.e. "thin" packs).
