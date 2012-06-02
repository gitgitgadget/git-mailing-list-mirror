From: David Michael Barr <davidbarr@google.com>
Subject: Re: More use of levenshtein?
Date: Sat, 2 Jun 2012 21:37:56 +1000
Message-ID: <CAFfmPPPi92zN7QOh4q=rcVBb0oEFa3LKKdURe5gGj02_dEHoMA@mail.gmail.com>
References: <7vzk8m26sf.fsf@alter.siamese.dyndns.org>
	<CACsJy8DuDzxrcb8kbWhH9N=1APQeEOUZzUvSaKCJ7LJ9rc9tKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 13:38:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sameg-0004Al-8g
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 13:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758752Ab2FBLh5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jun 2012 07:37:57 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57766 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182Ab2FBLh5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jun 2012 07:37:57 -0400
Received: by yenm10 with SMTP id m10so2336808yen.19
        for <git@vger.kernel.org>; Sat, 02 Jun 2012 04:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=NgorFy7g9hW+MS/0sj/VV1x2tHWAvtTS8jKnF7dZGlE=;
        b=glH4u4ZJ1FGdiZPimqBy2amXQdAZihQKAG1hvLFlzqzpPt1a+zy/3B+kC1jmfpw816
         nTuPtKU6b829rQzHVti2apSMfl3WuksRQ3zv+XoQ9ruZ/Q42pLVKZ8b0CwREDjj2LxhJ
         tT4zFEYN0GfEzMBKifjDRXZX3gcLs5LNrBbq6BzPX4jeZXWxTscZDK435UTLe+4VnrOL
         CqmuKczNLE+Wr5slXc3ZHfr3TL/fXMhu7oDIODa5j0cGNFLiFav5EiVJwfL1sdCGBtfQ
         PXxFUrgpOzJRPOwBjZMwub/SaTPwYA6L0S3vMys09VNixEYrlJXyvG9z6T5TrXqrduWw
         rhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=NgorFy7g9hW+MS/0sj/VV1x2tHWAvtTS8jKnF7dZGlE=;
        b=b9xjtMLqh5ImtFXyZtq7DUB/kjsxty+amM4j7a5vOINCBQByjXowj70OprrMxHJWBA
         kZbN+Sc65rfBQ8QNyYNhGZUqP1WzNAinYL7LgFktetnR2E+5+ApGPyR2qoBSe6I8qqEX
         IGS6QTRlVj1vSdwtb2WBbodO9B7VcLKXX32vOzs3RYgQ8ioNMDL/YITRCJiAJxIQHJK8
         6cjLTJP9NwH3Bcs6KmrMHrSPnIC0ZdwfKNX4zXOyEtrcRpOrj3gLfhw6vboz0/3TDLCn
         JuceO7q4+HtZFh0Smwmi+vIHySnzZx3WyDl68Pg3WMdJWgzg6LYYnDI1rjBcIaxfB0xy
         oKQg==
Received: by 10.101.111.17 with SMTP id o17mr1790805anm.69.1338637076427;
        Sat, 02 Jun 2012 04:37:56 -0700 (PDT)
Received: by 10.101.111.17 with SMTP id o17mr1790796anm.69.1338637076207; Sat,
 02 Jun 2012 04:37:56 -0700 (PDT)
Received: by 10.101.170.36 with HTTP; Sat, 2 Jun 2012 04:37:56 -0700 (PDT)
In-Reply-To: <CACsJy8DuDzxrcb8kbWhH9N=1APQeEOUZzUvSaKCJ7LJ9rc9tKg@mail.gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmoR50u4N6cHNJpzxBlIIlWrqpX/sgqVwcLya1qEDq8wEi0XX9ohNPlKE8/ysdorWHu5v1o9EoP92qMroXrKKnx3sakW2qLFQz/inkPfAMaBS74x7qAZi1IHaXWxwA2zht8UtD/20JBVI5o4L5UUYCAtsuH1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199043>

On Sat, Jun 2, 2012 at 8:26 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> On Sat, Jun 2, 2012 at 2:04 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Perhaps we could go one step further when we issue this error messag=
e?
>>
>> =A0$ git checkout -b jc/ls-files-i-dir maitn-1.7.8
>> =A0fatal: git checkout: updating paths is incompatible with switchin=
g branches.
>> =A0Did you intend to checkout 'maitn-1.7.8' which can not be resolve=
d as commit?
>
> Yes, please. Also to correct misspelled option names.
>
> In case there are more than one candidate, we should print extra info
> (for commands or options, it's one line description; for refs,
> probably commit subject line)

This and a functional implementation of "help.autocorrect =3D prompt."
I think we now have the bits and pieces to do it right.

--
David Barr
