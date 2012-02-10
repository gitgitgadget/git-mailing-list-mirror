From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Fri, 10 Feb 2012 18:33:19 +0100
Message-ID: <20120210183319.2f56ff88@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<m339aivn4z.fsf@localhost.localdomain>
	<20120210151528.56145e0c@gmail.com>
	<201202101555.20163.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 18:33:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvuM6-0004AS-S4
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 18:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759690Ab2BJRd0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 12:33:26 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53510 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759597Ab2BJRdZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 12:33:25 -0500
Received: by eekc14 with SMTP id c14so1038214eek.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 09:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=UP7MHpLVJyysBbZXnpiQ+400/9RJOAZIlqco6LdZARs=;
        b=D7At/laCzo9xyxdSz03dW+lc5EhEGiZBk7OyVgt3dZYuu8ChzE2z1+cR7Rl/MZQqsu
         WA4MPB1WHEobiU4uYeapV2+C/3Y0uP68EUCx3l+G9mMiv9eJ9AqUxq2BTjuFz1gB2O1F
         O7miOWZcgs0RccG53IQYpilxGQHfIrn+QSD+Q=
Received: by 10.213.16.142 with SMTP id o14mr504871eba.144.1328895203609;
        Fri, 10 Feb 2012 09:33:23 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id o49sm24403386eei.0.2012.02.10.09.33.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 09:33:23 -0800 (PST)
In-Reply-To: <201202101555.20163.jnareb@gmail.com>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190424>

Jakub Narebski <jnareb@gmail.com> wrote:

> On Fri, 10 Feb 2012, Micha=C5=82 Kiedrowicz wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote:
> > > Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
> > >=20
> > > > The code that comares lines is based on
> > > > contrib/diff-highlight/diff-highlight, except that it works wit=
h
> > > > multiline changes too.  It also won't highlight lines that are
> > > > completely different because that would only make the output un=
readable.
> > > > Combined diffs are not supported but a following commit will ch=
ange it.
> > >=20
> > > I was thinking that if gitweb were to support "diff refinement
> > > highlighting", it would either use one of *Diff* packages from CP=
AN,
> > > or "git diff --word-diff" output.
> >=20
> > I think highlighting inline and side-by-side diff outputs is
> > something different from "git diff --word-diff". I find it useful f=
or
> > people who are used to these diff formats (i.e. me :).
>=20
> I was thinking about *using* "git diff --word-diff" for diff refineme=
nt
> highlighting of inline (unified) and side-by-side diff...=20
>=20

Then I must have misunderstood you. =20

> though having an option of showing word-diff would be I think a good
> idea in some cases, like e.g. documentation changes.
>=20
> > OTOH I'm not against using a dedicated package from CPAN. But I thi=
nk
> > my approach is proven to work (I use contrib/diff-highlight as a
> > filter) and more lightweight (doesn't add another dependency to
> > gitweb). Moreover, adding support for some Diff package may be done
> > later, at any moment. It's just a matter of replacing one function
> > (format_rem_add_line()) with the one that uses Diff.=20
>=20
> O.K., if it is tested code, then all is good. =20

As I wrote, I haven't taken the code as-is (for example, original
code only works for oneline changes). But the general approach is the
same.

> Well, except the fact
> that I'm rather wary about adding more code to gitweb when it is stil=
l
> single monolithic script, rather than split into packages.
>=20

Yeah, jumping between 2k'th and 5k'th line isn't a great fun. Do you
have any roadmap how to split gitweb?

> Anyway, I'll try to review those patches soon.  I like the refactorin=
g
> work (that is from what I had chance to examine).

Thanks.
