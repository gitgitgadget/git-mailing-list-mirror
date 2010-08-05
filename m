From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 07/12] ll-merge: make flag easier to populate
Date: Thu, 5 Aug 2010 15:05:31 +0200
Message-ID: <AANLkTinz2hbbYcq=cQ=wmkK+Kg5W6Xf4r8yjYp1211ZU@mail.gmail.com>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
	<20100804031935.GA19699@burratino>
	<20100804032338.GF19699@burratino>
	<7vocdifdrk.fsf@alter.siamese.dyndns.org>
	<20100805110822.GB13779@burratino>
	<20100805111738.GI13779@burratino>
	<AANLkTi=9GwZgiQHpBLN_L14==Pir0Gs=DosZHF4wg9zi@mail.gmail.com>
	<20100805121658.GA23334@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 15:05:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh08h-0004n6-O8
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 15:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759232Ab0HENFe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 09:05:34 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48342 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219Ab0HENFc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 09:05:32 -0400
Received: by yxg6 with SMTP id 6so2475789yxg.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 06:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gxsVn+Gt4MCJOClezfNppakqfs3L0HEPm9lhvQdoGT8=;
        b=wxMG+5eI3cHMTxJ9lqLKgjo3gwytNKMi/lg3OTzbkysDO6WgYxKGQmc8BJt9ARVd7G
         OmYGcrwr5mAMo0D1fbhyjRat5LVMvhdzR3mCPGxN5czxBDUlzGBm7uFZF1mTta28egM0
         Ode6WV95IasUiXB0s5nZkVXkUkeuoNpo8prps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iPr+WiCMHhfACq50JJITT+y/5m1TDjvSwHlBJxtpGX7R3xn4E96sVB1Vbh0hiZF0f8
         9MjLKLqRoQFiKHjaGRVNa4LEB51pv/Ar6MJL+epz6eOr5IIb0FjrKtBNzsF7V+HEJ57X
         SkZc6KzQbTlliAQry6dTVU8JjQ5gbBe+4Wcow=
Received: by 10.100.96.14 with SMTP id t14mr11857566anb.155.1281013531575; 
	Thu, 05 Aug 2010 06:05:31 -0700 (PDT)
Received: by 10.231.146.131 with HTTP; Thu, 5 Aug 2010 06:05:31 -0700 (PDT)
In-Reply-To: <20100805121658.GA23334@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152654>

On Thu, Aug 5, 2010 at 14:16, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Bert Wesarg wrote:
>> On Thu, Aug 5, 2010 at 13:17, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>
>>> +static inline int ll_opt_favor(int flag)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 return (flag & LL_OPT_FAVOR_MASK) >> LL_OPT_=
=46AVOR_SHIFT;
>>> +}
>>> +
>>> +static inline int create_ll_flag(int favor)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 return ((favor << LL_OPT_FAVOR_SHIFT) & LL_O=
PT_FAVOR_MASK);
>>> +}
>>> +
> [...]
>> Or flavor_to_ll_flag()
>> and ll_flag_to_flavor().
>
> Sounds reasonable. =C2=A0(Well, except this is =E2=80=9Cfavor=E2=80=9D=
 as in =E2=80=9Cfavor our
> side=E2=80=9D or =E2=80=9Cfavor their side=E2=80=9D rather than =E2=80=
=9Cflavor of the month=E2=80=9D.) =C2=A0Patch?

Sorry for this typo. Do you really want a squash patch for this renamin=
g?

Bert

>
