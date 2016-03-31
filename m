From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v11 1/4] test-parse-options: print quiet as integer
Date: Fri, 1 Apr 2016 00:10:35 +0530
Message-ID: <CAFZEwPMyVftmW8ZCCyFMUMOegqimpFxjLrHfjMKc88w+HDvG+A@mail.gmail.com>
References: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
	<01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
	<xmqqegaqo6gg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 20:40:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alhWL-0000m0-Du
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 20:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605AbcCaSkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 14:40:37 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33850 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbcCaSkg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 14:40:36 -0400
Received: by mail-yw0-f194.google.com with SMTP id f6so12809180ywa.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=+c6Y0G9VPidOW0ViyeQRKHzs7UBBWuHWB0kfSmNdjNY=;
        b=D+rzcJZ/qb7PQGRvcfY9MxWwEfCFfCNsqW6FIiEcqV0uZoafmykCD5M2afyYdlHtRA
         Ww42gTfxiX1/VS05k0ColINMl1pvv277I4h3rsUJC3chiNRpxCz+C7UfnIa7ua6Yi9zQ
         bY+7dQmfPZRZ18BmtNo7Zzw57Aa0Y3EoS6WzleQfzYZNljTnn1DhN1Q6vucGjSanjVpn
         7aOGpR8202ACDZb5t4gpPgYr4nn2Z6CMlfEuSqTFOLHxU+M09tB2l/VZqQwS3+g0UgjZ
         Ad0o6VvGlNU3IDsd5ejGyXAnsRiz3DOD0yIgq7fi9Cr8FJ+8XzizHH1O3MJD3Yf1y752
         /uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=+c6Y0G9VPidOW0ViyeQRKHzs7UBBWuHWB0kfSmNdjNY=;
        b=kNUf9PjrYEMrOuo7xOMxDIETizzOghZ3M2ArrEfT1ku0WtUFffUV6tIzBExvVCT3nF
         uIdbyJIh1jMCJmGHbCqjN3qjuo0kEnumkobrCG51xCJvfEXTSQIb+wUU3NQjcOs0eihB
         2byN8Ds4+CliYD0oYR0SrqwZOGGgUJ1+7xMg5PG+PJz3O3bjjjI6Lxe0/JwyV6aWZtCz
         68IciIhSfKyO6gWt4V/VXF8dLS7XKd6kN1eaR4sZeOAnv/r1SLLBbMzEmDMGLDvIzp/X
         3z60HiLA8TMOBatpL77gM9xALFNbATw/6tdREYC++CvDLQ6Krf5yqqwfSqEtPCOg27vt
         eYhw==
X-Gm-Message-State: AD7BkJK4yDy/XWUBc3JwV0Ei8YaNRE+ANDQc2pHxPO/iBKE3/Ua06DPC/KKET99cun8snwFOy656Xf0BU8vp8A==
X-Received: by 10.129.91.6 with SMTP id p6mr8306425ywb.325.1459449635842; Thu,
 31 Mar 2016 11:40:35 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 31 Mar 2016 11:40:35 -0700 (PDT)
In-Reply-To: <xmqqegaqo6gg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290441>

On Thu, Mar 31, 2016 at 11:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> Current implementation of parse-options.c treats OPT__QUIET() as integer
>> and not boolean and thus it is more appropriate to print it as integer
>> to avoid confusion.
>>
>> While at it, fix some style issues.
>
> I counted the changes in t0040 and you have _more_ style fixes than
> the real change.  That is not "while at it".
>
> While I welcome the style fix, it is better done as a preparatory
> clean-up step before the real change.

Okay. I thought this was a minor change so I squashed it together. I
will separate it though.

> Missing sign-off.

Will include this

>> -cat > typo.err << EOF
>> +cat >typo.err <<EOF
>>  error: did you mean \`--boolean\` (with two dashes ?)
>>  EOF
>
> If your "style cleanup" patch were separate, you could fix this (and
> other that have backslash escape inside the here-document) further
> to something like this:
>
>         cat >type.err <<\EOF
>         error: did you mean `--boolean` (with two dashes ?)
>         EOF
>
> Thanks.

Will include this.
