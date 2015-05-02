From: Alangi Derick <alangiderick@gmail.com>
Subject: Re: Improving code base readability
Date: Sat, 2 May 2015 08:00:52 +0100
Message-ID: <CAKB+oNsYDL=iv8AqjoN_JqGTFf0_=f4nKa9_gcxHPLZO+rxmbA@mail.gmail.com>
References: <CAKB+oNvB322hyX3UbGBPETDc0zEdC39PdeM=GG=rVf_WYGq_OA@mail.gmail.com>
	<20150501185946.GV5467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 09:01:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoRQ3-0008NW-9Y
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 09:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbbEBHAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 03:00:54 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34164 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbEBHAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 03:00:53 -0400
Received: by qgfi89 with SMTP id i89so46166289qgf.1
        for <git@vger.kernel.org>; Sat, 02 May 2015 00:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wNTtQhacmg9kgbjx8nMjBkxjploDwmvPgnncwLOrr/8=;
        b=v0oNGeemHLkv+Jy27Lyp2pbTz9kJdqaV8nftLl29q+LMyt+Nbvyx9F4JctjONglbJq
         5ycfZzMKT+OfGttk5kRJDU2ezIdnZgXzTjfZnNVoXLuDXjyr5d+R4d6lhPYlrp3kKs/c
         cZlOXbEApIyfzluVBqRTnrf/mXSp7dI/QHO77V1w9R0PywYoQ/43lPhZpUmD78dDx6/3
         jRC0tFUJKK4Y6orYFQh18r+KWekQa4oTfa+inNqIbTmMpdhTK8/dnv44zrgSNj0N3JjE
         bGi4seLDujmFELO3XIVq2haLJg5hB6BAsoUvt6zVN430t4UStT4n0Ls0zi512la6DT5I
         T16Q==
X-Received: by 10.55.24.215 with SMTP id 84mr26456699qky.8.1430550052233; Sat,
 02 May 2015 00:00:52 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Sat, 2 May 2015 00:00:52 -0700 (PDT)
In-Reply-To: <20150501185946.GV5467@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268220>

     It is indeed a nice work for a start. I am very much interested
to work on that line since i am still learning the code base. I will
want you to help me or say orientate me on the work so i can produce a
patch. My intentions are clear. I will like to be a part of the git
community and contribute code to them from now till further notice.
      Let me look at the po/README and see if i can find some useful
information. Where ever i get stuck, i will ask for help.
Regards
Alangi Derick Ndimnain


On Fri, May 1, 2015 at 7:59 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Alangi Derick wrote:
>
>> This is an example of what i am talking about or what i am trying to
>> demonstrate. This is the patch:
>
> Thanks for giving an example.
>
> [...]
>> --- a/archive-tar.c
>> +++ b/archive-tar.c
>> @@ -102,7 +102,7 @@ static int stream_blocked(const unsigned char *sha1)
>>
>>   st = open_istream(sha1, &type, &sz, NULL);
>>   if (!st)
>> - return error("cannot stream blob %s", sha1_to_hex(sha1));
>> + return error("Cannot stream blob %s", sha1_to_hex(sha1));
>
> This is not about code readability but about the program's output, no?
>
> Habit is to use lowercase for error messages, to be brief, and to not
> include a period at the end since they are not sentences.  For
> example:
>
>         $ nonexistent-command
>         bash: nonexistent-command: command not found
>
> Git tends to follow that practice, too, though it is not completely
> consistent about it.
>
> As a first contribution, I don't think this is a good project to
> embark on.  It would touch a lot of code, meaning it is difficult to
> time to avoid interfering with other patches.  It is relatively
> low-impact or the impact is hard to demonstrate: consistency is
> pleasant, but the capitalization does not seem to be interfering with
> the program's usability.  Once the work is done, it is easy to
> backslide unless there is an automated test to avoid that, which makes
> the work more technically complicated.
>
> If you'd like a project that involves touching a large part of the
> codebase, one ongoing project has been to mark human-readable strings
> for translation.  See "Marking strings for translation" in po/README
> for hints about how that works.
>
> The same timing issues about avoiding conflicting with other people's
> work apply there, too, but I'd be happy to help as you go.  And the
> impact can be pretty big, both in consistency (a mixture of English
> and native language output due to incomplete i18n is not a great
> experience) and usability (for some, being able to interact with git
> in their native language makes using git much easier).
>
> A search with
>
>         git grep --cached -F -e 'error("'
>
> finds many files with untranslated strings.
>
> Such work might lead you to discover unclear code, unclear messages,
> or aspects of git's behavior that you'd like to change, which can also
> lead to other patches that go in other directions.
>
> What do you think?
>
> Thanks,
> Jonathan
