From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/12] ll-merge: make flag easier to populate
Date: Thu, 5 Aug 2010 07:16:58 -0500
Message-ID: <20100805121658.GA23334@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
 <20100805110822.GB13779@burratino>
 <20100805111738.GI13779@burratino>
 <AANLkTi=9GwZgiQHpBLN_L14==Pir0Gs=DosZHF4wg9zi@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Aug 05 14:18:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgzOz-0000cn-OU
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 14:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760168Ab0HEMSV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 08:18:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33955 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759181Ab0HEMSU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 08:18:20 -0400
Received: by iwn33 with SMTP id 33so141032iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 05:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fVGpXRp0PNlwNZB1wJkJHmbrgUVbBkKSI2r4qKjc3uI=;
        b=nLS8AZxFPxVhtHhBokziwnyC982QEqIg6H/f3wxrQ/DpoU6D5Oiw8qGhcSjxlbgGc3
         DRUPHMRXw7yqAWo0+yIcRCC8bhyQnzPCn1Ik69YYyLBcKX1Z6/K+wTKByByp6783TF3A
         fcHzp8NrOk/TE3QqzoBVP0V0H1N5p2OfAFUJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CSJCB0sSSGSPGLhn8b+N2QvrH8al7hcqiV3gpYZu0736LnKqczKDgYhJuq0rRqmFgp
         AUYDqMADu5qXylqVuoYEic1V5tyRe1AAJm7CUkf9OZ2nBDdZl9qkmyhb2sartCAvA8d0
         zmhOnMLAJnxx1extksoaqHIog8QtXBBgIvkSA=
Received: by 10.231.146.129 with SMTP id h1mr11525905ibv.181.1281010698789;
        Thu, 05 Aug 2010 05:18:18 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm92390ibk.9.2010.08.05.05.18.17
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 05:18:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=9GwZgiQHpBLN_L14==Pir0Gs=DosZHF4wg9zi@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152651>

Bert Wesarg wrote:
> On Thu, Aug 5, 2010 at 13:17, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

>> +static inline int ll_opt_favor(int flag)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 return (flag & LL_OPT_FAVOR_MASK) >> LL_OPT_F=
AVOR_SHIFT;
>> +}
>> +
>> +static inline int create_ll_flag(int favor)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 return ((favor << LL_OPT_FAVOR_SHIFT) & LL_OP=
T_FAVOR_MASK);
>> +}
>> +
[...]
> Or flavor_to_ll_flag()
> and ll_flag_to_flavor().

Sounds reasonable.  (Well, except this is =E2=80=9Cfavor=E2=80=9D as in=
 =E2=80=9Cfavor our
side=E2=80=9D or =E2=80=9Cfavor their side=E2=80=9D rather than =E2=80=9C=
flavor of the month=E2=80=9D.)  Patch?
