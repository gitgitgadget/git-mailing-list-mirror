From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Minimum Perl version?
Date: Fri, 24 Sep 2010 14:30:48 +0200
Message-ID: <AANLkTimjMkJGw+Dh_x+TQUscC1tOV6kW=a6_57f2snnB@mail.gmail.com>
References: <20100924100019.GT23563@ece.pdx.edu>
	<AANLkTi=3xNSV0y-i=0KUSDRBJ8HmfSfGO7TBHTPiv_KM@mail.gmail.com>
	<AANLkTimUE=hyJ-y_XzpvCokb77KvRGw3gnM+9Xxui9tG@mail.gmail.com>
	<AANLkTiknAw5DwEDHQVJs96gEShky3rLYjyqpQy3MY=8Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Tait <git.git@t41t.com>, git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Sep 24 14:30:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz7QW-0004XP-Ga
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 14:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158Ab0IXMau convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 08:30:50 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44562 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab0IXMat convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 08:30:49 -0400
Received: by qyk33 with SMTP id 33so3922648qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1CImiMCQezoHLyUWta7Hmf2Hs77nwTd+A9A6P7SE7Y4=;
        b=wOaWHHloo63JHuZgJPEmlymptGTbBjz3tDrGbkAOSXo2MdVQB/P5h8pFkudaxdv3dz
         dj+h3ZL2d/ScZD/2UZ41wD+la0roZMrVsUa6Gy92TBfRphl+geAxFnOcQt+xxyehr7nH
         pCY3yvZkGyfq/4lO3Wl4esCjH4Vz0kW0COBT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WBASOSCL3Cb6o0Ns1TWNY6j8NoOE+GrjpRYMoBFo+W/OfOvwCptTHQ3vwrbatAWlIY
         NP2ge4VVYjGSI2G6C8y74f7SUS7xOLUehAn819fxw0nmBxSk/m21uJaOgvBNPyjz5YRo
         Mp4EWMaL+iuk5glAas7tLNGJ278uVdz+HgMgs=
Received: by 10.224.54.69 with SMTP id p5mr2326966qag.373.1285331448458; Fri,
 24 Sep 2010 05:30:48 -0700 (PDT)
Received: by 10.229.87.212 with HTTP; Fri, 24 Sep 2010 05:30:48 -0700 (PDT)
In-Reply-To: <AANLkTiknAw5DwEDHQVJs96gEShky3rLYjyqpQy3MY=8Z@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156981>

On Fri, Sep 24, 2010 at 13:22, Tor Arntsen <tor@spacetec.no> wrote:
>> If that's the case (I don't have a 5.6 here to do archeology on) the=
n
>> git add -p never worked in 5.6. That was added in 5cde71d6 when it w=
as
>> introduced in 2006:
>>
>> =C2=A0 =C2=A0+sub run_cmd_pipe {
>> =C2=A0 =C2=A0+ =C2=A0 =C2=A0 =C2=A0 my $fh =3D undef;
>> =C2=A0 =C2=A0+ =C2=A0 =C2=A0 =C2=A0 open($fh, '-|', @_) or die;
>> =C2=A0 =C2=A0+ =C2=A0 =C2=A0 =C2=A0 return <$fh>;
>> =C2=A0 =C2=A0+}
>>
>
> Can't use an undefined value as filehandle reference at test-pl.pl li=
ne 5.
> (that's the 'open' line)

Maybe it is not the syntax (the separate argument for open mode
in this case), but the initialization of $fh to 'undef' which is the
problem here?
