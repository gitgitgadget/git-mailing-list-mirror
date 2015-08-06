From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] builtin/mv: remove get_pathspec()
Date: Thu, 6 Aug 2015 13:59:48 -0700
Message-ID: <CAGZ79ka=Zw3DmvQHwQXCAd1rekR4AJSG8CDDu9thUmvDppVUZA@mail.gmail.com>
References: <CAPig+cT_YB=HY9dBo5eRNu4qvCqCXRwwXgpxCA8YjxagP+sHfA@mail.gmail.com>
	<1438885632-26470-1-git-send-email-sbeller@google.com>
	<1438885632-26470-2-git-send-email-sbeller@google.com>
	<CAPig+cRREzwRJV-az-p-r1E7JyDqDZ4GPvM1cQQzXXNyLjGPUQ@mail.gmail.com>
	<CAGZ79kZ7oS+AQgq91WRaFTCKGUnZj-cZB1YPkjQo9KAueqEN3w@mail.gmail.com>
	<CAPig+cTn=KLryVJEz7_u7nt2AzB1zzc5y40euk=oP3ZWaaYF3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 23:01:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNSIT-0001Ou-PI
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 23:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161207AbbHFVBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 17:01:43 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34899 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964777AbbHFU7t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 16:59:49 -0400
Received: by ykcq64 with SMTP id q64so68312016ykc.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TpvmZgYCdwN1BkVZnYtNn7h88qc260ISmrKMqlbrsRQ=;
        b=gfQQPGhsVUW/S7d3MxOm0LfN39SZbnMepojdQIQ/tTmvSWVc7qvvwgKh5TvgxprDjm
         D2jaKXIFmVj7QZ3tP15cmXeR2iBvPCDU8/d5McRDZAbZ1827n40t3dokgasnHD4yaMCg
         eaOfYnuMjcTG3CNrm6d/ccOEF4i7Q6RHay/Ah6ynsFPL/3dEhLTUZTyw+rraXPcaz9YM
         Xztup/iWj/WOxHww+1G2u4PskSJx7XsZZB9zi1VacslvxSqE+JbJKWxpoe8tx6pEX7Sx
         GqhIxEZROSQO+vtDfTV8yxrmeiym7Xx5qt+SAo4VVljr1OpoPw+fW2TnAcc4or+KRELU
         k9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TpvmZgYCdwN1BkVZnYtNn7h88qc260ISmrKMqlbrsRQ=;
        b=GTkrqmhFRIE/SVXd7hcjSmRJqNrsyFP4WxcoiqzbL2Py1Q3olJcQ68R0H7HkuEgAmw
         s05yistlOekTb/7SEYYH9rgBGXPtUTU+Sn+BETiACCUpnVi+6a98ZRWgKPH415Hk+x6G
         XhnxMuxYqN/PQ+cmNlpiCkNsltAdWX1aZn/qHqx/2qNMS83k6JlA4UWYjysoyJi+f6/d
         80REMrbl/jFG4DsCS2HOQ7IEWaJizGSeW1VDe2nTGdqILIwq6sRKwLlAKQ2jgkogbSMF
         fYY4reQj5489NXNkBADNFky1Ra07keo6VoEXrbdKWRQn2j9fkrTLfYzVCp6yA1Vn9V0E
         W8iQ==
X-Gm-Message-State: ALoCoQmjoISa1swViHeqNbq+xRxpFi3XQ4MwPxXE/9zK/twr15MWwFhiN14QU53to5EXgoA0kHRk
X-Received: by 10.170.85.2 with SMTP id c2mr4252749yka.56.1438894788733; Thu,
 06 Aug 2015 13:59:48 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Thu, 6 Aug 2015 13:59:48 -0700 (PDT)
In-Reply-To: <CAPig+cTn=KLryVJEz7_u7nt2AzB1zzc5y40euk=oP3ZWaaYF3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275445>

On Thu, Aug 6, 2015 at 1:18 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Aug 6, 2015 at 2:58 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Thu, Aug 6, 2015 at 11:46 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Thu, Aug 6, 2015 at 2:27 PM, Stefan Beller <sbeller@google.com> wrote:
>>>> `get_pathspec` is deprecated and builtin/mv.c is its last caller, so
>>>> reimplement `get_pathspec` literally in builtin/mv.c
>>>
>>> Curious. Since this is just moving code around, rather than doing the
>>> actual work to complete the final step as stated by the NEEDSWORK
>>> comment, isn't it just moving the "problem" from one location to
>>> another? Is it worth the code churn?
>>
>> Yeah it is moving around the problem a bit. And the code churn is
>> unfortunate. Though when I was reading the documentation on
>> pathspecs, literally the first sentence was "Do not use get_pathspec,
>> it is out dated". And that was a sad taste for reading documentation.
>
> By loudly warning you about deprecation and, more importantly,
> pointing you at the accepted alternative, this documentation saves you
> from wasting time (both time spent reading and time spent going down a
> dead-end path). It would be a "sad taste" if it warned you quietly
> only at the end of the documentation or not at all.
>
>> It's ok to have such warnings in the docs, but as the first sentence as if
>> there was nothing more important than avoiding the out dated stuff?
>
> From a documentation standpoint, there is nothing more important than
> warning you to avoid it since it is outdated and likely to go away in
> the future.
>
>> I mean I want to understand the actual code and how I can use it, right?
>
> No. It's deprecated and not meant for your use.

I need to be more precise:
I mean I want to learn how to deal with <pathspec> things in code.
Assume I know nothing of the history of that code and its deprecated
earlier attempts. So I would expect a documentation like:

    foo-bar(int arg): bars the foos with the specific thing equal `arg`

    foobaz(int a, int b, int c): Note: this is outdated, bars the foos with ...

in that order, so if I were to start reading from top to bottom, I would find
the current version first and could jump off starting writing code based on
foo-bar.

If I was reading code and wonder: "What does foobaz exactly do? Oh
I know! I'll consult the documentation", then I would find the note about
it being out dated and preferably its suggested new replacement.

However I perceived the documentation I read more like this:

    some words on foo-bar, a bit too shallow (a good overview,
    but I'd like to know more details, so keep reading)

    note on foobaz being outdated

    more words on foo-bar

>
> It's a different matter if you want to understand what the function
> does because you've encountered a call in existing code, but that case
> is covered by the existing documentation still being intact (that is,
> it wasn't removed when the deprecation notice was added).
>
>> And there are different approaches to solving the problem.
>> I could have just reworded or even just rearranged the documentation.
>
> The documentation seems fine as-is.
>
>> The approach I take here includes a bit of code churn, but it moves the
>> problematic pieces all in one spot.
>
> Indeed, I had the "localizing the problem to one spot" argument in
> mind, and even wrote it as an answer to my own question, but deleted
> it before hitting "Send". The counterargument (aside from code churn)
> is, that by leaving it alone, it serves as a good reminder of the
> "problem" and is more likely to get noticed and (perhaps) fixed by
> someone than if it is hidden away in builtin/mv.c.

Having code just in one ugly spot however helps people in the other areas,
where they can see the shiny new thing in action and don't have the mental
burden of seeing a NEEDSWORK comment and thinking about that instead
of the feature they want to add there.
