From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git-am: suggest what to do with superfluous patches
Date: Mon, 31 May 2010 22:17:49 +0200
Message-ID: <AANLkTinRafLwhzxUuijdBzfzxLtTb_ua3aM1IxVCCgfa@mail.gmail.com>
References: <4C01B855.7080409@gmail.com> <7vwrujzx3t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Dale Rowley <ddrowley@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 31 22:18:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJBRA-00010G-LU
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 22:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293Ab0EaUSL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 May 2010 16:18:11 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54168 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757194Ab0EaUSK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 May 2010 16:18:10 -0400
Received: by vws9 with SMTP id 9so1195939vws.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 13:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5k7lebJv4MLMvd3a3C0xz2jYDQ2FVYZZ5wD4GbUUx9M=;
        b=jxH6NDAwTkJ4TCMQvDqV3AgrP1aSpAFjtHw+x8ZZiVaouQ0rqFuWstFfbguJoy/MJy
         fzAncgbt1ltx7rIE22HHJ9jCNcLH6NQf4VVMI/6xF0gibMDzSZcS9jES4YkSqDLSAvVt
         SV9Zakk/Y05FqVwWvBHtLC+FOUJL82QE4pakc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lNErNwE0U6oq+dnw7c2rUes+vdrBranhQNhliUCZNZXjlMLMhaHKg8ADhEnwsVRD6M
         s+VDCprcmkrwPwrcq2CVeCF9uo6hpEPfbOXxpkZbGnTT4Bsu8bd8aX+bpqDaQQisHvz8
         1gAnclptgNWflBH40i3uB4I8DHWveOsChrJsw=
Received: by 10.224.12.201 with SMTP id y9mr1947332qay.235.1275337089141; Mon, 
	31 May 2010 13:18:09 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Mon, 31 May 2010 13:17:49 -0700 (PDT)
In-Reply-To: <7vwrujzx3t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148053>

Hi Junio,

Junio C Hamano <gitster@pobox.com> wrote:
> Jan Kr=C3=BCger <jk@jk.gs> writes:
>> diff --git a/git-am.sh b/git-am.sh
>> index 87ffae2..43ea52c 100755
>> --- a/git-am.sh
>> +++ b/git-am.sh
>> @@ -726,6 +726,8 @@ do
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resolved=3D
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git diff-index --qu=
iet --cached HEAD -- && {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 echo "No changes - did you forget to use 'git add'?"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 echo "If there is nothing left to stage, chances are that something=
 else"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 echo "already introduced the same changes; you might want to skip t=
his patch."
>
> The exact wording I'd let people to fight out, but I think this is
> probably better than Ramkumar's one that says "if you dropped". =C2=A0=
The user
> may not know that he is doing an equivalent of dropping as a side eff=
ect
> of the new base that had accepted the same change, and your message n=
udges
> the reader to realize that.

I didn't see this patch on the list- did Jan send it to the list?
Yeah, the wording here is nicer, except you might also want to include
an explicit note on using "$cmdline --skip".

-- Ram
