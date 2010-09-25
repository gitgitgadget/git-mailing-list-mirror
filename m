From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: svn-fe status
Date: Sat, 25 Sep 2010 12:25:06 +0200
Message-ID: <AANLkTi=sij9TeY+Cv85n61xt3R6nPbkpOyKdoDMzbtaD@mail.gmail.com>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes> <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino> <20100924065900.GA4666@burratino> <20100925051926.GA19804@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 12:25:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzRwj-0007lf-MT
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 12:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108Ab0IYKZ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 06:25:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49209 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755842Ab0IYKZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 06:25:27 -0400
Received: by gwj17 with SMTP id 17so1199384gwj.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 03:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=DYnVffkg+gRWITmaXRZqspanb2Urqpa8IXDyQLrsahY=;
        b=MHcm/VZ3glc7WT9W32gr1IILSFC4kQ4ggfw0dtlVOVzaa4U6KCuINGf848/qUE96zP
         ehVQqga346UStD380A5IAM9tYWWJ4KU3vgF2jht9T9/WA3i0CxAzTwWfGT+5IvS3RyPO
         puti8cKiQ3kDCmmmjILtPpjOavyoyBk8CPVOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xYV+nqSnZDqDtPm5/uT4s03wSxTkS8T09KPyqBBHEbJz76tNrCoaam7YcvlF3sARZt
         Y9gNqLIdA1x6gupOqCxF1w4MZsLNsYoaZmz2/04hSpqyl5wejN50uJ8lHR/0LQCNlcst
         gSWjYW78yz1MSKk/Kq2ifqd0J0z5iTZiwWnpc=
Received: by 10.150.177.17 with SMTP id z17mr5828401ybe.122.1285410326646;
 Sat, 25 Sep 2010 03:25:26 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Sat, 25 Sep 2010 03:25:06 -0700 (PDT)
In-Reply-To: <20100925051926.GA19804@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157141>

Heya,

On Sat, Sep 25, 2010 at 07:19, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Now the features that would be most useful from fast-import become a
> bit clearer. =C2=A0Since a single svn revision can make multiple chan=
ges to
> a file, the ability to read back the currently staged content for the
> current revision would be helpful, like this:

Yes, that makes sense.

> =C2=A0from refs/remotes/origin/root^0
> =C2=A0M 100644 :72:"trunk/README" "branches/topic/README"

Shouldn't that be 'C' for copy? Of course, this should also be guarded
by a feature.

> =C2=A01. use ':<mark>:<path>' references to retrieve data from a
> =C2=A0 =C2=A0previous revision

I like this a lot better than the previous "catting the contents of a
commit to find the tree to find the file hash to cat the file
contents". I don't think there needs to be a colon after the mark
though, I'd prefer reserving the colon character for marks and instead
introduce a copy operation.

> =C2=A02. use 'cat <path>' references to retrieve data from the
> =C2=A0 =C2=A0current revision.

You'll thank yourself later if you add an (optional?) mark to cat, so
that you can cat previous versions of a file too? Doesn't svn ever
give you a diff against -. ... never mind! You don't need that, since
you can just copy the contents you want over first! Ok, great, that
works :).

> David's and Ram's discussions and patches from the last two weeks (or
> at least the part I have understood) have been very helpful.

Keep up the great work!

--=20
Cheers,

Sverre Rabbelier
