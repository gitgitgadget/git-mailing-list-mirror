From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] pathspec: remove check_path_for_gitlink
Date: Sat, 7 May 2016 14:16:41 +0700
Message-ID: <CACsJy8CkJ9UF3y6jgCS9KGArLqdEZRqehu_KABFPKo+P2W4M_g@mail.gmail.com>
References: <1462487497-28394-1-git-send-email-sbeller@google.com>
 <xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com> <CAGZ79kY65Fo4+_a1B8J0h7PymGWUSoAdb1eb5YVfG55=30oPEg@mail.gmail.com>
 <xmqqy47o6q71.fsf@gitster.mtv.corp.google.com> <CACsJy8BbWyw37sQkAq-B_De87N3XzZA9A1fm1A8A7MzfPBtdrw@mail.gmail.com>
 <CAGZ79kaBh-SogYrMcVfgE1DS464oK2Z01ZqpBiM0eSHKMPU1Fw@mail.gmail.com>
 <xmqqr3df2end.fsf@gitster.mtv.corp.google.com> <CAGZ79kaJYngaZfhx060C06J57aDqPJfdMD8xzK4dW4nvvktMLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, felix@debuggable.com,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat May 07 09:21:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aywY6-0003II-CV
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 09:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbcEGHRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 03:17:13 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35040 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbcEGHRN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 03:17:13 -0400
Received: by mail-lf0-f43.google.com with SMTP id j8so152898736lfd.2
        for <git@vger.kernel.org>; Sat, 07 May 2016 00:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nNAFuXNvCg/MTNe1MNzfAcQKsUJh84wXZVCFSsjlofc=;
        b=EOFqLbW6QOGDJ+xDALbbzuQb45uScgYyzbXKmzuXweeBwRUrJhuOj8NPyUfZGEAfN6
         egv+V2icbOcdpLJVnkg0XUqPtC/kmrMq4tfqC4bz8fg+NJ3ZVWp3ZR9bP0NpvQmYMXLx
         1Q5evrJoxru7P3xjnEH3AFV8lx7lQ9VAHzdhOd5TvdDFPbtstHvVWsyaLHDtlit3Fj/h
         JyH1j54PKCiZpLX9VSgflQHGLHzAdBTYik5K46dzSm70X7RKwB85deuB+SkJlYN5tO9c
         oDSOfgsGaBFyP1rB31hLAP6OBq2ya0bOAcWTteQgR/kgYetjvLqeQe4O0d6RZUvkSU++
         X9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nNAFuXNvCg/MTNe1MNzfAcQKsUJh84wXZVCFSsjlofc=;
        b=Aykz+rKhzcVdLpNDkcLqrQaNThuyJJpcDNhaTVXPTjCJqEd+bKpjgwh4YW9XpcHnP3
         sVTBSMArLEB+IS1f/D8NifO37wjTQvUiLrwhrSty8470FMEPHipvpMvPj2iPYKgZQq3G
         qIiMgoMy8RyjbBST6RWbt3lwU4O9UqoXVSWDABBzRCipCz4jSNhUZmUZjIFedryxpW/I
         wqACMYJubTKlHurw35x4uhRgLwmOxq+f6pWFeAvQrBM3388piCMQC4vBHdQOYh/s3haa
         C6mFzs+TVWOXXyV1+d9EKWH89p/1sIETWxrdHMRMk6vBk0M1a/VVkzyCYTYdX8GGm+Lf
         QmdA==
X-Gm-Message-State: AOPr4FWKqRZZ9TFNm85iPa6Uo9kwiFgDF/AjtPi9MXzl5IRLD5vOh5uy0w4C96VihxFGH97yKFI4TYgUWvm1pg==
X-Received: by 10.112.181.72 with SMTP id du8mr10959523lbc.137.1462605431073;
 Sat, 07 May 2016 00:17:11 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Sat, 7 May 2016 00:16:41 -0700 (PDT)
In-Reply-To: <CAGZ79kaJYngaZfhx060C06J57aDqPJfdMD8xzK4dW4nvvktMLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293888>

On Sat, May 7, 2016 at 2:18 AM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, May 6, 2016 at 12:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> On Fri, May 6, 2016 at 3:30 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>> On Fri, May 6, 2016 at 6:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> Stefan Beller <sbeller@google.com> writes:
>>>>>
>>>>>>> I wonder if the patches mentioned have something to do with the "git
>>>>>>> add deep/in/the/tree" that fails to notice deep/in/ is an unrelated
>>>>>>> repository in some way?
>>>>
>>>> The same functionality is added in 8745024 (parse_pathspec: support
>>>> stripping/checking submodule paths - 2013-07-14) so if it didn't fail
>>>> to notice that before 5a76aff1a6 and did after, it's a bug.
>>>
>>> The bug seems to have existed before. However in the bug we are talking
>>> about the nested repo is not a submodule yet.
>>
>> That agrees with Duy's recollection below:
>>
>>>> I vaguely recall this symptom. It has something to do with the index,
>>>> the check we do requires a gitlink in the index, I think. So if the
>>>> gitlink entry is not in the index, our protection line fails.
>>
>> So are we all on the same page that this is a bug now?
>
> It was a bug, but now people in the outside world consider it a feature.
> Search for "Git fake submodules" and you'll find a few users who use this
> technique successfully.
>
> I do not think fixing this bug would do good. So maybe we just let it slip?

I think it's because people do have some use cases for multiple
worktrees (typically from different repos) to share the same
filesystem portion. We never actually support that. There are a bunch
of questions on how these worktrees/repos should interact. Maybe
someone will finally add support for that. But this is still a bug,
even though nobody has time to fix it yet. So I agree with Junio
calling this "undefined behavior", not "feature".
-- 
Duy
