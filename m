From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] worktree: add: introduce --checkout option
Date: Fri, 25 Mar 2016 19:15:54 +0700
Message-ID: <CACsJy8BhFjS=t1cjJ2D5UzNk6avd8LknL1xg5admeu--YWjyew@mail.gmail.com>
References: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
 <01020153a73bbb70-11a8482f-1a90-49e4-a56c-b311e12a85a2-000000@eu-west-1.amazonses.com>
 <CACsJy8DxcqYKrRi7_ERS3xLWfbbq3bNx-u2NWiXYoNw4yD+0dg@mail.gmail.com>
 <CABEEbiBM-CTJdmOukLjfrmnmsSTwNzx+ELfO=BtgApT__QZu-g@mail.gmail.com>
 <CAPig+cTtRgMz_6oEXmBN2MHG65arq51JsoBL9QeWBFNLgFnCmw@mail.gmail.com>
 <CAPig+cS2qMZyUkf9Nekp+QaVkjc1oHXb4QF3wFDnBdF3WMU3iQ@mail.gmail.com>
 <CACsJy8Bs0WFJxGnVOBUnzipZYty-K4D9NkAQdODYqPUw2VAAiw@mail.gmail.com>
 <CABEEbiDRPsL6XJrnyFv43u26hXNbBVmMhbJeZmp+zjS+-jNZ=w@mail.gmail.com>
 <CACsJy8AyMUn_AAF-DNGvjS8D+qdFLNuVBYvAjide6wA-ZnHJ5w@mail.gmail.com> <CABEEbiAeMZ=PSScFJ98DkqyDBGTC1OBvTb8bLAn=whLjXJvdzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Zhang Lei <zhanglei002@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 13:16:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajQfJ-0008Uk-HK
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 13:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbcCYMQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 08:16:27 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33530 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbcCYMQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 08:16:26 -0400
Received: by mail-lf0-f48.google.com with SMTP id o73so54158538lfe.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 05:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EYlcMtMEopJtCwGuYIaFR93edkAfUkXuP8LusZKEoKc=;
        b=asfdujJ5Oy6+V2UtuLeo5jM5zvMUuv3EAmcVvvX8brWGypc5RO9kLGZH/54zHexw5a
         HA0QHymTmgNc3uoc8Kmh67eu0JIyhn6cpr7fYNV5ZcXl4LyDZyD6kK5LucKtMYhwqPk0
         hUknNQcfng8RH2UMa/lnNZuA5TeUhmLiFZEQQpi/HMdf6idGk5X68BWUVHeiyc8b5TdI
         9cT/K28gls7fHl78knaQC4075W/rBrubFL9ZUE3erS27grMxoW4dXh/kWuPCtVg2EjLE
         8eobAa7wGH6U44MATX8z5Snob3e5nQ0lFn68sNSJe6Dw4nLLESPoewCNzVMmvm/ri+V2
         yJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EYlcMtMEopJtCwGuYIaFR93edkAfUkXuP8LusZKEoKc=;
        b=E9Pk1gwsSq3YNVemX50ned/MHoAGti/qpU2sWrwqsGprra+sRFcIbyZ2hkep/pZF1j
         eE5GaekSPezLqx8//Z4MprWYzOG5hiDRn29oOblWmvRh7NXsO9bIv+cwV+VGsGh4nbeg
         7mV9HJy0OMedrY+UYO9P+MtXXm7LasL6TTf3yPMjqYoXyb9n03ZarX2HWCZ7fMYhbH1f
         4RNIPnQm7BsckvL9k1Bzz9ZMzJ2ps/0QTA95FFdFhEJPBIW/8b5UxmoYu5cZ0EjdtwYn
         Gi5HCeCNIXcYo7jpTv9n2VOpZthmWAf0GBl9bslITpVTjt3K03UFwsThNyuQsZEHt81r
         odAw==
X-Gm-Message-State: AD7BkJIFvuZc5O32lahySO+M9YWAiS9ANOHKwjPdJat28GfO0l390wRML6oRdB0SnYWvBdnjKVGmjtUFpdaY5g==
X-Received: by 10.25.159.68 with SMTP id i65mr5514869lfe.94.1458908184483;
 Fri, 25 Mar 2016 05:16:24 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 25 Mar 2016 05:15:54 -0700 (PDT)
In-Reply-To: <CABEEbiAeMZ=PSScFJ98DkqyDBGTC1OBvTb8bLAn=whLjXJvdzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289884>

Please don't top-post.

On Fri, Mar 25, 2016 at 7:06 PM, Zhang Lei <zhanglei002@gmail.com> wrote:
> Yes, path basename makes sense.
> I am asking this question because we have some legacy code requires
> that working tree
> called something like 'src', as a result, multiple branch would have
> src1 src2 src3 under .git/worktrees
> which could not be easy to maintain.

If you really need to care about these names, I think a new option to
let you control the naming explicitly would be better.

> I agreed with you, we should give users such option.
>
>
> 2016-03-25 19:41 GMT+08:00 Duy Nguyen <pclouds@gmail.com>:
>> On Fri, Mar 25, 2016 at 6:31 PM, Zhang Lei <zhanglei002@gmail.com> wrote:
>>> By the way, Duy, another unrelated question: why worktree name under
>>> .git/worktrees is being named
>>> after the working tree path basename? I think branch name is more
>>> reasonable since we don't allow checking out
>>> the same branch twice.
>>
>> Because branch name is not always available (e.g. detached HEAD) and
>> checkout branch can be switched later on. And normally you'll get
>> branch name there anyway with "git worktree add something" because the
>> branch "something" is automatically created. I've been wondering if
>> it's worth supporting "git worktree -b abc ./" where we create
>> worktree "./abc" based on branch name too.
>> --
>> Duy



-- 
Duy
