From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH 2/2] Don't close pack fd when free'ing pack windows
Date: Wed, 31 Jul 2013 23:21:14 +0200
Message-ID: <20130731212114.GG19369@paksenarrion.iveqy.com>
References: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
 <1375300297-6744-1-git-send-email-bcasey@nvidia.com>
 <1375300297-6744-2-git-send-email-bcasey@nvidia.com>
 <CALWbr2wR2cN8dcOtW2bV3p7FC3ymdXgfp61A4pNKvOWhP6WU_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <bcasey@nvidia.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, spearce@spearce.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Brandon Casey <drafnel@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 23:19:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4dnQ-0000xv-P7
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 23:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab3GaVSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Jul 2013 17:18:34 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:56119 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab3GaVSd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 17:18:33 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so878090lab.20
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 14:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Y/ERxm3P25OBwwBcn+nToA3PMh7f4HYNfIuYISNscAQ=;
        b=Z7nyjkqb9cCaSURb87WtxHZjOJWBKUOhknrcqla7mgOnOe+IByP6uMgAYujNeDKjWT
         soCmZ/y5EyO5A5JCOl/FL+Hjj7NgwlsEGO1DWUJmBcV1P932nnsjGRf8AyrfCih+AOa1
         rge0Ha8WhOSuGrNrBhsYIbrQ1cDhuTADApEnRmo1aLGbv+7GWg1lG510oY9Ix50DPc9O
         vA/mqkEVC6jHqK/YNYDz1EYNOeYE2ggtGjgTT+9nELp1upPh88CSA4xO/3WZHIyPaUb/
         20+oVDgbrrmGtd8OKK2Qe2GbKfcMw1s4ypS6BaCpLouMZK9NQMZYGNtUUsKD/aA0G/5I
         rGDw==
X-Received: by 10.152.120.136 with SMTP id lc8mr31281880lab.89.1375305512401;
        Wed, 31 Jul 2013 14:18:32 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id gh5sm8684lbc.12.2013.07.31.14.18.31
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 14:18:31 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V4dpa-0004zS-7b; Wed, 31 Jul 2013 23:21:14 +0200
Content-Disposition: inline
In-Reply-To: <CALWbr2wR2cN8dcOtW2bV3p7FC3ymdXgfp61A4pNKvOWhP6WU_Q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231463>

On Wed, Jul 31, 2013 at 11:08:21PM +0200, Antoine Pelisse wrote:
> On Wed, Jul 31, 2013 at 9:51 PM, Brandon Casey <bcasey@nvidia.com> wr=
ote:
> > -------------------------------------------------------------------=
----------------
> > This email message is for the sole use of the intended recipient(s)=
 and may contain
> > confidential information.  Any unauthorized review, use, disclosure=
 or distribution
> > is prohibited.  If you are not the intended recipient, please conta=
ct the sender by
> > reply email and destroy all copies of the original message.
> > -------------------------------------------------------------------=
----------------
>=20
> I'm certainly not a lawyer, and I'm sorry for not reviewing the
> content of the patch instead, but is that not a problem from a legal
> point of view ?

Talking about legal, is it a problem if a commit isn't signed-off by
it's committer or author e-mail? Like in this case where the sign-off i=
s
from gmail.com and the committer from nvidia.com?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
