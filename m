From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 20/20] gettextize: git-am printf(1) message to eval_gettext
Date: Tue, 7 Sep 2010 20:29:03 +0000
Message-ID: <AANLkTimDofOpfOrFisvP-1+qn1DYuk1oq2anjUcCHQw6@mail.gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
	<1283878224-20202-1-git-send-email-avarab@gmail.com>
	<AANLkTim_ovWkPPepB7xRez5DTmJRTrFoZWG+Nx0_O=oL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 22:29:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot4n2-0007Dg-9U
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 22:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522Ab0IGU3G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 16:29:06 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40903 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab0IGU3F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Sep 2010 16:29:05 -0400
Received: by ywh1 with SMTP id 1so2094559ywh.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UFlvMFRTCpkuw5WHkRr4QPDsqWPJxdSCAS2o2Y7H3a8=;
        b=nrxhC64Di1q4d/lTJ/7Eu+DsJtJfbX2SUlfHP0QmwV27FHMp39hU7SZQcjOp2QoNnY
         qkL65n7XZxDi/5D590e9el+Pb9mlzozeqqopau7hgSWzDxtn/PKTu+NjfVBJx6lFAc6n
         oU7Y/BfFW3Rv5RquF5FCU5rsIFeuz1UuT2+bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cpVADxpcQ6Q/6wRWtPaR2EHh7re9gPlBpa32jIVelVJ5wRddnwzilOKz2bv11fQi9/
         uYgG0RvRu18PhXsubGZaEpEDygZJ3VjTZN22obPxPBgjw5WsudvHOfx/WP6ioFcKgSgf
         i2t8OPonu/KgnfqHQ1vl3Jz/sikUx1TDD+9+E=
Received: by 10.150.216.2 with SMTP id o2mr571540ybg.420.1283891343966; Tue,
 07 Sep 2010 13:29:03 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 7 Sep 2010 13:29:03 -0700 (PDT)
In-Reply-To: <AANLkTim_ovWkPPepB7xRez5DTmJRTrFoZWG+Nx0_O=oL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155740>

On Tue, Sep 7, 2010 at 20:10, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Hi,
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> +++ b/git-am.sh
>> @@ -778,7 +778,7 @@ did you forget to use 'git add'?"; echo
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if test $apply_status !=3D 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0then
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf 'Patch fai=
led at %s %s\n' "$msgnum" "$FIRSTLINE"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "$(eval_gett=
ext "Patch failed at \$msgnum \$FIRSTLINE")"
>
> Probably I am missing something silly, but why not just:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0eval_gettext 'Patch failed at $msgnum $FIR=
STLINE\n'

That looks better, or:

    eval_gettext 'Patch failed at $msgnum $FIRSTLINE'; echo

To remove the change for translators to screw up the \n, the gettext
manual uses that style.

It also uses double quotes consistently, but '' works fine too. I
don't know if '' should be avoided for some other reason, probably
not.

> ? I ask because it is nice to be able to avoid "echo" with arbitrary
> data: special characters (e.g. \) can make for portability hassles.

Aside from this example (which looks nicer as you suggest) we'd be in
some slight trouble if the code in the patch is unportable, since I
think I'm using equivalent constructions elsewhere to thinks that get
passed to echo, but maybe that's not a problem if there's a level of
indirection.

In any case we could solve those with printf "%s" $str.
