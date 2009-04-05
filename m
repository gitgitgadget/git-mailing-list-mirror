From: John Tapsell <johnflux@gmail.com>
Subject: Re: non-ascii filenames issue
Date: Sun, 5 Apr 2009 11:51:10 +0100
Message-ID: <43d8ce650904050351p72590d52l8861b3901f95201a@mail.gmail.com>
References: <20090405093640.GA9803@home> <87ab6v2zor.fsf@iki.fi>
	 <20090405100127.GA12126@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 12:53:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqPyE-0002tK-QV
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 12:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759114AbZDEKv2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 06:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757513AbZDEKv1
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 06:51:27 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:12737 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758668AbZDEKvN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 06:51:13 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1805381rvb.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=r9Sv5Z78fFCF7oy9vXcp692jg5U1AOosnVqlDx7C938=;
        b=jtB1UNeKm+BYLY0LPTutXnPVntFO564Ts75aJtEswqbxPECVWE/p2BSWee1ax9jWKQ
         PdGAoRcQtlmkKflUg+jK9ZFpi+TlAHTEtapaDjlO7dPDrQtGZMmr5z/zOSly3/ifUF08
         SGccL2ePoP66/z+rXbOqTDFQfeM1ntVJ032cg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Dptb9B9Nnhb58UnLhHXD4RHL5ygZT1H9Y49dZ1KODrfBE3uqW3M5n1KnktKCILSuxT
         3eS7a/Iw190odHYRGogMQChRVajz6jtkSJq+r0AQND4pL61oYA1jM1ueYpFEdCfu3/1o
         EYiVTCsyPCrHqHbi3nEgByLDQ4aVURN2j/Lac=
Received: by 10.142.191.5 with SMTP id o5mr930826wff.53.1238928670885; Sun, 05 
	Apr 2009 03:51:10 -0700 (PDT)
In-Reply-To: <20090405100127.GA12126@home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115656>

2009/4/5 Gregory Petrosyan <gregory.petrosyan@gmail.com>:
> On Sun, Apr 05, 2009 at 12:54:28PM +0300, Teemu Likonen wrote:
>> On 2009-04-05 13:36 (+0400), Gregory Petrosyan wrote:
>>
>> > # Changes to be committed:
>> > # =C2=A0 (use "git rm --cached <file>..." to unstage)
>> > #
>> > # =C2=A0new file: =C2=A0 "\321\204\320\260\320\271\320\273"
>> > #
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"=D1=
=84=D0=B0=D0=B9=D0=BB" should be here instead
>>
>> It can be fixed with command:
>>
>> =C2=A0 =C2=A0 git config --global core.quotepath false
>
> Thanks! That works. Does it make sence to set it to "false" by defaul=
t?

Unfortunately not, because for some absolutely crazy reason, there is
no way at all to tell what encoding the string is in.  It never
occured to anyone that it might actually be useful to be able to read
the filename in an unambiguous way.  The result is this sort of mess.
Just wait until you try to checkout that file on a new filesystem with
a different encoding.  Or try to checkout that file in Windows.  It's
like git decided to step backwards 30 years.

John
