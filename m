From: Nathan Collins <nathan.collins@gmail.com>
Subject: Re: [BUG?] Patches created with 'diff.noprefix=true' don't 'git apply'.
Date: Wed, 7 May 2014 21:38:51 -0700
Message-ID: <CAO8RVvcyi6KvrZqueBA+PKCTocL=s7NJGann4CzU0WAf6DxWcA@mail.gmail.com>
References: <CAO8RVvdgN3U5hUEsJjYY9urfeVUDWwHiEur4NQp=H93W37RRnw@mail.gmail.com>
 <20140501024042.GX9218@google.com> <CAO8RVveV4SgXmJzWpYnyB3rnQALQkrrLNtLL5Ej5Y9Mjjekmmw@mail.gmail.com>
 <xmqqa9aug4my.fsf@gitster.dls.corp.google.com> <CAO8RVvfHVBG6QZ5M1DJK4kOX8GMDrvEw4_L=LsEc4G6E0pP7ug@mail.gmail.com>
 <xmqqbnvaehm3.fsf@gitster.dls.corp.google.com> <CAO8RVveF6Oh0mqqyiVRHmnqQ+vXX7riDW_=zn0g=t88cQjCVrg@mail.gmail.com>
 <xmqqzjita0sn.fsf@gitster.dls.corp.google.com> <CAO8RVvfzP_nc9=nwr6JSK9s6u7DEctMpdn_5yca9h7G4TOd2Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 08 06:39:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiG7N-0004KE-3x
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 06:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbaEHEjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 00:39:33 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:40662 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbaEHEjc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 00:39:32 -0400
Received: by mail-qc0-f174.google.com with SMTP id x13so2228220qcv.19
        for <git@vger.kernel.org>; Wed, 07 May 2014 21:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=S5aT+IUSJ9s4EN9W3qMYL7I6P3Gzl+csvpICubb6wGM=;
        b=mBGUrknEuZ3lffs2HqY2lvRv1jkVbQ8TjMl4O/31OmVF2zvHVsxpRqjikaR9tyUUve
         POoVkXI0huZCKjS0EwAjGTgLoo3NtFcfYyFJ0nNbbc23z8fPFZCwxhc3je8DL/C/Ouf7
         lT5diL3rVY8hDzStYOIACZKT/sJ7vkvhhLtk3zOwxefOrFtTNNR39XVINBoLROjGjMLg
         xSHJnOxlnsv/9Z7gMbYh1OKVD1MIpTPJBA7GugXp7p3Xxwi0b1m6M9gwc2O8AZ5XCC5N
         sH5lYlSh/IvlCo8zbt5MGyjsidP66rAFJZhFV885OtFdAwBl94Mfq3jG5QcmarD/6lju
         f/qA==
X-Received: by 10.224.12.138 with SMTP id x10mr1514311qax.80.1399523971698;
 Wed, 07 May 2014 21:39:31 -0700 (PDT)
Received: by 10.229.150.208 with HTTP; Wed, 7 May 2014 21:38:51 -0700 (PDT)
In-Reply-To: <CAO8RVvfzP_nc9=nwr6JSK9s6u7DEctMpdn_5yca9h7G4TOd2Bw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248403>

On Wed, May 7, 2014 at 4:39 PM, Nathan Collins <nathan.collins@gmail.com> wrote:
> On Wed, May 7, 2014 at 11:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nathan Collins <nathan.collins@gmail.com> writes:
>
>>> For (2), the solution may be to add a separate
>>> 'diff.add-clickable-paths' option (probably there is a better name?
>>> 'diff.add-copyable-paths'? ...),...
>>> ...
>>> Concretely, if 'diff.add-clickable-paths' is set, then instead of e.g.
>>>
>>>   diff --git a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>>> b/src/Data/Function/Decorator/Memoizer
>>>   index 3ef17da..a0586d3 100644
>>>   --- a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>>>   +++ b/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>>
>> If you do something along that line, perhaps
>>
>>         Index: src/Data/Function/Decorator/Memoizer/Unsafe.hs
>>         diff --git a/src/Data/Function/Decorator/Memoizer/Unsafe.hs ...
>>         index 3ef17da..a0586d3 100644
>>         --- a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>>         +++ b/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>>
>> to imitate what "cvs diff" does may be more familar to people.
>>
>> What would you propose to make clickable in a renaming diff, though?
>
> Your 'Index' header looks good, and I would expect a renaming diff to
> have something like
>
>   Index: foo -> bar
>
> as in 'git status', but I just realized that a "clickable paths"
> option already exists in some sense! There is a '--patch-with-raw'
> option (which is "short" for '--patch' and '--raw', hahaha) which
> inserts clickable file names in the patch, above each diff.

Or not: I stupidly only tested this with a single file modified: it
turns out that all the clickable file names appear at the top of the
patch, not as one file name above each corresponding diff as I
claimed.

D'oh,

-nathan
