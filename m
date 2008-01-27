From: "Marko Kreen" <markokr@gmail.com>
Subject: Re: I'm a total push-over..
Date: Sun, 27 Jan 2008 11:45:25 +0200
Message-ID: <e51f66da0801270145w41a94414g7bebd4a31293344d@mail.gmail.com>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
	 <4797518A.3040704@op5.se>
	 <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com>
	 <4798B633.8040606@op5.se>
	 <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com>
	 <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org>
	 <e51f66da0801251252r1950c2d5g12caa5e71b9a37a@mail.gmail.com>
	 <alpine.LFD.1.00.0801251407010.5056@hp.linux-foundation.org>
	 <e51f66da0801260416p5f5ffb98w16fe832fe62dc7c9@mail.gmail.com>
	 <alpine.LFD.1.00.0801262247140.3222@www.l.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Andreas Ericsson" <ae@op5.se>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 10:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJ45P-0008Op-4x
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 10:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbYA0Jp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 04:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbYA0Jp2
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 04:45:28 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:21742 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbYA0Jp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 04:45:26 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1279629fga.17
        for <git@vger.kernel.org>; Sun, 27 Jan 2008 01:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8/fz1YeHqjgy3WLzlLfDkcX8WRAUEiCBjAwnYUut4rM=;
        b=Yk0Z4ocDgyvlHJuK0jvcavfa6m+s7jgwG8reH6fZfFJbtkorP7pxHK9wTBmph42Pm38w205j5XQ3Sn9CQvgX71rOPAj0rf9Hf26yFUFrkzOZcuXNHa7mQN1WvLjCN9SOdCBWPnoNo6ll0+OHT1zuiChD6n0Hel4QwEUS3+uLecs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JMeKCSbrbob8l64rBd5+FsqWRuUJq3t8YbKeZIlMOaL4Bj7l8TNkKCGX3Mi++T3hO/g0zMeeLw4csopAl9X0Z682ZC5wys1r/4gooFqJi3YjoXLmLVjVOYRSXXWBulKllukLHL+t+uYYwOu1XHg7ngiJ4naCxZgA2fDrVO1b7PE=
Received: by 10.78.162.4 with SMTP id k4mr5417918hue.66.1201427125174;
        Sun, 27 Jan 2008 01:45:25 -0800 (PST)
Received: by 10.78.200.6 with HTTP; Sun, 27 Jan 2008 01:45:25 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801262247140.3222@www.l.google.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71811>

On 1/27/08, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sat, 26 Jan 2008, Marko Kreen wrote:
> >
> > Here you misunderstood me, I was proposing following:
> >
> > int hash_folded(const char *str, int len)
> > {
> >    char buf[512];
> >    do_folding(buf, str, len);
> >    return do_hash(buf, len);
> > }
> >
> > That is - the folded string should stay internal to hash function.
>
> If it's internal, it's much better, but you still missed the performance
> angle.
>
> The fact is, hashing can take shortcuts that folding cannot do!
>
> Case folding, by definition, has to be "exact" (since the whole point is
> what you're going to use the same folding function to do the compare, so
> if you play games with folding, the compares will be wrong).
>
> But hashing doesn't have to be exact. It's ok to hash '{' and '[' as if
> they were different cases of the same character, if that gives you a
> faster hash function. Especially as those charactes are rather rare in
> filenames.
>
> So if you do hashing as a function of its own, you can simply do a better
> job at it.
>
> I do agree that the functions that create a folded set of characters from
> a _complex_ UTF-8 character should be shared between folding and hashing,
> since that code is too complex and there are no simple shortcuts for doing
> a faster hash that still retains all the properties we want.

Well, you can always have fold_quick_and_dirty() function that
is used only internally in hash_folded() function, which can:

- fold with simple |= 0x20202020..
- write out full uint32/64, no need to make result proper string
- zero-fill at the end, so hash function does not need to check
  for partial block, which is pretty expensive part of hashing.

The win would be:
- more modularized code
- can use faster/any hash
- hash function can be certain to work on aligned data
  (win on non-x86)

The minus:
- some memory i/o overhead which may or may not matter
- the parts would not be fully generic, but special to hashing


-- 
marko


PS. Typo in last mail - "inner loop should be reversible - that
means that details from beginning of data should shift out of
horizon."  That obviously means "data should _not_ shift
out of horizon.

btw, "reversible" for integer hashes means that there is 1:1
mapping between input and output - no collisions.  Thus
no info loss.
