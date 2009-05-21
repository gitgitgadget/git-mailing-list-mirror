From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v0 3/3] Build in git-rebase.sh
Date: Thu, 21 May 2009 20:44:08 +1000
Message-ID: <fcaeb9bf0905210344h7ac8e10bx311bf9d714573eeb@mail.gmail.com>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com> 
	<1242899229-27603-2-git-send-email-pclouds@gmail.com> <1242899229-27603-3-git-send-email-pclouds@gmail.com> 
	<m363fukb3j.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 12:44:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M75lM-0003fv-Cl
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 12:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbZEUKo2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 06:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbZEUKo1
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 06:44:27 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:15429 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbZEUKo1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2009 06:44:27 -0400
Received: by an-out-0708.google.com with SMTP id d40so2311590and.1
        for <git@vger.kernel.org>; Thu, 21 May 2009 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=faFZlEx6HUFYQp548RkirUubgVRHFpZL7W67D97okSY=;
        b=elfLnPswB7haHRoZOdfBjzzm0251uGtFNcITEsoSy2L7uKBTr4xaivgK4oAAvCmtSB
         772oN5gqgvtnTUoyosoxTeCzB7k4bMQMQ/m864H1KVR4JK1JSJ2EqyF6nkpv9Ub+bJc0
         MCXORi6IC7c4EzqWfTcZFvpg5Fn7CeIF8PL5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aQlu7RVQbRgZtG+sddiFeViymuxe8y2ktEot3fHd0jEb+9Bnt/00T/obD9plWF9gZ7
         3XgFSvseg61Qt3zW/Zxxy/PEvU19HDP22S5wNf3cnZXxcZo2QitpVUzvQoyV6k+OpaAv
         461YF9Ru+xGqykQd3MjA4qTyU9kcQj84HOWzQ=
Received: by 10.100.141.10 with SMTP id o10mr4546148and.152.1242902668201; 
	Thu, 21 May 2009 03:44:28 -0700 (PDT)
In-Reply-To: <m363fukb3j.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119672>

2009/5/21 Jakub Narebski <jnareb@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0 =C2=A0<pclouds@gmail=
=2Ecom> writes:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0Regression: "-M" is gone. Don't really want to mess up struct =
option for "-M"
>>
>> =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
>> =C2=A0builtin-rebase.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0992 ++++++++++++++++++++++++++++++++++++++++
>> =C2=A0builtin.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A0contrib/examples/git-rebase.sh | =C2=A0530 +++++++++++++++++++=
++
>> =C2=A0git-rebase.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0530 ---------------------
>> =C2=A0git.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A06 files changed, 1525 insertions(+), 531 deletions(-)
>> =C2=A0create mode 100644 builtin-rebase.c
>> =C2=A0create mode 100755 contrib/examples/git-rebase.sh
>> =C2=A0delete mode 100755 git-rebase.sh
>
> You should have used -M option to git-format-patch to make it clear
> that this patch moves git-rebase.sh to contrib/examples/git-rebase.sh
> without changes.

Yes, much shorter patch. I recall some issues about reversable patch
long ago so I did not bother finding this option.

> [...]
>> +#define REBASE_ABORT =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0001
>> +#define REBASE_CONTINUE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x0002
>> +#define REBASE_FORCE =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0004
>> +#define REBASE_IGNORE_DATE =C2=A0 0x0008
>> +#define REBASE_INTERACTIVE =C2=A0 0x0010
>> +#define REBASE_MERGE =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0020
>> +#define REBASE_STAT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0040
>> +#define REBASE_NO_VERIFY =C2=A0 =C2=A0 0x0080
>> +#define REBASE_PRESERVE_MERGES =C2=A0 =C2=A0 =C2=A0 0x0100
>> +#define REBASE_ROOT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0200
>> +#define REBASE_SKIP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0400
>> +#define REBASE_VERBOSE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x0800
>
> I see misaligns here...

Hmm.. it's perfectly aligned in complete source form. Probably because =
of TABs.

> [...]
>
> Couldn't you use parseopt also in subcommands?

I don't understand. You mean parseopt for --continue, --skip and --abor=
t?
--=20
Duy
