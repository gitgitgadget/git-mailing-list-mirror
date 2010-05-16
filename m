From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Add git format-patch produced patches to .gitignore
Date: Sun, 16 May 2010 13:06:25 +0000
Message-ID: <AANLkTilsZ1Dzsu6GwWaNh8WvMrzpQtj5AQNDavdYuCjf@mail.gmail.com>
References: <1273958566-7328-1-git-send-email-avarab@gmail.com>
	 <AANLkTinSJTzYOk_MRp2ddlLnbd5dC65q-c4zQbv8Oubj@mail.gmail.com>
	 <20100516075244.GA9010@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 15:06:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODdYD-0000I5-QE
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 15:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212Ab0EPNG3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 May 2010 09:06:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38797 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab0EPNG2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 May 2010 09:06:28 -0400
Received: by fxm6 with SMTP id 6so2894304fxm.19
        for <git@vger.kernel.org>; Sun, 16 May 2010 06:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xeRcHjT16RujckX0yGtaj17BHSuZp2l5qho6xe8X+Ok=;
        b=mEXOeNUWLwnmeYh/yBP6cFIQReXDR+tVmgkgZlRP3tHv6eDmuF6WR1NyJ6kjYgGFXx
         YWSoVtDzdBFSTBYyApEnx+/HjjhPlgL2S9BuV24vB9s9lPtF3cUTN9d03yy+MklQIbhu
         a6LDtoN1UtYpsb6uNpb6jKj3/q3JTlcRNJChY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XLx1J+JCldE9kd/hJSLpxwC9Lgp9UmIx41UX7Y1MX2xgQJWaEgFBsA4OX3dH6isw7I
         Qgl65wlV4YElWrwsqSl7Fw1iyrzE+cGtz5XhCjjZ0Ujg8cjZFv0NKNin7CpFdYPNQLE0
         iJQ79fa7W4pvOeCT/bhitZIU56yuMl2HHF5BU=
Received: by 10.223.56.206 with SMTP id z14mr4574728fag.97.1274015185457; Sun, 
	16 May 2010 06:06:25 -0700 (PDT)
Received: by 10.223.109.78 with HTTP; Sun, 16 May 2010 06:06:25 -0700 (PDT)
In-Reply-To: <20100516075244.GA9010@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147187>

On Sun, May 16, 2010 at 07:52, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Pavan Kumar Sunkara wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>> --- a/.gitignore
>>> +++ b/.gitignore
>>> @@ -203,3 +203,4 @@
>>> =C2=A0*.pdb
>>> =C2=A0/Debug/
>>> =C2=A0/Release/
>>> +[0-9][0-9][0-9][0-9]-*.patch
> [...]
>> git format-patch -M origin/master -o outgoing/
>>
>> So, my patches will be in subdirectory outgoing.
>> But the regex rule in this patch won't be able to hide them.
>>
>> What do u want to do in that case ?
>
> Try it out.

Right, patches in outgoing/ will be ignored too because the rule isn't
prefixed with /, so it works regardless of whether the file is in a
subdirectory or not.

> In fact, I was worried that this patch would trigger a similar
> problem: maybe some test data directory contains format-patch
> output? =C2=A0In fact none do, so I like the patch.

None do, there's no file that matches '????-*.patch' in Git. Even if
there was you could still 'git add -f' it, which wouldn't be that big
of a problem because it would be part of some rarely touched test
suite in t/*.
