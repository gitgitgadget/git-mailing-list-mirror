From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Sun, 1 Apr 2012 11:22:44 +0700
Message-ID: <CACsJy8DTegW78Qw7-T6uK_oZj2CELv57bbH6sU=bScHDesGYPQ@mail.gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
 <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
 <loom.20120328T131530-717@post.gmane.org> <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
 <20120330203430.GB20376@sigill.intra.peff.net> <4F7768D6.3010400@gmail.com> <CA+M5ThTKtSFPq8A3oc1wvc9i0vG1NMyHCRE+poYaq+65FQWOxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Jeff King <peff@peff.net>, Sergio <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Bo Chen <chen@chenirvine.org>
X-From: git-owner@vger.kernel.org Sun Apr 01 06:23:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SECKU-000348-CD
	for gcvg-git-2@plane.gmane.org; Sun, 01 Apr 2012 06:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877Ab2DAEXR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Apr 2012 00:23:17 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:60079 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab2DAEXQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Apr 2012 00:23:16 -0400
Received: by wibhq7 with SMTP id hq7so1686579wib.1
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 21:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kB5yqorjN7FZQhUMb9VJv/w0s2XWb44MVrv3Q12ixdk=;
        b=zXTv1qKpAVtyKjhCIRexWyDDAO4ZgVUfAHHB7AuYGTFAUIVSbcdBkdl1ZaBM1wdsRa
         rjAEYl7KruO+Z5/4uQwZcD3fNYcRyhaGsw3Pkjel/aPo79hY8TWlJd16ZX1fobfubFL8
         FUaI4kwsqKNkusCFTLz7RaPJq6i6rTaJW4yZJTVitppn4ZY6aWhs145WB4dt3emutfqX
         0pu4UYvC1bYPltptlBPORkeTb0yodcf07uitdCgd9loZZIqTOVOQY4+rnhZZuwPohD8H
         e8qMC+3xPvSpX31x0WXckaqUpDj7LbPPYc+qvxARQC59LLy+Hrvsh6xoFECRbdarA4OW
         mjfw==
Received: by 10.180.102.3 with SMTP id fk3mr11786511wib.9.1333254194737; Sat,
 31 Mar 2012 21:23:14 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Sat, 31 Mar 2012 21:22:44 -0700 (PDT)
In-Reply-To: <CA+M5ThTKtSFPq8A3oc1wvc9i0vG1NMyHCRE+poYaq+65FQWOxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194475>

On Sun, Apr 1, 2012 at 4:27 AM, Bo Chen <chen@chenirvine.org> wrote:
>> Who decides bigness:
>> Bigness seems to be relative to system resources. =C2=A0Does the use=
r crunch the
>> numbers to determine if a file is big-file, or does git? =C2=A0If th=
e numbers are
>> relative then should git query the system and make the determination=
?
>> =C2=A0Either way, once the system-resources are upgraded and formerl=
y "big-files"
>> are no longer considered "big" how is the previous history refactore=
d tot
>> behave "non-big-file-like"? =C2=A0Conversely, if the system-resource=
s are
>> re-distributed so that formerly non-big files are now relatively big=
 (ie,
>> moved from powerful central server login to laptops), how is the his=
tory
>> refactored to accommodate the newly-relative-bigness?
>>
>
> In common sense, a file of tens of MBs should not be considered as a
> big file, but a file of tens of GBs should definitely be considered a=
s
> a big file. I think one simple workable solution is to let the user
> set the threshold of the big file.

We currently have core.bigFileThreshold =3D 512MB.

> One complicate but intelligent
> solution is to let git auto-config the threshold by evaluating curren=
t
> computing resources in the running platform (a physical machine or
> just a VM). As to the problem of migrating git in different platforms
> which equip with different computing power, the git repo should also
> keep tract of under what big file threshold a specific file is
> handled.
--=20
Duy
