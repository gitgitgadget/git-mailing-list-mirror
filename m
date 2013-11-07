From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 2/2] gitignore.txt: clarify recursive nature of excluded
 directories
Date: Thu, 07 Nov 2013 21:27:16 +0100
Message-ID: <527BF7A4.6070203@gmail.com>
References: <527BC00D.8000501@gmail.com> <527BC068.3040303@gmail.com> <xmqqa9hg59av.fsf@gitster.dls.corp.google.com> <xmqq61s457gd.fsf@gitster.dls.corp.google.com> <20131107195546.GA13456@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 21:27:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeWAg-00036C-PF
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 21:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755752Ab3KGU1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 15:27:15 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33588 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab3KGU1N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 15:27:13 -0500
Received: by mail-wi0-f175.google.com with SMTP id hm4so1234142wib.14
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 12:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=tgPY31iMKQ49zBsmcCNlSXZFxg/kXwxPv5MvQgjmfjg=;
        b=PGF1CxavXCk4eQHV1K5/yRUvPRy11jtytgUwkaeQ0X6xgDvqr8SVnJ0oTykgzRjSdx
         ZL/p6E6ZlTgbCZw/wfhbdDr9/qujY/VKkks8pT+sMlX3vhBRCggGbnA/GVcUBuhwzeBi
         iIKqMekw9G8NrnoOXkmW8aZHXA4NNn7oKAkyUZJYxylwFCmzgUUwhetiH3JrCl1ZoNFU
         /uGBiQDsaypgiSnoz8yQ81qzLgyTtPivE71glhGX0eQODK7ZivYPxiaUFONTFM7Lsp+U
         /If/GzGyQDZnUuCAWuCBF3Z37Xl9tKGKjBzCMeCoUZZhu5nFpWFboqSFZrSOIB/qXfo4
         KHLA==
X-Received: by 10.194.232.4 with SMTP id tk4mr13849wjc.79.1383856032044;
        Thu, 07 Nov 2013 12:27:12 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id bs15sm16483961wib.10.2013.11.07.12.27.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 12:27:11 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131107195546.GA13456@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237427>

Am 07.11.2013 20:55, schrieb Jeff King:
> On Thu, Nov 07, 2013 at 11:37:38AM -0800, Junio C Hamano wrote:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Karsten Blees <karsten.blees@gmail.com> writes:
>>>
>>>> Additionally, precedence of negated patterns is exactly as outlined in
>>>> the DESCRIPTION section, we don't need to repeat this.
>>>
>>> Very good, thanks.
>>>
>>> Even though I have a suspicion that somebody else may be able to
>>> come up with a better phrase that does not sound unnecessarily
>>> strongly than "recursively and irrevocably", that somebody else is
>>> not me, so I'll queue this as-is for now.
>>
>> Just in case somebody thinks about rephrasing, to me, these two
>> words sound heavier than the information they actually convey, and
>> that is why I said "unnecessarily strong".
> 
> I agree that it seems unnecessarily strong.  The word "irrevocable" to
> me implies that it cannot ever be changed. But of course it is only
> irrevocable for the particular run; you can always edit the .gitignore
> file. :)
> 
>> The key thing in the behaviour when a directory is excluded is that
>> it tells us to stop going into that directory, and there is no way
>> to override it with another .gitignore file somewhere inside,
>> because we are told not to even bother looking for it.  "Recursively
>> and irrevocably" may be an accurate description of the end result,
>> but that sounds more like a rule without a "because"; to a reader
>> (me), it lacks the "aha, of course" that comes from understanding
>> why.
> 
> I think it is more than just "we do not descend and so do not read the
> .gitignore file". I thought the previous discussion on this topic showed
> that you cannot do:
> 
>   $ cat .gitignore
>   foo
>   !foo/bar
> 
> to see foo/bar.
>

Yes, the pattern could be in .git/info/exclude and it still wouldn't work.
 
>>>>   - An optional prefix "`!`" which negates the pattern; any
>>>>     matching file excluded by a previous pattern will become
>>>> -   included again.  If a negated pattern matches, this will
>>>> -   override lower precedence patterns sources.
>>>> +   included again. It is not possible to re-include a file if a parent
>>>> +   directory of that file is excluded (i.e. excluding a directory
>>>> +   will recursively and irrevocably exclude the entire content).
>>>>     Put a backslash ("`\`") in front of the first "`!`" for patterns
>>>>     that begin with a literal "`!`", for example, "`\!important!.txt`".
> 
> How about:
> 
>   It is not possible to re-include a file if a parent directory of that
>   file is excluded. Once git considers a directory excluded, it does not
>   descend into the directory to consider its contents further.
> 

Hmm...an unsuspecting reader might still assume that it works in top-level .gitignore, given the precendence rules above...

How about this:

   It is not possible to re-include a file if a parent directory of that
   file is excluded. Git doesn't list excluded directories for performance
   reasons, so any patterns on contained files have no effect, no matter
   where they are defined.

>>>> +Example to exclude everything except a specific directory `foo/bar`
>>>> +(note the `/*` - without the slash, the wildcard would also exclude
>>>> +everything within `foo/bar`):
>>>> +
>>>> +--------------------------------------------------------------
>>>> +    $ cat .gitignore
>>>> +    # exclude everything except directory foo/bar
>>>> +    /*
>>>> +    !/foo
>>>> +    /foo/*
>>>> +    !/foo/bar
>>>> +--------------------------------------------------------------
> 
> That looks good to me. The simplest example would be handling a
> top-level directory (i.e., ignore all except `/foo`). That is a subset
> of what's happening above, and I think showing the general case is good.
> I'd worry slightly that a non-astute reader might not figure out how to
> simplify down to the top-level case, and we should have two examples. I
> may just be overly pessimistic, though.
> 
> -Peff
> 
