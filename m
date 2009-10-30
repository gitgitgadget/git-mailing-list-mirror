From: Gisle Aas <gisle@aas.no>
Subject: Re: [PATCH] More precise description of 'git describe --abbrev'
Date: Fri, 30 Oct 2009 09:01:38 +0100
Message-ID: <b48ea8a00910300101i38f2e4a8q2c2e014d2df1a150@mail.gmail.com>
References: <b48ea8a00910291438r8b66a0fq9e821393ecfff0bf@mail.gmail.com>
	 <7vws2d4y3d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 09:01:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3mQb-0006x1-P6
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 09:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018AbZJ3IBf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 04:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754898AbZJ3IBf
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 04:01:35 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:36897 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740AbZJ3IBe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 04:01:34 -0400
Received: by bwz27 with SMTP id 27so3232521bwz.21
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 01:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=ySHzSjgfQYnfSZk0nz8/CpLgpBTDmB/hi8D/f/am4Ks=;
        b=yFz+svDyz1iLUQujjcAoT2hBVCzlqD1lYdx/b1WaOmR/3VtBIQ0NUG3RLUKS8Ng3lf
         nuCIm7e6TMbJvV89gi24c1yA/6aaaqleLhHVJ4dqGvanKWzWmOgCq2gAyyF7ikNuowbK
         vQEf98NoexxmJ0ujA71YyNoeCBoYI3iQueiWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=WN6h/ejC3DrMxbHRnegcqUlqeBOz8AEm0zpFPkQ7o2e68cm+XMn6V4niQnhY/htC6h
         aTr8GU+RtPW+h9liBylWuJFY24ZbrCokwYx1DFvZi3/E0TJ/xtsOMKhwYjl0XRrefBLM
         InQU+Pxn1k2tkYbpzs8wtdtYwOFCmwHBMwLJE=
Received: by 10.239.143.214 with SMTP id l22mr118307hba.167.1256889698025; 
	Fri, 30 Oct 2009 01:01:38 -0700 (PDT)
In-Reply-To: <7vws2d4y3d.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 349c179d90b88fc9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131677>

On Thu, Oct 29, 2009 at 23:47, Junio C Hamano <gitster@pobox.com> wrote=
:
> Gisle Aas <gisle@aas.no> writes:
>
>> Also make the examples show what 'git describe' actually outputs
>> currently. =C2=A0I guess the default --abbrev value has been changed=
 from 4
>> to 7 at some point.
>
> Some are good changes, but I do not think the example with --abbrev=3D=
4 is.
>
> $ git describe 975bf9cf5ad5d440f98f464ae8124609a4835ce1
> v1.3.2-216-g975bf9c
> $ git describe 975b31dc6e12fba8f7b067ddbe32230995e05400
> v1.0.0-21-g975b31d
>
> Next time somebody adds a new object whose name happens to begin with
> 975b3 you would need to update the example output.

Yeah, I know, but I don't think that's a big deal.  So do you want an
updated patch for that?  We could either simply remove this example or
make it use --abbrev=3D10 or something like that.

--Gisle


>
>> Signed-off-by: Gisle Aas <gisle@aas.no>
>> ---
>> =C2=A0Documentation/git-describe.txt | =C2=A0 12 +++++++-----
>> =C2=A01 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/git-describe.txt b/Documentation/git-desc=
ribe.txt
>> index b231dbb..743eb95 100644
>> --- a/Documentation/git-describe.txt
>> +++ b/Documentation/git-describe.txt
>> @@ -44,7 +44,9 @@ OPTIONS
>>
>> =C2=A0--abbrev=3D<n>::
>> =C2=A0 =C2=A0 =C2=A0 Instead of using the default 7 hexadecimal digi=
ts as the
>> - =C2=A0 =C2=A0 abbreviated object name, use <n> digits.
>> + =C2=A0 =C2=A0 abbreviated object name, use <n> digits or as many d=
igits
>> + =C2=A0 =C2=A0 are needed to form a unique object name. =C2=A0An <n=
> of 0
>> + =C2=A0 =C2=A0 will suppress long format, only showing the closest =
tag.
>>
>> =C2=A0--candidates=3D<n>::
>> =C2=A0 =C2=A0 =C2=A0 Instead of considering only the 10 most recent =
tags as
>> @@ -68,8 +70,8 @@ OPTIONS
>> =C2=A0 =C2=A0 =C2=A0 This is useful when you want to see parts of th=
e commit object name
>> =C2=A0 =C2=A0 =C2=A0 in "describe" output, even when the commit in q=
uestion happens to be
>> =C2=A0 =C2=A0 =C2=A0 a tagged version. =C2=A0Instead of just emittin=
g the tag name, it will
>> - =C2=A0 =C2=A0 describe such a commit as v1.2-0-deadbeef (0th commi=
t since tag v1.2
>> - =C2=A0 =C2=A0 that points at object deadbeef....).
>> + =C2=A0 =C2=A0 describe such a commit as v1.2-0-gdeadbee (0th commi=
t since tag v1.2
>> + =C2=A0 =C2=A0 that points at object deadbee....).
>>
>> =C2=A0--match <pattern>::
>> =C2=A0 =C2=A0 =C2=A0 Only consider tags matching the given pattern (=
can be used to avoid
>> @@ -106,10 +108,10 @@ With --all, the command can use branch heads a=
s
>> references, so
>> =C2=A0the output shows the reference path as well:
>>
>> =C2=A0 =C2=A0 =C2=A0 [torvalds@g5 git]$ git describe --all --abbrev=3D=
4 v1.0.5^2
>> - =C2=A0 =C2=A0 tags/v1.0.0-21-g975b
>> + =C2=A0 =C2=A0 tags/v1.0.0-21-g975b3
>>
>> =C2=A0 =C2=A0 =C2=A0 [torvalds@g5 git]$ git describe --all HEAD^
>> - =C2=A0 =C2=A0 heads/lt/describe-7-g975b
>> + =C2=A0 =C2=A0 heads/lt/describe-7-g975b31d
>>
>> =C2=A0With --abbrev set to 0, the command can be used to find the
>> =C2=A0closest tagname without any suffix:
>> --
>> 1.6.2.95.g934f7
>
