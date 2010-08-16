From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] reset: Better warning message on git reset --mixed <paths>
Date: Mon, 16 Aug 2010 01:13:51 +0000
Message-ID: <AANLkTi=ddi_fek3NxF=ESM6HP3Myn6sa1xfsWMyNCUFB@mail.gmail.com>
References: <1281814499-11797-1-git-send-email-avarab@gmail.com>
	<20100814210505.GA2372@burratino>
	<7vvd7chcj4.fsf@alter.siamese.dyndns.org>
	<87tymwzjbk.fsf@catnip.gol.com>
	<AANLkTin3zyPvs3GjOt3=q6dOofFA2ba0sBAzt3=Ka1Wn@mail.gmail.com>
	<7vr5hzg1u1.fsf@alter.siamese.dyndns.org>
	<AANLkTik+yGn_0PR9uO2_EsZgQPW187P4qmZx4fJSbAWO@mail.gmail.com>
	<AANLkTim=TM_3aXMSSN1-vovdc3z6QNR15KHujiJ-wH4_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Ralf Ebert <info@ralfebert.de>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 16 03:14:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkoH0-0005qa-3K
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 03:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902Ab0HPBNx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 21:13:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55875 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab0HPBNw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 21:13:52 -0400
Received: by iwn7 with SMTP id 7so1120283iwn.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 18:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lQVWP17uMKd3FB/eam/XP0F4Pbi3GQASIkZDpnR9XGg=;
        b=PhTsgNFxCS0fhJ5wCPVWvEFZ10nahmxIGtQfkx9i6PeWJ4/Z8Uz3ZOVc3Diu5pkHuT
         WMo21MlOsZKSpX7OytQkFXL9gr+tLDd/kwrmGz41eutBqsjInc33Zwrgr/2pD3Mn+F25
         npA9mhoU3K0bVY6PM+pWKXJBp3ywwyn0S6FJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pMLSiIdv6sQV0VBhRLhMTc/dwmrTxthhshj3PooY+dncNaBNjiDAclYr3bSODd4oVB
         WGTHSRAMFdBeA1oyZ7x7JAnIVpnzlM70ehNVgTva/yxosx6g0l7SGQImWolf8cx1aRXC
         NezeYHEp4SSBtta9xzMM4TGre4i6QQQcPoxIQ=
Received: by 10.231.161.68 with SMTP id q4mr5168568ibx.79.1281921231887; Sun,
 15 Aug 2010 18:13:51 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sun, 15 Aug 2010 18:13:51 -0700 (PDT)
In-Reply-To: <AANLkTim=TM_3aXMSSN1-vovdc3z6QNR15KHujiJ-wH4_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153641>

On Mon, Aug 16, 2010 at 00:59, Miles Bader <miles@gnu.org> wrote:
> On Mon, Aug 16, 2010 at 5:51 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> So it's a question of whether git-reset should do all reset-y things
>> without complaining, even when that infringes on git-checkout's
>> domain.
>
> Of course one question is: =C2=A0why is this "git-checkout's domain" =
in the
> first place?
>
> From a UI perspective this functionality doesn't seem to make any mor=
e
> sense in checkout -- and perhaps _less_ -- than it does in git-reset.
> "git-checkout <path>" seems like a tacked-on-to-make-cvs-users-happy
> wart rather than a natural part of git-checkout.
>
> I know that as a beginning git user, I always tried to use "git-reset
> --hard <path>", because that sort of made sense in my mental model of
> git commands, only to be confused when it didn't work. =C2=A0The fact=
 that
> one actually needed to to do git-checkout instead was confusing.

Yeah, maybe one command to reset a file to various states makes more
sense than a singular "checking it out".

Anyway, this is the sort of thing I was alluding to, it won't do to
make micro-changes to the UI without considering the bigger picture.
