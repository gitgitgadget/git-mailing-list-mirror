From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 04/10] attr: more matching optimizations from .gitignore
Date: Sat, 6 Oct 2012 12:02:17 +0700
Message-ID: <CACsJy8BWJg0sr-6iG4LwJjkSM46=CBgddDac4dDR2o3HZ8_25g@mail.gmail.com>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
 <1349412069-627-5-git-send-email-pclouds@gmail.com> <7vy5jku549.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 07:03:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKMXc-0003yp-3d
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 07:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975Ab2JFFCt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Oct 2012 01:02:49 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43598 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab2JFFCt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2012 01:02:49 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so5619603iea.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 22:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2CiDbHGqvA8GhbjsKK5yyX+11fWSaHHIopg7bII+DJg=;
        b=EUTwR+XXPOBURYbUtFWcSccLaFcChquiHM2ltnPgHAQn86w4vD5oBZ6hDwJJ5rwzWD
         e8It4inpgvbl+p9PSqATOCfP+mnPrNkThlYisKmYLxOYygfF0rSMZFRt82larNzGhhCt
         kL2a3vky6GsV6NjgZpws04rENky3I3Z2/NU+vfRR4zqbZybmvb2xPgvU4K8uLUBe4wRb
         rBwhgtvxPhN4l1bxsao5mCBpTSoMD+mAggCwZep5B5k0UCgEoTV7PdqmlZuo0wLFLJTH
         9ue4WloN1MxIE4J8rRS/e57sEKv/2KRiNiAmWBq4ESccOisEfYRFGDhQltOcplr79o4N
         Z/8A==
Received: by 10.50.153.130 with SMTP id vg2mr836759igb.26.1349499768118; Fri,
 05 Oct 2012 22:02:48 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Fri, 5 Oct 2012 22:02:17 -0700 (PDT)
In-Reply-To: <7vy5jku549.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207128>

On Sat, Oct 6, 2012 at 1:48 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> +Unlike `.gitignore`, negative patterns are not supported.
>> +Patterns that match directories are also not supported.
>
> Is "are not supported" the right phrasing?
>
> I think it makes perfect sense not to forbid "!path attr1", because
> it is unclear what it means (e.g. "path -attr1" vs "path !attr1").
> So I would say "Negative patterns are forbidden as they do not make
> any sense".

OK

> But for the latter, I think it makes a lot more sense to just accept
> "path/ attr1" and doing nothing.  The user requests to set an
> attribute to "path" that has to be a directory, and there is nothing
> wrong in such a request in itself.  But nothing in git asks for
> attributes for directories (because we do not track directories),
> and such a request happens to be a no-op.

Or the user might think "path/ attr1" sets attr1 for all files under
"path/" because it does not make sense to attach attributes to a
directory in git.
--=20
Duy
