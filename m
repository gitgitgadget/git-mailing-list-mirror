From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 02/15] read-cache: Improve readability
Date: Fri, 20 Mar 2015 22:11:47 -0700
Message-ID: <CAGZ79kaLJgC6rWdRSeVVQSBYn0soJuzqnrK_bNtgAPWimPYE8w@mail.gmail.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-3-git-send-email-sbeller@google.com>
	<xmqqbnjnaso7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 06:11:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZBhS-0001Fv-5q
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 06:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbbCUFLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 01:11:49 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37213 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbbCUFLs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 01:11:48 -0400
Received: by igcqo1 with SMTP id qo1so4096161igc.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 22:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1VV6beQI9gjmkYKziwVr+Fh+HgQab9X8988yy+ZPCBs=;
        b=pM9iPOWUH4l4TSVq4Lqtnp8r3iABzlhrjsGfGnMjZWKLrJmQ7POoPtlcqRcdb8gHMj
         QIQz4t6h3JPsgNPLXE5xvad2IsPxM84jm1UMDiLF0PIYG06rCo7oEZje++sUXQYwFIFK
         tLRw2u+utVDM3hbVRCZIq1lPTwu3yJDLp7G7CL7is55yAPLsU+nRT5MGg0r43rt3+jB6
         Otetb1UXKAGYsK+JlbZ/j6+NQEK1KI9UPQr8hhV5wkRHmZ/CQ58hAr4CX0AHeMStKgXw
         8HiP2HiQhtC57xnQisXa1c/CpWOQ1nxqpjtqn4PwV0b+BF87+h1PfxF0TwYkPZkH6tv4
         mdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1VV6beQI9gjmkYKziwVr+Fh+HgQab9X8988yy+ZPCBs=;
        b=PEUDdT85CzyKZLCBKCfv8KtQqJnnMy9LqlaDuL0oiyo2TyGxD25yyPo48s3kGSIMSi
         FxxdugFrN46fOiS4XDNn7xFQB49GFtJj0h5jZioOfWaY3mtuKl/8WjfgTBZGQjH40SxF
         oB+1jSxchMDhzXnmT2GRNFiMMblY7GCdeZwRBm75xyyf0EdpJq0tdCxHDto1La7W79Ei
         6Lqgzpu/AfX5TYhJpK5hiCuHZF0RqAguFjTnIx8dadNeuz4mXh9FOaS95I4ue1QyJpx+
         i3Y7LqDEYvb/uC22wIQlovT8slTBFqhP5fMsFbCMJcLWGoNtmXy91ordCXR4gldBz6tQ
         bd6g==
X-Gm-Message-State: ALoCoQn4gDowODxV5dS/oSLWneN/1woDZ9YHXXxlGYnyHmMsYd3q6L4YqT9ffy1WZObbu/azPnq8
X-Received: by 10.50.56.82 with SMTP id y18mr1368762igp.25.1426914707566; Fri,
 20 Mar 2015 22:11:47 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Fri, 20 Mar 2015 22:11:47 -0700 (PDT)
In-Reply-To: <xmqqbnjnaso7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266009>

On Fri, Mar 20, 2015 at 9:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  read-cache.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index f72ea9f..769897e 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -703,9 +703,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>>                   !hashcmp(alias->sha1, ce->sha1) &&
>>                   ce->ce_mode == alias->ce_mode);
>>
>> -     if (pretend)
>> -             ;
>> -     else if (add_index_entry(istate, ce, add_option))
>> +     if (!pretend && add_index_entry(istate, ce, add_option))
>>               return error("unable to add %s to index",path);
>>       if (verbose && !was_same)
>>               printf("add '%s'\n", path);
>
> I have a moderately strong feeling against this change, as the code
> was done this way quite deliberately to keep it readable, namely, to
> avoid using && to concatenate two boolean expressions that are in
> totally different class inside condition part of if/while, where A
> is a precondition guard for B (i.e. you cannot evaluate B unless A
> holds) and B is called primarily for its side effect.  The problem
> is that, once you start liberally doing
>
>         if (A && B && C && D ...)
>
> with booleans with mixed semantics (guards and actions), it will
> quickly get harder to tell which one is which.
>
> I could have written it as
>
>         if (!pretend) {
>                 if (add_index_entry(...))
>                         return error(...);
>         }

This makes sense to point out the different semantics to me.
Maybe I have read too much of the refs code lately as there we
have these long chains which combine precondition with error
checking. :/ That's why I thought it would be global to git to not
care much about this semantics distinction.

>
> and that would have been just as readable as the original; it
> clearly separates the guard (i.e. only do the add-index thing when
> we are not pretending) and the operation that is done for the side
> effect.
>
> But I find the original tells you "if pretend mode, do *nothing*"
> and "otherwise, try add_index_entry() and act on its error" very
> clearly.  Of course, I am biased as the original is my code from
> 38ed1d89 ("git-add -n -u" should not add but just report,
> 2008-05-21).
>
> FYI, between preference and taste, I'd say this one is much closer
> to the latter than the former.
>
> By the way, aren't we leaking ce when we are merely pretending?

Yes we are, that's how I found this spot. (coverity pointed out ce was
leaking, so I was refactoring to actually make it easier to fix it, and then
heavily reordered the patch series afterwards. That spot was forgotten
apparently.

>
>
