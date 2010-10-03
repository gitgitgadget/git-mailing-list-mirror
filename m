From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv5 03/16] t4017 (diff-retval): replace manual exit code
 check with test_expect_code
Date: Sun, 3 Oct 2010 13:33:04 -0600
Message-ID: <AANLkTik1D3m-n1LZqq0cs1j7TdTVsi9LfiwcrWSHinPJ@mail.gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
	<1286082644-31595-4-git-send-email-newren@gmail.com>
	<20101003134757.GA17084@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 21:33:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2UJ5-0006OV-RX
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab0JCTdG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:33:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54376 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab0JCTdG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 15:33:06 -0400
Received: by fxm14 with SMTP id 14so1392981fxm.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=u/kHGSexfpEip/7ZLmyPc/cLFMn+PWoXBWCy0djQQLU=;
        b=lg0QIod1LvBiiAFQJ5K7iz4zis/dedrsjm7stMJlz7LOHlywL+CEnh1Bgoh4bcx1Rn
         imAnSG2lcvfjVhMXn5YvSooh0b3lKBi4+peCb7ebqdRBUSqoHvNGgxp4F6AZsEYHOmHn
         7wD3M8e6Da/7eSsKj6dzqa2zRqbzM5tRyIcdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OAXphTbVISwHyaESBFh6TEObILzEC6Kn33wAQkGzD8ojicrgOdIuEf5qTz0gFF8Vpn
         kSm033rWfWOnSdAOTZzJFbQ/qPQ/kEv4iOTkBOanycISexJJxVY85LKQgzqvRGAKcHUw
         0FTWfN6RpG9Z+5Ve60JPHE+JweVq0Nymr8I/w=
Received: by 10.223.104.75 with SMTP id n11mr84703fao.10.1286134384353; Sun,
 03 Oct 2010 12:33:04 -0700 (PDT)
Received: by 10.223.126.70 with HTTP; Sun, 3 Oct 2010 12:33:04 -0700 (PDT)
In-Reply-To: <20101003134757.GA17084@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157895>

On Sun, Oct 3, 2010 at 7:47 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
>> @@ -145,20 +122,14 @@ test_expect_success 'check honors conflict mar=
ker length' '
>> =C2=A0 =C2=A0 =C2=A0 git reset --hard &&
>> =C2=A0 =C2=A0 =C2=A0 echo ">>>>>>> boo" >>b &&
>> =C2=A0 =C2=A0 =C2=A0 echo "=3D=3D=3D=3D=3D=3D" >>a &&
>> - =C2=A0 =C2=A0 git diff --check a &&
>> - =C2=A0 =C2=A0 (
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git diff --check b
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test $? =3D 2
>> - =C2=A0 =C2=A0 ) &&
>> + =C2=A0 =C2=A0 git diff --check a
>> + =C2=A0 =C2=A0 test_expect_code 2 git diff --check b &&
>
> Missing &&?

Indeed -- that's pretty embarrassing, considering the topic of the
series.  :-/  Good catch.

> With that exception,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
