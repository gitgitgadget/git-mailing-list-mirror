From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 05/14] revert: Propogate errors upwards from do_pick_commit
Date: Wed, 6 Jul 2011 15:00:46 +0530
Message-ID: <CALkWK0kC36d72kxmWz1L=1tdjGeq9BVc2_UUE5SvvKXnefEG4g@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-6-git-send-email-artagnon@gmail.com> <20110706085007.GB15682@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 11:31:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeORu-0003zp-Jj
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 11:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab1GFJbI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 05:31:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60160 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417Ab1GFJbH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 05:31:07 -0400
Received: by wwe5 with SMTP id 5so6753318wwe.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 02:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=sc0vqLDH+tnE9NP63K4gDSPv/QSwMhQ5rQKf8A1ybCk=;
        b=r2rT+YjU7bjwxGNf0b+nZRRvrvVY50wnYCrR510Ab1nS7X4az3IabMpg8P9G4HJkd4
         SolvQ9Idr0l+DJViKgnEskSh/LJKn615JhaEux/n0UVaC7sPw0IESgz4n1o+rXVGyrqX
         x6OXwVuAr54v86vCOeZBYuzR4kG/GoKEcasvw=
Received: by 10.216.62.3 with SMTP id x3mr5216638wec.77.1309944666118; Wed, 06
 Jul 2011 02:31:06 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 02:30:46 -0700 (PDT)
In-Reply-To: <20110706085007.GB15682@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176671>

Hi again,

Jonathan Nieder writes:
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -250,25 +250,20 @@ static struct tree *empty_tree(void)
> [...]
>> + =C2=A0 =C2=A0 if (action =3D=3D CHERRY_PICK)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error(_("Your local chan=
ges would be overwritten by %s."), me);
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error(_("Your local chan=
ges would be overwritten by %s."), me);
>
> gettext creates one msgid for these two strings, so translators have
> no choice but to give them the same translation. =C2=A0Is that the in=
tent?
>
> [...]
>> + =C2=A0 =C2=A0 if (res < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("%s failed"), me);
>> + =C2=A0 =C2=A0 return res;
>> =C2=A0}
>
> Likewise.

Oops, I didn't realize that! Will fix.

-- Ram
