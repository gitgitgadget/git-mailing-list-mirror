From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: [Q] merging from one (kernel) stable to another?
Date: Mon, 30 Mar 2009 14:51:33 +0200
Message-ID: <200903301451.33956.brian.foster@innova-card.com>
References: <200903301024.08848.brian.foster@innova-card.com> <200903301358.48864.brian.foster@innova-card.com> <49D0B8BF.2000502@op5.se>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	git mailing list <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Mar 30 14:53:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoGzf-0002qa-W4
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 14:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbZC3MwF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 08:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbZC3MwD
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 08:52:03 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:62352 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbZC3MwB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 08:52:01 -0400
Received: by ewy9 with SMTP id 9so2040426ewy.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=Tdwuuq8CUMEAAK11xT1A7iEoH5t62gZgTFv+T+hDeE8=;
        b=rzWpduc+2Ik4uV2uCvWSnHnzKUeMr/GX7FHmoitkFmuat42YamCARqy8jQJ3lYnNCe
         0jgUqc4XgOIeAvGcuwO794OSb1WYGbc10MhHLqmApYSoQ4rg9Y8G4Rt2mOkr6HWbyob6
         roK9UJjBdBx1er+iJ/0BmHw4I4d5W8qPBIsns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PGbBFR8u1UIi2/yxxbSjrkzD7yUAV3zt8jdtFaf5i1bsuiFkSM34wyM980dggLVu17
         sED7ggSvH1E15qExA1LKkT0jLipTsgI+qnxDeVt0d/TBJfHZqP+02b48N+Dp3HIHwvgY
         GyytvpzEEPy5sdcV7/NxRC03LSTPn/kuna6Qg=
Received: by 10.210.36.10 with SMTP id j10mr2603494ebj.31.1238417518436;
        Mon, 30 Mar 2009 05:51:58 -0700 (PDT)
Received: from innova-card.com (LRouen-152-82-23-47.w80-13.abo.wanadoo.fr [80.13.118.47])
        by mx.google.com with ESMTPS id 4sm4557676ewy.80.2009.03.30.05.51.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 05:51:57 -0700 (PDT)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; x86_64; ; )
In-Reply-To: <49D0B8BF.2000502@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115147>

On Monday 30 March 2009 14:19:11 Andreas Ericsson wrote:
> Brian Foster wrote:
> >[ ... ]
> >   (1)  Create a patch which is all (local) changes
> >          (n=C3=A9e diffs) from linux-mips.21 to our.21;
>=20
> This is wrong.  Create several git-patches, each containing
> the equivalence of one commit (complete with diff, author
> info and commit message).

  Yes, I was being sloppy there.  Internally, we use both
 `git format-patch' and `git am', but have a bad(?) habit
 of referring to a patch series as =E2=80=9Ca patch=E2=80=9D.  Apologie=
s
 for the confusion.  Sorry!

> >   (2)  Checkout linux-mips.26.8 (e.g.);
> >   (3)  Apply the patch created in (1), above;
>=20
> Except it'll be "apply the patches, re-creating history
> as if it had been done with a different base from the
> start".

  Yes.

> >   (4)  Tag the result `like-this';
> >   (5)  Checkout our.21;  and
> >   (6)  Merge with `like-this'.
>=20
> Merge is not necessary.

  <Shrugs/>  I'll going to try in both ways (with and without
 merging) to better understand just what the results are like.

> >  I admit that now that I write the steps out, it seems
> >  to make sense ....?   Am I understanding correctly?
>=20
> Almost. "git help format-patch" and "git help am" will get
> you the rest of the way, I think.

  ;-)   Well, I did say =E2=80=9CRTF<a named>M=E2=80=9D is useful....!

  Many thanks for your patient and very helpful replies.
cheers!
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
