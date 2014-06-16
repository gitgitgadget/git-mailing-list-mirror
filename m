From: Caleb Thompson <caleb@calebthompson.io>
Subject: Re: [PATCH v5 4/4] commit: Add commit.verbose configuration
Date: Mon, 16 Jun 2014 15:10:37 -0500
Message-ID: <20140616201037.GA37953@sirius.local>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
 <1402603225-46240-1-git-send-email-caleb@calebthompson.io>
 <xmqqppic3dko.fsf@gitster.dls.corp.google.com>
 <20140616195057.GB28126@sirius.local>
 <xmqqzjhcpqju.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:10:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwdEp-0007rB-4S
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 22:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855AbaFPUKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 16:10:41 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50754 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750953AbaFPUKj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2014 16:10:39 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A7162648;
	Mon, 16 Jun 2014 16:10:38 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 16 Jun 2014 16:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=mesmtp; bh=kR+b50uE0VzWBjasAuGeN01u
	AzI=; b=TRMflb9NP7tG6amtkBaLoSGqErV7yJP4c8Sprosj2qzJap356KzQQ0Pl
	nG5zcR0fX/BaJyfZGkKAGucj9Tmfxa5VwRjZzi8vFUpAg18fhkxi9Q0+BOKkpDKq
	8jN+uM3Rszz13BRECNYkFHRTg1HWKNivsrK2qbEuV0X1wxT9ZtQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=kR+b50uE0VzWBjasAuGeN01uAzI=; b=DpMtkldwTL/IwsI9uEDLtHe3R3Sz
	Vco6Wj8yrH8HQb0sP6LdJmfcxVQThZPELv1ft5mKk1F/NEyoWgeQ2M1dG/Mb3bIU
	OVvIuopPIz5ekufhb2EGT1sIeElmAXsb/z+2fiGvPY+vO6r6cOw11UWg7mD8P4Ic
	EMdpCAT9iFYXeNo=
X-Sasl-enc: MPH2SE70qY4/jCQf5GMbX1oPdw9dpD6hyIZ3mhSi+RMY 1402949438
Received: from localhost (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2EEFDC007AC;
	Mon, 16 Jun 2014 16:10:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqqzjhcpqju.fsf@gitster.dls.corp.google.com>
X-PGP-Key: fp="B432 C068 2FD1 C2D0 6A8B 3951 1621 ADC2 A0AC E70A";
 id="0xA0ACE70A"; get=<http://calebthompson.io/pubkey.asc>;
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251814>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 01:06:45PM -0700, Junio C Hamano wrote:
> Caleb Thompson <caleb@calebthompson.io> writes:
>
> > On Fri, Jun 13, 2014 at 10:48:55AM -0700, Junio C Hamano wrote:
> >> Caleb Thompson <caleb@calebthompson.io> writes:
> >>
> >> > diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> >> > index 35a4d06..402d6a1 100755
> >> > --- a/t/t7507-commit-verbose.sh
> >> > +++ b/t/t7507-commit-verbose.sh
> >> > @@ -7,6 +7,10 @@ write_script check-for-diff <<-'EOF'
> >> >		exec grep '^diff --git' "$1"
> >> >  EOF
> >> >
> >> > +write_script check-for-no-diff <<-'EOF'
> >> > +	exec grep -v '^diff --git' "$1"
> >> > +EOF
> >>
> >> This lets grep show all lines that are not "diff --git" in the
> >> input, and as usual grep exits success if it has any line in the
> >> output.
> >>
> >>     $ grep -v '^diff --git' <<\EOF ; echo $?
> >>     diff --git
> >>     a
> >>     EOF
> >>     a
> >>     0
> >>     $ exit
> >>
> >> What are we testing, exactly?
> >
> > Good catch. It worked when I switched check-for-diff from
> > check-for-no-diff, but I didn't try to make check-for-no-diff fail
> > independently, so I apologize.
>
> No need to apologize at all.  None of us (including this reviewer)
> is perfect and that is why we review patches by each other.
>
> > This version removes the the beginning of a line starting with
> > "diff --git" from the string,...
>
> Again, what are we testing, exactly?
>
> We do not want to see "^diff --git" in the output file, in other
> words, we want to make sure "^diff --git" does not appear in the
> output.
>
> So
>
>         write_script check-for-no-diff <<-\EOF
>         ! grep '^diff --git' "$@"
>	EOF
>
> should be the most natural way to express what we are testing, no?

I did consider that. The reason I didn't propose that is that it doesn't catch
the unlikely case that the $1 only contains a "diff --git" line or that $1 is
empty.

Those are rather unreasonable concerns, so I'm happy to use the much more
readable version as you propose.

Caleb Thompson

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJTn089AAoJEBYhrcKgrOcK4S8IAJ+COvRoZfZsDxrgE01aeQ4Y
1GZp1i7okwkNxZoc5ZS5/FjrJAryEhCtPfRaiImI584AYo1pPbQZaQsWqyujiMyg
ho3ok4dP8IFdBu0eQaualVBBolg0xGCFeS8+t8ltyQAT6hbSAGnUJOVzvOfFBgNx
lZEcdGmgK1x0gb/7iBzAY8i15OCw/39unKyUIzNZHZ+JsxtXiS+6op13MP0SLH8f
sZVHq3aU0zsmvAD9c0ZVcK3aEF2YY7/vpCXwg/tKagrxN7P3ouxZMw8DfsoVI9Pz
oIdgjA/Gr+5hSwCJMQnXfwx8WvB+nQchjSiuCHWDjfBw8JFcnAFa6m7ct9UWngQ=
=NZSH
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
