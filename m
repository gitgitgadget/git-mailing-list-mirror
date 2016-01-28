From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] stash: use "stash--helper"
Date: Thu, 28 Jan 2016 13:41:23 -0800
Message-ID: <CAGZ79kYVRY+6zFnHe8LPp2E_W_gAs--Vog-HoqXW-Do_WgHGXw@mail.gmail.com>
References: <0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com>
	<0000015289f33e85-713596a1-2718-4c3a-bf3c-4a0f1048d401-000000@eu-west-1.amazonses.com>
	<CAGZ79kaPQP+-LpW8ExM2wmfftW4_oa7tB5XdfsdC8XHwH4aFOA@mail.gmail.com>
	<BLU436-SMTP572EDBE67B8D37ECADD616A5DA0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Roberto Tyley <roberto.tyley@gmail.com>
To: =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 22:41:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOuJk-000559-VF
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 22:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbcA1Vl0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 16:41:26 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:34855 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbcA1VlY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 16:41:24 -0500
Received: by mail-io0-f182.google.com with SMTP id d63so52415406ioj.2
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 13:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/nj4SE+jO0adJ6Z78LLMDOCMr34uvI6ZJFgh+aBx+Eo=;
        b=YvOMt28/5x5BTss+xCbdZjzlfZBG/ygfnkh5ONs2WVBE2IC4NVWM6sHWbbT7fUvJcW
         cOjVIURUikxeje53GMF/dKblfbhtAbCvFzvYUDh+y27LMDUVWIw2Wss4Q3TsaF/hBE81
         qrbvMC00I9kYUhz1Ozob8nIMyB6PUHuTxiz8GxGpE697RNGntSOa+ftuI5KB9KC7EE6s
         DsIZvx85tR84EgNVRyOt+hIp9LxQx0zm4i9OjTxX+jbnUEM3eP8u7aRTzX+oKOqVgwab
         wyxjel+wazSFwIIib0HxrBVdd36NHZ5pdxPHBp9OAfBWbFdC+fuYpza+2FdeyVBYP9CT
         6ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/nj4SE+jO0adJ6Z78LLMDOCMr34uvI6ZJFgh+aBx+Eo=;
        b=giXrN0y3i5UjFsj2KoM+ewNxg/w0RAeY7pMRzoIqTt7Ktx1gkmcvH5VgwR+s8IT5xK
         15xF6MirsCUQSL/y6x/X1jvpMYnU9NoyMEz9OqkBXE646z6susIByzUyH0AffB/2Zjhm
         wLkNEPEt3vPsNhe3DSlkFHparB5GE44qH9wQsusMTVc3AWMJARkNOINW8/4dWDzzz32E
         1vGYkeVeASjMCl4xm8biv1ho0xsWB5WtbmONnALk6hWE6MySPFhpYPfLVolkjv9EtxWz
         AypBJrhDes3pmvY3bUuC2VvYQa8ApaOtXqY+d2+P9Z8mcDHPk/GPPrmCub+zeLSx+uoC
         0P1g==
X-Gm-Message-State: AG10YOQPMxGQGHMU/dS0ISh5SsNjsaG/Wzil+CBKrp5OLWeXYIOg5O9JYYPKj5Kbfwbpb9CEnYQxOWhvW6Ll2GIO
X-Received: by 10.107.137.68 with SMTP id l65mr7512009iod.110.1454017283641;
 Thu, 28 Jan 2016 13:41:23 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Thu, 28 Jan 2016 13:41:23 -0800 (PST)
In-Reply-To: <BLU436-SMTP572EDBE67B8D37ECADD616A5DA0@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285036>

On Thu, Jan 28, 2016 at 1:25 PM, Matthias A=C3=9Fhauer <mha1993@live.de=
> wrote:
>> You had some good measurements in the coverletter, which is not goin=
g to be recorded in the projects history. This part however would be pa=
rt of the commit.
>> So you could move the speed improvements here (as well as the other =
reasoning) on why this is a good idea. :)
>
> I considered that, but I thought it would inflate the size of the com=
mit message quite a bit and represents a  pretty temporary information =
as I'm planning to port more code.

No worries about too large commit messages. ;) See
dcd1742e56ebb944c4ff62346da4548e1e3be675 as an example for commit
message per code raio what Jeff usually produces. :)

> Any further progression on this would make the old meassurements kind=
 of obsolete IMHO.

Well it records that this specific step was beneficial, too, on the
platforms you measured on. If it turns out to there is a regression
after you rewrote lots of code, it is still traceable that this commit
was done in good faith.

> I decided to move it to the coverletter, because it is only valid inf=
ormation if you consider both commits. If the general opinion on here i=
s that I should add it to the commit message though, I'll gladly update=
 it.

Heh, true. However you enable the speedup in the second patch. If you
were to apply only the first (add the helper), you'd not see the
difference, so maybe it's worth adding it to the second commit
message.

>
>>> https://github.com/git/git/pull/191
>>
>> Oh I see you're using the pull-request to email translator, cool!
>
> Yes, I did. It definitly makes things easier if you are not used to m=
ailing lists, but it was also a bit of a kerfuffle. I tried to start wo=
rking on coverletter support, but I couldn't get it to accept the amazo=
n SES credentials I provided. I ended up manually submiting the coverle=
tter. It also didn't like my name.

Not sure if Roberto, the creator of that tool, follows the mailing
list.  I cc'd him.

>
> Thank you for your quick feedback.
>
