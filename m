From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Wed, 11 Apr 2007 02:32:48 -0700
Message-ID: <7vabxfp873.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org>
	<81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com>
	<Pine.LNX.4.64.0704100758430.6730@woody.linux-foundation.org>
	<81b0412b0704100848n69c99f55xa7cc96087cad7e31@mail.gmail.com>
	<Pine.LNX.4.64.0704100852550.6730@woody.linux-foundation.org>
	<7v6484vxd5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704101302480.6730@woody.linux-foundation.org>
	<7vk5wkuf35.fsf@assigned-by-dhcp.cox.net>
	<87d52bib9e.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:23:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbZCB-0006w4-CN
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 11:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbXDKJcv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 11 Apr 2007 05:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbXDKJcv
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 05:32:51 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:48956 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbXDKJcu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2007 05:32:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070411093250.VNHI1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 05:32:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id llYp1W00Q1kojtg0000000; Wed, 11 Apr 2007 05:32:50 -0400
In-Reply-To: <87d52bib9e.fsf@morpheus.local> (David =?utf-8?Q?K=C3=A5gedal?=
 =?utf-8?Q?'s?= message of
	"Wed, 11 Apr 2007 10:08:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44228>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> ...  This _will_ fail, but that is to be expected, as
>> we intend to replace that with what we just amended.  Just reset
>> it away and keep going.
>>=20
>> $ git reset --hard
>> $ git rebase --skip
>
> Wouldn't
>
> $ git rebase --onto HEAD lt/gitlink~3 lt/gitlink
>
> do the trick in one step?

It is probably more Kosher, and I used to always do that, but it
is much longer to type, and I use both perhaps 50%/50% depending
on the mood.

When the fix-up only adds stuff, 3-way merge would say that the
commit before fixing up (lt/gitlink~3 in our example, which you
are explicitly excluding, while I am letting rebase to see it)
has already been applied, in which case the procedure would not
even stop.  The case illustrated in my message which only adds a
forgotten line "fclose(f)" falls into that category.
