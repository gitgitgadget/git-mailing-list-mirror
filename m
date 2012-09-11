From: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@entel.upc.edu>
Subject: Re: Git an case-insensitive Mac OS X filesystem
Date: Tue, 11 Sep 2012 10:44:02 +0100
Message-ID: <CAPLaKK6R=BNjgY8wc8nZzyPy53ppeO4bKN=Cum_+b6Kwb5F=SA@mail.gmail.com>
References: <CAPLaKK71O3RzavOqY2uVC1tUsbs+W6WxJRWuLBDFUvTwojAN-g@mail.gmail.com>
	<1347355466-ner-6656@calvin>
	<CAPLaKK4Xm8KzQ8HcM_TbbuDr1hcLjhjSOWSyJS3jFX0toFBjsA@mail.gmail.com>
	<CAPabhsKrnFq3z6wTcZny+Jh1PF-7arx_r8WyNRHmgQUu=U4sig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 11:44:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBN13-0002YR-QW
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 11:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142Ab2IKJoL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Sep 2012 05:44:11 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:60358 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932138Ab2IKJoI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 05:44:08 -0400
Received: by lagy9 with SMTP id y9so177886lag.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 02:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LoTiBMIGCbydV8QvxIPRPjgrimNQCIi6uwB7tvSiAAY=;
        b=jwDMdPMElCLDPAPI7qiYlxzGaZOmL3X5J0apIHIKa4KdygQPUyRuh86vZ5EavGMbzl
         DE9+W3B35eXFRY/b3PzM2zdAER/ZVWMii7odA+M7Z7lhZTiOXP0/wsJLcennns+k2PUP
         dNdRKu7DT5YH/0r9bB5b3OU0AKZ7zFCu+4GCRpURm9gkZ6ClFJGeocZ5hmJtyg6ex3Qe
         fZTJQNxbePO+x46PVvZCJejHmk4FGi7L7wdARt9d2QRd9EDStHaEiGMlU2ed4LdZAFnt
         vcCmCYnFkedspCNgo3MYcHm3MscTpkPrBjEintbJgTp40ePgXNuR+PKSE5xzxAoE+NEI
         XXZw==
Received: by 10.152.110.46 with SMTP id hx14mr15044822lab.21.1347356642151;
 Tue, 11 Sep 2012 02:44:02 -0700 (PDT)
Received: by 10.114.0.20 with HTTP; Tue, 11 Sep 2012 02:44:02 -0700 (PDT)
In-Reply-To: <CAPabhsKrnFq3z6wTcZny+Jh1PF-7arx_r8WyNRHmgQUu=U4sig@mail.gmail.com>
X-Google-Sender-Auth: yu2T1hriO2TrEaq3P3zxWbUW2b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205213>

On Tue, Sep 11, 2012 at 10:36 AM, Tomas Carnecky
<tomas.carnecky@gmail.com> wrote:
> On Tue, Sep 11, 2012 at 9:30 AM, Roger Pau Monn=C3=A9
> <roger.pau@entel.upc.edu> wrote:
>> On Tue, Sep 11, 2012 at 10:24 AM, Tomas Carnecky
>> <tomas.carnecky@gmail.com> wrote:
>>> On Tue, 11 Sep 2012 10:21:16 +0100, Roger Pau Monn=C3=A9 <roger.pau=
@entel.upc.edu> wrote:
>>>> Hello,
>>>>
>>>> I'm using git for all my projects, and I usually work under Mac OS=
 X
>>>> with the default filesystem (that's case-insensitive, but
>>>> case-preserving). I'm currently working on a project that has seve=
ral
>>>> branches, and two of them are called origin/DHCPCD and origin/dhcp=
cd
>>>> respectively, that's unfortunate, but I cannot do anything about i=
t.
>>>> This completely breaks the git repository, because
>>>> .git/refs/remotes/origin/DHCPD and .git/refs/remotes/origin/dhcpd =
are
>>>> actually the same file, so when I try to update my repository
>>>> performing a git pull I get the following error:
>>>>
>>>> error: Ref refs/remotes/origin/dhcpcd is at
>>>> 6b371783de2def2d6e3ec2680ba731f7086067ee but expected
>>>> 79f701ce599a27043eed8343f76406014963278a
>>>>
>>>> So I was wondering if anyone has stumbled upon this issue, and wha=
t's
>>>> the best approach to fix it.
>>>
>>> Make a disk image and format it with a case sensitive filesystem (u=
se the Disk
>>> Utility to do that). Do your work there.
>>
>> Yes, I could also create a partition, or format my entire disk to
>> case-sensitive (although I heard it might break some OS X
>> applications), I guess adding a workaround for this in git itself is
>> not appealing (like storing the branch file using a slightly differe=
nt
>> name?)
>
> No, I'm not talking about a partition. I'm talking about a Mac OS X
> disk image (eg. http://en.wikipedia.org/wiki/.dmg).

I understood this, it's just that I would prefer to avoid doing this
kind if things, I would prefer to be able to work natively on my
filesystem, but it seems like there's no other option.

Thanks, Roger.
