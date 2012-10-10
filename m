From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/8] wildmatch: remove static variable force_lower_case
Date: Wed, 10 Oct 2012 12:14:50 +0700
Message-ID: <CACsJy8BOcH8cXje5osL4oNP1YkJ8HadUOYBek3uhEbySBey9Kw@mail.gmail.com>
References: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
 <1349752147-13314-5-git-send-email-pclouds@gmail.com> <7vtxu3e5jl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 07:15:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLodp-00055Q-FD
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 07:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608Ab2JJFPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 01:15:23 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:35553 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197Ab2JJFPV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 01:15:21 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so172746qaa.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 22:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oltYkyMWBD/uLvyXZHOre+sLGCsrz8/m5PlkokLTBWU=;
        b=bNmAUcMCWwnWiamS1/9Lt3Nt7BdC9FOfCKaG3/zz0+LXKoJTDBExXLBCgCA77KPe7Y
         5pxJa7f/eSkYdiPvgmWzQC9SDr3a3D1C5o1V/P3A2FEqtqRopHn174qv0xNFFEOSNvFP
         MIUXC6CodmpXMvLamatxGvTpqWNX0wfLoHOYRR6qob0oFTXunna4Jchgzg4WpHsYUCxA
         ymULZZzujcN6xR7JjLv5Tu8IZ2nlN8bH5mZT6JXsRhYfhT9Muk5clg6j2prqaq62uGXS
         smWrrKDmFHD2ztnWeFQ4ai75PiA4c4iL5EK+gSaxdEAW1sK9MMyk0fCReLdFoH+ozl+q
         KZhg==
Received: by 10.229.137.12 with SMTP id u12mr1405766qct.28.1349846121019; Tue,
 09 Oct 2012 22:15:21 -0700 (PDT)
Received: by 10.49.13.194 with HTTP; Tue, 9 Oct 2012 22:14:50 -0700 (PDT)
In-Reply-To: <7vtxu3e5jl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207361>

On Wed, Oct 10, 2012 at 3:47 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> diff --git a/wildmatch.c b/wildmatch.c
>> index 7b64a6b..2382873 100644
>> --- a/wildmatch.c
>> +++ b/wildmatch.c
>> @@ -11,8 +11,8 @@
>>
>>  #include <stddef.h>
>>  #include <ctype.h>
>> -#include <string.h>
>>
>> +#include "cache.h"
>>  #include "wildmatch.h"
>
> This is wrong; the includes from the system headers should have
> been removed in the previous step where the series "integrated"
> wildmatch to git, after which point the first include any C source
> that is not at the platform-compatibility layer should be cache.h
> or git-compat-util.h.

Git's ctype does not seem to be complete for wildmatch's use so
ctype.h is required. But that can be easily fixed later on.
--=20
Duy
