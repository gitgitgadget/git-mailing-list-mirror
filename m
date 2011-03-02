From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv2 1/3] t6022: New test checking for unnecessary updates of
 renamed+modified files
Date: Wed, 2 Mar 2011 15:26:55 -0700
Message-ID: <AANLkTikG+DT3fz3ntqQAz7pzz+aDd2Q4db02C8ypQMx_@mail.gmail.com>
References: <1298941732-19763-1-git-send-email-newren@gmail.com>
	<1298941732-19763-2-git-send-email-newren@gmail.com>
	<4D6CA13C.1000006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 23:27:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuuVa-0002E0-BW
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 23:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757934Ab1CBW05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 17:26:57 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40259 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757873Ab1CBW04 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2011 17:26:56 -0500
Received: by fxm17 with SMTP id 17so520267fxm.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 14:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BzQna4kx5ds7SK3mS7lWB17tvMB4USB4+00jfV2B2NU=;
        b=oDnaZtvdNzVrKXR3UniVXMZ0HQakHWFBf0J75s1IcCDWQ3MuHtv4lVNr3V3LHJN7j4
         i4AerioONtw67pGt+GrRZpS8V8xV/F5QwvalN9tjDUwGw1mOqcYvg+TUQnMxw+PerftT
         dDkcz8MImctcl0hY0GdyUB+KEMo0OiomYNNjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=p0/+Y+2uMkq7IGMtw83385tpQPMl7snmz5M9DG+8dDSKncS+blVMZpasnTESlloT8i
         QCHOjUar9qTK4IIsBL3hF5vif8r4PduwDnb/z5HNue+rgLABFYCIqYwqUdI5hK/nFmBY
         VsnKH27QZCsycWzYhD4Nl2LrgLmU0QANXCxe0=
Received: by 10.223.3.3 with SMTP id 3mr576188fal.15.1299104815140; Wed, 02
 Mar 2011 14:26:55 -0800 (PST)
Received: by 10.223.111.6 with HTTP; Wed, 2 Mar 2011 14:26:55 -0800 (PST)
In-Reply-To: <4D6CA13C.1000006@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168358>

Hi,

On Tue, Mar 1, 2011 at 12:33 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 3/1/2011 2:08, schrieb Elijah Newren:
> Use
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test-chmtime =3D1000000000 rename &&
<snip>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0orig=3D$(test-chmtime -v +0 rename) &&
<snip>
>> + =C2=A0 =C2=A0 git diff-files --exit-code # Is "rename" clean, or o=
nly racily clean?
>
> What you see here, is not "racily clean", but "stat dirty". "Racily c=
lean"
> means that git thinks that the file is clean (because the stat inform=
ation
> matches), but in fact the file content is not identical to the conten=
t
> recorded in the index.

Thanks for the suggestions and explanation; I've got it and Jeff's
suggestions incorporated.
