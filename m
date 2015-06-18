From: Florian Aspart <florian.aspart@gmail.com>
Subject: Re: Using clean/smudge filters with difftool
Date: Thu, 18 Jun 2015 17:39:18 +0200
Message-ID: <CAGA3+++LqZ8Qv6tpuoqQwi37kO5LLODwcbFQtvneorjiV4KARw@mail.gmail.com>
References: <CAGA3++LiX9NyK94RPiuiG83X8FSRN4EkaxMchir51hGSQY90Tw@mail.gmail.com>
 <5582BA1F.1030409@drmicha.warpmail.net> <CAGA3++LrVSs3rMkg=S2Og48pz1yEBxwpcRsPt7sNLENRh1ooAg@mail.gmail.com>
 <20150618132622.GJ18226@serenity.lan> <CAGA3+++_mx=O=Un0pip8Q41X5PZBLmES=Hd=U=aSowryx5r=8w@mail.gmail.com>
 <20150618141116.GK18226@serenity.lan> <CAGA3+++ibw=8Q1LtM6yJrZ7Q4eVs_MEHmPAzctSVSREXMmBiMQ@mail.gmail.com>
 <20150618142852.GL18226@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jun 18 17:39:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5buq-00070I-Ni
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 17:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044AbbFRPjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 11:39:41 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:35357 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721AbbFRPjj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 11:39:39 -0400
Received: by ykar6 with SMTP id r6so69185933yka.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=maU2ENwspyvLgiAmfNIg5QiMTVOo5nqHIqCZ29o9a5c=;
        b=kw7I7qsFOh1T+ZKr3EElq5F5Ne+NXGseQInOipqYpoqXUGv6GF2qcfO9NLHrPxRRJk
         u4/dViybAGD3G9ZNijknB580r0HjXqQ3HMfA+OrWYPn4nzb2BHRnHLUc14eqmgYbpQ0h
         c+i0/aCRjLsuabLWkby4Q/usfI8h3X2LnuINYuEZ7PHB7mbMMYlSQA2Hb4hmz0Vl9Uzb
         LTfxl/rwX0vyJ/XpuTQXM7Atxhf3TOZDK6+nojwhFZC0GUrvre1RIs29p22M10FSlFAS
         zro4flOhTzfy5TAEjiOxxQncdW1nJc4uRxMe2C0JlL597C31MvtOCyhPKyKjb4i5w9Ot
         kIJQ==
X-Received: by 10.129.74.135 with SMTP id x129mr14184871ywa.98.1434641978680;
 Thu, 18 Jun 2015 08:39:38 -0700 (PDT)
Received: by 10.37.114.85 with HTTP; Thu, 18 Jun 2015 08:39:18 -0700 (PDT)
In-Reply-To: <20150618142852.GL18226@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272016>

2015-06-18 16:28 GMT+02:00 John Keeping <john@keeping.me.uk>:
> On Thu, Jun 18, 2015 at 04:17:52PM +0200, Florian Aspart wrote:
>> 2015-06-18 16:11 GMT+02:00 John Keeping <john@keeping.me.uk>:
>> > On Thu, Jun 18, 2015 at 03:51:25PM +0200, Florian Aspart wrote:
>> >> 2015-06-18 15:26 GMT+02:00 John Keeping <john@keeping.me.uk>:
>> >> > [Please don't top-post on this list.]
>> >> >
>> >> > On Thu, Jun 18, 2015 at 03:15:38PM +0200, Florian Aspart wrote:
>> >> >> 2015-06-18 14:31 GMT+02:00 Michael J Gruber <git@drmicha.warpmail.net>:
>> >> >> > Florian Aspart venit, vidit, dixit 16.06.2015 16:11:
>> >> >> >> I created a clean filter to apply on some files before commiting them.
>> >> >> >> The filter works correctly when I commit the file and is also applied
>> >> >> >> when I usethe iff command line tool.
>> >> >> >> However, when using difftool with meld, the filter is not applied and
>> >> >> >> the different versions of the files are compared without any
>> >> >> >> filtering.
>> >> >> >>
>> >> >> >> Is there a way to apply the clean/smudge filters when comparing the
>> >> >> >> working copy of a file to the HEAD version in a gui diff tool?
>> >> >> >>
>> >> >> >> I'm using git version 2.4.3 under Ubuntu.
>> >
>> > I also realised that the code for file diff is very different from
>> > directory diff do you see any difference between git-difftool acting on
>> > files and with the `--dir-diff` option?
>>
>> No, even with the --dir-diff option, the filter is still not applied.
>
> I have tried to reproduce this and it works as expected for me (i.e. the
> filter is applied) both for file diff and directory diff mode:
>
> $ git config filter.quote.clean "sed -e 's/^> //'"
> $ git config filter.quote.smudge "sed -e '/^> /n; s/^/> /'"
> $ git config filter.quote.required true
>
> $ echo '*.quote filter=quote' >>.gitattributes
> $ cat >1.quote <<EOF
> one
> two
> three
> EOF
> $ git add .gitattributes 1.quote
> $ git commit -m 'Initial commit'
> $ echo four >>1.quote
>
> Now `git-difftool` shows the differences with the filter applied.  This can be
> seen running with GIT_TRACE:
>
> $ GIT_TRACE=2 git difftool
> 15:26:59.211541 git.c:557               trace: exec: 'git-difftool'
> 15:26:59.211674 run-command.c:347       trace: run_command: 'git-difftool'
> 15:26:59.338617 git.c:348               trace: built-in: git 'config' '--bool' '--get' 'difftool.trustExitCode'
> 15:26:59.342664 git.c:348               trace: built-in: git 'diff'
> 15:26:59.344857 run-command.c:347       trace: run_command: 'sed -e '\''s/^> //'\'''
> 15:26:59.345383 run-command.c:195       trace: exec: '/bin/sh' '-c' 'sed -e '\''s/^> //'\''' 'sed -e '\''s/^> //'\'''
> 15:26:59.351077 run-command.c:347       trace: run_command: 'sed -e '\''/^> /n; s/^/> /'\'''
> 15:26:59.351605 run-command.c:195       trace: exec: '/bin/sh' '-c' 'sed -e '\''/^> /n; s/^/> /'\''' 'sed -e '\''/^> /n; s/^/> /'\'''
> 15:26:59.355716 run-command.c:347       trace: run_command: 'git-difftool--helper' '1.quote' '/tmp/SUEySx_1.quote' '4cb29ea38f70d7c61b2a3a25b02e3bdf44905402' '100644' '1.quote' '0000000000000000000000000000000000000000' '100644'
> 15:26:59.356191 run-command.c:195       trace: exec: 'git-difftool--helper' '1.quote' '/tmp/SUEySx_1.quote' '4cb29ea38f70d7c61b2a3a25b02e3bdf44905402' '100644' '1.quote' '0000000000000000000000000000000000000000' '100644'
> 15:26:59.370468 git.c:348               trace: built-in: git 'config' 'diff.tool'
> 15:26:59.373485 git.c:348               trace: built-in: git 'config' 'merge.tool'
> 15:26:59.378402 git.c:348               trace: built-in: git 'config' 'difftool.vimdiff.cmd'
> 15:26:59.381424 git.c:348               trace: built-in: git 'config' 'mergetool.vimdiff.cmd'
> 15:26:59.386623 git.c:348               trace: built-in: git 'config' '--bool' 'mergetool.prompt'
> 15:26:59.390198 git.c:348               trace: built-in: git 'config' '--bool' 'difftool.prompt'
>
> I think the first run_command of `sed` is cleaning the working tree file
> to figure out *if* it differs, then the second `sed` is smudging the
> version in the index so that difftool can use it.

I'm not really understanding what your filter is doing, but I tried
your code on my machine and I get a different result when using diff
and difftool on my machine.

The diff results give me:

diff --git a/1.quote b/1.quote
index 4cb29ea..f384549 100644
--- a/1.quote
+++ b/1.quote
@@ -1,3 +1,4 @@
 one
 two
 three
+four

While the diff tool tells me that the repository file is:
> one
> two
> three

and my working copy:
one
two
three
four

In both case the the filters are called twice (cf GIT_TRACE) as in the
example your wrote.
