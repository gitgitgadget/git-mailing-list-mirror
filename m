From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Strange cogito behaviour
Date: Tue, 1 Aug 2006 16:41:16 +0100
Message-ID: <200608011641.20077.andyparkins@gmail.com>
References: <200608011053.25112.andyparkins@gmail.com> <20060801151258.GB3923@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1301681.62zSTv9fCe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 01 17:41:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7wNB-0005Gd-PW
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 17:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWHAPla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 11:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWHAPla
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 11:41:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:12518 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030362AbWHAPla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 11:41:30 -0400
Received: by nf-out-0910.google.com with SMTP id o25so310499nfa
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 08:41:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=bxoDg6joVlrfePu8ZW8etZ4R86tRRqoqsZ9MRc9+FQdR8Q8v7ul4RYsmkisoS1E9kH8wVsfqinkeiWe/7ksGAkJdtsPHVBKHuAxYBSwiLMvwwKVxZhdWJhliI7UVD38+BY8oz6Y3vbBjOyw/4XK4OFtfiYZ/uvI5hl2iGAjS7ew=
Received: by 10.49.29.2 with SMTP id g2mr945791nfj;
        Tue, 01 Aug 2006 08:41:28 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.gmail.com with ESMTP id b1sm56705nfe.2006.08.01.08.41.22;
        Tue, 01 Aug 2006 08:41:23 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <20060801151258.GB3923@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24602>

--nextPart1301681.62zSTv9fCe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2006 August 01 16:12, Jeff King wrote:

> A cogito fetch without a branch specifier defaults to the remote HEAD,
> not master.  This is the documented behavior (see cg-branch-add(1)). I
> agree it is confusing (I also thought it was a bug until I looked it up

=46air enough.  If it is working as intended, then I have no complaint.


> > The script then continues with
> >  * Switch repo1 back to master branch
> >  * Update repo2
> > This time repo2 doesn't change.  So I'm more confused :-)
>
> This is because repo2's master is already at the branch, and repo1 is a
> subset of that history. There is no need to merge since repo2 already
> contains all of the commits in repo1 (plus another one which is only on
> the branch in repo1).

I think I see now.  repo2 is neither repo1#master nor repo1#branch because =
it=20
actually went like this:
 * repo1 cloned to repo2, repo2#master is repo1#master
 * repo2 fetches repo1#branch and /merges/ those changes
 * repo1#HEAD switched to HEAD=3Dmaster
 * repo2 fetch does nothing because repo2 is actually
   repo1#master + repo1#branch, hence is newer than both
   repo1#master and repo1#branch
That explanation seems to fit exactly with the observed results, so would s=
eem=20
to be plausible.

Thank you for your help; I of course withdraw my bug report and apologise f=
or=20
bothering you all :-)


Andy


=2D-=20
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com

--nextPart1301681.62zSTv9fCe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEz3YgwQJ9gE9xL20RAoaHAJ95i/WxvSFpEuq8UVzs21QnxkEz7QCdG2Ok
xRkQaE4CGzMmBKYtAauybMk=
=mvEj
-----END PGP SIGNATURE-----

--nextPart1301681.62zSTv9fCe--
