From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: add extra safetly in address sanitazion
Date: Sun, 5 Feb 2012 22:51:46 +0200
Message-ID: <CAMP44s1wqmT4mavsXrEhB-OquOtQrYnnoSoX9G7X4wzFoMD29A@mail.gmail.com>
References: <1328373162-25188-1-git-send-email-felipe.contreras@gmail.com>
	<87sjipxe5u.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 05 21:51:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru93w-0001IL-Ne
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 21:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab2BEUvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 15:51:48 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:47026 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751704Ab2BEUvs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 15:51:48 -0500
Received: by lbom4 with SMTP id m4so871435lbo.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 12:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Vw/DVO/OJpZ0RwGbk3iFTTlU2TNIr0oya5vsZEPjtDU=;
        b=jrO30RNdry6ocab5v0NE7lXIzeSWMGKBneJE7VgjDmdjH4JtcMnPQkkGnsFsQf7yIa
         7tEaoBSMCQo5s4/Sq5d1CjTFTDWj/V6Ek9tEjK0DNqtOpGOX/EFwFyPJYk/9CMP/T59k
         y7n10iLsW4Ek2VJs6xGNzZEzWw/ZairMktFKA=
Received: by 10.112.32.1 with SMTP id e1mr4151911lbi.3.1328475106662; Sun, 05
 Feb 2012 12:51:46 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Sun, 5 Feb 2012 12:51:46 -0800 (PST)
In-Reply-To: <87sjipxe5u.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189959>

2012/2/5 Thomas Rast <trast@inf.ethz.ch>:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Currently bad addresses like 'Foo Bar <foo@bar.com>>' will just be s=
ent
>> verbatim -- that's not good; we should either error out, or sanitize
>> them.
>>
>> The following patch adds extra sanitazion so the following
>> transformations are performed:
>>
>> =C2=A0 'Foo Bar <foo@bar.com>' -> 'Foo Bar <foo@bar.com>'
>> =C2=A0 '"Foo Bar" <foo@bar.com>' -> '"Foo Bar" <foo@bar.com>'
>> =C2=A0 'foo@bar.com' -> 'foo@bar.com'
>> =C2=A0 '<foo@bar.com>' -> 'foo@bar.com'
>> =C2=A0 'Foo Bar' -> 'Foo Bar'
>
> Am I the only one who stared at this for ten seconds, only to then
> realize that there is no sanitizing whatsoever going on here?

There is: '<foo@bar.com>' -> 'foo@bar.com'

>> =C2=A0 'Foo Bar <foo@bar.com>>' -> 'Foo Bar <foo@bar.com>'
>> =C2=A0 '"Foo Bar" <foo@bar.com>>' -> '"Foo Bar" <foo@bar.com>'
>> =C2=A0 '<foo@bar.com>>' -> 'foo@bar.com'
>
> All of these are the same underlying issue. =C2=A0Does your patch fix=
 any
> other malformed addresses, or just this particular type?

See above.

--=20
=46elipe Contreras
