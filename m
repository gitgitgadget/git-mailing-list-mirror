From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/12] ll-merge: make flag easier to populate
Date: Thu, 5 Aug 2010 08:11:32 -0500
Message-ID: <20100805131132.GA25070@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
 <20100805110822.GB13779@burratino>
 <20100805111738.GI13779@burratino>
 <AANLkTi=9GwZgiQHpBLN_L14==Pir0Gs=DosZHF4wg9zi@mail.gmail.com>
 <20100805121658.GA23334@burratino>
 <AANLkTinz2hbbYcq=cQ=wmkK+Kg5W6Xf4r8yjYp1211ZU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 15:13:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh0Fo-00055c-GV
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 15:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760305Ab0HENMz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 09:12:55 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58647 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759070Ab0HENMy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 09:12:54 -0400
Received: by gwb20 with SMTP id 20so2439013gwb.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=uO8dSDB+O5un4QWls4E+Dkp2tuqT6oJZee8643rt2kE=;
        b=tMEsgda/xTtKhNwc6h3lEBVs9MQJXGHWCih4uKkTLvwdBFchojjb67RukU5l8nSEyu
         wK2t7XHGOJD8yLoULY5lf8fFButCGXziMQ73Tc+QsrgbpgJH2NOCuHl3QroMroqmTRdT
         dd++HUFrUEPwT+R9EOsyrpj9FbSsiNb1Dt1Qw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NwIZKPetYcyTN3c/7loh1Z/0hgXdijCNYbmVEmmBaQzg233W5qa00o2gXRrVcFyDzL
         0Bv05a8oe6sqBwcxkrDgdNyaTYlQjar8ZOQhmxTjLAs9/RWxkC3+JCyXY+FclEH++SDE
         v8cr9MoUSwAwS+xrRP5yEHRbI/bRtiLjfelpg=
Received: by 10.100.109.13 with SMTP id h13mr11833042anc.193.1281013973898;
        Thu, 05 Aug 2010 06:12:53 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id w6sm241917anb.23.2010.08.05.06.12.52
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 06:12:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinz2hbbYcq=cQ=wmkK+Kg5W6Xf4r8yjYp1211ZU@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152657>

Bert Wesarg wrote:
> On Thu, Aug 5, 2010 at 14:16, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
>> Bert Wesarg wrote:

>>> Or flavor_to_ll_flag()
>>> and ll_flag_to_flavor().
>>
>> Sounds reasonable. =C2=A0(Well, except this is =E2=80=9Cfavor=E2=80=9D=
 as in =E2=80=9Cfavor our
>> side=E2=80=9D or =E2=80=9Cfavor their side=E2=80=9D rather than =E2=80=
=9Cflavor of the month=E2=80=9D.) =C2=A0Patch?
>
> Sorry for this typo. Do you really want a squash patch for this renam=
ing?

Yes, that would make my life easier.  But if you are short on time, I
can get to it myself later.
