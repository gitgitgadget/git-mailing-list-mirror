From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] Improve the naming of guessed target repository for 
	git clone
Date: Thu, 14 May 2009 07:54:34 +0200
Message-ID: <81b0412b0905132254n5046666t24f3887f1fd4e4d9@mail.gmail.com>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>
	 <200905121557.18542.Hugo.Mildenberger@namir.de>
	 <81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com>
	 <200905121900.00625.Hugo.Mildenberger@namir.de>
	 <81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com>
	 <20090512172452.GA32594@blimp.localdomain>
	 <20090513180853.GB26288@blimp.localdomain>
	 <20090513205333.GA21631@blimp.localdomain>
	 <7vfxf81ppd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 07:57:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Tx6-0000V6-NJ
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 07:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbZENFyg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 01:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752266AbZENFyf
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 01:54:35 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:59928 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbZENFye convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 01:54:34 -0400
Received: by bwz22 with SMTP id 22so1068273bwz.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 22:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eA2obnCDvUw6amdhB+SXRAhx9XhV+dmdefYNdOW6+r8=;
        b=m2QObZrc1OcJBdNuJZnkSiac7cd6h4P3TZjfGAeXVoz0saZWEsWQkr8EaaccxfhhSo
         PQO7GsQLbchOQu3DnhUOVZpl/f0czimo4OtX8zf5lfW9jPX2Z8P9849GkKI21YY7t4r1
         BcjQoQS4n5eyW0AC+rfKhRdsGPo6GSOB+x7EA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YsoGGMUQ1qTKJvfRNcWUCidQ6K0pXl8Ny/Roh4Y6ptVS5i6Ywpz2Vy6uJIF6II6rPA
         01Z+3J6p6vnp7Z9bEox1lc7mmoTUKLHORXfiooiVFFwEZzBWDRQaiIFjOzzNBev+hy/b
         3pMV/uzssBIsM3Y3Z+efrM3dEAkvVemm2vH/M=
Received: by 10.204.59.14 with SMTP id j14mr1784890bkh.39.1242280474219; Wed, 
	13 May 2009 22:54:34 -0700 (PDT)
In-Reply-To: <7vfxf81ppd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119144>

2009/5/14 Junio C Hamano <gitster@pobox.com>:
> Alex Riesen <raa.lkml@gmail.com> writes:
>> + =C2=A0 =C2=A0 /* replace all 'control' characters with ascii space=
 */
>> + =C2=A0 =C2=A0 for (start =3D dir; *start; ++start)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*(const unsigned cha=
r *)start < 32u)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dir[start - dir] =3D '\x20';
>
> What's this strange mixture of 32u and '\x20'?
>

Not sure myself. I probably wanted visibility, and somehow ended
up using different presentations.

>> + =C2=A0 =C2=A0 /* remove trailing spaces */
>> + =C2=A0 =C2=A0 if (dir < start)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (end =3D start; dir =
< --end; )
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!isspace(*end))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dir[end - dir] =3D '\0';
>> + =C2=A0 =C2=A0 return dir;
>> =C2=A0}
>
> Honestly, I regret having asked if there was a 2/2 ;-)
>
> What's the point of this change, now that you have a fix in 1/2? =C2=A0=
Who are
> you helping with this patch?
>

Without this the _automatically_ generated names for cloned repositorie=
s
have all the whitespace around them. As you cannot sanely depend on
automatically
generated names, I thought that making them simpler will make sense.

But I should complete the patch: remove heading whitespace, and replace
multiple spaces and control characters with one space.
