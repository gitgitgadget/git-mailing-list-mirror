From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] status merge: guarentee space between msg and path
Date: Wed, 12 Mar 2014 06:33:25 +0700
Message-ID: <CACsJy8DvBVxtP_+qbcxL0J8D3iokGeMVW0jxFtZD=Jk_A=mwQg@mail.gmail.com>
References: <1394555447-1805-1-git-send-email-sandy.carter@savoirfairelinux.com>
 <xmqqeh28pkuu.fsf@gitster.dls.corp.google.com> <531F706C.1080901@savoirfairelinux.com>
 <xmqqwqg0o518.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Sandy Carter <sandy.carter@savoirfairelinux.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 00:34:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNWBN-0003NC-NE
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 00:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971AbaCKXd5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 19:33:57 -0400
Received: from mail-qa0-f41.google.com ([209.85.216.41]:48531 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943AbaCKXd4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Mar 2014 19:33:56 -0400
Received: by mail-qa0-f41.google.com with SMTP id j5so9373110qaq.14
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 16:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KoewnPCAQTG7qCilvpSeIPVN4FXq//eV4r4EQEY6zZQ=;
        b=G66HrOo6V+WoOAZm58eASX+hLsHpmTJcaAZQ3yFpWfAoqOQZuaPeltenAS9aIlwVgX
         UMiXt/m82DWS8pRH88e2cu0wm1OUkVdIzqZxdcC5mTO8XtCZu7a1RxGrSn1kMXfwsvFx
         IB9UJX/3W7prh/iFwH0t23kYjP0UR5J8bCGOdfb8yz5Gm4aZNWQbQsfNPGQS0id4VYqf
         89t8S9TekHJNL4mmDZBCd7PPzY7qqF1vEtj1xAqkz5VjieHekSf0y2v0bcFPdIdDmXKp
         YogpFZJTEdp7djs4ZSzsn9Cg/vZ3EQNAiALQm21ZpjQpquBCY7Ii/gVKohAKlI9/hEhN
         i1Cw==
X-Received: by 10.140.40.5 with SMTP id w5mr48759173qgw.65.1394580836008; Tue,
 11 Mar 2014 16:33:56 -0700 (PDT)
Received: by 10.96.215.102 with HTTP; Tue, 11 Mar 2014 16:33:25 -0700 (PDT)
In-Reply-To: <xmqqwqg0o518.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243913>

On Wed, Mar 12, 2014 at 3:26 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Sandy Carter <sandy.carter@savoirfairelinux.com> writes:
>
>> Le 2014-03-11 15:59, Junio C Hamano a =C3=A9crit :
>>> Sandy Carter <sandy.carter@savoirfairelinux.com> writes:
>>>
>>>> diff --git a/wt-status.c b/wt-status.c
>>>> index a452407..69e0dfc 100644
>>>> --- a/wt-status.c
>>>> +++ b/wt-status.c
>>>> @@ -264,7 +264,7 @@ static void wt_status_print_unmerged_data(stru=
ct wt_status *s,
>>>>     case 6: how =3D _("both added:"); break;
>>>>     case 7: how =3D _("both modified:"); break;
>>>>     }
>>>> -   status_printf_more(s, c, "%-20s%s\n", how, one);
>>>> +   status_printf_more(s, c, "%-19s %s\n", how, one);
>>>>     strbuf_release(&onebuf);
>>>>   }
>>>
>>> Thanks; I have to wonder if we would want to do something similar t=
o
>>> what 3651e45c (wt-status: take the alignment burden off translators=
,
>>> 2013-11-05) to the other parts of the output, though.
>>>
>>
>> I could, do this. It would be cleaner, but there's just the issue of
>> the colon (:) which requires a space before it in the french
>> language[1]. As you can see in po/fr.po, the french translators have
>> done a good job at including it [2].
>>
>> 3651e45c takes the colon out of the control of the translators.
>
> That is a separate bug we would need to address, then.  Duy Cc'ed.

We went through this before

http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/1109239/f=
ocus=3D239560

If the colon needs language specific treatment then it should be part
of the translatable strings.
--=20
Duy
