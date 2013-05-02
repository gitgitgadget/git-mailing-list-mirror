From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v3] Add support for -i/--interactive to git-clean
Date: Thu, 2 May 2013 21:43:54 +0800
Message-ID: <CANYiYbFXFM5Z394b+9gWxJ3=OfXHmnwjH44V0tNOp3Vf+G2niw@mail.gmail.com>
References: <CANYiYbHKWv6R2vtwG=bTNhj8q0iC4EBt8usC3posBCtYBTXOvA@mail.gmail.com>
	<3ecc9ca1b1363b5bd27ae53cbf5899ce6d44cd48.1367349734.git.worldhello.net@gmail.com>
	<vpq38u6n397.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 02 15:44:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXtnm-00079G-SW
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 15:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758958Ab3EBNn6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 May 2013 09:43:58 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:50370 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758558Ab3EBNn5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 May 2013 09:43:57 -0400
Received: by mail-wi0-f182.google.com with SMTP id m6so597144wiv.9
        for <git@vger.kernel.org>; Thu, 02 May 2013 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=GkcpZ3KgHcoFyHd3edJAUuaIMZpnGhb/LBc8bd/CnEs=;
        b=XOXV6o408Hk6EfOlZj5fwsgZ7Rv+M/ClPTJLRPhnLy4vorZkiQnIiNk6BuUlej9TgV
         nD3HcBP07hiEQxU1pS+j4nwqWdb+gFTBNG+fP/r4gLW5LkPJ3PPHsIDR3gjLu44NROaZ
         2VDQNinX44OFuLJ2DX4fuP9aBvthwt6gDvae47ck6cLncL3kPo/pkgZs7/S12TyzZTAy
         D1ocOP+oUUnUG43ToEALg9Susb5EdgFAHd0FSTbhwx/cmybeHKsDJYCbrEQBCQNFrRlg
         QKJcg/K0VsAb/CkDBYbhHWBWOqlq021PpHVH9EGY76c2VLbzOC4XXxiLO62rlpFo8UKE
         Ac5g==
X-Received: by 10.180.86.230 with SMTP id s6mr7882877wiz.6.1367502235159; Thu,
 02 May 2013 06:43:55 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Thu, 2 May 2013 06:43:54 -0700 (PDT)
In-Reply-To: <vpq38u6n397.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223207>

2013/5/1 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Show what would be done and the user must confirm before actually
>> cleaning. In the confirmation dialog, the user has three choices:
>>
>>  * Yes: Start to do cleaning.
>>  * No:  Nothing will be deleted.
>>  * Edit (default): Enter edit mode.
>
> I like this much more than the previous one. I played with it a bit, =
and
> found it much more pleasant than "rm -i": by default, only one querry=
,
> but still an option to select which files to clean.

I add columns and colors display for interactive git-clean, and wish yo=
u
like them too.

> I'm wondering whether "Enter" in the edit mode should return to the
> yes/no/Edit querry instead of applying the clean. It would make it cl=
ear
> for the user that it's still possible to cancel completely (the
> Control-C hint is not visible in the UI otherwise).

In patch v4 1/3, I make it a three stages cleaning, and it is also
easy to do real cleaning -- just press three ENTERs.

1. Remove (yes/no/Edit) ? -- Press the 1st ENTER (default to EDIT mode)
2. Input ignore patterns>  -- Press the 2nd ENTER (back to confirm)
3. Remove (Yes/no/edit) ? -- Press the 3rd ENTER (start to do cleaning)

>> Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> Please, no. I already mentionned it in my previous patch, but I did n=
ot
> review the patch. See SubmittingPatches:
>
>   3. "Reviewed-by:", unlike the other tags, can only be offered by th=
e
>      reviewer and means that she is completely satisfied that the pat=
ch
>      is ready for application.  It is usually offered only after a
>      detailed review.
>
> Commenting !=3D reviewing.

I will add you with 'Comments-by:' tag temporarily, and invent a
'Spelling-check-by:' tag (now there are 100+ kinds of tags in Git) to
say thank you to Eric. After this series of patches reach a consensus,
I may change the tag from 'Comments-by: to 'Reviewed-by:' with
your permissions.

>
>> +             /* dels list may become empty when we run string_list_=
remove_empty_items later */
>> +             if (!dels->nr)
>> +                     break;
>
> This happens when the user removed everything from the list in the ed=
it
> mode. This could print something before breaking (and then exiting
> silently). Maybe "No more files to clean, exiting." or so.

added in patch v4 1/3..

>> +                     printf(_("Remove (yes/no/Edit) ? "));
>> +                     strbuf_getline(&confirm, stdin, '\n');
>> +                     strbuf_trim(&confirm);
>> +                     if (confirm.len) {
>> +                             if (!strncasecmp(confirm.buf, "yes", c=
onfirm.len)) {
>> +                                     break;
>> +                             } else if (!strncasecmp(confirm.buf, "=
no", confirm.len)) {
>> +                                     string_list_clear(dels, 0);
>> +                                     break;
>> +                             }
>> +                     }
>> +                     edit_mode =3D 1;
>
> It's weird that anything but "yes" and "no" enter the edit mode witho=
ut
> complaining. It's safe, but surprising. If I type "foo", I'd rather g=
et
> an error and be asked again.
>
>> +             if (!matches) {
>> +                     strbuf_addf(&message, _("WARNING: Cannot find =
items prefixed by: %s"), confirm.buf);
>
> "prefixed" seems a remainder of the previous version of the patch. Yo=
u
> probably mean "matched by: %s".

Updated in patch v4 1/3.

> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/


--=20
=BD=AF=F6=CE

=B1=B1=BE=A9=C8=BA=D3=A2=BB=E3=D0=C5=CF=A2=BC=BC=CA=F5=D3=D0=CF=DE=B9=AB=
=CB=BE
=D3=CA=BC=FE: worldhello.net@gmail.com
=CD=F8=D6=B7: http://www.ossxp.com/
=B2=A9=BF=CD: http://www.worldhello.net/
=CE=A2=B2=A9: http://weibo.com/gotgit/
=B5=E7=BB=B0: 18601196889
