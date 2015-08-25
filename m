From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Git's inconsistent command line options
Date: Tue, 25 Aug 2015 15:21:33 -0700
Message-ID: <CA+P7+xrawC42hm54_8cNYpv51H+LgUF-F4kKQ9W3pcAe+Q2q=Q@mail.gmail.com>
References: <mrh7ck$r0g$1@ger.gmane.org> <CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
 <CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com> <CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Graeme Geldenhuys <graemeg@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 00:22:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUMbO-0007Ow-99
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 00:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbbHYWVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 18:21:54 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35408 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbbHYWVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 18:21:53 -0400
Received: by igbjg10 with SMTP id jg10so25410909igb.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 15:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=n4wrKlPm0UaSdriglr8jQbP4bvkHbbsbV3ifg4BuPFk=;
        b=obK7ZvL3JowJxwSXBs/zOu3nz7uKTdbbWXSzRIS1MjkaSDIpqhh474RVax3mgJtp9t
         moyoKXdq5Csv0oIvYqsaMIjqwY+wN2/su0NWI/wGt0bWOjGfdCuCpFjHuF9oJL1dNpfG
         X9aJ6lZB+eZANPPvIoodi8wXaKh2oF15RpCMPpv8UQ8DOyNQBxHgIwG50NaQ382Fi6iv
         ntcpQ/MYUeK1M9xfdzgim1u7eXdlh/tEZLtCYYMeuAAzZ7cjYKDk3+TUA5ZrQVkAsDYB
         TRc97PxMp+2jSTA/6dA/H6JfuZAK/gUJA/L5l0yITI6xxXhqeKDCDaoSAMlFR45dSDAW
         s4xg==
X-Received: by 10.50.93.33 with SMTP id cr1mr6776476igb.35.1440541313035; Tue,
 25 Aug 2015 15:21:53 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 25 Aug 2015 15:21:33 -0700 (PDT)
In-Reply-To: <CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276579>

On Tue, Aug 25, 2015 at 3:06 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Aug 25, 2015 at 2:49 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Tue, Aug 25, 2015 at 8:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> On Tue, Aug 25, 2015 at 1:01 AM, Graeme Geldenhuys <graemeg@gmail.com> wrote:
>>>>
>>>> Even though I have worked with Git since 2009, I still have to
>>>> reference the help to remind me of what parameter to use in certain
>>>> situation simply because similar tasks differ so much.
>>>>
>>>> Maybe we could address this in the next major version of Git? Has
>>>> anybody else thought about this or started work on this? Or was this
>>>> discussed before and declined (link?).
>>>
>>> http://article.gmane.org/gmane.comp.version-control.git/231478 comes to mind,
>>> which has been linked from this entry:
>>>
>>> Discuss and decide if we want to choose between the "mode word" UI
>>> (e.g. "git submodule add") and the "mode option" UI (e.g. "git tag --delete")
>>> and standardise on one; if it turns out to be a good idea, devise the migration
>>> plan to break the backward-compatibility.
>>>
>>> in http://git-blame.blogspot.com/p/leftover-bits.html
>>
>> I would vote for command words, as this is clean and simple.
>
> me too after rereading the arguments in that thread.
>
>> The
>> downside is in converting all the old options based commands, git-tag,
>> and similar. These commands cannot easily convert because "valid"
>> sequences would become invalid with no easy way to deprecate for
>> example in the linked gmane above, "git tag delete master" can't be a
>> call to delete master as it is currently a call to create a tag
>> "delete" at the commit marked by master.
>
> git-tag being a porcelain command (i.e. we do not give a promise to keep
> it set to stone) can be changed with a deprecation announcement period.
> Say starting with Git 2.6 we would put out warnings for upcoming commands:
>
>  $ git tag --delete master
>  $ echo $?
>  # 0 # actually works as of today!
>
>  $ git tag delete master
>  #  Due to the planned switch to command words, this doesn't work.
>  #  For details see road map at  `man git commandwords-roadmaps`
>  $ echo $?
>  # 128 maybe ?
>
> $ git tag create delete
>
> And after a while (maybe 3-5 years, once this version is picked up by
> debian stable as well as red hat stable)
> we can change it, so with Git 3.4(?)
>
>  $ git tag --delete master
>  # --delete is deprecated since 3.4, use `git tag delete` instead
>  $ echo $?
>  # 128
>
>  $ git tag delete master
>  # --delete is deprecated since 2.6, use `git tag delete` instead
>  $ echo $?
>  # 0 # actually works!
>


This seems like a possible strategy for converging on command words.
So basically, we force all uses of the command words to just fail and
then once that's picked up we can migrate to the command words.

Regards,
Jake
