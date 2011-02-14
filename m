From: Norbert Thiebaud <nthiebaud@gmail.com>
Subject: Re: libreoffice merge issue ...
Date: Mon, 14 Feb 2011 10:52:26 -0600
Message-ID: <AANLkTik9icGApTP+0C+ANWsLZBb8HVTXo-cyW3kKEppw@mail.gmail.com>
References: <1297699635.31477.253.camel@lenovo-w500>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kendy <kendy@novell.com>
To: michael.meeks@novell.com
X-From: git-owner@vger.kernel.org Mon Feb 14 17:52:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp1f8-0002E7-1C
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 17:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087Ab1BNQw2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 11:52:28 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48661 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965Ab1BNQw1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 11:52:27 -0500
Received: by iwn9 with SMTP id 9so4992997iwn.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 08:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vFGDb4fvXVaD/GGELfke4n1D8sUuDIYViL+J9IvQVy8=;
        b=OWnbbA8Y3qG6hIOJT8sLlXnmAumxARhlBf/MR7YwbeYmr6aFjgNTQ29lEu00u8mLCh
         uVlwTF+uwhX3flVCfcsabey7EYptYAqLYZzNEcxOFlSdgn5RGuWtfXIQ1ihdVoi5Mg7k
         meNPGwHIci/+uKZjx0KLI88Q1KYC5scRqsMa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uX5Ayj2yet9LjAj4lUL4R5tUlB2S7f00W/RvNCLgQ+V8Z8qE1kPlJWs/wzamhz/z6S
         SDOtt1YPXdwbtUx79fXBeKX7D67PHbQzQg0OJ8+9ucxJ76KUazcULrvwhJXhh29GodNC
         Wmlvf5hnAunZEwFBoSOftgbndzXEbBoL+k5UU=
Received: by 10.231.36.75 with SMTP id s11mr3120203ibd.130.1297702346623; Mon,
 14 Feb 2011 08:52:26 -0800 (PST)
Received: by 10.231.14.132 with HTTP; Mon, 14 Feb 2011 08:52:26 -0800 (PST)
In-Reply-To: <1297699635.31477.253.camel@lenovo-w500>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166735>

On Mon, Feb 14, 2011 at 10:07 AM, Michael Meeks
<michael.meeks@novell.com> wrote:
> Hi guys,
>
> We are having quite some fun merging git branches with LibreOffice, a=
nd
> I stumbled over this just now with master git with hash:
> 00e6ee724640701b32aca27cc930fd6409c87ae2
>
> Setup (some large repos):
>
> =A0 =A0 =A0 =A0git clone git://anongit.freedesktop.org/libreoffice/li=
bs-core
> =A0 =A0 =A0 =A0git checkout integration/dev300_m98
> =A0 =A0 =A0 =A0git remote add stage git://anongit.freedesktop.org/lib=
reoffice/staging/@REPO@

correction: this should read
        git remote add stage
git://anongit.freedesktop.org/libreoffice/staging/libs-core

or you should use ./g instead of git for all these 3 git operations

Norbert


> =A0 =A0 =A0 =A0git fetch stage
>
> =A0 =A0 =A0 =A0Test[1]:
>
> =A0 =A0 =A0 =A0git merge stage/premerge/dev300_m98
> =A0 =A0 =A0 =A0git diff idl/source/cmptools/lex.cxx
>
> =A0 =A0 =A0 =A0yields:
>
> @@@ -147,11 -147,7 +147,15 @@@ SvToken & SvToken::operator =3D ( cons=
t S
> =A0******************************************************************=
*******/
> =A0void SvTokenStream::InitCtor()
> =A0{
> ++<<<<<<< HEAD
> =A0+#ifdef DOS
> =A0+ =A0 =A0SetCharSet( CHARSET_ANSI );
> =A0+#else
> =A0 =A0 =A0SetCharSet( gsl_getSystemTextEncoding() );
> =A0+#endif
> ++=3D=3D=3D=3D=3D=3D=3D
> ++ =A0 =A0SetCharSet( gsl_getSystemTextEncoding() );
> ++>>>>>>> stage/premerge/dev300_m98
> =A0 =A0 =A0aStrTrue =A0=3D "TRUE";
> =A0 =A0 =A0aStrFalse =3D "FALSE";
> =A0 =A0 =A0nLine =A0 =A0 =A0 =3D nColumn =3D 0;
>
> =A0 =A0 =A0 =A0With the above master hash; whereas with v1.7.3.4 it y=
ields nothing (as
> it should IMHO) - we havn't edited things around that chunk in master=
=2E
>
> =A0 =A0 =A0 =A0That is slightly concerning; thoughts much appreciated=
=2E Incidentally,
> the whole 'make install' installs into ~/bin was extremely unexpected
> and yielded 30minutes of pain trying to work out what was installed
> where and why, and the interaction with --prefix, and ... now it seem=
s I
> should always run rehash; git --version before any command, and sanit=
y
> check things ;-)
>
> =A0 =A0 =A0 =A0Thanks,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Michael.
>
> [1] - potentially you need:
> [merge]
> =A0 =A0renamelimit =3D 20000
> in your ~/.gitconfig
> --
> =A0michael.meeks@novell.com =A0<><, Pseudo Engineer, itinerant idiot
>
>
>
