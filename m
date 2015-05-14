From: Alex Coppens <alex@nativetouch.com>
Subject: Re: Problem with rerere forget
Date: Thu, 14 May 2015 14:40:25 -0400
Message-ID: <CAPt1q6d3euApCKLUBjssyfBmeVw0TVYOqDmTZL79gN1TvtxdsA@mail.gmail.com>
References: <CAPt1q6fMMz61aZEJB9b+K6+kHFwkm+bMYXoKBj78GNJU+dWioA@mail.gmail.com>
	<CAGZ79kZ8Cy1Pp9cf7vExntbfe-YW5KjYx6Fogr3O94wDfwuOXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 14 20:40:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysy3e-0007mx-3B
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 20:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933623AbbENSk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 14:40:27 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34974 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933511AbbENSk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 14:40:26 -0400
Received: by pdbqd1 with SMTP id qd1so95736098pdb.2
        for <git@vger.kernel.org>; Thu, 14 May 2015 11:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+czSYs3SCm0lkk5tMKdFsKLsweztwuHxoHxAaaONaAI=;
        b=aBJD6TZlWNpajN4YG6qBOJENl2dNBViWUdCrzbgO27cighkf5/OolHC2uiC85Wp4R1
         KxSqSqnLt4hvMnCczLrWhFgAff0JnudV7JV8vdijiM7okHMwtUb61tvQRgFKh31kqRG+
         ZRxqwkiQi5rXyc8LTGg77ge56gYkb9nHEfVX1zZqNkLAXCwSP/1+Lynumb1wJNtCmKZZ
         1X/uEgkOeAFmyLCgqj7ZcHRqfJ8D4VPnQEEyRm78voR5ag0U8yjyytrRU1vbymr3LW0W
         r3o2lOnpK9w9rCp3lg9hq/IS77gqfufPnsT1hfkI3PQm0RpExLGybp/pU49AP6hBeMls
         ROzQ==
X-Gm-Message-State: ALoCoQn7nrfp1DBjjfPWCWadEfbntG5GBS+eQIHkUg+u8cWwuycVTbxxrU72v1jAhNNAbII9rzbi
X-Received: by 10.70.136.169 with SMTP id qb9mr10694564pdb.46.1431628825146;
 Thu, 14 May 2015 11:40:25 -0700 (PDT)
Received: by 10.70.45.135 with HTTP; Thu, 14 May 2015 11:40:25 -0700 (PDT)
In-Reply-To: <CAGZ79kZ8Cy1Pp9cf7vExntbfe-YW5KjYx6Fogr3O94wDfwuOXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269064>

I use git version 2.2.1. I cannot provide an example repository that
reproduces the error.

What does git bisect do?

Alex

On Thu, May 14, 2015 at 2:21 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, May 14, 2015 at 11:05 AM, Alex Coppens <alex@nativetouch.com> wrote:
>> Hello there,
>>
>> So I am trying to make git forget a conflict resolution:
>
> Which version of git do you run?
>
>> _______________
>>
>>
>> git rerere forget path_to_file/file.js
>>
>> fatal: BUG: attempt to commit unlocked object
>>
>> _______________
>>
>> Google doesn't seem to know the answer: No results found for "fatal:
>> BUG: attempt to commit unlocked object".
>
> see: https://github.com/git/git/blob/master/lockfile.c#L316
> (The "fatal:" will be added by the call to die)
>
>>
>>
>> I think I am using rerere forget the wrong way. Can someone help?
>
> (I don't think you're doing it wrong.)
>
> The "BUG:" errors are a hint that the internal implementation of git is broken,
> which should be fixed, thanks for reporting! We'd need to find out where/how
> git broke and fix that. If it's a hard fix, we'd need to have a better
> error message
> at least.
>
> Can you provide an example repository which reproduces this failure?
> Or better yet, can you git bisect git itself to find out when the
> error was introduced?
>
> Thanks,
> Stefan
>
>>
>> Regards,
>>
>> Alex
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
