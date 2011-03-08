From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH] Honor HP C's noreturn attribute
Date: Tue, 8 Mar 2011 20:26:43 +0100
Message-ID: <AANLkTi=FPkccc3Rk3YDuEsN3YGt_U1NhhT2MGHmbrAra@mail.gmail.com>
References: <32EABE0E-2447-4189-A3CE-05B68A5E18EF@nextsoft.cz>
	<7v4o7dfndw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michal Rokos <rokos@nextsoft.cz>, GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 20:26:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px2YV-0004RA-3m
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 20:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367Ab1CHT0p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 14:26:45 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50518 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877Ab1CHT0p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 14:26:45 -0500
Received: by vws12 with SMTP id 12so4989792vws.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 11:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=p8I6oACfkmCt+ZfPdIhHjjwL52GwsLCDtAZHx5IgmEE=;
        b=J6bhDT4/0V2f3NGYWhhb7pZ2Hl6AIRpOoppZhHQh26rsmynhrgNiwQgBjm59aNjvDk
         UBmgGDTD1t2tBbq52ITimm9UBh8nUM2AsZ5uYAD10FJGMOa3D1j2S5PUUOG1FcseEOk1
         ZyyUwLuG1lLa8j3CtQemqJ5/NjDuVmYH4i520=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sG7Y/CJPrMSAIuGkJ3TtZPAPcK3Acptuqvef0w85z5AmuU17kEK1SHLA2eFDAU0s9W
         7xRUiqgcynGKAgKpYhgHgz7Gs8MPlUChrDFcRCDPmSD3eT3ijGmOP8GH+uL197DTLb/z
         SxI3rOwwxzSRbmRpX3R0wiIgaJlOIZ8a9yRd0=
Received: by 10.52.68.18 with SMTP id r18mr5549677vdt.82.1299612403625; Tue,
 08 Mar 2011 11:26:43 -0800 (PST)
Received: by 10.220.186.205 with HTTP; Tue, 8 Mar 2011 11:26:43 -0800 (PST)
In-Reply-To: <7v4o7dfndw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168678>

On Tue, Mar 8, 2011 at 8:00 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Michal Rokos <rokos@nextsoft.cz> writes:
>
>> HP C for Integrity servers (Itanium) gained support for noreturn
>> attribute sometime in 2006. It was released in Compiler Version A.06=
=2E10
>> and made available in July 2006.
>>
>> The __HP_cc define detects the HP C compiler version. Precede the
>> __GNUC__ check so it works well when compiling with HP C using -Agcc
>> option that enables partial support for the GNU C dialect. The -Agcc
>> defines the __GNUC__ too.
>>
>> Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>
>
> We tend to prefer new code be appended at the end of if/elif/.../then=
/fi
> cascade when there is no strong reason to do otherwise; your log mess=
age
> clearly explains why this particular #if needs to come before the exi=
sting
> one.
>
> I love it when people write a very readable log message to explain wh=
y the
> patch _has_ to be the way it is. =A0Very good job.

I liked it too, but it'd be even better to put the comment in the code =
IMO.
I don't think anyone would check the commit to see if he can change the
order of the #ifdefs ...

(So please comment in code more!)


--=20
Piotr Krukowiecki
