From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Thu, 9 Dec 2010 08:28:07 +0700
Message-ID: <AANLkTimU6Bhx-2XsZ45_7BmT9fo9MpK8TJWB3zZ=j-i7@mail.gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
 <20101208180605.GD5687@burratino> <201012082051.09730.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 02:28:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQVJN-00049m-Iz
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 02:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581Ab0LIB2k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 20:28:40 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38498 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab0LIB2j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 20:28:39 -0500
Received: by wyb28 with SMTP id 28so1737275wyb.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 17:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+Rn+bud4IybyUT1HLCl1UHAOAZ0lQdEyfxGPTj9iorQ=;
        b=rl3J8XeAlarhFqhgUqB8CKn1faW6Qj1YGmDi92EMmzm3r2yjfVeqUzTjN41hAzOWhX
         jSUlYIasYIArLnPJiA+H0HNLSMBI2JcgC5g62Ajj7XuEgmv/9bPudGFPZkQ+BmkUTe4h
         wptzT2mUEByGPFISXh02Mp16inNqDJQ0PoExE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=B5E5x6Vyw/fvPawNvh2qY6BearCQ7JIbkl+3npGwzh1/cUv81kO86Mm+qg+u1lXrh5
         1e3p6fRhl1gHHMwG9zUEjnpM22Mi4RrsZs80usyW/jAT0hOHIuAEPiPRHkkgdlrCaT0X
         euAG77lKppEMTUrsVNdxZedcQDWmRSuujLRKs=
Received: by 10.216.169.6 with SMTP id m6mr1297647wel.49.1291858117422; Wed,
 08 Dec 2010 17:28:37 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Wed, 8 Dec 2010 17:28:07 -0800 (PST)
In-Reply-To: <201012082051.09730.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163250>

On Thu, Dec 9, 2010 at 2:51 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> Dnia =C5=9Broda 8. grudnia 2010 19:06, Jonathan Nieder napisa=C5=82:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>
>> > Let's start off from where the previous discussion [1] stopped. Pe=
ople
>> > seem to agree ref^{/regex} is a good choice. But we have not come =
to
>> > conclusion how to specify the count yet. Possible suggestions are
>> >
>> > =C2=A0- ref^{/foo}2
>> > =C2=A0- ref^{2/foo}
>> > =C2=A0- ref^{:2/foo}
>> > =C2=A0- ref^{2nd/foo}
>>
>> How about
>>
>> =C2=A0 =C2=A0 =C2=A0 ref^{/foo}^^{/foo}
>>
>> ?
>
> I'll assume that there is invisible ";)" emoticon here.
>
>
> First, it would be ref^{/foo}^@^{/foo}, otherwise you would follow on=
ly
> first parent.
>
> Second, consider ref^{:nth(10)/foo} in your workaround...

Maybe we should generalize this to apply to all operators. Currently
foo~3 is expanded to foo^^^. How about ~~X (or xN) denote repeat the
last operator N times? For example, HEAD^2x3 =3D> HEAD^2^2^2,
HEAD^{/foo}x3 =3D> HEAD^{/foo}^{/foo}^{/foo}.
--=20
Duy
