From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv2/RFC] gitweb: Prepare for splitting gitweb
Date: Wed, 14 Jul 2010 10:05:56 +0000
Message-ID: <AANLkTikDtlHwtk4j0E5vYViFVWtsV_yA5e90z-6nZb8_@mail.gmail.com>
References: <1278496676-26575-1-git-send-email-jnareb@gmail.com>
	<201007140024.58446.jnareb@gmail.com>
	<AANLkTikyxqPHkNnVaN6kLNdbjxl69e_8Yuf1-n7CwnEg@mail.gmail.com>
	<201007141125.01863.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 12:06:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYyqq-0000tc-R5
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 12:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab0GNKF6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 06:05:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50579 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab0GNKF5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 06:05:57 -0400
Received: by iwn7 with SMTP id 7so6850208iwn.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 03:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ksyy/ay5pt/VpTE4GNm2BhDwVwaXNfmUZ8htoY/B/Q4=;
        b=EaxqdKewPLu+/qwfvlNi4B/ug0GxaZBoQd5bDeKotbXAk49kshb4o+EC61Rji2ax+Z
         fhBzpUCeY9l/wtDUacHt4UnE151y4dFBR1yJGevSAba8Di5MGXEILSySRSxPiAOCGeCr
         hKS+pQMl8Tgp9Om74noF7lUW4EiYvqIHFPF7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Yhg7vHqPUrApXPn5060iaTRgVIbKvVSQyNVxvzn4eCdZ7BCrzDxNYaxoZw/02qqxw+
         oen58YzZivWgLWoGW6YilOs1IMEzuAqLWbj95maDDWq4CHKDHpMQCbqoELZAjQPrr23E
         Thb6ZTfwFSuHSujGB0+SDxbBHJya9KfVruLhE=
Received: by 10.231.31.197 with SMTP id z5mr17064360ibc.80.1279101956955; Wed, 
	14 Jul 2010 03:05:56 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 14 Jul 2010 03:05:56 -0700 (PDT)
In-Reply-To: <201007141125.01863.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150976>

On Wed, Jul 14, 2010 at 09:24, Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 14 Jul 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Jul 13, 2010 at 22:24, Jakub Narebski <jnareb@gmail.com> wro=
te:
>>
>> > I wrote simple script that tests result of __DIR__ and $FindBin::B=
in.
>> > For cgi-bin / mod_cgi it was:
>> >
>> > =C2=A0__DIR__ =C2=A0 =C2=A0 =C2=A0 =3D /var/www/cgi-bin/gitweb (sy=
mlink to /home/local/gitweb)
>> > =C2=A0$FindBin::Bin =3D /home/local/gitweb
>> >
>> > For mod_perl (ModPerl::Registry handler) it was
>> >
>> > =C2=A0__DIR__ =C2=A0 =C2=A0 =C2=A0 =3D /var/www/perl/gitweb (symli=
nk to /home/local/gitweb)
>> > =C2=A0$FindBin::Bin =3D /
>> >
>> > As you can see it's useless. =C2=A0I have't checked the FastCGI ca=
se...
>>
>> Thanks for spending time researching what was an offhand ignorant "h=
ey
>> wasn't .." comment. Also, sorry :)
>
> Nothing to it. =C2=A0I wanted to check if there really is a problem w=
ith
> FindBin on mod_perl, as I was not sure with description in "Known Iss=
ues"
> section in FindBin manpage.
>
> Note that using 'FindBin->again();' after 'use FindBin;' fixes this
> issue. =C2=A0So perhaps it would be beter to use FindBin than borrow =
code
> for __DIR__ from Dir::Self.

That should work, though note that FindBin->again requires at least
perl 5.8.3. This should work on older versions (if Gitweb cares):

    if ($] <=3D 5.008003) {
        delete $INC{'FindBin.pm'};
        require FindBin;
    } else {
        FindBin->again;
    }

See https://rt.cpan.org/Public/Bug/Display.html?id=3D57988 and
http://search.cpan.org/diff?from=3DModule-Install-0.98&to=3DModule-Inst=
all-0.99
for reference.
