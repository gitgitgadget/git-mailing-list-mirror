From: Michael Witten <mfwitten@gmail.com>
Subject: Re: In favor of "git commit --no-parent"
Date: Thu, 29 Sep 2011 21:28:39 +0000
Message-ID: <CAMOZ1Bs9kei58AVJZRJM4g+Nh3QaY8dtUBctmLL8SVL3XW=aLw@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr> <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr> <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com> <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com> <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
 <CABURp0q4wi5ruLmeaZtN=8QvuX2ftSFQo1uJL0_8-wtm1nYaGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 23:29:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9OAO-0005YD-7Y
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 23:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757123Ab1I2V3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 17:29:11 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65296 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab1I2V3K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 17:29:10 -0400
Received: by iaqq3 with SMTP id q3so1105884iaq.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 14:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CQCu61fLlsiTklDkLOIKmfiRhqxe6L5qBeg3celTkvM=;
        b=hDEtn0J/YpP/Ud3O/2uRLMWAoxSSNvdt77WyZcPl438KB5PrUaJX2GHivbUhuTCJIh
         DTjeR6Bc9O9NFOjzwd8K3HkyaosHS39tbGyJjW68J9/F/2xDLG4MW14jvhdrLu7Dac6d
         x4LOmr6m27jh9eUJyLvNgS8v/zxZOcUqi/nLE=
Received: by 10.42.117.133 with SMTP id t5mr1517196icq.222.1317331749105; Thu,
 29 Sep 2011 14:29:09 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Thu, 29 Sep 2011 14:28:39 -0700 (PDT)
In-Reply-To: <CABURp0q4wi5ruLmeaZtN=8QvuX2ftSFQo1uJL0_8-wtm1nYaGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182441>

On Thu, Sep 29, 2011 at 21:02, Phil Hord <phil.hord@gmail.com> wrote:
> On Thu, Sep 29, 2011 at 2:11 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
> [...]
>> Step back a bit. There are two independent issues:
>>
>> =C2=A0- When does it make sense to originate two independent histori=
es in a
>> =C2=A0 single repository that has a working tree?
>>
>> =C2=A0- What is the best tool to originate a new independent history=
 in a
>> =C2=A0 single repository that has a working tree?
>>
>> As I said number of times already, be it done with "checkout --orpha=
n" or
>> "commit --no-parent", the "Separate History" use case is better done=
 in a
>> separate repository. There is *no* advantage to originate the two se=
parate
>> histories that do not share any resemblance of tree shape as branche=
s in a
>> single repository with a working tree; "git checkout $branch" betwee=
n the
>> two would actively work against you.
>
> I think a user looking for this functionality -- either a new git use=
r
> or a user who seldom uses the "create secondary root commit" command
> -- would first try 'git help init'. =C2=A0It seems logical to me that=
 I
> should be able to do this:
>
> =C2=A0cd my-git-repo
> =C2=A0git init --root=3D<newbranch> .
>
> This feels natural to me for this operation.

That would be a good place for the "git checkout --no-parent" variant,
especially given that I think "git checkout --no-parent" should produce
an empty working tree and index, which we can all note is essentially
what "git init" gives us.

Your suggestion seems like a corroboration of my stance.
