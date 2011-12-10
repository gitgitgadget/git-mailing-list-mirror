From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about commit message wrapping
Date: Sat, 10 Dec 2011 20:30:14 +0100
Message-ID: <201112102030.15504.jnareb@gmail.com>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com> <m3zkf1hnh9.fsf@localhost.localdomain> <E085218D-9287-4F82-B34C-8379742F818A@sidneysm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sidney San =?utf-8?q?Mart=C3=ADn?= <s@sidneysm.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:30:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZSdB-0000cO-15
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 20:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083Ab1LJTaU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Dec 2011 14:30:20 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59545 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab1LJTaS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 14:30:18 -0500
Received: by eaak14 with SMTP id k14so2246868eaa.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 11:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=LoSUONoChqK0kyuwtsl4CCV9aGZIFdsZPSQbY0Q3m0w=;
        b=QHwYvJ/lmDxGogIePZvrtaabZHlO70bTdRu9WHciKaEzUH4tJanpVQY9Aatcm5F+za
         WtljQYjs6KwnVnTV77yaQkEK2rx+Gtbd1alZtcv1tsbfWdFWk9HRiDov9fSeFOaqY/Pf
         w3eIuXRtgnxQ0hlBCEMOMPnH5NOW68EtHdJvA=
Received: by 10.213.35.12 with SMTP id n12mr923581ebd.25.1323545416768;
        Sat, 10 Dec 2011 11:30:16 -0800 (PST)
Received: from [192.168.1.13] (abvt218.neoplus.adsl.tpnet.pl. [83.8.217.218])
        by mx.google.com with ESMTPS id q28sm49998750eea.6.2011.12.10.11.30.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 11:30:15 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <E085218D-9287-4F82-B34C-8379742F818A@sidneysm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186788>

On Fri, 9 Dec 2011, Sidney San Mart=C3=ADn wrote:
> On Dec 9, 2011, at 8:41 AM, Jakub Narebski wrote:
>> Sidney San Mart=C3=ADn <s@sidneysm.com> writes:
>>=20
>>> *Nothing else* in my everyday life works this way anymore. Line
>>> wrapping gets done on the display end in my email client, my web
>>> browser, my ebook reader entirely automatically, and it adapts to
>>> the size of the window.
>>=20
>> The problem with automatic wrapping on the display is that there cou=
ld
>> be parts of commit message that *shouldn't* be wrapped, like code
>> sample, or URL... and in plain text you don't have a way to separate
>> flowed from non-flowed part.
=20
Additional and the more serious problem with wrapping on output is
related to backward compatibility.  If you have commit message that is
wrapped e.g. to 80 characters, and you wrap on output to 72 characters,
you would get ugly and nigh unreadable ragged output:

original:

  Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eius=
mod
  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
  veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex =
ea
  commodo consequat. Duis aute irure dolor in reprehenderit in voluptat=
e
  velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
  occaecat cupidatat non proident, sunt in culpa qui officia deserunt
  mollit anim id est laborum.

wrapped to 70th column:

  Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
  eiusmod
  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
  minim
  veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip
  ex ea
  commodo consequat. Duis aute irure dolor in reprehenderit in
  voluptate
  velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
  occaecat cupidatat non proident, sunt in culpa qui officia deserunt
  mollit anim id est laborum.

You can re-wrap, but this is more code, and additional problems, like
with ASCII-art like this or pseudo-Markdown headers like this
               ^^^^^^^^^

  Header
  =3D=3D=3D=3D=3D=3D
=20
> I usually lead code, URLs, and other preformatted lines like this wit=
h
> a few spaces. Markdown uses the same convention, and it looks like
> commits in this repo do too. =20
>=20
> The patch in my last email prints lines which begin with whitespace
> verbatim. How does that work?=20

What about lists done using hanging indent, e.g.:

  * Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua.
=20
or

  - Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua.

or

 1. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua.

>> Also with long non-breakable identifiers you sometimes need to wrap =
by
>> hand (or use linebreaking algorithm from TeX) or go bit over the lim=
it
>> to make it look nice.
>=20
> Could you elaborate on this? The patch uses strbuf_add_wrapped_text,
> which was already in Git. If an identifier is longer than the wrap
> width, it leaves it alone. =20

The line breaking algorithm of TeX typesetting engine takes into accoun=
t
look of whole paragraph (well, mathematical representation of "good loo=
k")
before breaking lines and hyphenating words.

What I meant here that if you have long identifier, naive line-breaking
(word-wrapping) algorithm could leave the paragraph unbalanced, with on=
e
or more lines much shorter than the rest, while allowing one line to be
overly long over 1 character leads to nicely wrapped result.


BTW. In Polish (and Czech) typography there is rule that you don't leav=
e
single-letter prepositions like 'i' ('and' in English) hanging at the e=
nd
of the line... automatic wrapper cannot ensure that.
=20
>> BTW. proper editor used to create commit message can wrap it for you
>> ;-).
>=20
> Only if everybody else in the world does it too!

Educate.

> And only if I never care about seeing my commits at any width besides
> 80 columns. =20

Overly long lines are hard to read, and sometimes fit-to-width would gi=
ve
us too long lines to read comfortably.


Anyway I am not against adding support for wrapping commit message and
tag payload, but IMHO it must be *optional*: --no-wrap, --wrap=3Dauto
(or just --wrap), --wrap=3D80, and log.wrap or core.wrap.

--=20
Jakub Narebski
Poland
