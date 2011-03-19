From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH v4 2/2] gitweb: introduce localtime feature
Date: Sat, 19 Mar 2011 14:22:21 -0700
Message-ID: <AANLkTikw7_9Q0MgVZZxX_dXvcxoXfx5VEmRQkVH_k1YC@mail.gmail.com>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost>
	<7v39mjro38.fsf@alter.siamese.dyndns.org>
	<AANLkTimssscn+STEPyM7NbXF5ddFApPBsgXfqz-9SSNs@mail.gmail.com>
	<201103192209.29759.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 22:22:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q13bR-0008In-Cb
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 22:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757563Ab1CSVWX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 17:22:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63529 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757513Ab1CSVWW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 17:22:22 -0400
Received: by fxm17 with SMTP id 17so4595633fxm.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 14:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ld3gY4cC9Ayxlnp4mDKbjWmQ+ImEdq03EA1uoR9YF+g=;
        b=pL3xhdlzbAWRAnUlwOGaR+54CsPLv/StX+l/eG6w9o8d3z7/g/df5uZyJpJ1wbHoPe
         dz3B4QVGTTDYgXs6lOgaJi2jvgH7VjZlRYP2ckEIRSODm2WAk8iANA4tXXDCKt3ofqTw
         TVp/uW/eR9Dfcg0D6pDHhB3dzPAKr7z4hHhIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=I0BncnZTqdZDTFITCDY+SkgO2pK+C/5qDix22/g+CnEZzvdEgooQemroYrpaTBnN3d
         Oigrq3TM5aDr0oeddDQrULxV1szB5wSCHu09CubTWQMdejAKFB9x/pwd/SOCQH7/uFPr
         KN1MjNAKaKDQ+52QRIDcyb4txdEXS4bN905Oo=
Received: by 10.223.143.5 with SMTP id s5mr2989459fau.60.1300569741164; Sat,
 19 Mar 2011 14:22:21 -0700 (PDT)
Received: by 10.223.61.83 with HTTP; Sat, 19 Mar 2011 14:22:21 -0700 (PDT)
In-Reply-To: <201103192209.29759.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169465>

On Sat, Mar 19, 2011 at 2:09 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>> For the $feature{'localtime'} disabled case, the coloring is the sam=
e as before.
>
> No, it is not the same. =C2=A0It used to be
>
> =C2=A0Wed, 16 Mar 2011 07:02:42 +0000 (02:02 -0500)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^^
>
> and now it is
>
> =C2=A0Wed, 16 Mar 2011 07:02:42 +0000 (02:02 -0500)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^
> which is I also think improvement,... but should be mentioned in the
> commit message.

Oh OK, I did not notice this or intend to change the formatting.  My ba=
d.

>> I will paint the whole line in the next spin, and mention it in the
>> commit message.
>
> I think current solution of using
>
> =C2=A0Wed, 16 Mar 2011 02:02:42 -0500 (07:02:42 +0000)
> =C2=A0^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> when 'localtime' feature is enabled is better than painting the whole=
:
> you are now painting the _local_ part, i.e the part responsible for
> "atnight" warning.

I can fix up v4 if Junio thinks this is a better way to go...

It does make the code a little more complicated, though.  If we paint
the entire string, it can be done once toward the end of the function,
rather than twice (two different ways) inside the localtime /
no-localtime clauses.

I am largely indifferent to how "atnight" is handled but it would be
good to arrive at a consensus.

>> Also, is there a cleaner way of writing this?
>>
>> sub timestamp_html {
>> =C2=A0 =C2=A0 my %date =3D %{$_[0]};
>> =C2=A0 =C2=A0 shift;
>> =C2=A0 =C2=A0 my %opts =3D @_;
>
> =C2=A0sub timestamp_html {
> =C2=A0 =C2=A0 =C2=A0my %date =3D %{ shift };
> =C2=A0 =C2=A0 =C2=A0my %opts =3D @_;

This did not work for me.  It interprets "shift" as a variable name.

> Or just use hash reference for $date:
>
> =C2=A0sub timestamp_html {
> =C2=A0 =C2=A0 =C2=A0my ($date, %opts) =3D @_;
>
> and use $date->{'sth'}.

That is what I did on the latest 3/3 (change "atnight" highlighting)
patch.  Seemed to work OK.

Thanks.
