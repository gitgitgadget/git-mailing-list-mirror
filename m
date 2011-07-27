From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 12/18] revert: Save command-line options for continuing operation
Date: Wed, 27 Jul 2011 15:21:43 +0530
Message-ID: <CALkWK0=5drVxLe4SAVLem3cpWCB=Eg3dTFQGhLKFD+Z77RHohA@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-13-git-send-email-artagnon@gmail.com> <20110727050515.GH18470@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 11:52:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm0mm-0006Uu-5q
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 11:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786Ab1G0JwG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 05:52:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33122 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab1G0JwE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 05:52:04 -0400
Received: by wwe5 with SMTP id 5so1229762wwe.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 02:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=nP0yxqCiCb4NAjlhiLodmd50FuIZKnz4rkY3T7lPHHY=;
        b=eDJ1ar8ylEJSqgaJiWOrs0XkvwpxORuEpsK6kmfF5UzBd775XDsCAW6895QbWh2+pS
         7rEptvUhNQEiESSBbKBMqEsj4aK33RaMPkVklUUMAHPJNH+6oVW641UtxuKpNbJN5sZK
         RMOhp2/wiFdFA0EXK1wE4VmxguVlTv8z+kf24=
Received: by 10.216.143.66 with SMTP id k44mr2712067wej.81.1311760323114; Wed,
 27 Jul 2011 02:52:03 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Wed, 27 Jul 2011 02:51:43 -0700 (PDT)
In-Reply-To: <20110727050515.GH18470@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177956>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> In the same spirit as ".git/sequencer/head" and ".git/sequencer/todo=
",
>> introduce ".git/sequencer/opts" to persist the replay_opts structure
>> for continuing after a conflict resolution. =C2=A0Use the gitconfig =
format
>> for this file so that it looks like:
>>
>> [core]
>> =C2=A0 =C2=A0 =C2=A0 signoff =3D true
>> =C2=A0 =C2=A0 =C2=A0 record-origin =3D true
>> =C2=A0 =C2=A0 =C2=A0 mainline =3D 1
>> =C2=A0 =C2=A0 =C2=A0 strategy =3D recursive
>> =C2=A0 =C2=A0 =C2=A0 strategy-option =3D patience
>> =C2=A0 =C2=A0 =C2=A0 strategy-option =3D ours
>
> Maybe "[options]" instead of "[core]" would be more self-explanatory.

=46ixed, thanks.

> If this is meant to be closely analagous to the gitconfig file, then
> variable names should not contain dashes.

Huh?  Quoting Documentation/config.txt:

All the other lines (and the remainder of the line after the section
header) are recognized as setting variables, in the form
'name =3D value'.  If there is no equal sign on the line, the entire li=
ne
is taken as 'name' and the variable is recognized as boolean "true".
The variable names are case-insensitive and only alphanumeric
characters and `-` are allowed.  There can be more than one value
for a given variable; we say then that variable is multivalued.

Btw, the multi-value thing is something I wasn't aware about earlier;
that's what led to the " | " ugliness in my earlier patch.

> It would be nice if some
> day the config parser could learn to treat dashes as insignificant,
> just like it already treats case distinctions as insignificant.

Is the documentation out of date? I can't find any special handling
for `-` in the code either.  What are you talking about?

-- Ram
