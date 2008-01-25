From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: On pathnames
Date: Fri, 25 Jan 2008 16:55:10 +1300
Message-ID: <46a038f90801241955j672ca508q2eb691be5e1d328f@mail.gmail.com>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	 <20080123064139.GC16297@glandium.org>
	 <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
	 <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
	 <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
	 <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
	 <alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org>
	 <7vprvr7x8h.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.1.00.0801241722130.22568@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Kevin Ballard" <kevin@sb.org>, "Theodore Tso" <tytso@mit.edu>,
	"Mike Hommey" <mh@glandium.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 04:55:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIFfP-00079r-Dk
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 04:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbYAYDzP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 22:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbYAYDzO
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 22:55:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:12624 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbYAYDzM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2008 22:55:12 -0500
Received: by ug-out-1314.google.com with SMTP id z38so444486ugc.16
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 19:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3xfuo+omqOaM9jKiRJJ7ZuMh5Oy4NGN9maqyoLDryZU=;
        b=EV2HiZfdj3n3s7PBEW9HEk8iVRuilz+X3NWhEgSikIBvh/R3xBOw+Qpo1ilkBxJPuKD9qVe3jZ1aT0WxWYPSPYJPnAmzV5u6cSAyocIYbJdKDg+NJUQSswF4M2oPXzeP4F6264MHRYhf26c6lFCs2wom5SywsgiBuMpT7fTObZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nn/1Fh296aGJjxyjNq1SeLAa2FupCZel2UyoKCXYh40r5pV3/cHIgAT05YG1NdeiVc+rA5ohBAfhxy+mYCivJmyN9T+2lLQfNMiqM+cT1bkzGmLe4xGB+IeFnexMlJddxl1Z4OT9kVeVU1Fs7nxbZhklH69jTan78eYqm1NXpBc=
Received: by 10.67.20.11 with SMTP id x11mr3074760ugi.29.1201233310497;
        Thu, 24 Jan 2008 19:55:10 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Thu, 24 Jan 2008 19:55:10 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801241722130.22568@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71675>

On Jan 25, 2008 11:31 AM, Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 24 Jan 2008, Junio C Hamano wrote:
>
> > If it is a new file, we won't find any name that is equivalent
> > to $A in the index, and we use the name $A obtained from
> > readdir(3).
> >
> > BUT with a twist.
> >
> > If the filesystem is known to be inconveniently case folding, we
> > are better off registering $B instead of $A (assuming we can
> > convert from $A to $B).
>
> Why?
>
> If you have no other representation for the file name than $A already=
,
> then I don't see why Git would have to play similar evil games and
> corru^H^H^Hnvert $A into $B.  Just store $A in the index and tree
> objects and be done with it.

Because if you happen to be on a case-challenged filesystem, and you
need to add a new file - say xt_CONNBARK.c, you can, even if your FS
only has xt_connbark.c to offer to git. Granted, it's harder, but it
can be done, and it means that powerusers and wrappers around git have
a hope of dealing with it.

I think this is an excellent plan.

There is one thing that I don't see in Junio's plan -- which is
excellent -- and is

 - a warning during checkout if the index contains "equivalent" paths
that will clobber eachother during checkout.
 - an optional warning/error during add, to be raised if I am adding a
path that is equivalent to an already-existing path in the index

The second one is to support project that are known to be developed on
these non-filename-preserving platforms. So if I am on a linux host,
and I add Readme where README already exists, a warning can save me
and the project a bit of grief - and possibly catch an unintended
mistake! Because while I agree that users should be able to store any
file in git, in practice most instances of Ma"rchen/M=E4rchen case will
be due to user error (or editor/gui error).

cheers,


m
