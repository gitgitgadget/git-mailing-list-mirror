From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] [submodule] Add depth to submodule update
Date: Sat, 29 Jun 2013 01:07:14 +0200
Message-ID: <20130628230714.GA22143@paksenarrion.iveqy.com>
References: <1371974698-28685-1-git-send-email-iveqy@iveqy.com>
 <20130624224925.GC32270@paksenarrion.iveqy.com>
 <20130625221132.GB4161@sandbox-ub>
 <20130626160219.GC9141@paksenarrion.iveqy.com>
 <7vli5wvb3n.fsf@alter.siamese.dyndns.org>
 <51CC5235.6030908@web.de>
 <20130628065001.GA2783@sandbox-ub>
 <7vk3lenkhh.fsf@alter.siamese.dyndns.org>
 <51CDF819.9030308@web.de>
 <7vr4fllugy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 29 01:07:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UshlY-0000q3-Fn
	for gcvg-git-2@plane.gmane.org; Sat, 29 Jun 2013 01:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740Ab3F1XHl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 19:07:41 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:51623 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab3F1XHk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 19:07:40 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so2710146lab.18
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 16:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jVeM80kMSnaf/AZFMQlK5VNnMW8jeNaci7T6+gFA0C8=;
        b=ssJJnHAzScIFhkosNUdfa6zsxS01elMNJtvTdL2t1Sw3AphSf1hEOMmd8qnTkBis8E
         FOZovYe3GtngdAzNGoU2BGzp3Am3lhguwJT+uryTMRLx5bzBur6FVVSVDiCfslyshLWE
         UiS8u0DS1SR5h4Ni67Peqb0RtrSnCY2YWITn2QvIPgaDT88tLfUT5e3LGdpkzFAKEzFN
         bYFDzIaMfMw8m2NsJUObhm6+kjlmAZROoPJuDJ+tm8rPNdNyCC9c75pqGw5LRMnNwCBD
         YjmMyoYTYnLu0QFFmFu7idNYoQCSymmZq7AvlQlGUFEXfp3vHGFCqSka4jUv2QciexLK
         84Ww==
X-Received: by 10.112.164.164 with SMTP id yr4mr7355137lbb.88.1372460858403;
        Fri, 28 Jun 2013 16:07:38 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id s3sm3299175lbs.14.2013.06.28.16.07.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 16:07:37 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Ushl4-0005Cg-EN; Sat, 29 Jun 2013 01:07:14 +0200
Content-Disposition: inline
In-Reply-To: <7vr4fllugy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229248>

On Fri, Jun 28, 2013 at 03:51:41PM -0700, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>=20
> > Am 28.06.2013 20:44, schrieb Junio C Hamano:
> >> Heiko Voigt <hvoigt@hvoigt.net> writes:
> >> ...=20
> >>> Hmm, but does it have a --depth option for revisions? Maybe we sh=
ould
> >>> call it --clone-depth or --rev-depth to make it clear? --depth an=
d
> >>> --max-depth would be completely orthogonal but the name does not =
allow
> >>> to distinguish them properly.
> >>=20
> >> I do not have a strong opinion either way, but as you suggest, it
> >> might be a good idea to call this new option --clone-depth to be
> >> more specific.
> >
> > No strong opinion here either, but I'm leaning towards "--depth"
> > because on one hand we already have the "--reference" option which
> > is passed on to the clone command (and not "--clone-reference")...
>=20
> OK, then "--depth" it is.
>=20
> The points in your review on the last version with "--depth" (which
> I picked up and parked on 'pu') still need to be addressed, I think?

I agree, I'm on it

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
