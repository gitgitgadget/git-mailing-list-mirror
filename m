From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Sun, 20 May 2007 12:16:04 -0700
Message-ID: <7vd50vl30r.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com>
	<7vabvzq0bb.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550705200334pef694cn1a7842c23e2672f5@mail.gmail.com>
	<7vabvzoij8.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550705200545kcf1f7f9n4f3f6d7d25955e1@mail.gmail.com>
	<7v1whbmjel.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550705201156m244e1cf0v7e6b3ab43fa3b47b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 21:16:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpqt0-0001kv-Mg
	for gcvg-git@gmane.org; Sun, 20 May 2007 21:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879AbXETTQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 15:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755613AbXETTQG
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 15:16:06 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:50523 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879AbXETTQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 15:16:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520191605.QIST19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 20 May 2007 15:16:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1XG41X00T1kojtg0000000; Sun, 20 May 2007 15:16:05 -0400
In-Reply-To: <e5bfff550705201156m244e1cf0v7e6b3ab43fa3b47b@mail.gmail.com>
	(Marco Costalba's message of "Sun, 20 May 2007 20:56:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47891>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 5/20/07, Junio C Hamano <junkio@cox.net> wrote:
> ...
>> > diff --git a/builtin-apply.c b/builtin-apply.c
>> > index 0399743..6032f78 100644
>> > --- a/builtin-apply.c
>> > +++ b/builtin-apply.c
>> > ...
>> > @@ -1770,6 +1800,10 @@ static int apply_one_fragment(struct buffer_desc *desc,
>> >               if (match_beginning && offset)
>> >                       offset = -1;
>> >               if (offset >= 0) {
>> > +
>> > +                     if (desc->size - oldsize - offset == 0) /* end of file? */
>> > +                             newsize -= trailing_added_lines;
>> > +
>> >                       int diff = newsize - oldsize;
>> >                       unsigned long size = desc->size + diff;
>> >                       unsigned long alloc = desc->alloc;
>>
>> But we have kept our sources -Wdeclaration-after-statement
>> clean so far
>
> ??????
>
> Wie bitte?

Sorry I forgot to mention that that is "trivial" so there is no
reason to resend.  I don't expect me doing much git stuff for
the rest of the day, but you'll hear from me about this patch
later (hopefully it would appear on 'next' -- we'll see).
