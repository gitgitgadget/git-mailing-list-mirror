From: Nathan Collins <nathan.collins@gmail.com>
Subject: Re: [BUG?] Patches created with 'diff.noprefix=true' don't 'git apply'.
Date: Wed, 7 May 2014 21:53:57 -0700
Message-ID: <CAO8RVvdfEPrtNNr1bFAA-aUigz67swS-rzUhTkZE76DJO3TBaA@mail.gmail.com>
References: <CAO8RVvdgN3U5hUEsJjYY9urfeVUDWwHiEur4NQp=H93W37RRnw@mail.gmail.com>
 <20140501024042.GX9218@google.com> <CAO8RVveV4SgXmJzWpYnyB3rnQALQkrrLNtLL5Ej5Y9Mjjekmmw@mail.gmail.com>
 <xmqqa9aug4my.fsf@gitster.dls.corp.google.com> <CAO8RVvfHVBG6QZ5M1DJK4kOX8GMDrvEw4_L=LsEc4G6E0pP7ug@mail.gmail.com>
 <xmqqbnvaehm3.fsf@gitster.dls.corp.google.com> <CAO8RVveF6Oh0mqqyiVRHmnqQ+vXX7riDW_=zn0g=t88cQjCVrg@mail.gmail.com>
 <xmqqzjita0sn.fsf@gitster.dls.corp.google.com> <CAO8RVvfzP_nc9=nwr6JSK9s6u7DEctMpdn_5yca9h7G4TOd2Bw@mail.gmail.com>
 <CAO8RVvcyi6KvrZqueBA+PKCTocL=s7NJGann4CzU0WAf6DxWcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 08 06:54:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiGM0-00069v-M5
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 06:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbaEHEyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 00:54:40 -0400
Received: from mail-qa0-f54.google.com ([209.85.216.54]:59788 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbaEHEyj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 00:54:39 -0400
Received: by mail-qa0-f54.google.com with SMTP id j15so2032501qaq.27
        for <git@vger.kernel.org>; Wed, 07 May 2014 21:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IHNzwiegDeBVkF9WC2fX37ZYevwTczx5F6kZvM5phqo=;
        b=WdFvHGs4idz2RD2AnULFJU6vxGrok21ooayrkeG5aFwZnDLaqNAA6Ar8NPWczbnuwS
         VyWrxTuuLNXe+m7AyDwjB7P9PNf/W/9h3HbETaoYlM57YPYMlBwESi/n49+p0Ptrj6F1
         gNb+iLznHX348u8+aT8kLAKUo0QE6Y2i9Te9hZbVUfzyg693iJUgXE/XOGHzZKxB7OVa
         AbfSrrqy8+Yv0J/DJTEUj9t/1+y73zVWBhzQybITZAGdxZ+grBGuY6qsVS2ryH6OKJ93
         5bZVAjrW/p01Dw51q9L2Tc5xA5LBNkKip3BXp/bDVDSnPpmNBI+lkTghr+CbBOTkKc4Q
         +c6w==
X-Received: by 10.140.82.180 with SMTP id h49mr1515612qgd.84.1399524879068;
 Wed, 07 May 2014 21:54:39 -0700 (PDT)
Received: by 10.229.150.208 with HTTP; Wed, 7 May 2014 21:53:57 -0700 (PDT)
In-Reply-To: <CAO8RVvcyi6KvrZqueBA+PKCTocL=s7NJGann4CzU0WAf6DxWcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248404>

On Wed, May 7, 2014 at 9:38 PM, Nathan Collins <nathan.collins@gmail.com> wrote:
> On Wed, May 7, 2014 at 4:39 PM, Nathan Collins <nathan.collins@gmail.com> wrote:
>> On Wed, May 7, 2014 at 11:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Nathan Collins <nathan.collins@gmail.com> writes:
>>
>>>> For (2), the solution may be to add a separate
>>>> 'diff.add-clickable-paths' option (probably there is a better name?
>>>> 'diff.add-copyable-paths'? ...),...
>>>> ...
>>>> Concretely, if 'diff.add-clickable-paths' is set, then instead of e.g.
>>>>
>>>>   diff --git a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>>>> b/src/Data/Function/Decorator/Memoizer
>>>>   index 3ef17da..a0586d3 100644
>>>>   --- a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>>>>   +++ b/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>>>
>>> If you do something along that line, perhaps
>>>
>>>         Index: src/Data/Function/Decorator/Memoizer/Unsafe.hs
>>>         diff --git a/src/Data/Function/Decorator/Memoizer/Unsafe.hs ...
>>>         index 3ef17da..a0586d3 100644
>>>         --- a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>>>         +++ b/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>>>
>>> to imitate what "cvs diff" does may be more familar to people.
>>>
>>> What would you propose to make clickable in a renaming diff, though?
>>
>> Your 'Index' header looks good, and I would expect a renaming diff to
>> have something like
>>
>>   Index: foo -> bar
>>
>> as in 'git status', but I just realized that a "clickable paths"
>> option already exists in some sense! There is a '--patch-with-raw'
>> option (which is "short" for '--patch' and '--raw', hahaha) which
>> inserts clickable file names in the patch, above each diff.
>
> Or not: I stupidly only tested this with a single file modified: it
> turns out that all the clickable file names appear at the top of the
> patch, not as one file name above each corresponding diff as I
> claimed.

The following may be a non-option, since presumably many tools depend
on the current Git patch format.

The paths in the "extended header lines" in Git patches are clickable
by default, and respect the '--relative' option. So, adding a path to
the extended header lines that don't already have one would solve the
"clickable paths" problem.

E.g.

  index <hash>..<hash> <mode>

becomes

  index <hash>..<hash> <mode> <path>

The 'man git-diff' description of extended header lines in the
"Generating Patches with -p" section:

  2. It is followed by one or more extended header lines:

         old mode <mode>
         new mode <mode>
         deleted file mode <mode>
         new file mode <mode>
         copy from <path>
         copy to <path>
         rename from <path>
         rename to <path>
         similarity index <number>
         dissimilarity index <number>
         index <hash>..<hash> <mode>

     File modes are printed as 6-digit octal numbers including the
file type and file
     permission bits.

     Path names in extended headers do not include the a/ and b/ prefixes.

Cheers,

-nathan
