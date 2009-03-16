From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: Generalised bisection
Date: Mon, 16 Mar 2009 22:47:09 +0000
Message-ID: <efe2b6d70903161547m4cb8b16co542e2f7bb3afd043@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <efe2b6d70903111515p2b9f656bp186d0b3cc7ae483d@mail.gmail.com>
	 <43d8ce650903112345x3d40b70ap7e4c0f8c7d0b6069@mail.gmail.com>
	 <alpine.DEB.1.00.0903121154560.10279@pacific.mpi-cbg.de>
	 <d9c1caea0903121102y5452603fua0e7a1b82e121b01@mail.gmail.com>
	 <efe2b6d70903130549m63ae9bdeg1cd3f24a43b3e66f@mail.gmail.com>
	 <d9c1caea0903130819u770686b1w867f074ffef8fabf@mail.gmail.com>
	 <efe2b6d70903151216q4a8881e5t797cf5d3bebc5697@mail.gmail.com>
	 <d9c1caea0903160329v3c1a1600m9913eafa00cc2f37@mail.gmail.com>
	 <43d8ce650903160337p5a48c429nd9efd7f35e66248d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Tweed <orthochronous@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 23:49:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjLcZ-0003Xk-EH
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 23:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527AbZCPWrP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2009 18:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754413AbZCPWrO
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 18:47:14 -0400
Received: from mail-bw0-f175.google.com ([209.85.218.175]:35586 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425AbZCPWrM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 18:47:12 -0400
Received: by bwz23 with SMTP id 23so1162421bwz.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 15:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yehtJO83rYnGgasnME8+He4iJNGi/5moZiJoHhddAoo=;
        b=BQGWDhlS84iX/Hi0zYIhjANYOCTbQWzcHY7yHvVzsFaW36Cz85V19e5ai/1CKxtv5R
         WYQ7XwHZd0ynaIE3NUoOxVrMqcJW5Sc6uqWVWfiJ1G8gvgvgSgvbORikN5FW9IWXfybd
         V4yLQLr46XD3BBpBmjZgW0ktBBxkTgqaI2zUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YcFh4euv4aTzSYmEdSfSvWbnvls3/UR6b88PYQtumbwqrWUor2G+cZ+4fQBO0UoHsi
         cCAtTwNUH07qyp8UbNr1aPYioQkUEjO0RkJ5Jfz/4CGvVrILDDFrymxgRsHGg4/oj+nT
         im8IT7MTlku/XdAyPlEB/ireEsAbRRJEhiP0c=
Received: by 10.204.119.133 with SMTP id z5mr1792248bkq.86.1237243629373; Mon, 
	16 Mar 2009 15:47:09 -0700 (PDT)
In-Reply-To: <43d8ce650903160337p5a48c429nd9efd7f35e66248d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113401>

On Mon, Mar 16, 2009 at 10:37 AM, John Tapsell <johnflux@gmail.com> wro=
te:

> I think it's reasonable to expect false-positives as well as
> false-negatives. =A0e.g. you're looking for a commit that slows down =
the
> frame rate. =A0But on one of the good commits the hard disk hits a ba=
d
> sector and takes a bit longer to retrieve data and so you get a
> false-positive.

It's true that you could get false positives, as you say. What's less
obvious to me is whether it would be a good idea for the algorithm to t=
ry
to deal with them, or just report the earliest revision that failed
and leave it
up to the intelligence of the user to decide whether it is a false posi=
tive,
and what to do about it.

In the absence of some user-provided way of  discriminating, the only w=
ay
I can see for the algorithm can distinguish between revisions affected =
by
 the real bug as opposed to ones affected by false positives is to
assume that
the false positives occur at some lower rate. There are two
difficulties with this:
first, presumably it would have to start sampling more times at some lo=
cations
in order to figure out what the rate is at them. This sounds like it
would be expensive -
currently the algorithm can usually get away with looking at most locat=
ions no
more than once.  Secondly, I'm not sure how to justify this
assumption, or model it.
In short, false positives look like a can of worms to me; I'm hoping
the algorithm is
useful without considering them.

The algorithm actually has one potentially problematic assumptions
already - or rather,
it has two alternative assumptions, neither of which is completely beli=
evable.
It can either assume that the bug causes faults at the same rate in
all affected revisions,
or that the affected revisions each have their own completely
independent rate. Originally
I thought that the latter would be the more conservative assumption -
it certainly assumes less.
However, the following argument convinces me that the other one is
actually more conservative:

Suppose that in the latest revision, we observe a fault in one run out
of ten. Under the second
assumption, this observed rate has no effect on our belief about the
fault rate in other affected
revisions, if any. This means that with a uniform prior on the fault
rate, we more or less start out
assuming a fault rate of 50% on any other affected revisions - much
higher, implausably so.
 If any of them  are only affected at a rate of one in ten, the
algorithm is quite likely to terminate without
seeing a fault there, concluding that the bug was introduced later
than it really was.

On the other hand, we know quite well that the fault rate isn't
necessarily going to  be
identical either.  Of the two, I think the assumption of identical
rates is the more practical one, more
likely to actually identify the correct location. It does leave me
wondering whether some intermediate
assumption would more accurately represent our experience of fault
rates, but I haven't thought of a
really convincing one.

Ealdwulf.
