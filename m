From: David Cowden <dcow90@gmail.com>
Subject: Re: [PATCH v3] Clarify pre-push hook documentation
Date: Tue, 8 Apr 2014 01:43:49 -0700
Message-ID: <CAC1XvcMyo4VaJv4bzP+isMoUwoW28yz39=kvJz4EmKxF95Gk-w@mail.gmail.com>
References: <1395704609-81957-1-git-send-email-dcow90@gmail.com>
	<1395705088-82216-1-git-send-email-dcow90@gmail.com>
	<xmqqmwgemceq.fsf@gitster.dls.corp.google.com>
	<3CA35D0B7B7C411292360D1516EF409B@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Apr 08 10:43:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXRdO-0005Da-M9
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 10:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbaDHInx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 04:43:53 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:34226 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaDHInu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 04:43:50 -0400
Received: by mail-qa0-f49.google.com with SMTP id j7so553628qaq.36
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=X7Hf7EyAcloGhs4dYf98g9MIWOCrpoandk0sisyyXKU=;
        b=vJ0ZZNdJT95i+bfK4KmSfM5mBqAv9GmhCT2/uwAbSXSy/W+vl30ZqLixGmKnQR6B8g
         ohmqvhC25dkANbpoNXuK+B3pPNjueT0Sx1SbZRVeIv83mT1Goxxz4aOiN55cAgZkjNp9
         /4PYq+38w/e+e1ni+1OrYwQzDfAKoK59n4FAiRRDgx8OksaypBWGcF8rRax82m+jRqPP
         xglIV/DwTtE/eAWdxFYqkd9M6jFXO/bwSMwHSEURO66yxlcYNYTcPqi8iUdhSH3yAaG5
         1WFqeSgp3HAPe2rQ4kk4eJ/LR5f/LBjngyJ7eCERKpXVDLyyXdP0eh1dFFdt8B+UriAd
         JlJA==
X-Received: by 10.224.45.67 with SMTP id d3mr2623424qaf.33.1396946629122; Tue,
 08 Apr 2014 01:43:49 -0700 (PDT)
Received: by 10.140.91.14 with HTTP; Tue, 8 Apr 2014 01:43:49 -0700 (PDT)
In-Reply-To: <3CA35D0B7B7C411292360D1516EF409B@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245919>

Hey guys, I was on vacation for a little over a week, I'll be back on
this this coming week (haven't forgotten).

David

On Wed, Mar 26, 2014 at 4:21 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Junio C Hamano" <gitster@pobox.com>
>>
>> David Cowden <dcow90@gmail.com> writes:
>>
>>
>>> The documentation as-is does not mention that the pre-push hook is
>>> executed even when there is nothing to push.  This can lead a new
>>> reader to believe there will always be lines fed to the script's
>>> standard input and cause minor confusion as to what is happening
>>> when there are no lines provided to the pre-push script.
>>>
>>> Signed-off-by: David Cowden <dcow90@gmail.com>
>>> ---
>>>
>>> Notes:
>>>     I'm not sure if I've covered every case here.  If there are more
>>> cases to
>>>     consider, please let me know and I can update to include them.
>>
>>
>> I do not think of any offhand, but a more important point that I was
>> trying to get at was that we should not give an incorrect impression
>> to the readers that the scenario that is described is the only case
>> they need to be worried about by pretending to be exhaustive.
>>
>> The "may" in your wording "This may happen when" may be good enough
>> to hint that these may not be the only cases.
>>
>>>     c.f.
>>>
>>> http://stackoverflow.com/questions/22585091/git-hooks-pre-push-script-does-not-receive-input-via-stdin
>>>
>>>  Documentation/githooks.txt | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
>>> index d954bf6..1fd6da9 100644
>>> --- a/Documentation/githooks.txt
>>> +++ b/Documentation/githooks.txt
>>> @@ -203,6 +203,15 @@ SHA-1>` will be 40 `0`.  If the local commit was
>>> specified by something other
>>>  than a name which could be expanded (such as `HEAD~`, or a SHA-1) it
>>> will be
>>>  supplied as it was originally given.
>>>
>>> +The hook is executed regardless of whether changes will actually be
>>> pushed or
>>> +not.  This may happen when 'git push' is called and:
>>> +
>>> + - the remote ref is already up to date, or
>>> + - pushing to the remote ref cannot be handled by a simple
>>> fast-forward
>>> +
>>> +In other words, the script is called for every push.  In the event
>>> that nothing
>>> +is to be pushed, no data will be provided on the script's standard
>>> input.
>
>
> Doesn't an 'in other words' indicate it could be further tightened?
> Maybe
>    "If there is nothing to push, the hook will still run, but the input
>    line will be empty.
>
>    Likewise the hook will still run for other cases such as:
>
>    - the remote ref is already up to date,
>    - pushing to the remote ref cannot be handled by a simple
>      fast-forward,
>    - etc."
>
>
>>
>> When two things are to be pushed, the script will see the two
>> things.  When one thing is to be pushed, the script will see the one
>> thing.  When no thing is to be pushed, the script will see no thing
>> on its standard input.
>>
>> But isn't that obvious?  I still wonder if we really need to single
>> out that "nothing" case.  The more important thing is that it is
>> invoked even in the "0-thing pushed" case, and "the list of things
>> pushed that is given to the hook happens to be empty" is an obvious
>> natural fallout.
>
>
> Personally I think it should be mentioned in that paragraph, which is
> covering all the various special cases. The 'nothing' case often causes
> confusion when it's not specified in documentation.
>>
>>
>>>  If this hook exits with a non-zero status, 'git push' will abort
>>> without
>>>  pushing anything.  Information about why the push is rejected may be
>>> sent
>>>  to the user by writing to standard error.
>>
>> --
>
>
> It may be that the documentation should include the caveat
>
>    "Hooks, when enabled, are executed unconditionally by their calling
>    functions.
>     Script writers should ensure they handle all conditions."
>
> somewhere near the top of the page to cover all hooks, which IIRC
> started David's journey. That would allow my second paragraph
> "Likewise.." to be dropped.
>
> Philip
> --
> [apologies for any whitespace damage]
>
